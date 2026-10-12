# 14 — Event, Queue, and Redis Architecture

## Event envelope

Every event published to the event bus (Kafka/Redpanda) uses this envelope (formalized in `../../contracts/events/schemas/envelope.schema.json`):

```json
{
  "event_id": "01J8X7Z8K9QANM3E7B5T6R2F4C",
  "event_type": "PlaceUpdated",
  "event_version": 1,
  "aggregate_type": "Place",
  "aggregate_id": "01J8X7...",
  "producer": "core-api",
  "occurred_at": "2026-09-22T14:03:11.482Z",
  "published_at": "2026-09-22T14:03:11.601Z",
  "correlation_id": "01J8X7Z8K9QANM3E7B5T6R2F4D",
  "trace_id": "4bf92f3577b34da6a3ce929d0e0e4736",
  "schema_version": 1,
  "data": { "...": "event-type-specific payload" }
}
```

| Field | Notes |
|---|---|
| `event_id` | ULID, unique per publication; retries of the same logical event reuse it (see `05-...md`) |
| `event_type` | PascalCase, from the registry below (`../../contracts/events/registry.md`) |
| `event_version` | Integer, increments on breaking payload change to this specific `event_type` |
| `aggregate_type` / `aggregate_id` | The domain entity this event is about |
| `producer` | Deployable name that published it (see `02-...md`) |
| `occurred_at` | Event-time (see `05-...md`) |
| `published_at` | Processing-time |
| `correlation_id` | Propagated from the originating request |
| `trace_id` | W3C trace context, best-effort |
| `schema_version` | JSON Schema version of the envelope itself (distinct from `event_version`, which is per-type) |
| `data` | Type-specific payload, validated against `../../contracts/events/schemas/{event_type}.schema.json` |

## Topic strategy

- One Kafka topic per **aggregate type** family (not per event type), e.g., `places.place-events`, `identity.session-events`, `navigation.session-events`, `traffic.snapshot-events` — keeps related event ordering-relevant events (e.g., `PlaceCreated` then `PlaceUpdated` for the same place) on the same partition when keyed by `aggregate_id`.
- Partition key = `aggregate_id`, guaranteeing per-aggregate ordering within a topic; cross-aggregate ordering is not guaranteed and consumers must not assume it.
- Topic naming: `{domain}.{aggregate}-events`, lowercase, hyphenated.

## Domain event registry (initial)

See `../../contracts/events/registry.md` for the full table (topic, producer, consumers, schema file, version). Summary of the event families established by this architecture:

| Event | Producer | Primary consumers |
|---|---|---|
| `UserRegistered` | Identity | Users (profile creation), Notifications |
| `SessionCreated` / `SessionRevoked` | Identity | Navigation (force-close sessions), Analytics |
| `UserProfileUpdated` | Users | Analytics |
| `PlaceCreated` / `PlaceUpdated` / `PlaceDeleted` / `PlaceModerated` | Places | Search, Analytics, Saved Places (cascade) |
| `MapDataVersionPublished` | Geographic/Address Data (`geodata-pipeline`) | Search, Map Tiles, Routing, Geocoding, Analytics |
| `TileVersionPublished` | Map Tiles | Analytics, Observability dashboards |
| `RouteRequested` / `RouteComputed` | Routing | Analytics |
| `NavigationStarted` / `NavigationRerouted` / `NavigationEnded` | Navigation | Notifications, Analytics |
| `TrafficSnapshotUpdated` | Traffic | Routing, Navigation, Map Tiles, Analytics |
| `IncidentReported` / `IncidentResolved` | Traffic | Navigation, Map Tiles, Notifications |
| `LocationTelemetryReceived` | Location Telemetry | Traffic (aggregation consumer only) |
| `SavedPlaceCreated` / `SavedPlaceRemoved` | Saved Places | Analytics |
| `ContributionSubmitted` / `ContributionApproved` / `ContributionRejected` | Contributions | Places (apply on approval), Moderation, Notifications |
| `ReviewCreated` / `ReviewUpdated` / `ReviewDeleted` / `ReviewModerated` | Reviews & Ratings | Places (rating aggregate recompute), Moderation, Search |
| `MediaUploaded` / `MediaProcessed` / `MediaRemoved` | Media | Moderation, Places/Reviews (attach confirmation) |
| `NotificationRequested` | Any domain | Notifications |
| `NotificationDelivered` / `NotificationFailed` | Notifications | Analytics |
| `ReportSubmitted` | Moderation & Administration | Moderation (self), Notifications |
| `ModerationDecisionMade` | Moderation & Administration | Places, Reviews, Media, Contributions, Notifications |
| `AdminActionPerformed` | Moderation & Administration | Analytics, Audit |

