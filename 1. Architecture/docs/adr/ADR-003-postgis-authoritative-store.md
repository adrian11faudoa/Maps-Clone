# ADR-003: PostgreSQL/PostGIS as the Authoritative Geospatial Store

## Context

The platform needs a transactionally consistent, queryable store for canonical geospatial data (places, addresses, road segments, administrative regions) supporting spatial indexing, containment/nearest-neighbor queries, and strong consistency guarantees for writes (contributions, moderation).

## Decision

PostgreSQL with the PostGIS extension is the authoritative store for all canonical geospatial and transactional business data (`10-database-postgis-architecture.md`). Specialized derived stores (OpenSearch for search, routing-engine-native graph formats, vector tile artifacts) are built *from* PostGIS, never in place of it.

## Alternatives considered

- **A dedicated spatial/NoSQL database (e.g., MongoDB with geo indexes) as the primary store.** Rejected: weaker transactional/consistency guarantees for the platform's write-heavy, invariant-sensitive domains (moderation-gated place mutation, review aggregate recomputation) than PostgreSQL's ACID transactions; PostGIS's spatial function library (validity checking, topology operations) is more mature for authoritative geospatial data management.
- **Using OpenSearch as the primary geospatial store, skipping PostGIS.** Rejected: OpenSearch is well-suited for derived, eventually-consistent, ranked search but is not designed as a transactional system of record; using it as such would violate the "derived indexes must not become accidental sources of truth" principle (`02-...md`/`03-...md`).

## Consequences

- A single relational engine hosts multiple schemas by domain (`10-...md`), requiring disciplined per-schema access grants to preserve domain ownership boundaries within one physical cluster.
- Geometry-vs-geography type selection must be made deliberately per table (documented in `10-...md`) since PostGIS supports both, and a wrong default choice would hurt either correctness (geometry near poles/antimeridian) or performance (geography at high volume).
- Routing-graph and tile-build pipelines add operational complexity (derived-artifact build/versioning) but keep the authoritative store's write path simple and consistent, which is the higher-priority property for a system where geospatial data correctness has real-world (navigation-safety-adjacent) consequences.
