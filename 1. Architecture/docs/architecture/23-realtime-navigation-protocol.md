# 23 — Realtime Navigation Protocol, SLOs, and Failure Degradation

## Realtime protocol

**Authoritative schema:** `../../contracts/realtime/navigation-protocol.schema.json`. This document is its prose companion.

### Connection establishment

- Endpoint: `wss://{api-host}/v1/navigation/sessions/{sessionId}/stream`.
- **Authentication:** the access token is presented as a query parameter (`?access_token=...`) or a `Sec-WebSocket-Protocol` subprotocol-encoded token at handshake time (browsers cannot set arbitrary headers on the WebSocket handshake) — never as a cookie alone, consistent with `08-auth-architecture.md`'s bearer-token model. The server validates the token exactly as it would an HTTP request's `Authorization` header before completing the upgrade.
- **Session binding:** the connection is scoped to exactly one `sessionId` at the URL level. The server verifies the token's `sub` matches `NavigationSession.user_id` for that `sessionId` before accepting the upgrade; a mismatch closes the connection with `session_closed { reason: "unauthorized" }` sent as a normal WebSocket close frame with an appropriate close code (4403), never a silent drop, and never delivers another user's session data over any channel (per `17-security-privacy-architecture.md`).
- **One live connection per session:** if a new connection is authenticated for the same `sessionId`, the server closes the previous connection with `session_closed { reason: "replaced_by_new_connection" }` before accepting the new one — this handles the common case of a client reconnecting after a network blip without leaving a stale connection receiving state it can no longer act on.

### Message types

See the schema for full shapes. Client → server: `location_update`, `heartbeat`. Server → client: `state_update`, `heartbeat_ack`, `session_closed`, `error`.

### Sequencing and acknowledgement

- **Client sequence:** every client message carries a client-assigned, monotonically increasing `sequence` (per connection, resets on reconnect). The server rejects (via `error { code: "sequence_replay" }`, connection stays open) any `location_update`/`heartbeat` whose `sequence` is not strictly greater than the last accepted sequence on this connection — protects against a client accidentally replaying a buffered message twice.
- **Server sequence:** every `state_update` carries a `server_sequence`, monotonically increasing per **session** (not per connection — it survives a reconnect), so a client that reconnects and misses updates can detect the gap (its last-seen `server_sequence` vs. the first one received after reconnect) and knows to fall back to `GET /v1/navigation/sessions/{id}` (REST) to resynchronize state, rather than assuming it has a complete history.
- **Acknowledgement model:** the protocol is not per-message request/reply — `state_update` is fire-and-forget from the server's perspective (no client ack required) because it always carries the *current* authoritative state, not a delta; a client that misses one `state_update` is made whole by the next one, or by the REST fallback if it suspects a larger gap. `heartbeat` is the only client message the server acknowledges directly (`heartbeat_ack`), giving the client a simple round-trip-time and liveness signal independent of location-update cadence.

### Heartbeat

- Clients send `heartbeat` at a fixed interval (recommended 15–20 seconds) whenever no `location_update` has been sent more recently than that interval (an active `location_update` stream already demonstrates liveness and does not need a redundant heartbeat).
- The server treats the absence of **any** client message (heartbeat or location update) for a configured grace period as connection-level staleness, independent of the session-level "no location update" pause rule in `13-routing-navigation-traffic-architecture.md` — a client could keep the WebSocket alive with heartbeats while genuinely stationary/signal-lost, which correctly pauses the *session* without needing to tear down the *connection*.

### Reconnect and missed-message recovery

