# 24 — Queue, Redis Keyspace, Idempotency, and Concurrency Contracts

## Queue contract

**Authoritative artifacts:** `../../contracts/queues/registry.md`, `../../contracts/queues/schemas/*.schema.json`. Every background job on the platform uses the common envelope (`job_id`, `job_type`, `job_version`, `payload`, `created_at`, `available_at`, `attempt`, `correlation_id`, `causation_id`) — this is a **different envelope from the Kafka event envelope** (`../../contracts/events/schemas/envelope.schema.json`) because jobs and events are different concerns (work-to-do vs. facts-that-happened, per `14-event-queue-architecture.md`'s framing), even though both share the identifier/timestamp conventions from `05-...md`.

Six job types are registered: `search-indexing`, `media-processing`, `notification-delivery`, `moderation-workflow-transition`, `route-precomputation` (reserved/optional), `retention-cleanup`. Each schema file carries `x-max-attempts`, `x-timeout-ms`, `x-concurrency`, `x-deduplication` as binding operational parameters, not just documentation — a worker implementation must honor the values in the deployed job's schema, sourced from `../../contracts/config/service-config.schema.json`'s per-service overrides where a service needs to tune them away from the schema default (schema defaults are the floor/reference, config can tighten but not silently diverge in meaning).

## Redis keyspace contract

**Authoritative artifact:** `../../contracts/redis/keyspace.json` — supersedes nothing in `14-event-queue-architecture.md`'s Redis table (that table remains the prose explanation); the JSON file is the machine-checkable version of the same nine namespaces, each carrying `pattern`, `owner`, `purpose`, `value_type`, `serializer`, `ttl`, `invalidation`, `max_item_size_bytes`, and `failure_behavior`. No service may write a Redis key outside one of these nine registered patterns without first registering it here — this is the same discipline as the event/queue registries, applied to cache/coordination keys.

`max_item_size_bytes` is a soft operational ceiling (not a Redis hard limit) chosen to keep hot-path cache values small enough that Redis latency stays predictable under load; a value class that regularly needs to exceed its listed ceiling is a signal to either narrow what's cached (e.g., paginate before caching) or move the data to a store better suited for larger payloads (object storage + a pointer in Redis), not to quietly raise the ceiling in code without updating this registry.

## Idempotency contract

- **Convention:** `Idempotency-Key` HTTP request header, required on: contribution creation (`POST /v1/contributions`), review creation (`POST /v1/places/{id}/reviews`), media upload authorization (`POST /v1/media/uploads`), navigation-session creation (`POST /v1/navigation/sessions`), and any future external-provider-triggering or payment-like operation. Not required (but harmless if sent) on naturally idempotent operations (`PUT`/`DELETE` by ID, `PATCH` with a full replacement semantic).
- **Key format:** opaque string, 1–255 characters, any printable ASCII (no server-imposed structure — clients typically use a UUID/ULID generated client-side).
- **Scope:** `(principal_id, endpoint, idempotency_key)` — the same key value reused by two different users, or against two different endpoints, is not a collision; scoping is enforced by the Redis key pattern `idempotency:{principal}:{endpoint}:{key}` (`../../contracts/redis/keyspace.json`).
- **Retention:** 24 hours (`IdempotencyRecord.expires_at`, `../../contracts/entities/IdempotencyRecord.schema.json`).
- **Request fingerprinting:** the server stores a `request_fingerprint` (hash of the normalized request body) alongside the cached response. A repeated key with a **matching** fingerprint replays the cached response verbatim (same status, same body) without re-executing side effects. A repeated key with a **different** fingerprint returns `409 idempotency_key_conflict` (`07-error-contract.md`) — the platform never silently treats two different request bodies as "the same operation" merely because they reused a key, and never silently treats them as two separate operations either (that would defeat the purpose of the key).
- **Concurrent duplicate handling:** if two requests with the same key arrive concurrently before the first has completed and cached its response, the second is held (short bounded wait) or receives `409 idempotency_key_conflict` with `retryable: true` if the first hasn't completed within a short window — the platform never runs the underlying operation twice concurrently for the same key.
- **Terminal failure handling:** if the underlying operation fails with a genuine server error (not a validation rejection), the idempotency record is **not** cached as a success — a retry with the same key is allowed to actually retry the operation, since the original attempt didn't durably succeed. A validation failure (`422`), by contrast, is a legitimate terminal outcome for that exact request body and **is** cached, so a client blindly retrying an invalid request doesn't need special-casing to get a fast, consistent rejection.

## Concurrency contract

| Resource | Mechanism | Conflict response |
|---|---|---|
| `Place` | Optimistic (`version` integer column, `WHERE version = :expected`) | `409 conflict`; client re-fetches and reapplies |
| `Review` (edit) | Optimistic (`updated_at`-based `If-Unmodified-Since` or an explicit `version` field, implementation's choice, documented consistently once chosen) | `409 conflict` |
| `SavedPlace` | Natural uniqueness constraint (`user_id, place_id, list_id`) — a duplicate save is not a conflict, it's a no-op returning the existing record (`200`, not `201`, when the exact tuple already exists) | N/A (idempotent by construction, not by `Idempotency-Key`) |
| `Contribution` | No concurrent-edit concern (create-only until decided; a `pending` contribution is not user-editable — withdraw-and-resubmit is the correction path) | N/A |
| `NavigationSession` | Server-authoritative single-writer (only the owning session's own location-update stream mutates it; `version` integer column guards against a rare double-processed update) | A stale write is simply superseded (last-server-processed-wins on the server's own sequence, not a client-facing conflict) |
| `ModerationCase` | Optimistic via `status` transition guard (`WHERE status = 'open'` on the deciding update) | `409 conflict` — "case already decided," surfaced to a moderator attempting to act on a case another moderator just closed |

Where optimistic concurrency is used, the API contract exposes the guarding field (`version` in the entity schema/OpenAPI response) so clients can round-trip it on their next update, per `10-database-postgis-architecture.md`'s database-level mechanism — this document is the API-visible half of that same mechanism, not a separate one.

## Filtering and sorting contract

Every list endpoint over a geospatial or otherwise unbounded resource enumerates its **exact** allowed filter/sort parameters in the OpenAPI contract (`../../contracts/openapi/core-v1.yaml`) — there is no generic/arbitrary query-parameter passthrough to the database anywhere in the API layer. Standardized parameter semantics:

| Concept | Parameter(s) | Applies to |
|---|---|---|
| Geographic radius bias | `near` (`lng,lat`), `radius_m` | `/places`, `/search`, `/autocomplete` |
| Bounding box | `bbox` (`minLng,minLat,maxLng,maxLat`) | `/places`, `/search` |
| Category | `category` (single slug; multi-category filtering is a documented future extension, not silently supported via repeated params in this volume) | `/places`, `/search` |
| Free text | `q` | `/search`, `/autocomplete` |
| Rating | reserved (`min_rating`) — not implemented in the OpenAPI contract yet; documented here as the next natural filter to add | `/places` (future) |
| Route mode/constraints | `mode`, `avoid`, `alternatives`, `traffic_aware` | `/routes` |
| Timestamp range | `since`/`until` — reserved for admin/audit list endpoints, not yet in the public contract | `/admin/moderation/cases` (future) |
| Moderation state | `status` | `/admin/moderation/cases` |
| Sort | `sort=field` / `sort=-field`, closed set per endpoint (documented in each endpoint's OpenAPI parameter, not a free-form field name) | All list endpoints |

**Maximum query complexity:** at most one geographic bound (`near`+`radius_m` OR `bbox`, never both simultaneously — the API rejects both being present with `422 validation_failed`) and at most one free-text term (`q`) per request; combining these with a single `category` filter is supported, combining with more than one simultaneous categorical filter is a documented future extension, not silently accepted today.
