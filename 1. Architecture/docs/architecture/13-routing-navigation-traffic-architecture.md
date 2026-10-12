# 13 — Routing, Navigation, and Traffic Architecture

## Routing

### Boundary and engine abstraction

- `routing-api` (NestJS, thin translation layer) exposes the **stable public contract** (`POST /v1/routes`). It never exposes engine-specific request/response shapes to clients.
- `routing-engine` is a specialized process (candidate technologies: OSRM, Valhalla, GraphHopper — final selection is an implementation-prompt decision constrained by this architecture, not fixed here) that performs the actual graph computation over the routing graph built in `09-geospatial-data-architecture.md` stage [4c].
- `routing-api` translates: stable public request → engine-specific request; engine-specific response → stable public response. **This translation layer is the entire reason the public contract survives an engine swap** — if the project later migrates from OSRM to Valhalla, only the translation layer changes, not the API contract, not client code, not stored `Route` records' shape.

### Request contract (see OpenAPI for full schema)

```json
{
  "origin": { "type": "Point", "coordinates": [lng, lat] },
  "destination": { "type": "Point", "coordinates": [lng, lat] },
  "waypoints": [ { "type": "Point", "coordinates": [lng, lat] } ],
  "mode": "driving | walking | cycling | transit",
  "alternatives": true,
  "avoid": ["tolls", "highways", "ferries"],
  "depart_at": "RFC3339 timestamp | null (null = now)",
  "traffic_aware": true
}
```

### Response contract

```json
{
  "id": "route_request_id (ULID)",
  "routes": [
    {
      "id": "route_id (ULID)",
      "mode": "driving",
      "distance_m": 12345.6,
      "duration_s": 980,
      "duration_in_traffic_s": 1120,
      "geometry": { "type": "LineString", "coordinates": [ [lng, lat], "..." ] },
      "legs": [
        {
          "distance_m": 12345.6,
          "duration_s": 980,
          "steps": [
            {
              "instruction": "Turn right onto Main St",
              "distance_m": 200.0,
              "duration_s": 30,
              "geometry": { "type": "LineString", "coordinates": ["..."] },
              "maneuver": "turn-right"
            }
          ]
        }
      ],
      "warnings": []
    }
  ],
  "traffic_assumptions": { "used_live_traffic": true, "snapshot_time": "RFC3339" }
}
```

- Distance/duration always in canonical units (meters, seconds — see `05-...md`). `duration_in_traffic_s` present only when `traffic_aware: true` was honored; if traffic data was unavailable, `traffic_assumptions.used_live_traffic: false` is returned rather than silently fabricating a traffic-aware number (per Master Prompt: never fabricate traffic-aware routing behavior when live data is unavailable).
- `route_not_found` (see `07-error-contract.md`) is returned when no viable route exists for the given mode/constraints — this is a `422`, not a `404` (the *request* was well-formed; the *routing problem* has no solution).

### Caching and deduplication

- Identical `(origin, destination, waypoints, mode, avoid, traffic_aware-bucketed-by-minute)` requests within a short TTL (seconds) are served from Redis cache rather than recomputed — bucketing `depart_at`/traffic freshness by a coarse time window (e.g., 1 minute) so the cache key doesn't fragment into uniqueness on every millisecond.
- `RouteRequest`/`Route` persistence in `routing` schema is a **sampled audit/analytics record** (per `04-data-ownership-matrix.md`), not the primary retrieval path — `GET /v1/routes/{id}` first checks Redis, falling back to the audit sample if present, and returns `404` if the route has expired from both (routes are not permanently retrievable by ID; they are a short-lived computation result).

### Failure behavior

