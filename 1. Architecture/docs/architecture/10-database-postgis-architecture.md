# 10 — Database / PostGIS Architecture

## Ownership and schema namespacing

A single PostgreSQL/PostGIS cluster (with read replicas — see `19-...md`) hosts multiple **schemas**, one per domain cluster, enforcing logical separation even where physically co-located initially:

| Schema | Owning domain(s) | Notes |
|---|---|---|
| `identity` | Identity, Users | Highest-sensitivity schema; tightest access grants |
| `places` | Places, Saved Places, Contributions, Reviews & Ratings | Grouped because they share heavy referential locality (all hang off `Place`) |
| `geodata` | Geographic/Address Data | PostGIS-heavy, large tables, mostly-read after publication |
| `routing` | Routing (audit/analytics sample only — hot path is Redis + engine-native graph) | |
| `navigation` | Navigation | Session state; high write churn, short-lived rows |
| `traffic` | Traffic | Time-bucketed, rolling-window retention |
| `media` | Media | Metadata only; binaries in object storage |
| `notifications` | Notifications | |
| `moderation` | Moderation & Administration | Append-only `audit_record` table lives here |

Each backend deployable connects with a database role scoped to only the schema(s) its owned domains need, enforced via PostgreSQL `GRANT`s — a service cannot read or write another domain's schema even if it wanted to, independent of application-layer discipline.

## Geometry vs. geography type decision

| Table | Column | Type | Rationale |
|---|---|---|---|
| `geodata.road_segment` | `geom` | `geometry(LineString, 4326)` | High-volume, mostly local/bounded-extent queries (routing graph build, tile clipping); `geometry` operations are faster and sufficient given data is pre-validated planar-safe for the extents queried |
| `geodata.administrative_region` | `geom` | `geometry(MultiPolygon, 4326)` | Same as above; large polygon counts, performance-sensitive containment queries via GiST index |
| `places.place` | `location` | `geography(Point, 4326)` | Nearby/radius queries ("places within 2km") are the dominant access pattern and must be accurate great-circle distances regardless of latitude, including near poles/across the antimeridian; point data volume is far lower than road-segment volume so the performance cost of `geography` is acceptable |
| `traffic.traffic_snapshot` | `segment_ref` (FK, no own geometry) | n/a | Traffic snapshots reference `road_segment.id`; geometry is not duplicated |
| `navigation.location_update` | `point` | `geography(Point, 4326)` | Point-in-time, low volume per row, correctness of distance-to-route matching matters more than raw throughput |

General rule: **`geography`** where correctness of real-world distance/radius queries across arbitrary latitude is the dominant requirement and row volume is moderate; **`geometry`** where volume/performance dominates and the extents involved make planar approximation acceptable (validated per use case, not assumed).

## Spatial reference system

EPSG:4326 for all stored geometry/geography (see `05-...md`). No table stores geometry in a different SRID; any projection needed for computation (e.g., Web Mercator for tiling) happens in the consuming component (Map Tiles), not in the canonical store.

## Indexing

- **Spatial indexes:** GiST index on every `geometry`/`geography` column used in spatial predicates (`ST_DWithin`, `ST_Intersects`, `ST_Contains`, `&&`).
- **Standard indexes:** B-tree on all foreign keys, on `(created_at)` for cursor pagination support (ULID primary keys already sort by creation time, so pagination cursors are primary-key-based, not separate timestamp indexes, except where a query needs to sort by a non-ID timestamp like `updated_at`).
- **Composite indexes:** `traffic.traffic_snapshot (road_segment_id, time_bucket)` as the primary access pattern; `places.review (place_id, created_at)` for place-scoped review listing.
- **Partial indexes:** used for soft-delete filtering (e.g., `WHERE deleted_at IS NULL`) on high-traffic tables (`place`, `review`) so default queries don't scan tombstoned rows.
- **Text search:** PostgreSQL is not the search engine of record (OpenSearch is — see `11-...md`); Postgres does not carry `tsvector`/GIN text-search indexes for user-facing search, to avoid two competing search implementations. A lightweight `pg_trgm` index may exist on `place.name` purely to support fast internal admin-tooling lookups, not user-facing search.

