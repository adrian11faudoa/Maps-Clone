# ADR-012: Direct-Resource JSON Responses with Cursor-Paginated Collections, GeoJSON Geometry, No Envelope Wrapping for Single Resources

## Context

Volume 2 required a single, binding decision on API response shape (envelope vs. direct resource), pagination style, and public geometry serialization, so independently implemented endpoints don't each invent their own convention.

## Decision

Single-resource endpoints return the resource directly at the JSON top level (no `{ data: {...} }` wrapper). Collections use `{ items: [...], page: { next_cursor, has_more, limit } }`. Pagination is cursor-based everywhere, never offset-based, derived from ULID ordering. Public geometry is GeoJSON; route geometry uses GeoJSON `LineString` (not an encoded polyline) for consistency with every other geometry surface in the API, at the cost of larger payloads than a polyline encoding would produce.

## Alternatives considered

- **JSON:API-style envelope** (`{ data: { type, id, attributes } }` for every resource, including singles). Rejected: adds a layer of indirection with no benefit for this platform's client set (first-party web/mobile clients, not a public third-party API ecosystem where JSON:API's tooling ecosystem would pay for itself).
- **Offset/limit pagination.** Rejected per `06-api-architecture.md`'s original reasoning: unsafe over mutable, high-write datasets (places, reviews) — a page boundary shifts under concurrent writes, producing skipped or duplicated results.
- **Encoded polyline for route geometry** (Google's polyline algorithm or similar). Rejected as the default: while more compact, it requires every consumer (web, mobile, any future third-party integration) to implement a polyline decoder, whereas GeoJSON is directly consumable by MapLibre GL JS and virtually every geospatial library without a decoding step. Payload size is mitigated by gzip/brotli compression at the edge, which compresses repetitive GeoJSON coordinate arrays well in practice.

## Consequences

Every endpoint in `contracts/openapi/core-v1.yaml` follows this shape without exception; a future endpoint that wants to diverge must get a new ADR, not a local decision. Route geometry payload size is monitored (`23-realtime-navigation-protocol.md` SLOs) and revisited only with evidence it's a genuine problem, not preemptively.

---

# ADR-013: WebSocket (Not SSE or Long-Polling) for the Navigation Realtime Protocol, with Redis-Backed Session State (Not Sticky Connections)

## Context

Navigation needs bidirectional real-time communication (client sends location, server pushes state) with a defined reconnect/resync story, one connection per session, and horizontal scalability across `navigation-api` replicas.

## Decision

WebSocket is the primary transport (`contracts/realtime/navigation-protocol.schema.json`), with a REST fallback (`POST .../location`, `GET .../sessions/{id}`) for environments where a persistent WebSocket is impractical. Session state lives in Redis (`nav:session:{id}:state`), not in any single `navigation-api` instance's memory, so any replica can serve a reconnect without sticky-session load balancing.

## Alternatives considered

- **Server-Sent Events (SSE) + separate REST POST for location updates.** Rejected: SSE is one-directional (server→client only), so location updates would need a separate REST channel anyway, splitting one logical bidirectional stream into two transports with independent failure modes and reconnect logic to coordinate — more complexity than one bidirectional WebSocket.
- **Long-polling.** Rejected: higher latency for state updates (bounded by poll interval) and higher connection overhead at scale (repeated HTTP handshakes) than a single persistent WebSocket connection, for a use case (turn-by-turn navigation) where update latency directly affects safety-adjacent instruction timing.
- **Sticky-session load balancing (route reconnects to the same instance that held the connection).** Rejected: couples horizontal scaling to load-balancer session affinity, and complicates instance recycling/deployment (an instance can't be cleanly drained without dropping affinity-pinned connections); Redis-backed state removes the need entirely — a reconnect to any instance is fully resumable.

## Consequences

Every `navigation-api` replica must connect to the same Redis, adding it to the request-path critical dependency for live updates (mitigated by the documented REST-fallback degradation in `23-...md`'s failure matrix when Redis itself is unavailable). The one-connection-per-session rule (replacing a prior connection on new connect) is implemented at the session level in Redis, not at the load balancer.

---

# ADR-014: Header-Based Idempotency Keys with Server-Side Request Fingerprinting, Optimistic Concurrency via Per-Resource Version Fields

## Context

Several write endpoints (contribution/review/media/navigation-session creation) need protection against duplicate submission from client retries; several mutable resources (Place, Review, NavigationSession, ModerationCase) need protection against lost updates from concurrent writers.

## Decision

`Idempotency-Key` header, server-stored with a request-body fingerprint, 24-hour retention, `409` on a reused key with a different body (`24-queue-and-redis-keyspace-contracts.md`). Optimistic concurrency via an explicit `version` integer column/field per mutable resource, `409 conflict` on a version mismatch, rather than database-level row locking for the general case.

## Alternatives considered

- **Idempotency via natural request uniqueness only (e.g., relying on a unique constraint like `(place_id, user_id)` for reviews) without a dedicated key.** Rejected as the sole mechanism: works for the review case specifically but doesn't generalize to operations without a natural uniqueness constraint (contribution submission, navigation-session creation), so a uniform mechanism was preferred over a per-endpoint bespoke solution.
- **Pessimistic locking (`SELECT ... FOR UPDATE`) as the default concurrency mechanism.** Rejected as the default: holds database locks for the duration of a request/transaction, which doesn't scale well under the platform's target write concurrency for frequently-edited resources; reserved (per `10-database-postgis-architecture.md`) only for the specific multi-row invariants that genuinely need it (e.g., rating aggregate recomputation), not general single-resource updates.

## Consequences

Every mutable canonical entity's schema (`contracts/entities/*.schema.json`) that supports concurrent edits carries an explicit `version`-bearing pattern (see the `x-mutable-fields` metadata), and the OpenAPI response for that resource must surface it so clients can round-trip it — an entity that's optimistically-concurrent in the database but doesn't expose its version field in the API response would be a silent contract gap; the cross-artifact consistency rule in `22-...md` is what prevents that gap from going unnoticed.

---

# ADR-015: Provider-Neutral Adapter Interface for All External Integrations, Configuration-Driven Fallback Behavior

## Context

Multiple external provider classes (geographic data, traffic, transit, push/email, content scanning) each need timeout/retry/circuit-breaker/error-mapping behavior, and the public domain contracts must never leak provider-specific shapes.

## Decision

One common adapter configuration shape (`contracts/config/provider-adapter.schema.json`) covers every provider class, with `fallback_behavior` as an explicit, closed-enum configuration field tying each provider to one of the platform's documented degradation behaviors (`23-realtime-navigation-protocol.md`'s failure matrix), rather than leaving fallback behavior as adapter-code-specific logic invented independently per provider.

## Alternatives considered

- **Bespoke configuration/interface per provider class.** Rejected: would require every implementation prompt touching an external provider to reinvent timeout/retry/circuit-breaker conventions, risking inconsistent resilience behavior across providers (e.g., one provider retrying forever with no circuit breaker while another correctly backs off) — directly undermines the anti-retry-storm guidance in `18-observability-reliability-architecture.md`.

## Consequences

Adding a new provider (e.g., a second traffic vendor) is a configuration addition (`provider_specific` extension point) rather than a new architectural pattern; QA can write one adapter-contract test harness (`26-cross-part-implementation-matrix-v2.md`) that exercises every provider's configured `fallback_behavior` uniformly by simulating failure and asserting the documented platform-level degradation occurs, rather than one bespoke test per provider integration style.
