# 18 — Observability and Reliability Architecture

## Observability stack

- **Standard:** OpenTelemetry (OTel) SDKs in every service for traces, metrics, and log correlation. Exporters target an OTel Collector, which fans out to Prometheus (metrics), Tempo or equivalent (traces), Loki or equivalent (logs) — exact backend selection is an infrastructure decision (`19-...md`), but the **in-application instrumentation contract is OTel-standard and backend-agnostic**, so swapping the backend never requires re-instrumenting services.
- **Correlation:** every log line, metric label (where cardinality-safe), and trace span carries `correlation_id` and `trace_id` (see `05-identifier-time-coordinate-model.md`) so a single user-facing request can be reconstructed across service boundaries and into any events it caused.

## What every production-relevant component instruments

| Component | Metrics | Traces | Logs (structured) | Health/readiness/liveness |
|---|---|---|---|---|
| API edge | Request rate, latency histogram, status-code distribution, rate-limit rejections | Root span per request | Access log (method, path, status, correlation_id, latency) | `/healthz`, `/readyz` |
| Application services (`core-api`, etc.) | Per-endpoint latency/error rate, DB query duration, cache hit rate | Span per handler, child spans for DB/Redis/OpenSearch/external calls | Structured JSON logs with correlation_id | `/healthz`, `/readyz` (checks DB/Redis connectivity) |
| PostgreSQL/PostGIS | Query duration, connection pool utilization, replication lag, slow-query log | N/A (instrumented at the query-issuing service) | Slow query log | DB-native health checks |
| Redis | Hit/miss rate, memory usage, eviction rate, connection count | N/A | N/A (metrics-first) | Redis-native health checks |
| Search (OpenSearch) | Query latency, indexing lag (event consumed → document searchable), index size, rejected-request rate | Span per search request | Slow query log | Cluster health API |
| Routing engine | Computation latency, graph load time/version, request queue depth | Span per route computation | Engine process logs | Process health check |
| Navigation | Active session count, WebSocket connection count, location-update ingest rate, off-route/reroute rate | Span per session lifecycle event | Session state-transition logs (redacted per `17-...md`) | `/healthz`, `/readyz` |
| Location telemetry ingestion | Ingest rate, validation rejection rate, clock-skew-flagged rate | Span per ingest batch | Rejection reason logs (aggregate counts, not per-event PII) | `/healthz` |
| Queues/workers | Queue depth, job latency, retry rate, DLQ rate | Span per job execution | Job lifecycle logs | Worker liveness (heartbeat) |
| Event streams (Kafka) | Consumer lag per group, produce/consume throughput, partition count | N/A (spans on producer/consumer boundary in the owning service) | Broker/consumer error logs | Broker + consumer-group health |
| Media processing | Upload success/failure rate, scanning result distribution, processing latency | Span per upload lifecycle | Rejection reason logs | `/healthz` |
| External providers (traffic, notifications, geographic sources) | Per-provider call latency, error rate, quota utilization | Span per outbound call, tagged with provider name | Provider error responses (redacted) | Circuit-breaker state exposed as a metric |
| Map-tile delivery | CDN cache hit rate (from CDN provider metrics), origin request rate, tile-build duration/success | Span per build job | Build job logs | Origin `/healthz` |

## Dashboards and alerts (representative, not exhaustive)

- **Golden signals per service:** latency (p50/p95/p99), traffic (RPS), errors (rate by error `code` from `07-error-contract.md`), saturation (CPU/memory/connection pool).
- **Domain-specific:** search indexing lag, routing-engine graph staleness (time since last successful `MapDataVersionPublished`-triggered rebuild), traffic-snapshot freshness, navigation off-route/reroute rate (spike may indicate a routing-quality regression), notification delivery failure rate per provider, DLQ depth per consumer group.
- **Alert routing:** severity-tiered (page vs. ticket vs. dashboard-only), with alert conditions tied to documented SLOs per component (exact SLO numbers are a per-implementation-prompt operational decision, not fixed in this architecture volume, but every component listed above must have at least one alerting rule before it is considered production-ready).

## What must never be logged

See `17-security-privacy-architecture.md` logging redaction rules — this document's instrumentation guidance is subordinate to those rules; no metric label, log field, or trace attribute may carry credential material, full precise location history, or other classified-sensitive data beyond the documented operational minimum.

## Reliability: per-dependency failure behavior

