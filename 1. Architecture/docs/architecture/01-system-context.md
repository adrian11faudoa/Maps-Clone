# 01 — System Context

## Purpose

Defines the outer boundary of the platform: who and what interacts with it, and which dependencies are genuinely external versus internally owned. Later prompts must not depict an external dependency as an internal service, and must not depict an internal domain as an external black box.

## Actors

| Actor | Description | Trust level |
|---|---|---|
| Anonymous web/mobile visitor | Views maps, searches places, gets directions, without an account | Untrusted, rate-limited |
| Registered user | Has an account; saves places, contributes content, navigates with history | Authenticated, resource-scoped |
| Contributor | Registered user with elevated place-editing trust (earned or granted) | Authenticated, contribution-scoped |
| Moderator | Reviews reports, contributions, reviews, media | Authenticated, moderation-scoped |
| Support agent | Read-mostly account/trip support access | Authenticated, support-scoped |
| Administrator | Full platform configuration, user, and data administration | Authenticated, admin-scoped |
| Internal service | Any backend service calling another backend service | Service-to-service credential |
| Background job / worker | Executes async processing (indexing, tile builds, notification delivery) | Service-to-service credential |

## System boundary — internal vs. external

### Internal (owned by this platform, defined in this package)

- Public/edge API layer
- Identity & session service
- User/profile domain
- Place domain (places, addresses, categories)
- Geocoding service
- Search service (query-facing; wraps a search engine it owns operationally)
- Map-tile service (build + serve; owns tile artifacts)
- Routing service (wraps a routing engine it owns operationally)
- Navigation service (session/state)
- Traffic service (ingest + aggregate; may consume an external feed, see below)
- Location telemetry ingestion
- Saved places / lists
- Contributions service
- Reviews & ratings service
- Media service
- Notification service
- Moderation & administration service
- Analytics/event pipeline
- Observability stack (metrics/logs/traces)

### External (not owned; integrated through explicit adapters, see `19-deployment-scalability-integration-architecture.md`)

- Geographic base-data providers (e.g., OpenStreetMap extracts, licensed commercial datasets) — **data source**, not a live API dependency at request time
- Optional commercial traffic data provider — **live API dependency**, optional/pluggable
- Optional transit data provider (GTFS/GTFS-RT sources) — **data source + optional live feed**
- Push notification platforms (APNs, FCM) — **live API dependency**
- Email delivery provider — **live API dependency**
- Object storage provider and CDN — **infrastructure dependency**, treated as external managed service
- Identity federation providers, if/when social login is added — **live API dependency**, out of scope until an implementation prompt adds it

The platform must not assume any external dependency is always available. See `18-observability-reliability-architecture.md` for degradation behavior per dependency.

## Context diagram (logical)

```text
                        ┌───────────────────────────┐
                        │        Web Client         │
                        │  (Next.js / React / TS)   │
                        └─────────────┬─────────────┘
                                      │ HTTPS (REST) + WSS (realtime)
                        ┌─────────────▼─────────────┐        ┌────────────────────────┐
   ┌───────────────┐    │        API Edge /         │        │   Mobile Client        │
   │ Admin Console │───▶│   Gateway (AuthN check,   │◀──────▶│ (React Native / TS)     │
   └───────────────┘    │  rate limiting, routing)  │        └────────────────────────┘
                        └─────────────┬─────────────┘
                                      │
        ┌────────────┬───────────────┼───────────────┬─────────────────┬───────────────┐
        ▼            ▼               ▼               ▼                 ▼               ▼
   ┌─────────┐  ┌──────────┐   ┌───────────┐   ┌────────────┐   ┌────────────┐   ┌────────────┐
   │Identity │  │  Places  │   │  Search / │   │  Routing   │   │ Navigation │   │  Media /   │
   │& Session│  │  Domain  │   │Geocoding  │   │  Service   │   │  Service   │   │ Contrib./  │
   └────┬────┘  └────┬─────┘   └─────┬─────┘   └─────┬──────┘   └─────┬──────┘   │ Reviews    │
        │            │               │               │                │          └─────┬──────┘
        │            │               │               │                │                │
        ▼            ▼               ▼               ▼                ▼                ▼
   ┌─────────────────────────────────────────────────────────────────────────────────────────┐
   │        Event Bus (Kafka/Redpanda) + Outbox   |   Redis (cache/coord)   |   Queues        │
   └─────────────────────────────────────────────────────────────────────────────────────────┘
        │            │               │               │                │                │
        ▼            ▼               ▼               ▼                ▼                ▼
   ┌─────────┐  ┌──────────┐  ┌────────────┐  ┌──────────────┐ ┌─────────────┐  ┌────────────┐
   │Postgres/│  │Postgres/ │  │ OpenSearch │  │ Routing Graph│ │  Postgres   │  │  Object    │
   │ PostGIS │  │ PostGIS  │  │  (derived) │  │  (derived,   │ │ (nav state) │  │  Storage + │
   │(identity)│ │ (places) │  │            │  │  built from  │ │             │  │  CDN       │
   └─────────┘  └──────────┘  └────────────┘  │  PostGIS)    │ └─────────────┘  └────────────┘
                                                └──────────────┘
                                      │
                                      ▼
                        ┌───────────────────────────┐
                        │   Map-Tile Service (build  │
                        │   pipeline + CDN delivery) │
                        └─────────────┬─────────────┘
                                      │
                                      ▼
                        ┌───────────────────────────┐
                        │      CDN (tiles, media)    │
                        └───────────────────────────┘

   External (not owned):
   ┌────────────────┐ ┌───────────────────┐ ┌──────────────┐ ┌──────────────┐ ┌───────────────┐
   │ Geographic base │ │ Traffic provider   │ │ Transit feed │ │ APNs / FCM   │ │ Email provider │
   │ data (OSM/etc.) │ │ (optional)         │ │ (optional)   │ │              │ │                │
   └────────────────┘ └───────────────────┘ └──────────────┘ └──────────────┘ └───────────────┘
```

## Interaction summary

| Interaction | Protocol | Sync/Async | Notes |
|---|---|---|---|
| Client ↔ API edge | HTTPS/REST (JSON) | Sync | See `06-api-architecture.md` |
| Client ↔ Navigation service | WSS or HTTP long-poll fallback | Sync (session-bound) | See `13-routing-navigation-traffic-architecture.md` |
| Service ↔ Service (internal) | HTTPS/REST or internal RPC | Sync | Service-to-service auth, see `08-auth-architecture.md` |
| Domain → Event bus | Kafka/Redpanda producer via outbox | Async, at-least-once | See `14-event-queue-architecture.md` |
| Event bus → Consumers | Kafka/Redpanda consumer groups | Async, at-least-once | Idempotent consumers required |
| Backend ↔ Object storage | S3-compatible API | Sync (upload/fetch), async (processing) | See `15-storage-media-architecture.md` |
| Map-tile service → CDN | Push/pull publish | Async (build), sync (serve) | See `12-map-tile-architecture.md` |
| Backend ↔ External providers | Provider-specific adapters | Sync or async per provider | See `19-deployment-scalability-integration-architecture.md` |

## Non-goals of this system context

- Does not depict internal module decomposition inside a single deployable (see `02-component-architecture.md` for the service-vs-module decision per domain).
- Does not depict specific cloud provider topology (see `19-deployment-scalability-integration-architecture.md`).
