# 25 — Compatibility, Versioning, and Deployment-Order Contract

This document makes `06-api-architecture.md`'s versioning note, `14-event-queue-architecture.md`'s schema-compatibility note, and `19-deployment-scalability-integration-architecture.md`'s deployment-safety section into one concrete, cross-artifact ruleset, since Volume 1 stated the principles per-artifact and implementation prompts need one place that says what to do when a change touches more than one artifact at once.

## Compatibility rules per artifact class

| Artifact | Additive change (no version bump) | Breaking change (version bump required) | Deprecation window |
|---|---|---|---|
| REST API (`contracts/openapi/core-v1.yaml`) | New optional request field; new response field; new endpoint; new optional query parameter | Removing/renaming a field; changing a field's type or meaning; making an optional field required; removing an endpoint; changing an error `code`'s meaning | New major path (`/v2/...`) ships alongside `/v1/...` for a minimum of 90 days after `/v2/...` reaches general availability, signaled via `Deprecation`/`Sunset` headers on `/v1/...` from the day `/v2/...` ships |
| Domain events (`contracts/events/`) | New optional `data` field; new event type | Removing/renaming a `data` field; changing a field's type/meaning; changing `event_type` string | Previous `event_version` continues to be produced and consumed in parallel until all registered consumers (per `contracts/events/registry.md`) confirm migration; minimum 30 days |
| Queue jobs (`contracts/queues/`) | New optional `payload` field | Removing/renaming a `payload` field; changing `job_type` semantics | Previous `job_version` supported until the producing service confirms no in-flight jobs of the old version remain (bounded by the job's own retry/DLQ window) |
| Database schema (`contracts/db/core-entities.sql`) | New nullable column; new table; new index | Dropping/renaming a column or table; changing a column's type or nullability in an incompatible direction; changing a CHECK constraint's enum values | Two-phase expand/contract (below), minimum one full deployment cycle between phases |
| Enum registry (`contracts/enums/registry.json`) | New enum value that doesn't change existing values' meaning | Removing a value; renaming a value; changing a value's meaning; changing which transitions are valid | Same as the artifact that consumes the enum (API/event/DB, whichever is affected) |
| Map datasets (`MapDatasetVersion`) | N/A — every publish is a new version by definition | N/A — versions are never mutated in place | Current + N previous versions retained for immediate rollback (`09-geospatial-data-architecture.md`) |
| Tile versions (`MapTile`/`TileVersion`) | N/A — same as map datasets | N/A | Current + N previous versions retained |
| Search index | Reindex from canonical data at any time (no versioning needed — always rebuildable) | N/A (the index itself is never the compatibility surface; the `SearchDocument` shape is, governed by the entity-schema rule below) | N/A |
| Routing graph | Rebuilt from each `MapDatasetVersion` | N/A (internal engine artifact, not a public contract) | Current + N previous builds |
| Configuration schema (`contracts/config/service-config.schema.json`) | New optional property | Removing/renaming a required property; changing a property's type | Services validate against the schema at startup and refuse to boot on an incompatible config — so a breaking config schema change must ship with updated config in the same deployment, sequenced per the deployment-order rules below |
| Realtime protocol (`contracts/realtime/navigation-protocol.schema.json`) | New optional message field; new message `type` | Removing/renaming a field; changing a `type` discriminant's meaning | Server supports both old and new client message shapes for a transition window; clients are expected to update within one app-store release cycle for mobile, immediately for web (server-delivered) |

## Canonical entity schemas are the cross-artifact compatibility anchor

Per `22-canonical-entities-and-enums.md`'s consistency rule, a single entity's shape appears in up to four places: its entity schema (`contracts/entities/`), the OpenAPI representation, the database columns, and any event payload carrying it. **The entity schema file is authoritative** — when a field changes, the entity schema changes first, and the OpenAPI/DB/event changes are then derived from it and must not diverge. This prevents the common failure mode where an API response schema and a database migration drift apart because they were each treated as independently authoritative.

## Expand/contract sequencing for destructive database changes

```text
Phase 1 — Expand
  Add new column/table (nullable or with a safe default).
  Deploy application code that WRITES to both old and new representations.
  ↓
Phase 2 — Backfill
  Batch-migrate existing rows from old to new representation
  (background job, bounded batches, per 10-database-postgis-architecture.md's
  migration rules — never an unbounded table lock).
  ↓
Phase 3 — Switch reads
  Deploy application code that READS from the new representation only,
  still writing to both (safety margin — at least one full deployment cycle
  after Phase 1 before this ships).
  ↓
Phase 4 — Contract
  Deploy application code that stops writing to the old representation.
  ↓
Phase 5 — Drop
  A later migration drops the old column/table, only after confirming
  no rolled-back application version still expects it.
```

Each arrow is a separate deployment; phases 1 and 3 are separated by at least one full deployment cycle specifically so that a rollback of the phase-3 deploy still finds the old representation intact and populated.

## Deployment-order examples

**Adding a required field to `PlaceCreated`'s payload (breaking event change):**
1. Add the field as optional in `contracts/events/schemas/PlaceCreated.schema.json` at the current `event_version`, deploy Places (producer) to start populating it, deploy Search/Analytics (consumers) to start reading it if present — no version bump yet (additive).
2. Once all consumers confirm they read it when present, bump `event_version`, update the schema's `required` array, and update `contracts/events/registry.md`.
3. Producer starts requiring/validating the field internally before publish; old-version consumers (if any remain) continue to receive the previous `event_version` in parallel per the registry's deprecation-window rule until they migrate.

**Renaming a `Place` field surfaced in the API, DB, and search index simultaneously:**
1. Update `contracts/entities/Place.schema.json` first (the anchor) — this alone is a documentation-only change with no deployment impact yet.
2. Database: expand/contract per the five-phase sequence above (add new column, dual-write, switch reads, stop old writes, drop old column across separate deployments).
3. API: add the new field name as additive (`06-api-architecture.md`), mark the old field name deprecated in the OpenAPI `description`, remove it only at the next major API version.
4. Search: reindex is a rebuildable derived store, so it picks up the renamed field on its next event-driven update or full rebuild — no separate versioning burden, but the indexing consumer code must be updated in the same deployment as the database's Phase 3 (switch reads), not before (it would otherwise read a column that doesn't exist yet) and not long after (stale field name persists in the index).

## Client compatibility expectations

- **Web client:** deployed independently of the backend; must tolerate additive API/event changes with no client update required (ignore unknown fields), and is expected to update within the same release cycle as a new major API version's GA.
- **Mobile clients:** cannot be forced to update instantly (app store review, user update lag) — this is the primary reason the deprecation windows above are measured in tens of days, not hours, and why the realtime protocol's breaking-change rule explicitly accounts for "one app-store release cycle." A mobile client on an old major API version continues to function against the deprecated version until its support window ends.
- **No implementation prompt may assume simultaneous deployment of every project part** to ship a single contract change — every rule above is designed so that producers, consumers, and clients can each update on their own schedule within the stated window.
