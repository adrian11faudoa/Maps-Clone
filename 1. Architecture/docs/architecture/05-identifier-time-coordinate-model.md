# 05 — Identifier, Time, and Coordinate Model

These conventions are binding across every domain, API, event, and database schema in the platform. No implementation prompt may introduce an alternative scheme.

## Identifiers

- **Primary entity identifiers:** ULID (Universally Unique Lexicographically Sortable Identifier), stored as a 26-character Crockford base32 string, exposed in APIs as a string field named `id`. Rationale: sortable-by-creation-time (useful for pagination and debugging) while remaining globally unique without coordination, unlike auto-increment integers; more URL/log-friendly than raw UUID v4. See ADR-002.
- **Public vs. internal identifiers:** the platform uses the same ULID as both public and internal identifier for most entities — there is no separate "public slug" layer in this volume, except:
  - `Category.id` uses a stable lowercase slug string (e.g., `restaurant.italian`) because categories are a small, curated, human-referenced taxonomy.
  - `MapDataVersion` and `TileVersion` use a monotonic integer `version` field in addition to their ULID `id`, because version ordering must be simple and comparable.
- **Route/request IDs:** `RouteRequest.id` is a ULID, returned to clients and reused as `Route.id` when a computed route is retrieved later within its cache TTL.
- **Navigation session IDs:** `NavigationSession.id` is a ULID, used as the WebSocket stream path segment.
- **Event IDs:** every event has a top-level `event_id` (ULID), unique per publication (a redelivery/retry of the same logical event MUST reuse the same `event_id`; an edit that produces a new logical event gets a new `event_id`).
- **Idempotency keys:** client-supplied idempotency keys (header `Idempotency-Key`) are opaque strings, 1–255 chars, scoped per authenticated principal + endpoint; servers store them for at least 24 hours. Required on all unsafe (`POST`/`PATCH`/`PUT`/`DELETE`) endpoints that are not naturally idempotent (see `06-api-architecture.md`).
- **Correlation IDs:** every request/event carries `correlation_id` (ULID), generated at the API edge if not supplied by the client, propagated across all downstream synchronous calls and into any events published as a result of that request.
- **Trace IDs:** W3C Trace Context (`traceparent`/`tracestate` headers) is the trace propagation mechanism; `trace_id` from that context is attached to logs/events for correlation but is a distinct concern from `correlation_id` (trace IDs are OpenTelemetry's format/lifecycle; correlation IDs are a stable business-level request identifier that survives across async event boundaries where trace context may not).
- **External provider IDs:** always stored verbatim alongside the platform's own ID in a `external_ids` map/column (e.g., `{"osm": "way/123456"}`), never used as the platform's primary key.

## Timestamps

- **Timezone:** UTC only, everywhere — storage, computation, events, API payloads. No local-time storage anywhere in the system.
- **Serialization format:** ISO 8601 / RFC 3339, e.g., `2026-09-22T14:03:11.482Z`. Always includes the `Z` suffix (never a bare offset-less string).
- **Precision:** milliseconds for all business timestamps. Location telemetry and navigation location updates use milliseconds as well; routing engine internal computation may use higher precision internally but truncates to milliseconds at any contract boundary.
- **Server-generated vs. client-provided:** `created_at`/`updated_at` on canonical entities are always server-generated at write time. Client-provided timestamps (e.g., a location telemetry event's device-reported time) are stored in a separate field named `client_observed_at`, distinct from `server_received_at` — never conflated. Servers never trust `client_observed_at` for ordering-sensitive logic without comparing against `server_received_at` and applying clock-skew handling below.
- **Ordering semantics:** durable ordering-sensitive operations (event streams, navigation location sequences) use a monotonic `sequence` number scoped to the relevant aggregate (e.g., per `NavigationSession`) in addition to timestamps, because timestamps alone are not a safe total order across distributed producers.
- **Clock-skew handling:** any `client_observed_at` more than 5 minutes ahead of `server_received_at`, or more than 24 hours behind it, is flagged (`clock_skew_suspected: true`) and de-prioritized in traffic aggregation and navigation map-matching, but not silently discarded (audit trail preserved).
- **Event-time vs. processing-time:** every event distinguishes `occurred_at` (event-time — when the business fact became true) from `published_at` (processing-time — when it was actually published to the bus). Consumers doing time-windowed aggregation (e.g., Traffic) must use `occurred_at` with documented lateness tolerance, not `published_at`.

## Coordinates

- **Ordering:** all platform APIs, events, and internal contracts use **`[longitude, latitude]`** order (GeoJSON convention), never `[lat, lng]`. This is the single most error-prone convention in mapping systems and is treated as non-negotiable. Any UI-layer display convention (`lat, lng` shown to humans) is a presentation-only concern in client code, not a wire-format or storage convention.
- **Coordinate Reference System (CRS):** WGS 84 (EPSG:4326) is the canonical CRS for all stored and transmitted geometry. Any projection used internally for specific computations (e.g., Web Mercator EPSG:3857 for tile generation) is an internal implementation detail of the component that needs it (Map Tiles) and must be converted back to EPSG:4326 at any contract boundary.
- **Geometry encoding:** GeoJSON (RFC 7946) for API payloads. PostGIS `geometry(Type, 4326)` columns for storage of static/vector data; PostGIS `geography` type is used specifically where great-circle distance/area calculations over larger extents are the dominant query pattern (see `10-database-postgis-architecture.md` for the geometry-vs-geography decision per table).
- **Precision:** 6 decimal degrees (~11 cm at the equator) is the maximum precision the platform stores or transmits for any coordinate; clients/providers supplying higher precision are truncated at ingestion. This is a practical precision ceiling, not a claim of GPS accuracy (actual accuracy is carried separately in an `accuracy_meters` field where applicable, e.g., `LocationEvent`).
- **Distance units:** meters is the canonical unit for all stored/transmitted distances. API responses additionally may include a `display` block with unit-localized values (miles/km) computed at the edge/client layer from the canonical meters value — never stored.
- **Speed units:** meters per second (m/s) canonical; same display-localization rule as distance.
- **Bearing/heading convention:** degrees, `0`–`360`, clockwise from true north. `0`/`360` = north, `90` = east, `180` = south, `270` = west. A `null` bearing means "unknown/not available," never `0` used as a sentinel for unknown.

## Cross-reference

These conventions are encoded machine-readably in the shared type definitions implied by `../../contracts/openapi/core-v1.yaml` (`components.schemas.GeoPoint`, `components.schemas.Timestamp` usage throughout) and in `../../contracts/events/schemas/*.json` (`envelope.schema.json`). Implementation prompts must generate types from these contracts rather than hand-rolling parallel definitions.