- Routing-engine timeout or unavailability → `502 routing_engine_unavailable` — never a silently degraded/fabricated route.
- A partial alternative-set failure (some alternatives computed, one alternative's computation failed) still returns the successful alternatives with a `warnings` entry noting the reduced set, rather than failing the whole request.

## Navigation

### Session model

```text
NavigationSession
  id, user_id, route_id, mode, status (active|paused|rerouting|completed|cancelled),
  started_at, ended_at, current_step_index, current_leg_index,
  last_known_location, last_location_at, off_route: bool,
  created_at, updated_at, version
```

- **Creation:** `POST /v1/navigation/sessions` with a previously computed `route_id` (or an inline route request) → creates `NavigationSession`, publishes `NavigationStarted`.
- **Server is authoritative for session state.** The client sends location updates; the server computes current step/leg, off-route status, and ETA — the client never self-reports "which step I'm on" as authoritative (prevents desync and cheating/spoofing of trip-completion-dependent features).
- **Live channel:** `wss://.../v1/navigation/sessions/{id}/stream` — bidirectional: client → server location updates (`{ location, heading, speed, accuracy_m, client_observed_at }`), server → client state updates (`{ current_step, next_maneuver, eta, off_route, rerouted: bool }`). A REST fallback (`POST /v1/navigation/sessions/{id}/location`, `GET /v1/navigation/sessions/{id}`) exists for clients/environments where a persistent WebSocket is impractical (degraded connectivity), at higher latency.

### Map matching and off-route detection

- Each location update is map-matched against the active route geometry (nearest-point-on-route within a tolerance, e.g., 30–50 meters depending on mode and reported `accuracy_m`).
- Off-route is declared after a **sustained** deviation (both distance-from-route and a minimum consecutive-update or time threshold) to avoid false positives from single noisy GPS samples — a single outlier update never triggers a reroute.
- On sustained off-route: server automatically requests a new route from Routing (same destination/remaining waypoints, origin = current location), publishes `NavigationRerouted`, and pushes the new route/steps to the client over the live channel.

### Noisy input handling

- Updates with `accuracy_m` beyond a configured ceiling (e.g., >100m) are accepted (stored) but down-weighted/excluded from map-matching decisions until accuracy improves.
- Updates implying an impossible jump (speed inferred from consecutive points exceeds a physically implausible threshold for the current `mode`) are flagged (`implausible: true`) and excluded from map-matching/off-route decisions, but retained in the raw event trail for debugging — never silently discarded without a trace.
- Stale updates (`client_observed_at` far in the past relative to `server_received_at`, beyond clock-skew tolerance — see `05-...md`) do not regress `current_step_index` backward.

### Connectivity loss and background execution

- A session with no location update for a configured grace period (e.g., 2 minutes) transitions to `status: paused` server-side (not `cancelled`), preserving state for resumption. A subsequent update within a longer outer window (e.g., 30 minutes) resumes the session (map-matches from the new location, possibly triggering a reroute if far off-route); beyond that window, the session auto-transitions to `status: cancelled` and the client must start a new one.
- Client-side background execution (mobile OS background location) is a client engineering concern (see Master Prompt's mobile requirements) — the server contract above is agnostic to why updates stopped arriving.

### Termination

- `POST /v1/navigation/sessions/{id}/complete` (arrival) or `.../cancel` (user-initiated) → `status: completed`/`cancelled`, publishes `NavigationEnded`, stops accepting further location updates for that session (subsequent update returns `409 navigation_session_conflict`).

## Traffic

### Data flow

```text
[optional] External traffic provider feed  ──┐
                                               ├──▶ Raw traffic observations
Aggregated/anonymized Location Telemetry  ────┘         │
                                                          ▼
                                               Validation (plausibility, road-segment
                                                          association)
                                                          │
                                                          ▼
                                               Aggregation (per road_segment_id,
                                                          per time_bucket)
                                                          │
                                                          ▼
                                               TrafficSnapshot (traffic schema)
                                                          │
                                          ┌───────────────┼──────────────┐
                                          ▼               ▼              ▼
                                      Routing        Navigation      Map-tile
                                      (scoring)       (ETA update)    (traffic layer)
```

- **Raw contributing telemetry is never exposed** beyond the aggregation boundary — `TrafficSnapshotUpdated` and its consumers only ever see per-segment aggregates (e.g., average speed, congestion level `free|light|moderate|heavy|severe`, sample count, confidence), never a per-user trace.
- Aggregation requires a minimum sample count per `(road_segment_id, time_bucket)` before publishing a snapshot for that cell, both for statistical validity and as a privacy floor (a cell with only 1–2 contributing devices is not published as a distinct aggregate, to avoid re-identification risk) — see `17-security-privacy-architecture.md`.
- **Incidents** (`Incident` entity — accidents, closures, hazards) are a separate, individually-tracked record type (not an aggregate), sourced from the external provider feed and/or user reports (via the Reports/Moderation path for user-submitted incidents), each carrying its own confidence/source/expiry.

### Freshness, staleness, and confidence

- Every `TrafficSnapshot` and `Incident` carries `confidence` and `snapshot_time`/`reported_at`. Consumers (Routing, Navigation) apply a documented staleness threshold (e.g., snapshots older than 15 minutes are treated as `low confidence`, older than 60 minutes are excluded from traffic-aware scoring entirely) rather than trusting arbitrarily old data as current.
- If no traffic data source is configured/available at all (neither external provider nor sufficient telemetry volume), `traffic_aware` requests are honored with `traffic_assumptions.used_live_traffic: false` (per the "never fabricate" rule above) rather than returning an error — traffic-awareness is a best-effort enhancement, not a hard routing dependency.

### Failure isolation

- A Traffic-service outage degrades Routing/Navigation to non-traffic-aware behavior (still functional) rather than failing route computation or navigation entirely — see `18-observability-reliability-architecture.md`.