## Partitioning candidates

| Table | Partitioning strategy | Trigger |
|---|---|---|
| `traffic.traffic_snapshot` | Range partition by `time_bucket` (e.g., daily) | From day one — rolling-window retention makes drop-partition the efficient purge mechanism |
| `navigation.location_update` | Range partition by `created_at` (e.g., hourly) | From day one — same reasoning, very high write volume, short retention |
| `moderation.audit_record` | Range partition by `created_at` (e.g., monthly) | Once table exceeds an operational size threshold (append-only, indefinite retention, so partitioning aids archival/compliance export rather than purge) |
| `places.review`, `places.place` | Not partitioned initially | No natural time-bounded purge pattern; revisit if row counts materially exceed single-table operational comfort |

## Transactions, isolation, concurrency

- Default isolation level: `READ COMMITTED` (PostgreSQL default), sufficient for the vast majority of operations given per-aggregate transactional boundaries.
- Aggregate-level transactional boundaries: a single transaction never spans more than one bounded context's schema (e.g., approving a `Contribution` and applying the resulting `Place` mutation are two separate transactions coordinated via the `ContributionApproved` event and an idempotent consumer in Places — not one cross-schema transaction). This preserves the domain-ownership rule in `03-...md` and avoids distributed-transaction complexity.
- Within a single domain's schema, multi-row invariants (e.g., `Review` create + `Place` aggregate rating recompute) use `SERIALIZABLE` or explicit row-locking (`SELECT ... FOR UPDATE`) only where the specific invariant demands it (e.g., rating aggregate correctness under concurrent review writes); most operations remain at `READ COMMITTED` with optimistic concurrency (`updated_at`/version column check) for update conflicts.
- Optimistic concurrency: mutable canonical entities (`Place`, `Review`) carry a `version` integer column; updates include a `WHERE version = :expected_version` clause and treat zero-rows-affected as a `409 conflict`.

## Migrations

- Forward-only, versioned migration files (tool-agnostic at this architecture layer; implementation prompts select a specific migration tool such as Prisma Migrate, but must honor the following rules regardless of tool):
  - Every migration is reversible in principle (a corresponding down-migration or documented manual rollback procedure exists) even if forward-only is the default operational path.
  - Destructive migrations (column/table drop) require a two-phase deploy: phase 1 stops writing/reading the column (application-level), phase 2 (a later migration) drops it, separated by at least one full deployment cycle, to preserve rolling-deployment compatibility (see `19-...md`).
  - Migrations never lock large tables for unbounded durations in production; long-running backfills run as background batch jobs writing to a new column/table, swapped in once complete.

## Read replicas

- Read replicas are used for read-heavy, replication-lag-tolerant query classes: place/search-adjacent reads, analytics extraction, admin reporting.
- Replication-lag-sensitive reads (a user's own just-submitted contribution, navigation session state) always read from the primary.

## Backup strategy

- Continuous WAL archiving + daily full base backups, enabling point-in-time recovery (PITR). Backups are stored in object storage with lifecycle-managed retention, in a different failure domain from the primary database.
- Backups are periodically restored into an isolated environment and validated (row-count/checksum spot checks against known-good markers) — a completed backup job is not treated as proof of a working restore path (per Master Prompt's disaster-recovery requirement); see `19-...md` for the DR testing cadence.

## Archival

- `navigation.location_update` and raw `LocationEvent` buffers are purged (not archived) per the privacy retention window in `17-security-privacy-architecture.md` — they are not backed up long-term beyond the operational backup window, by design.
- `moderation.audit_record` is archived, never purged, consistent with its compliance role.