1. Client reconnects to the same `wss://.../v1/navigation/sessions/{sessionId}/stream` URL with a valid token.
2. Server re-validates ownership, closes any stale prior connection as above, and immediately sends a fresh `state_update` reflecting current authoritative state (not a replay of missed history — the protocol is state-carrying, not event-sourced from the client's perspective).
3. Client resumes sending `location_update` with a **new** sequence numbering starting from 0 (sequence is connection-scoped) but continues to interpret `server_sequence` continuously (session-scoped) to detect any gap and decide whether a REST resync (`GET /v1/navigation/sessions/{id}`) is warranted (e.g., a very large `server_sequence` jump suggesting a reroute happened while disconnected).
4. If the underlying `NavigationSession` had transitioned to `paused` during the disconnect (per the session-level pause rule), the first accepted `location_update` after reconnect transitions it back to `active` (or triggers a reroute if far off-route), exactly as described in `13-...md`.

### Authorization failures and session expiration

- A connection attempt for a `sessionId` that does not belong to the caller, does not exist, or is in a terminal state (`completed`/`cancelled`/`expired`) is refused at handshake time with an appropriate WebSocket close code and no data exchange — never accepted and then immediately closed after leaking any state.
- If a session transitions to `expired`/`cancelled` while a connection is live (e.g., the outer resumption window elapses), the server sends `session_closed { reason: "expired" }` (or `"cancelled"`) and closes the connection.

## Offline and reconnection contract (client-side)

- Clients retain the current route, current step/leg index, and any location updates queued while offline, in bounded local storage (a hard cap on queued location points, e.g., a few hundred, oldest-dropped-first — never an unbounded local telemetry queue).
- On reconnect, the client does **not** replay the entire queued location history to the server as a burst — it sends only the most recent, freshest location (the server is authoritative and map-matches from current position; replaying stale historical points would risk the server interpreting them as an impossible-jump sequence per `13-...md`'s noisy-input handling). Queued points beyond the most recent are discarded once connectivity resumes and a fresh authoritative `state_update` is received.
- If the local route/session state is older than the outer resumption window (`13-...md`), the client does not attempt to resume — it starts a new navigation session via `POST /v1/navigation/sessions` instead of reconnecting a stale one.

## SLOs (engineering targets, not measured production claims)

| Capability | Availability target | Latency target (p95) | Freshness target |
|---|---|---|---|
| Map tile delivery (via CDN) | 99.95% | < 100ms (cache hit) | Per `MapDataVersion` publication cadence |
| Autocomplete | 99.9% | < 150ms | Near-real-time (seconds-to-minutes indexing lag) |
| Place search | 99.9% | < 300ms | Near-real-time |
| Geocoding (forward/reverse) | 99.9% | < 300ms | Per `MapDataVersion` publication cadence |
| Route calculation | 99.9% | < 800ms (no alternatives), < 1500ms (with alternatives) | Traffic input freshness per `13-...md` staleness thresholds |
| Navigation state updates (WebSocket) | 99.9% connection availability | < 500ms server processing per location update | Real-time (session-scoped) |
| Core API availability (aggregate) | 99.9% | N/A (per-endpoint above) | N/A |

These are **engineering targets** to design and alert against (`18-observability-reliability-architecture.md`), not measurements of an already-operating production system. Error budgets and paging thresholds are derived from these targets during implementation, not fixed numerically here.

## Failure and degradation matrix (extends `18-observability-reliability-architecture.md`)

| Dependency failure | Expected system behavior |
|---|---|
| PostgreSQL unavailable (a given domain's schema) | That domain's writes fail safely with `503 service_unavailable`/`502 dependency_unavailable`; reads may continue from a replica where one exists and is current; no partial/corrupt writes — transactions either fully commit or fully roll back |
| Redis unavailable | Each use degrades per its documented fallback in `14-event-queue-architecture.md`'s Redis table — never a hard failure, only latency/feature degradation (e.g., idempotency protection temporarily weakened, not routing/search/navigation broken) |
| Search (OpenSearch) unavailable | Free-text search/autocomplete return `502 dependency_unavailable`; place reads by ID, geocoding's structured PostGIS path, and place writes are unaffected |
| Routing engine unavailable | New route computation returns `502 routing_engine_unavailable`; already-active navigation sessions continue using their last-computed route/steps without forced termination |
| Traffic provider/service unavailable | Routing/navigation proceed without traffic-awareness (`traffic_assumptions.used_live_traffic: false`); never fabricated traffic data |
| Event broker (Kafka) unavailable | Domain writes remain available (outbox row persists locally); downstream effects (indexing, notifications) lag until the broker recovers, bounded by outbox-relay retry with backoff |
| Queue workers unavailable | Jobs remain queued (Redis-backed durability); no job is lost, only delayed; DLQ only after exhausting the retry policy once workers do recover and still fail |
| Object storage unavailable | Media upload/processing fails safely (`502`, asset stays `requested`/`uploaded`, retried); no orphaned partial metadata claiming a nonexistent successful upload |
| CDN unavailable/degraded | Tile/media requests fall through to origin (Map-tile service / signed-URL issuance), at higher latency and origin load, not a hard failure, until CDN recovers |
| Notification provider (push/email) unavailable | Notification intent (`NotificationRequested`) is preserved and retried per `14-...md`'s queue policy; in-app channel (`Notification` record) is unaffected since it doesn't depend on the external provider |
| Geographic data pipeline outage | No effect on currently-serving Geographic/Address Data, Map Tiles, or Routing graph — previous published `MapDataVersion` continues serving indefinitely until the pipeline recovers |

This matrix governs implementation-prompt failure-handling code directly: a service encountering one of these dependency failures must produce the documented behavior, not an ad hoc alternative.
