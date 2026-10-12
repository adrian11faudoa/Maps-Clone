# 02 — Component Architecture

## Decision: modular monolith first, extract by evidence

**Default deployment shape:** a small number of independently deployable NestJS applications ("services"), each owning multiple related domain **modules**, rather than one service per domain. This avoids premature distributed-systems complexity while preserving clean internal module boundaries that can be extracted into standalone services later without a rewrite (see ADR-001 in `../adr/`).

A domain becomes its own standalone deployable **only when at least one is true**:
- it has a materially different scaling profile (e.g., location telemetry ingestion vs. account management),
- it requires a different runtime/language for performance (e.g., routing engine in Go, tile generation),
- it has distinct compliance/access boundaries (e.g., admin/moderation),
- it is inherently a data pipeline, not a request/response service (e.g., geospatial ingestion, tile build).

## Deployable groupings (initial)

| Deployable | Type | Owned modules | Rationale |
|---|---|---|---|
| `core-api` | NestJS service | Identity & session, User/profile, Places, Saved places, Contributions, Reviews & ratings, Notifications (orchestration), Moderation & administration | Shared transactional domain, moderate/uniform scaling profile, shared PostGIS database cluster (separate schemas) |
| `search-api` | NestJS service | Search query API, Autocomplete, Geocoding, Reverse geocoding | Distinct scaling profile (very high read QPS, low latency SLO), wraps OpenSearch |
| `routing-api` | NestJS service (thin) + `routing-engine` (Go or engine-native process, e.g. Valhalla/OSRM/GraphHopper) | Route request orchestration, route contract translation | Routing computation is CPU/graph-bound and benefits from a specialized engine process; NestJS layer only translates the stable public contract to/from the engine |
| `navigation-api` | NestJS service | Navigation session, live location ingestion (session-scoped), rerouting orchestration | Stateful, real-time, WebSocket-heavy; different connection-scaling profile than `core-api` |
| `traffic-service` | NestJS service + stream processors | Traffic ingestion, aggregation, incidents | Stream-processing heavy, consumes Kafka topics continuously |
| `geodata-pipeline` | Batch/worker application (Node/TS or Go) | Source ingestion, normalization, canonical geospatial publication, routing-graph build, tile build | Pipeline, not request/response; runs on schedule/trigger, not behind the API edge |
| `media-service` | NestJS service | Upload authorization, processing orchestration, derivative generation trigger | Distinct security boundary (untrusted file input) and storage-heavy |
| `notification-worker` | Worker application | Notification delivery (push/email/in-app), provider adapters | Async, provider-dependent, must not block domain transactions |
| `analytics-pipeline` | Stream/batch worker | Event consumption, aggregation, warehouse publication | Read-only consumer of the event bus, isolated from transactional path |
| `admin-console` (web) | Next.js app | Internal administrative/moderation UI | Separate client app, separate auth scoping from public web client |
| `web-client` | Next.js app | Public-facing map/search/directions/navigation UI | See `19-deployment-scalability-integration-architecture.md` |
| `mobile-client` | React Native app | Public-facing mobile experience | Same API contract as `web-client` |

This grouping is the **initial** topology. `19-deployment-scalability-integration-architecture.md` documents extraction triggers for splitting `core-api` further (e.g., separating Moderation & administration into its own deployable once audit/compliance requirements grow).

## Logical component responsibilities

| Component | Responsibility | Does NOT do |
|---|---|---|
| API edge/gateway | TLS termination, request routing to backend deployables, coarse rate limiting, correlation-ID injection, AuthN token validation (signature/expiry) | Business authorization decisions, business logic |
| Identity & session | Account lifecycle, credential verification, token issuance/refresh/revocation, device/session tracking | Authorization *decisions* for other domains' resources (each domain enforces its own resource-level authorization using identity claims) |
| User/profile | Profile data, preferences, unit/locale settings | Authentication mechanics |
| Places domain | Place/address/business canonical records, categories, ownership claims | Search ranking, tile rendering |
| Geocoding | Forward/reverse geocoding requests | General free-text place search (delegates to Search) |
| Search | Query-time search/autocomplete/nearby against derived index | Owning canonical place data (consumes it) |
| Map-tile service | Vector tile build orchestration, tile versioning, CDN publication | Serving authoritative business data to clients directly |
| Routing | Route computation orchestration, contract stability across engine changes | Real-time turn-by-turn session state (delegates to Navigation) |
| Navigation | Session lifecycle, location-to-route matching, off-route detection, rerouting triggers, ETA updates | Long-term location history storage (delegates raw telemetry to Location telemetry component within retention rules) |
| Traffic | Ingest, validate, aggregate traffic signals; expose traffic state to Routing/Navigation and map visualization | Raw per-user telemetry storage (consumes anonymized/aggregated telemetry only) |
| Location telemetry ingestion | Validate, rate-limit, and persist/forward raw location events within privacy retention rules | Business logic interpretation of those events |
| Saved places | User lists/favorites | Place canonical data ownership |
| Contributions | User-submitted place edits/corrections, review workflow trigger | Direct mutation of canonical place data (goes through moderation-gated apply) |
| Reviews & ratings | Review/rating CRUD, aggregate score computation trigger | Moderation decisions (delegates to Moderation) |
| Media | Upload authorization, validation, derivative generation orchestration | Long-term business meaning of the media (owned by Places/Reviews/Contributions that reference it) |
| Notifications | Notification intent → delivery provider dispatch, preference enforcement | Business logic that decides *whether* something is notification-worthy (domains publish intent events; Notifications only delivers) |
| Moderation & administration | Reports, moderation cases, admin actions, audit trail | Domain business logic (acts on domains through their own APIs/events, with elevated authorization) |
| Analytics pipeline | Event aggregation, reporting datasets | Real-time operational decisions |
| Observability | Metrics/logs/traces collection and correlation | Business logic |

## Component interaction rules

1. A component may read another domain's data only through that domain's published API or published events/derived store — never by directly querying another domain's authoritative database schema.
2. Synchronous calls are reserved for request-path operations with a real-time user-facing requirement (e.g., Routing calling the routing engine, Navigation calling Traffic for current conditions).
3. Cross-domain side effects (e.g., "when a review is created, maybe send a notification") are event-driven, not synchronous calls, to preserve failure isolation (see `01-system-context.md` and `18-observability-reliability-architecture.md`).
4. No component holds long-lived credentials for another component's datastore.

## Deployment-shape decision table

| Domain | Shape now | Extraction trigger |
|---|---|---|
| Identity & session | Module in `core-api` | Sustained auth QPS requiring independent scaling, or MFA/federation complexity growth |
| Places | Module in `core-api` | Write volume from contributions at a scale that contends with other `core-api` traffic |
| Search/Geocoding | Standalone `search-api` from day one | Already distinct scaling/latency profile |
| Routing | Standalone `routing-api` + engine process from day one | N/A — already isolated due to engine dependency |
| Navigation | Standalone `navigation-api` from day one | N/A — already isolated due to WebSocket/real-time profile |
| Traffic | Standalone `traffic-service` from day one | N/A — stream-processing profile |
| Media | Standalone `media-service` from day one | N/A — distinct security boundary |
| Moderation & admin | Module in `core-api` | Compliance/audit isolation requirement, or admin traffic pattern diverging materially |
| Notifications | Standalone `notification-worker` from day one | N/A — must not block domain transactions |
| Geospatial pipeline | Standalone `geodata-pipeline` from day one | N/A — inherently batch/pipeline |
