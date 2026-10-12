# Queue Registry

Binding registry of background-job types on the platform's Redis-backed queue system (BullMQ-style), distinct from the Kafka event bus (`../events/registry.md`). See `../../docs/architecture/14-event-queue-architecture.md` for the prose architecture and `../../docs/architecture/24-queue-and-redis-keyspace-contracts.md` for the deepened Volume 2 contract.

| job_type | Producer | Consumer | Max attempts | Timeout | Schema file |
|---|---|---|---|---|---|
| search-indexing | Kafka event consumer (PlaceCreated/Updated/Deleted/Moderated, MapDataVersionPublished) | `search-api` indexing worker | 5 | 10s | `schemas/search-indexing.schema.json` |
| media-processing | `media-service` (upload-complete notification) | `media-service` worker | 3 | 60s | `schemas/media-processing.schema.json` |
| notification-delivery | Notifications (consumes NotificationRequested) | `notification-worker` | 5 | 15s | `schemas/notification-delivery.schema.json` |
| moderation-workflow-transition | Moderation & Administration (ModerationDecisionMade) | `core-api` moderation module | 3 | 10s | `schemas/moderation-workflow-transition.schema.json` |
| route-precomputation | Routing (scheduled, optional) | `routing-api` worker | 2 | 5s | `schemas/route-precomputation.schema.json` |
| retention-cleanup | Scheduled | Owning domain's worker | 3 | 300s | `schemas/retention-cleanup.schema.json` |

## Envelope

Every job uses the common envelope (enforced by each schema file): `job_id` (ULID), `job_type` (matches the table above), `job_version` (integer, per-type), `payload` (type-specific, schema-validated), `created_at`, `available_at` (supports delayed/scheduled jobs), `attempt` (current attempt number, 1-indexed), `correlation_id` (propagated from the originating request/event), `causation_id` (optional — the event or job that caused this job to be enqueued).

## Update procedure

Identical discipline to `../events/registry.md`: add a schema file + registry row together; breaking payload changes bump `job_version` and are supported in parallel with the previous version until all producers/consumers migrate.