Every event listed here has a corresponding JSON Schema file in `../../contracts/events/schemas/`. **This registry is the binding contract** — no implementation prompt introduces a new event type or changes a payload shape without updating the schema file and this registry together.

## Delivery semantics

- **At-least-once delivery** is the platform default and the only guarantee assumed anywhere. No consumer may assume exactly-once without an explicit, documented idempotency mechanism of its own.
- **Consumer idempotency:** every consumer keys its side effect off `event_id` (or a natural idempotency key derivable from `aggregate_id` + `event_type` + `event_version` where replays of the same logical state change are expected to be safely reapplied, e.g., an upsert). A consumer that cannot be made naturally idempotent maintains a processed-`event_id` dedup table/cache with a retention window at least as long as the broker's redelivery window.
- **Transactional outbox:** any producer whose event publication must be atomic with a database write (the overwhelming majority of domain events) writes the event to an `outbox` table in the same transaction as the domain write, and a separate relay process publishes from the outbox to Kafka, deleting/marking-published rows after broker acknowledgment. This guarantees the event is never lost due to a crash between "DB commit" and "publish," and never published without a corresponding committed DB state (no phantom events).
- **Ordering:** guaranteed per-`aggregate_id` (via partition key), not globally. Consumers needing cross-aggregate ordering must derive it from `occurred_at` plus their own reconciliation logic, not assume broker-level global order.
- **Retries/backoff:** consumer processing failures retry with exponential backoff (base delay, multiplier, jitter — configured per consumer group in `../../contracts/config/service-config.schema.json`), capped at a max attempt count before dead-lettering.
- **Dead-letter handling:** every consumer group has a corresponding `{topic}.dlq` topic; dead-lettered messages retain the full envelope plus a `failure_reason` and `attempt_count` wrapper, and are alertable (see `18-...md`). Dead-lettered messages are never silently dropped.
- **Replay:** topics retain sufficient history (retention policy per topic family, documented in infra config) to allow a consumer to be reset to an earlier offset and reprocess — this is the primary mechanism for rebuilding a derived store (e.g., full Search reindex) rather than requiring a bespoke backfill job for every derived store, where feasible; `MapDataVersionPublished`-driven rebuilds (tiles, routing graph) use the versioned-artifact rebuild path in `09-...md` instead, since those rebuilds are computationally heavy batch jobs, not simple event replays.
- **Schema compatibility:** producers/consumers use a schema registry (Confluent-compatible or equivalent) enforcing backward-compatible evolution (new optional fields only) within an `event_version`; a breaking change increments `event_version` and the old version continues to be produced/consumed in parallel for a documented deprecation window until all consumers migrate.

## Queue / background-job architecture (BullMQ-style, Redis-backed, distinct from the Kafka event bus)

Event bus (Kafka) is for **domain facts** other services need to know about. **Queues** are for **work this service needs done**, often by itself, asynchronously — a different concern.

