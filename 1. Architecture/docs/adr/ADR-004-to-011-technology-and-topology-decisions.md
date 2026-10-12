# ADR-004: OpenSearch as the Search Engine, Behind a Derived-Index Boundary

## Context

Free-text/geo search, autocomplete, and ranking need a purpose-built search engine; the choice must not let the engine's data model become an accidental system of record.

## Decision

OpenSearch (Elasticsearch-API-compatible, open-source) is the search engine of record, always treated as a derived, rebuildable projection of PostGIS canonical data (`11-search-geocoding-autocomplete-architecture.md`), fed via event-driven indexing (`14-...md`), never written to synchronously as part of a canonical domain transaction.

## Alternatives considered

- **Algolia or another managed SaaS search provider.** Rejected as the *architectural default*: introduces a hard external-provider dependency for a core discovery capability and a proprietary query DSL; OpenSearch's open-source, self-hostable nature keeps the platform's core discovery path within its own operational control, consistent with the platform's scale ambitions. (Not precluded as a future pluggable alternative behind the same Search domain boundary.)
- **PostgreSQL full-text search (`tsvector`) as the sole search mechanism.** Rejected as primary: weaker relevance ranking, fuzzy/typo-tolerance, and geo-text combined scoring than a purpose-built search engine at the platform's target scale; retained only as a narrow internal-admin-tooling convenience (`10-...md`), not the user-facing path.

## Consequences

Requires an indexing pipeline and acceptance of near-real-time (not synchronous) search consistency (`11-...md`); isolates search-engine choice behind the Search domain's API boundary so a future engine swap (e.g., to a managed provider) doesn't change `06-api-architecture.md`'s public `/v1/search`/`/v1/autocomplete` contracts.

---

# ADR-005: Routing Engine Abstracted Behind a Stable Public Contract

## Context

Production-grade routing computation benefits from an established graph-routing engine (OSRM, Valhalla, GraphHopper) rather than a from-scratch implementation, per the Master Prompt. The specific engine choice should not leak into the public API.

## Decision

`routing-api` (NestJS) owns the stable public routing contract; `routing-engine` (a specialized process running the selected engine) is swappable behind it (`13-routing-navigation-traffic-architecture.md`). This ADR does not lock in a single engine name as final — it locks in the *abstraction boundary* as the binding architectural decision; a specific engine selection is an implementation-prompt decision within this boundary.

## Alternatives considered

- **Directly exposing the routing engine's native API to clients.** Rejected: couples clients and the public contract to engine-specific request/response shapes and would make an engine migration a breaking API change — directly conflicts with the Master Prompt's requirement that the public routing contract remain stable even if the internal engine changes.
- **Implementing custom routing algorithms from scratch.** Rejected per the Master Prompt's explicit guidance to use established engines rather than reimplementing complex routing mathematics without a documented, justified reason.

## Consequences

Adds one translation layer (`routing-api`) but decouples engine lifecycle (version upgrades, engine replacement) from the public API's versioning cycle (`06-...md`).

---

# ADR-006: Kafka/Redpanda as the Event-Streaming Backbone, Transactional Outbox for Publication

## Context

Cross-domain side effects must be decoupled for failure isolation (`01-...md` principle), with at-least-once delivery and durable retention for replay-based derived-store rebuilds.

## Decision

Kafka or Redpanda (API-compatible) is the event bus, keyed by `aggregate_id` per topic family (`14-event-queue-architecture.md`), with every producing domain using a transactional outbox pattern to guarantee events are never lost or published without a corresponding committed write.

## Alternatives considered

- **Simple message queue (e.g., SQS/RabbitMQ) without durable replay/retention.** Rejected as the primary backbone: the platform relies on event replay for derived-store rebuild (Search reindex) as a first-class capability, which requires a log-structured, replayable broker rather than a queue with default at-most-once-consumed-then-gone semantics.
- **Direct synchronous service-to-service calls for all cross-domain effects.** Rejected: violates the failure-isolation principle (`01-...md`) — a Notifications outage would otherwise block a Contribution approval, for example.

## Consequences

Adds broker operational overhead (partitioning, consumer-group management, schema registry) but is the mechanism that makes the domain-boundary/failure-isolation architecture in `02-`/`03-`/`18-...md` actually hold under real failure conditions, not just in the happy path.

---

# ADR-007: Redis Scoped to Cache/Coordination Only, Never Authoritative

## Context

Redis is fast and convenient, creating a temptation to store increasingly important state in it over time ("Redis creep" into becoming an undocumented second database), which the Master Prompt explicitly warns against.

## Decision

Every Redis use in the platform is enumerated with an explicit TTL, invalidation rule, and documented fail-open/degraded behavior (`14-event-queue-architecture.md` Redis table); no Redis key is the sole durable source of truth for any fact the platform cannot afford to lose.

## Alternatives considered

- **Using Redis as the primary store for navigation session state.** Rejected as sole store: session state is mirrored to PostgreSQL (`navigation` schema) specifically so a Redis outage degrades (REST-poll fallback) rather than loses active trip state.

