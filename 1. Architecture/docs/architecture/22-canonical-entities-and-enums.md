# 22 — Canonical Entities and Enums

This document is the prose index to the machine-readable canonical entity contracts. It supersedes nothing in Volume 1 (`03-domain-boundaries.md`, `04-data-ownership-matrix.md`, `10-database-postgis-architecture.md`) — it makes those boundaries concrete at field level, in a form other implementation prompts can generate types from directly.

## Authoritative artifacts

- **Entity schemas:** `../../contracts/entities/*.schema.json` — one file per canonical entity, 39 total. Each carries, as JSON Schema plus `x-*` extension metadata: `title`/`description`, `type: object`, `properties`/`required` (field-level contract), `x-owning-domain`, `x-authoritative-storage`, `x-privacy-classification` (cross-referencing `17-security-privacy-architecture.md`'s data classes), `x-immutable-fields`, `x-mutable-fields`, `x-lifecycle-enum` (where applicable, pointing into the enum registry), `x-deletion-semantics`, `x-authorization`, and `x-relationships`.
- **Enum registry:** `../../contracts/enums/registry.json` — the single source of truth for every status/enum string on the platform. Every entity schema's status-like field `$ref`s into this file rather than inlining a competing value list.

## Entity-to-Volume-1-name mapping

A few entities named explicitly in this prompt reuse or specialize a Volume 1 concept under a different name; both names are valid and refer to the same thing:

| This document's name | Volume 1 name | Note |
|---|---|---|
| `MapDatasetVersion` | `MapDataVersion` | Same entity; `09-geospatial-data-architecture.md` uses `MapDataVersion` |
| `MapTile` | `TileSet`/`TileVersion` | `MapTile` is one tile artifact; `TileVersion` is the version grouping of many `MapTile`s |
| `TrafficSegmentState` | `TrafficSnapshot` | Same entity |
| `TrafficIncident` | `Incident` | Same entity |
| `PlacePhoto` | `MediaAsset` (context_type = `place`) | No separate table; a `MediaAsset` attached to a place context IS a place photo |
| `PlaceCategory` | `Category` + `PlaceCategory` join (Volume 1 DDL) | One bounded concept spanning two physical tables |

No new competing schema was introduced for these — the entity schema file documents the mapping directly.

## Entity list (39 total)

| Entity | Owning domain | Storage | Privacy class | Lifecycle enum |
|---|---|---|---|---|
| User | Identity | PostgreSQL `identity` | account_information | AccountStatus |
| UserProfile | Users | PostgreSQL `identity` | account_information | — |
| Device | Identity | PostgreSQL `identity` | account_information | — |
| Session | Identity | PostgreSQL `identity` + Redis | account_information | SessionStatus |
| Place | Places | PostgreSQL/PostGIS `places` | public_place_data | PlaceStatus |
| PlaceCategory | Places | PostgreSQL `places` | public_place_data | — |
| PlaceAlias | Places | PostgreSQL `places` | public_place_data | — |
| Address | Places / Geographic Data | PostgreSQL `places`/`geodata` | public_place_data | — |
| GeographicFeature | Geographic/Address Data | PostgreSQL/PostGIS `geodata` | public_place_data | — |
| Road | Geographic/Address Data | PostgreSQL/PostGIS `geodata` (derived grouping) | public_place_data | — |
| RoadSegment | Geographic/Address Data | PostgreSQL/PostGIS `geodata` | public_place_data | — |
| Intersection | Geographic/Address Data | Routing-engine graph artifact | public_place_data | — |
| MapDatasetVersion | Geographic/Address Data | PostgreSQL `geodata` + object storage | public_place_data | MapDataVersionStatus |
| MapTile | Map Tiles | Object storage + PostgreSQL `tiles` | public_place_data | — |
| SearchDocument | Search | OpenSearch | public_place_data | — |
| RouteRequest | Routing | Redis + PostgreSQL `routing` | public_place_data | RouteRequestStatus |
| Route | Routing | Redis + PostgreSQL `routing` | public_place_data | — |
| RouteAlternative | Routing | Same as Route | public_place_data | — |
| RouteLeg | Routing | Same as Route | public_place_data | — |
| RouteStep | Routing | Same as Route | public_place_data | — |
| NavigationSession | Navigation | PostgreSQL `navigation` + Redis | active_navigation_data | NavigationSessionStatus |
| NavigationState | Navigation | Redis (live) | active_navigation_data | — |
| LocationEvent | Location Telemetry | Kafka + short-lived buffer, partitioned | precise_private_location | — |
| TrafficObservation | Traffic | Kafka stream (transient) | aggregated_traffic | — |
| TrafficSegmentState | Traffic | PostgreSQL/PostGIS `traffic`, partitioned | aggregated_traffic | — |
| TrafficIncident | Traffic | PostgreSQL/PostGIS `traffic` | aggregated_traffic | IncidentStatus |
| TransitStop | Geographic Data (reserved) | PostgreSQL/PostGIS `geodata` (reserved) | public_place_data | — |
| TransitRoute | Geographic Data (reserved) | PostgreSQL/PostGIS `geodata` (reserved) | public_place_data | — |
| TransitJourney | Routing (reserved) | Same as Route (reserved) | public_place_data | — |
| SavedPlace | Saved Places | PostgreSQL `places` | saved_places | — |
| SavedPlaceList | Saved Places | PostgreSQL `places` | saved_places | — |
| Review | Reviews & Ratings | PostgreSQL `places` | reviews_contributions | ReviewStatus |
| Rating | Reviews & Ratings (aggregate) | PostgreSQL `places` | public_place_data | — |
| MediaAsset | Media | PostgreSQL `media` + object storage | media | MediaStatus |
| Contribution | Contributions | PostgreSQL `places` | reviews_contributions | ContributionStatus |
| ModerationCase | Moderation & Administration | PostgreSQL `moderation` | administrative_data | ModerationCaseStatus |
| Notification | Notifications | PostgreSQL `notifications` | administrative_data | — |
| AuditRecord | Moderation & Administration | PostgreSQL `moderation`, append-only | administrative_data | — |
| IdempotencyRecord | API edge / per-service | Redis | operational_data | — |

**Reserved-boundary entities** (`TransitStop`, `TransitRoute`, `TransitJourney`): schema shape is fixed now so a future transit implementation prompt has no incompatible-model risk, but no ingestion/routing logic for them exists in this or Volume 1's scope.

## Canonical enums

See `../../contracts/enums/registry.json` for the full machine-readable set. Summary: `AccountStatus`, `SessionStatus`, `PlaceStatus`, `ContributionStatus`, `ReviewStatus`, `MediaStatus`, `NavigationSessionStatus`, `RouteRequestStatus`, `TravelMode`, `CongestionLevel`, `IncidentStatus`, `NotificationDeliveryStatus`, `JobStatus`, `ModerationCaseStatus`, `ModerationDecision`, `MapDataVersionStatus`. Each entry documents its values, per-value meaning, terminal states, and allowed transitions — the same registry is referenced by entity schemas, the OpenAPI contract, and the database CHECK constraints in `../../contracts/db/core-entities.sql`, so a status string is never redefined independently in more than one place.

## Consistency rule

An entity's `required`/`properties` in its schema file is the same shape its OpenAPI representation, database columns, and event payloads must agree with — where a field appears in more than one artifact (e.g., `Place.status` in the entity schema, the OpenAPI `Place` schema, and the `places.place.status` column), the enum values, nullability, and meaning must match exactly. `../../contracts/scripts/validate.py` performs cross-artifact checks for this (see its extended checks after this volume).