| Job category | Producer | Consumer | Retry policy | Idempotency | Priority | Notes |
|---|---|---|---|---|---|---|
| Search indexing | (consumes Kafka events, not itself queue-triggered) | `search-api` indexing worker | 5 attempts, exponential backoff | Upsert-by-id | Normal | See `11-...md` |
| Media processing (validation, derivative generation) | `media-service` (upload confirmation) | `media-service` worker | 3 attempts, exponential backoff | Reprocessing overwrites the same derivative keys safely | High (user-facing latency) | See `15-...md` |
| Notification delivery | Notifications (consumes `NotificationRequested`) | `notification-worker` | 5 attempts, exponential backoff, then DLQ + `NotificationFailed` event | Provider-side idempotency key passed through where the provider supports it | Normal, `urgent` priority lane for navigation-critical notifications | See `16-...md` |
| Moderation workflow transitions | Moderation & Administration | `core-api` (moderation module) | 3 attempts | Case-state-machine transitions are naturally idempotent (re-applying the same transition is a no-op) | Normal | |
| Traffic aggregation | Traffic (stream processing, technically a Kafka Streams-style consumer, not a discrete queue job, but documented here for completeness) | `traffic-service` | N/A (continuous stream processing, not job-retry semantics) | Aggregation window recomputation is idempotent (same inputs → same aggregate) | N/A | |
| Route precomputation (optional — popular route pre-warming) | Routing (scheduled) | `routing-api` worker | 2 attempts, low priority | Cache-key overwrite is naturally idempotent | Low | Out-of-scope for initial implementation; boundary reserved |
| Cleanup (expired sessions, retention-window purges) | Scheduled | Owning domain's worker | 3 attempts | Deletion is naturally idempotent | Low | Runs against `navigation.location_update`, `LocationEvent` buffers, expired `Notification` rows, etc. |

Standard job-record fields across all categories: `job_type`, `payload` (versioned, same discipline as event payloads), `producer`, `attempt`, `max_attempts`, `timeout_ms`, `priority`, `created_at`, `scheduled_for`, `status` (`queued|active|completed|failed|dead_lettered`). Concurrency limits are per-queue configuration, not hardcoded. Graceful shutdown: workers stop pulling new jobs on `SIGTERM`, finish in-flight jobs up to a bounded grace period, then exit — in-flight jobs beyond the grace period are returned to the queue for another worker rather than lost.

## Redis architecture

Redis has **no** authoritative-data role anywhere in this platform except the explicitly time-bounded, reconstructable uses below.

| Use | Key namespace | Serialization | TTL | Invalidation | Ownership | Failure behavior |
|---|---|---|---|---|---|---|
| Session denylist (revocation) | `session:denylist:{session_id}` | string flag | = remaining access-token lifetime (≤15 min) | Natural TTL expiry | Identity | Redis outage → falls back to trusting token expiry alone (slightly weaker revocation window, never a hard failure of auth) — see `18-...md` |
| Rate limiting counters | `ratelimit:{principal}:{endpoint_class}:{window}` | integer counter | = rate-limit window | Natural TTL expiry | API edge | Redis outage → fail open with a conservative default limit enforced at the edge process level, logged as degraded |
| Autocomplete/search response cache | `search:cache:{normalized_query_hash}` | JSON | seconds (e.g., 30s) | Natural TTL expiry, or explicit purge on relevant `PlaceUpdated` for exact-match keys where cheap to do so | Search | Redis outage → cache miss, serve from OpenSearch directly (slower, not broken) |
| Nearby-result cache | `nearby:cache:{geohash}:{radius}:{filters_hash}` | JSON | seconds | Natural TTL expiry | Search/Places | Same as above |
| Route computation cache | `route:cache:{request_hash}` | JSON | seconds (traffic-bucketed) | Natural TTL expiry | Routing | Redis outage → every request recomputed against the routing engine (higher load, not broken) |
| Navigation live session state | `nav:session:{session_id}:state` | hash | session lifetime + grace period | Explicit delete on session termination, TTL as backstop | Navigation | Redis outage → active navigation sessions degrade to REST-poll-and-recompute from the `navigation` schema (durable state), live push unavailable until recovery — see `18-...md` |
| Distributed locks (e.g., serializing a specific map-data publish) | `lock:{resource}` | string (lock token) | short, operation-bound | Explicit release + TTL backstop against holder crash | `geodata-pipeline` | Redis outage → publish jobs queue/wait rather than risk a race; used sparingly, only where a genuine mutual-exclusion need exists |
| Idempotency key store | `idempotency:{principal}:{endpoint}:{key}` | JSON (cached response) | 24 hours | Natural TTL expiry | API edge / per-service | Redis outage → idempotency protection temporarily unavailable; documented as a degraded-but-not-unsafe mode (worst case is a duplicate side effect during the outage window, mitigated by underlying unique-constraint safeguards in Postgres where applicable) |

Every Redis use above is either a cache of a PostgreSQL/Kafka-durable source, a TTL-bounded coordination primitive, or reconstructable session state — none is the sole durable record of a fact the platform cannot afford to lose.