| Dependency | Timeout | Retry | Failure isolation / degraded behavior |
|---|---|---|---|
| PostgreSQL (primary) | Per-query timeout (short, e.g., single-digit seconds) | Bounded retry with backoff for transient connection errors only, never for constraint-violation-class errors | A domain's primary-DB outage fails that domain's writes (`503`/`dependency_unavailable`); does not cascade to unrelated domains' schemas (separate connection pools per schema owner) |
| PostgreSQL (read replica) | Same as primary | Same | Falls back to primary for replica-dependent reads if replica is unavailable, accepting higher primary load temporarily, rather than failing the read |
| Redis | Short timeout (sub-second) | One quick retry, then fail open per the specific use's documented failure behavior in `14-event-queue-architecture.md`'s Redis table | Never a hard failure of the calling request — every Redis use in this architecture has an explicit degraded-mode fallback |
| OpenSearch | Short-to-moderate timeout | Bounded retry for transient errors | Search/autocomplete return `502 dependency_unavailable`; Geocoding's structured PostGIS path continues to function (see `11-...md`); does not block place writes (indexing is async/event-driven) |
| Routing engine | Moderate timeout (route computation can be nontrivial) | One retry for transient engine errors, not for `route_not_found`-class results | Route computation fails (`502 routing_engine_unavailable`); Navigation sessions already in progress continue using their already-computed route/steps (no forced session termination on a transient routing-engine blip) |
| Traffic service | Short timeout | One retry | Routing/Navigation proceed without traffic-awareness (`traffic_assumptions.used_live_traffic: false`) rather than failing — per `13-...md`'s "never fabricate, but also never block" rule |
| Geographic data pipeline (`geodata-pipeline`) | N/A (batch, not request-path) | Job-level retry per `14-...md` queue table | A pipeline failure does not affect currently-serving Geographic/Address Data, Map Tiles, or Routing graph — the previous published version continues serving (see `09-...md`) |
| Object storage / CDN | Short timeout for API calls; CDN itself is the primary serving path for tiles/media | Bounded retry with backoff | Media upload/processing degrades gracefully (`502`/queued-for-retry); tile/media serving relies on CDN edge cache surviving brief origin issues |
| Kafka/event broker | Producer: bounded retry via outbox relay (see `14-...md`) — a broker outage delays publication, never loses the event, since the outbox row persists in Postgres until successfully published | N/A (relay retries continuously with backoff until success) | Domain writes remain available (outbox write is local to the domain's own transaction) even during a full broker outage; only downstream event-driven effects (search indexing, notifications, etc.) lag until the broker recovers |
| Queue workers (BullMQ/Redis-backed) | Per-job timeout | Per job-category retry policy (`14-...md`) | Job failures beyond max attempts dead-letter, never silently vanish; a worker-fleet outage delays async work without losing it (jobs remain queued in Redis, itself backed by Redis persistence/AOF per infra config) |
| External providers (traffic feed, push/email, geographic sources) | Provider-appropriate timeout, generally short | Bounded retry with backoff; circuit breaker opens after a sustained failure rate to stop hammering a failing provider | Documented per-provider fallback (traffic: degrade to non-traffic-aware; notifications: queue and retry, in-app channel unaffected; geographic sources: continue serving last published `MapDataVersion`) |

## Anti-retry-storm measures

- Exponential backoff with jitter on every retry path listed above (never fixed-interval retry at scale).
- Circuit breakers on external-provider adapters (`19-...md`) prevent a struggling downstream provider from being hammered by a full-throughput retry stream from every calling instance simultaneously.
- Bounded queue/consumer concurrency (configured, not unbounded) prevents a backlog-draining recovery from itself becoming a thundering-herd load spike against recovering dependencies (e.g., Postgres, OpenSearch).

## Graceful degradation summary

Critical mapping functionality (viewing the map, basic search, route computation without traffic) remains available when any single **noncritical** dependency (Traffic, Notifications, Analytics, external geographic-source live connectivity) fails. The dependencies whose failure legitimately degrades a **critical** path are called out explicitly above (PostgreSQL for the owning domain, the routing engine for route computation, OpenSearch for free-text search specifically) — this is intentional and documented, not an oversight; the architecture does not claim 100% of functionality survives every possible failure, only that failure impact is scoped to what a dependency is actually load-bearing for.

## Recovery and reconciliation

- Consumers resuming after an outage process their backlog from the last committed offset (Kafka) — no manual reconciliation step required for eventually-consistent derived stores (Search, Analytics) beyond normal catch-up processing.
- `geodata-pipeline` publish jobs are safe to retry/resume from the last successful stage (raw snapshot → normalize → publish) without reprocessing already-completed stages, via stage-level completion markers.
- Navigation sessions reconcile via the resume-window mechanism in `13-...md` rather than requiring a distinct "recovery procedure" — the session state machine already accounts for connectivity loss as a first-class transition, not an exceptional recovery path.
