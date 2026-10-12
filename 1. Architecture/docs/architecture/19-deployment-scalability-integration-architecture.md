# 19 — Deployment, Scalability, and External Integration Architecture

## Environment model

| Environment | Purpose | Data | Notes |
|---|---|---|---|
| Local development | Individual developer workstation | Synthetic/seeded, small geographic extract | Docker Compose for Postgres/PostGIS, Redis, Kafka/Redpanda (single-broker), OpenSearch (single-node) |
| CI | Automated test execution on every change | Ephemeral, per-run | Same container images as local, spun up per pipeline run, torn down after |
| Test | Shared integration testing | Synthetic, refreshed periodically | Used for cross-service integration tests beyond unit-level CI |
| Development | Shared team-facing environment for in-progress work | Larger synthetic/sampled real-structure data | May run smaller-scale infra (single-AZ) |
| Staging | Production-like pre-release validation | Production-structure data, either sampled/anonymized production data or full synthetic-at-scale | Full multi-AZ topology mirroring production, smaller instance sizes |
| Production | Live user traffic | Real data | Multi-region-capable (see scalability section) |
| Disaster recovery | Standby capability for regional failure | Replicated production data | See backup/DR subsection |

Configuration, secrets, and feature flags are environment-scoped and never hardcoded per `../../contracts/config/service-config.schema.json` (schema is identical across environments; values differ).

## Deployment boundaries