## Consequences

Slightly more write overhead (dual-write session state to Postgres + Redis) in exchange for the guarantee that no Redis outage is a data-loss event, only a latency/feature-degradation event (`18-...md`).

---

# ADR-008: Vector Tiles Built from Canonical PostGIS Data, Served via CDN, Independently Versioned from Style

## Context

Tile delivery must scale to very high read volume while remaining consistent with canonical geospatial data and cheaply rollback-able.

## Decision

Tiles are built offline/batch from PostGIS (`12-map-tile-architecture.md`), versioned independently of both the underlying `MapDataVersion` build cadence pairing and the map style JSON, and served through a CDN with the tile-serving origin never granting direct database query access to clients.

## Alternatives considered

- **On-the-fly tile rendering per request from live PostGIS queries.** Rejected as the default: would not scale to the platform's stated high concurrent map-traffic targets and would couple tile-serving latency directly to database load; reserved only as a potential low-traffic fallback path for regions without a pre-built tile version, not the primary architecture.
- **Raster tiles as the default format.** Rejected: vector tiles allow client-side styling flexibility (day/night themes, layer toggling) without a full tile-set rebuild per style, at lower bandwidth cost — raster remains available only where a specific client capability genuinely requires it (`12-...md`).

## Consequences

Requires a batch build pipeline and versioning discipline but decouples serving-time scalability entirely from database load, and CDN cache absorbs the overwhelming majority of traffic before it reaches any platform-owned compute.

---

# ADR-009: URL Path Major-Versioned REST API (`/v1/...`), Additive-First Evolution

## Context

Independently generated project parts (web, mobile, future third-party integrations) need a stable, predictable API evolution policy that doesn't force lockstep releases.

## Decision

Major version in the URL path (`/v1/...`); additive/backward-compatible changes ship without a version bump; breaking changes require a new major version path, with the old version supported for a documented deprecation window (`06-api-architecture.md`, `19-...md`).

## Alternatives considered

- **Header-based versioning (`Accept: application/vnd.platform.v1+json`).** Rejected: less discoverable/debuggable (URL versioning is visible in logs, browser address bars, and API testing tools without needing to inspect headers), and the platform's client base (web + mobile, both platform-controlled) doesn't need content-negotiation-style versioning flexibility that header versioning is best suited for.
- **No explicit versioning (evolve in place only additively, forever).** Rejected: unrealistic long-term guarantee for a platform expected to evolve over years; an explicit breaking-change path is needed even if used rarely.

## Consequences

Requires maintaining parallel version support during deprecation windows (`19-...md`) but gives independently-generated clients (mobile apps that can't force-update instantly) a predictable compatibility guarantee.

---

# ADR-010: Strict, Structurally-Enforced Retention Limits for Precise Location Data

## Context

Location telemetry is the platform's most privacy-sensitive data class; the Master Prompt requires it never be retained indefinitely without documented reason and never exposed cross-user without aggregation.

## Decision

Raw `LocationEvent` and `NavigationLocationUpdate` tables are time-range-partitioned specifically so retention purge is a cheap `DROP PARTITION` operation, making short retention operationally the path of least resistance rather than something requiring active discipline to maintain (`10-...md`, `17-security-privacy-architecture.md`). Traffic aggregation enforces a minimum-sample-count floor before publishing any aggregate cell.

## Alternatives considered

- **Policy-only retention (documented rule, manual/scheduled deletion job without structural partitioning support).** Rejected as the sole mechanism: a policy without a structural enforcement mechanism is more prone to silent drift (a missed cron job leaves data accumulating indefinitely with no immediate operational symptom); partitioning makes the purge mechanism cheap and visible in dashboards (partition count/size).

## Consequences

Slightly more upfront schema design complexity (partition management) in exchange for a privacy posture that is enforced by the data model itself, not solely by process discipline.

---

# ADR-011: Initial Deployment Topology — Single-Region, Multi-AZ, Multi-Region-Capable Design

## Context

The platform's long-term scale target is global, but the Master Prompt cautions against prematurely provisioning infrastructure not yet justified by real load.

## Decision

Initial production topology is single-region, multi-availability-zone (for intra-region HA), built on a service-boundary and event-driven design (`02-`, `14-...md`) that does not preclude a future multi-region expansion (`19-...md`), rather than provisioning a full active-active multi-region topology from day one.

## Alternatives considered

- **Full active-active multi-region from initial launch.** Rejected: significant added operational complexity (cross-region data consistency, conflict resolution, multi-region secrets/cert management) not yet justified without demonstrated geographically-distributed load; directly conflicts with the Master Prompt's "do not prematurely introduce distributed infrastructure with no demonstrated architectural purpose" guidance.

## Consequences

Faster, lower-risk initial launch; a documented future migration path (read replicas in additional regions, geo-aware load balancing) exists because the architecture's boundaries were designed with it in mind, but it is explicitly deferred, not implemented, in this volume.
