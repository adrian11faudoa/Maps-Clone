# Event Registry

Binding registry of every domain event type on the platform. Every row's `event_type` has a corresponding `data` payload schema at `schemas/{event_type}.schema.json`, used together with `schemas/envelope.schema.json` (see `../../docs/architecture/14-event-queue-architecture.md`).

| event_type | event_version | Topic | Producer | Primary consumers | Schema file |
|---|---|---|---|---|---|
| UserRegistered | 1 | identity.user-events | Identity | Users, Notifications | `schemas/UserRegistered.schema.json` |
| SessionCreated | 1 | identity.session-events | Identity | Analytics | `schemas/SessionCreated.schema.json` |
| SessionRevoked | 1 | identity.session-events | Identity | Navigation, Analytics | `schemas/SessionRevoked.schema.json` |
| UserProfileUpdated | 1 | identity.profile-events | Users | Analytics | `schemas/UserProfileUpdated.schema.json` |
| PlaceCreated | 1 | places.place-events | Places | Search, Analytics | `schemas/PlaceCreated.schema.json` |
| PlaceUpdated | 1 | places.place-events | Places | Search, Analytics | `schemas/PlaceUpdated.schema.json` |
| PlaceDeleted | 1 | places.place-events | Places | Search, Saved Places, Analytics | `schemas/PlaceDeleted.schema.json` |
| PlaceModerated | 1 | places.place-events | Places | Search, Analytics | `schemas/PlaceModerated.schema.json` |
| MapDataVersionPublished | 1 | geodata.version-events | Geographic/Address Data (`geodata-pipeline`) | Search, Map Tiles, Routing, Geocoding, Analytics | `schemas/MapDataVersionPublished.schema.json` |
| TileVersionPublished | 1 | tiles.version-events | Map Tiles | Analytics | `schemas/TileVersionPublished.schema.json` |
| RouteRequested | 1 | routing.route-events | Routing | Analytics | `schemas/RouteRequested.schema.json` |
| RouteComputed | 1 | routing.route-events | Routing | Analytics | `schemas/RouteComputed.schema.json` |
| NavigationStarted | 1 | navigation.session-events | Navigation | Notifications, Analytics | `schemas/NavigationStarted.schema.json` |
| NavigationRerouted | 1 | navigation.session-events | Navigation | Analytics | `schemas/NavigationRerouted.schema.json` |
| NavigationEnded | 1 | navigation.session-events | Navigation | Notifications, Analytics | `schemas/NavigationEnded.schema.json` |
| TrafficSnapshotUpdated | 1 | traffic.snapshot-events | Traffic | Routing, Navigation, Map Tiles, Analytics | `schemas/TrafficSnapshotUpdated.schema.json` |
| IncidentReported | 1 | traffic.incident-events | Traffic | Navigation, Map Tiles, Notifications | `schemas/IncidentReported.schema.json` |
| IncidentResolved | 1 | traffic.incident-events | Traffic | Navigation, Map Tiles | `schemas/IncidentResolved.schema.json` |
| LocationTelemetryReceived | 1 | telemetry.location-events | Location Telemetry | Traffic (aggregation only) | `schemas/LocationTelemetryReceived.schema.json` |
| SavedPlaceCreated | 1 | places.saved-place-events | Saved Places | Analytics | `schemas/SavedPlaceCreated.schema.json` |
| SavedPlaceRemoved | 1 | places.saved-place-events | Saved Places | Analytics | `schemas/SavedPlaceRemoved.schema.json` |
| ContributionSubmitted | 1 | places.contribution-events | Contributions | Moderation, Notifications | `schemas/ContributionSubmitted.schema.json` |
| ContributionApproved | 1 | places.contribution-events | Contributions | Places, Notifications | `schemas/ContributionApproved.schema.json` |
| ContributionRejected | 1 | places.contribution-events | Contributions | Notifications | `schemas/ContributionRejected.schema.json` |
| ReviewCreated | 1 | places.review-events | Reviews & Ratings | Places, Moderation, Search | `schemas/ReviewCreated.schema.json` |
| ReviewUpdated | 1 | places.review-events | Reviews & Ratings | Places, Search | `schemas/ReviewUpdated.schema.json` |
| ReviewDeleted | 1 | places.review-events | Reviews & Ratings | Places, Search | `schemas/ReviewDeleted.schema.json` |
| ReviewModerated | 1 | places.review-events | Reviews & Ratings | Places, Search | `schemas/ReviewModerated.schema.json` |
| MediaUploaded | 1 | media.asset-events | Media | Moderation | `schemas/MediaUploaded.schema.json` |
| MediaProcessed | 1 | media.asset-events | Media | Places, Reviews, Contributions (attach confirmation) | `schemas/MediaProcessed.schema.json` |
| MediaRemoved | 1 | media.asset-events | Media | Places, Reviews, Contributions | `schemas/MediaRemoved.schema.json` |
| NotificationRequested | 1 | notifications.request-events | Any domain | Notifications | `schemas/NotificationRequested.schema.json` |
| NotificationDelivered | 1 | notifications.delivery-events | Notifications | Analytics | `schemas/NotificationDelivered.schema.json` |
| NotificationFailed | 1 | notifications.delivery-events | Notifications | Analytics | `schemas/NotificationFailed.schema.json` |
| ReportSubmitted | 1 | moderation.case-events | Moderation & Administration | Moderation (self), Notifications | `schemas/ReportSubmitted.schema.json` |
| ModerationDecisionMade | 1 | moderation.case-events | Moderation & Administration | Places, Reviews, Media, Contributions, Notifications | `schemas/ModerationDecisionMade.schema.json` |
| AdminActionPerformed | 1 | moderation.admin-events | Moderation & Administration | Analytics, Audit | `schemas/AdminActionPerformed.schema.json` |

**Total: 37 registered event types**, all at `event_version: 1` (initial release — no breaking changes have occurred yet).

## Update procedure

1. Adding a new event type: add a schema file `schemas/{EventType}.schema.json`, add a row here, and add the event to the summary table in `../../docs/architecture/14-event-queue-architecture.md`. All three in the same change.
2. Changing an existing event's payload in a backward-compatible way (new optional field): update the schema file in place, no `event_version` bump required, note the change in this file's row if it affects consumer expectations.
3. Breaking change to an existing event: increment `event_version` in this table and in the schema file's expectations, continue producing/consuming the previous version in parallel for the documented deprecation window (`14-...md`), and add a new row here for the new version rather than silently overwriting the old one's documented shape.