| Component class | Deployment unit | Scaling unit |
|---|---|---|
| Application services (`core-api`, `search-api`, `routing-api`'s NestJS layer, `navigation-api`, `traffic-service`, `media-service`) | Container image, deployed to Kubernetes (once operational complexity justifies it — see ADR-001) or a simpler container platform for early stages | Horizontal pod/instance autoscaling on CPU/RPS/latency |
| `routing-engine` process | Container image, co-scheduled/sidecar or independently scaled service depending on the selected engine's operational model | Horizontal scaling of stateless query replicas; the routing graph itself is versioned/distributed to each replica, not shared mutable state |
| `geodata-pipeline` (batch) | Scheduled/triggered Kubernetes Jobs or equivalent batch execution | Not autoscaled in the request-serving sense; resourced for peak batch computation, scaled to zero between runs where the platform supports it |
| `notification-worker`, other queue workers | Container image, worker deployment | Horizontal scaling on queue depth |
| Databases (PostgreSQL/PostGIS) | Managed database service where available, else self-managed with documented HA topology | Vertical scaling primarily; read-replica horizontal scaling for read traffic |
| Redis | Managed Redis service where available | Vertical + read-replica scaling; cluster mode for high-throughput namespaces if a single node becomes a bottleneck |
| OpenSearch | Managed or self-managed cluster | Horizontal (add data nodes), shard count planned per index size |
| Kafka/Redpanda | Managed or self-managed cluster | Horizontal (add brokers/partitions) |
| Object storage + CDN | Managed cloud service | Effectively unlimited horizontal scale (provider-managed) |
| Web/mobile clients | Static asset hosting (web) + app store distribution (mobile) | CDN-fronted for web; N/A for mobile |

## Secrets, certificates, configuration, feature flags

- **Secrets:** stored in a dedicated secrets manager (cloud-provider-native or HashiCorp Vault-equivalent), injected into services at runtime (environment variables or mounted files populated at deploy/start time), never committed to the repository, never baked into container images.
- **Certificates:** TLS termination at the edge uses certificates issued/rotated via an automated certificate-management process (e.g., ACME); internal mutual TLS between Zone 2 services (see `17-...md`) uses a private CA with automated short-lived certificate rotation.
- **Configuration:** validated against `../../contracts/config/service-config.schema.json` at service startup — a service refuses to start with invalid/incomplete configuration rather than starting in an undefined state.
- **Feature flags:** a pluggable feature-flag boundary (provider-agnostic interface) allows gradual rollout of new capabilities (e.g., a new traffic provider, a new routing engine) without a full redeploy; flag state itself is configuration, not a secret, but flag *evaluation* for user-targeted flags respects the same authorization boundaries as everything else (a flag must not become an authorization bypass).

## Deployment safety

- **Immutable builds:** every deployment is a specific, immutable container image tag (never `:latest` in any environment beyond local dev); the exact image digest deployed is recorded for rollback and audit.
- **Migrations:** run as a distinct pipeline step before the new application version receives traffic, following the expand/contract pattern from `10-database-postgis-architecture.md` for anything destructive, so that the previous application version remains compatible with the schema during a rolling deployment.
- **Health/readiness gating:** a new instance receives traffic only after passing its readiness check (per `18-...md`); rolling deployment proceeds instance-by-instance/batch-by-batch, never a full-fleet simultaneous cutover.
- **Canary/staged rollout:** for higher-risk changes (routing-engine version bump, ranking-weight changes, major schema migrations), a canary slice of traffic validates the change before full rollout — the specific canary percentage/duration is an operational runbook decision, not fixed in this architecture.
- **Rollback:** every deployment is rollback-capable to the immediately prior immutable image; database migrations are compatible across one rollback step by the expand/contract discipline above; `MapDataVersion`/`TileVersion`/routing-graph rollback follow their own versioned-artifact rollback path (`09-...md`, `12-...md`).
- **Compatibility between application versions:** API/event/schema changes follow the additive-first discipline in `06-api-architecture.md` and `14-event-queue-architecture.md` specifically so that N and N+1 application versions can coexist during a rolling deploy without incompatibility.

## Scalability mapping

| Workload | Expected scaling dimension | Mechanism |
|---|---|---|
| API requests (general) | Horizontal | Stateless service replicas behind a load balancer, autoscaled on RPS/latency/CPU |
| Search/autocomplete | Horizontal (query layer) + index sharding | OpenSearch shard count planned by index size; query-layer replicas scaled independently |
| Tile delivery | CDN-absorbed (near-unlimited) | CDN edge caching; origin scaled for cache-miss volume only, which is small relative to total traffic |
| Geocoding | Horizontal | Stateless, backed by read-scaled PostGIS + OpenSearch |
| Route computation | Horizontal (stateless query replicas) + graph distribution | Each `routing-engine` replica holds a full (or regionally-partitioned) copy of the current routing graph; new replicas pull the latest published graph version on startup |
| Navigation sessions | Horizontal, connection-bound | WebSocket connection count is the primary scaling driver; `navigation-api` replicas scale on concurrent-connection count, with session state in Redis (shared, not per-instance-local) so any replica can serve reconnects |
| Location telemetry | Horizontal, throughput-bound | High-throughput ingestion tier (Kafka producer path) decoupled from any synchronous processing; consumer-side aggregation scales independently |
| Traffic processing | Horizontal (stream processing) | Kafka partition count sized for target throughput; consumer group scales with partition count |
| Media | CDN-absorbed for delivery; processing horizontally scaled | Upload/processing workers scale on queue depth |
| Events (Kafka) | Horizontal | Partition count planned per topic for target throughput and consumer parallelism |
| Background jobs | Horizontal | Worker fleet scales on queue depth per job category |

**Geographic partitioning / sharding candidates** (not implemented in this volume, boundary reserved): `geodata`/routing-graph build parallelization by region (build-time optimization, not a serving-time shard); OpenSearch index-per-region as a future option if global index size becomes unwieldy; `traffic.traffic_snapshot` is already time-partitioned and could additionally be region-partitioned if write volume in a single region dominates. None of these are premature default choices — they are documented triggers for a future scaling decision, consistent with the Master Prompt's instruction not to prematurely introduce distributed infrastructure without demonstrated need.

**Regional deployment / multi-region:** the architecture's service-boundary and event-driven design does not preclude multi-region deployment (e.g., active-active for stateless query services fronted by a geo-aware load balancer, with a primary-region writable database and read replicas in other regions), but a specific multi-region topology is an infrastructure-implementation-prompt decision building on this document's boundaries, not fixed here.

## Disaster recovery and backups

- **Backup frequency/retention:** continuous WAL archiving + daily full backups for PostgreSQL (per `10-...md`), retained per a documented window (e.g., 35 days) enabling point-in-time recovery within that window.
- **Restore procedure:** documented runbook; **restore is tested on a recurring schedule** (e.g., monthly) by actually restoring into an isolated environment and validating against known-good markers — a backup job's "success" status is never treated as proof restoration works, per the Master Prompt's explicit requirement.
- **Regional failure:** DR environment maintains a replicated copy of production data (cross-region read replica or equivalent) with a documented recovery time objective (RTO) and recovery point objective (RPO) — exact numeric targets are a business/operational decision layered on this architecture, not fixed here, but every production datastore listed in `10-...md`/`14-...md` must have an assigned RTO/RPO before go-live.
- **Non-database artifacts:** `MapDataVersion` raw/normalized snapshots, tile artifacts, and media originals are backed by object storage's own cross-region replication where enabled, independent of the database backup path.

## External integration boundaries

Each external provider is integrated through an explicit adapter with this shape (formalized per-provider in implementation, structure fixed here):

```text
interface ExternalProviderAdapter<Req, Res> {
  call(request: Req, context: { correlation_id, timeout_ms }): Promise<Res>
  // internally implements: authentication, retry, circuit breaker, rate-limit
  // awareness, error mapping to the platform's error catalog (07-...md),
  // and observability instrumentation (18-...md)
}
```

| Provider class | Auth mechanism | Timeout | Retry | Rate limit/quota handling | Error mapping | Fallback |
|---|---|---|---|---|---|---|
| Geographic base-data source | Source-specific (API key or bulk-download credential) | Long (bulk download, batch context) | Job-level retry (`14-...md`) | Respects source-documented rate/quota limits in the ingestion scheduler | Ingestion failure alert, does not affect serving (see `09-...md`) | Continue serving last published `MapDataVersion` |
| Commercial traffic provider (optional) | API key / OAuth client credentials | Short (request-path-adjacent, feeds aggregation) | Bounded retry + circuit breaker | Quota-aware request throttling in `traffic-service` | Maps to internal "traffic source degraded" state, not a user-facing error | Traffic aggregation continues from telemetry-only sources, or `used_live_traffic: false` if no source available |
| Transit feed (optional, GTFS/GTFS-RT) | Source-specific | Moderate | Bounded retry | Respects feed publisher's documented refresh cadence | Ingestion failure alert | Transit mode routing degrades/unavailable, does not affect other modes |
| Push notification providers (APNs/FCM) | Provider-specific (certificate/key-based) | Short | Bounded retry + circuit breaker per provider independently | Provider-documented rate limits respected in `notification-worker` | Maps to `NotificationFailed` per delivery attempt | Falls back to remaining requested channels (e.g., email, in-app) |
| Email provider | API key | Short | Bounded retry | Provider-documented limits | Maps to `NotificationFailed` | Same as above |
| Malware/content scanning provider | API key | Short-to-moderate | Bounded retry | Provider-documented limits | Upload processing blocked pending scan result; scan-provider outage delays (queues) processing rather than skipping the scan | Media remains in `pending` status, never auto-approved on scan-provider failure |
| Object storage / CDN | Provider IAM | Short | Bounded retry | Provider-managed | Maps to `502`/`503` per `07-...md` | CDN edge cache survives brief origin/provider blips |
| Identity federation (future) | OAuth/OIDC | Short | Bounded retry | Provider-documented | Maps to `unauthenticated`/`dependency_unavailable` | Falls back to password login (once federation exists as an addition, not a replacement) |

No provider-specific request/response shape leaks past its adapter boundary into domain logic or the public API contract — domain code and the public API always deal in the platform's own types.

## Validation record for this volume's machine-readable artifacts

The following validations were executed against the artifacts in `../../contracts/` at authoring time (see the completion report for exact commands/output):

- `contracts/openapi/core-v1.yaml` validated as a structurally correct OpenAPI 3.1 document.
- Every file in `contracts/events/schemas/*.json` validated as syntactically correct JSON Schema (draft 2020-12) and cross-checked against `contracts/events/registry.md` for one-to-one coverage.
- `contracts/config/service-config.schema.json` validated as syntactically correct JSON Schema, and a representative example configuration validated against it.
- `contracts/db/core-entities.sql` validated for syntactic correctness by executing it against a disposable PostgreSQL/PostGIS instance in the build environment.
- A dedicated script, `contracts/scripts/validate.py`, performs all of the above checks and is intended to run in CI on every change to `contracts/`.
