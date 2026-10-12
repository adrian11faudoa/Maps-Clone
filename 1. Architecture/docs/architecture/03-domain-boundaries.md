# 03 — Domain Boundaries (Bounded Contexts)

Each domain below is a bounded context with one authoritative owner. "Owned entities" are canonical; anything else referenced is a foreign reference by ID only (no shared mutable state across boundaries).

---

## Identity

- **Purpose:** account existence, credentials, sessions, devices, authorization claims issuance.
- **Owned entities:** `User` (account core fields only — see Users domain for profile), `Credential`, `Device`, `Session`, `RefreshToken`.
- **Authoritative data:** yes, for all owned entities.
- **API boundary:** `/v1/auth/*`, `/v1/sessions/*`.
- **Event boundary publishes:** `UserRegistered`, `SessionCreated`, `SessionRevoked`.
- **Event boundary consumes:** none required for core function.
- **Data dependencies:** none (root domain).
- **Security boundary:** highest sensitivity; credential material never leaves this domain's storage; other domains receive only signed claims.
- **Operational characteristics:** high read QPS (token validation may be edge-cached via public key, not full lookups), moderate write QPS.

## Users (Profile)

- **Purpose:** user-facing profile, preferences, locale/unit settings.
- **Owned entities:** `UserProfile`.
- **Authoritative data:** yes.
- **API boundary:** `/v1/users/me`, `/v1/users/{id}` (limited public fields).
- **Publishes:** `UserProfileUpdated`.
- **Consumes:** `UserRegistered` (to create the initial profile record).
- **Data dependencies:** Identity (`User.id` foreign key).
- **Security boundary:** owner-only write; limited public read for contributor/reviewer attribution.

## Places

- **Purpose:** canonical places, addresses, businesses, categories, and their static attributes.
- **Owned entities:** `Place`, `Address`, `Category`, `PlaceCategory`, `PlaceAlias`, `PlaceOwnership` (business-claim relationship).
- **Authoritative data:** yes — this is the single source of truth for "what places exist and their canonical attributes."
- **API boundary:** `/v1/places/*`.
- **Publishes:** `PlaceCreated`, `PlaceUpdated`, `PlaceDeleted`, `PlaceModerated`.
- **Consumes:** `ContributionApproved` (applies an approved contribution as a canonical mutation), `ModerationDecisionMade`.
- **Data dependencies:** Geographic/Address data (address normalization), Identity (ownership claims).
- **Security boundary:** public read (subject to moderation status), write gated through Contributions + Moderation, direct write reserved for administrators.

## Geographic / Address Data

- **Purpose:** authoritative geometry for roads, administrative regions, and normalized address components, sourced from the geospatial data pipeline (`09-geospatial-data-architecture.md`), distinct from business "Place" records.
- **Owned entities:** `GeographicFeature`, `RoadSegment`, `AdministrativeRegion`, `MapDataVersion`.
- **Authoritative data:** yes, for base-map geometry (not for business places).
- **API boundary:** internal only — consumed by Geocoding, Routing, Map-tile, not exposed as a public CRUD API.
- **Publishes:** `MapDataVersionPublished`.
- **Consumes:** none (root domain fed by external ingestion pipeline).
- **Data dependencies:** external geographic providers (ingestion only, not runtime dependency).
- **Security boundary:** internal service-to-service only; no direct public write ever.

## Search

- **Purpose:** query-time free-text/geo search, ranking, autocomplete.
- **Owned entities:** `SearchDocument` (derived/projected — see `04-data-ownership-matrix.md`).
- **Authoritative data:** no — derived from Places and Geographic/Address Data.
- **API boundary:** `/v1/search/*`, `/v1/autocomplete`.
- **Publishes:** `SearchIndexRebuildRequested` (operational), none domain-significant.
- **Consumes:** `PlaceCreated`, `PlaceUpdated`, `PlaceDeleted`, `PlaceModerated`, `MapDataVersionPublished`.
- **Data dependencies:** Places, Geographic/Address Data.
- **Security boundary:** public read, no public write; reindex triggers are internal/admin only.

## Geocoding

- **Purpose:** forward/reverse geocoding (address ↔ coordinate resolution), distinct from free-text place search.
- **Owned entities:** none new — computes over Geographic/Address Data and Places.
- **Authoritative data:** no.
- **API boundary:** `/v1/geocode`, `/v1/geocode/reverse`.
- **Publishes:** none.
- **Consumes:** `MapDataVersionPublished`.
- **Data dependencies:** Geographic/Address Data, Places (for POI-level geocoding).

## Map Tiles

- **Purpose:** vector tile generation and delivery.
- **Owned entities:** `TileSet`, `TileVersion`.
- **Authoritative data:** yes, for tile artifacts (derived in content, but the tile artifact itself and its version lineage are authoritatively owned here).
- **API boundary:** `/v1/tiles/{z}/{x}/{y}.pbf` (typically served via CDN, origin owned here), `/v1/tiles/styles/*`.
- **Publishes:** `TileVersionPublished`.
- **Consumes:** `MapDataVersionPublished`.
- **Data dependencies:** Geographic/Address Data.
- **Security boundary:** public read (rate-limited), write is pipeline-only (no user or admin manual tile edits).

## Routing

- **Purpose:** route calculation across travel modes, route alternatives, ETA.
- **Owned entities:** `RouteRequest`, `Route`, `RouteLeg`, `RouteStep` (short-lived, cached — see `04-data-ownership-matrix.md`).
- **Authoritative data:** yes, for the routing graph build lineage; route *results* are computed, cacheable, not long-term authoritative records of truth beyond operational caching/audit windows.
- **API boundary:** `/v1/routes` (compute), `/v1/routes/{id}` (retrieve a previously computed route within TTL).
- **Publishes:** `RouteRequested`, `RouteComputed`.
- **Consumes:** `MapDataVersionPublished` (graph rebuild trigger), `TrafficSnapshotUpdated` (traffic-aware scoring).
- **Data dependencies:** Geographic/Address Data (via routing graph), Traffic.

## Navigation

- **Purpose:** stateful turn-by-turn session management.
- **Owned entities:** `NavigationSession`, `NavigationLocationUpdate` (session-scoped, short retention).
- **Authoritative data:** yes, for active session state.
- **API boundary:** `/v1/navigation/sessions/*`, WebSocket channel `wss://.../v1/navigation/sessions/{id}/stream`.
- **Publishes:** `NavigationStarted`, `NavigationRerouted`, `NavigationEnded`.
- **Consumes:** `RouteComputed`, `TrafficSnapshotUpdated`.
- **Data dependencies:** Routing, Traffic, Location Telemetry.
- **Security boundary:** strictly owner-only; no other user or unauthorized service may read another user's active session.

## Traffic

- **Purpose:** ingestion, validation, and aggregation of traffic conditions and incidents.
- **Owned entities:** `TrafficSnapshot`, `Incident`.
- **Authoritative data:** yes, for aggregated traffic state; raw inputs are not authoritative on their own.
- **API boundary:** `/v1/traffic/snapshot`, `/v1/traffic/incidents` (internal + limited public read for map visualization).
- **Publishes:** `TrafficSnapshotUpdated`, `IncidentReported`, `IncidentResolved`.
- **Consumes:** aggregated/anonymized output of Location Telemetry, optional external traffic provider feed.
- **Data dependencies:** Location Telemetry (aggregated only, never raw per-user), Geographic/Address Data (road segment association).
- **Security boundary:** public read is aggregate/anonymized only; raw contributing telemetry never exposed.

## Location Telemetry

- **Purpose:** ingest and validate raw device location events, feed Navigation (session-scoped) and Traffic (aggregated) under strict retention.
- **Owned entities:** `LocationEvent` (short retention, see `17-security-privacy-architecture.md`).
- **Authoritative data:** yes, for raw telemetry within its retention window.
- **API boundary:** `/v1/telemetry/location` (typically invoked via Navigation session context, not as a standalone public surface).
- **Publishes:** `LocationTelemetryReceived`.
- **Consumes:** none.
- **Data dependencies:** Identity/Session (device/session identity), Navigation (session association where applicable).
- **Security boundary:** highest privacy sensitivity in the system; strict purpose limitation (see `17-security-privacy-architecture.md`).

## Saved Places

- **Purpose:** user lists/favorites of places.
- **Owned entities:** `SavedPlace`, `PlaceList`.
- **Authoritative data:** yes.
- **API boundary:** `/v1/users/me/saved-places`, `/v1/users/me/lists`.
- **Publishes:** `SavedPlaceCreated`, `SavedPlaceRemoved`.
- **Consumes:** `PlaceDeleted` (cascades removal/soft-tombstone).
- **Data dependencies:** Places, Identity.
- **Security boundary:** strictly owner-only.

## Contributions

- **Purpose:** user-submitted corrections/additions to place data, routed through moderation before becoming canonical.
- **Owned entities:** `Contribution`.
- **Authoritative data:** yes, for the contribution record itself (not for the resulting canonical place data — see Places).
- **API boundary:** `/v1/contributions`.
- **Publishes:** `ContributionSubmitted`, `ContributionApproved`, `ContributionRejected`.
- **Consumes:** `ModerationDecisionMade`.
- **Data dependencies:** Places, Identity.
- **Security boundary:** authenticated write; approval requires Moderation authorization.

## Reviews & Ratings

- **Purpose:** user reviews and ratings of places.
- **Owned entities:** `Review`, `Rating`.
- **Authoritative data:** yes.
- **API boundary:** `/v1/places/{id}/reviews`, `/v1/reviews/{id}`.
- **Publishes:** `ReviewCreated`, `ReviewUpdated`, `ReviewDeleted`, `ReviewModerated`.
- **Consumes:** `ModerationDecisionMade`.
- **Data dependencies:** Places, Identity, Media (photo attachments by reference).
- **Security boundary:** owner-only write of own review; moderation can hide/remove.

## Media

- **Purpose:** upload, validate, process, and serve place/review photos and other media.
- **Owned entities:** `MediaAsset`, `MediaDerivative`.
- **Authoritative data:** yes, for the asset and its processing lineage (binary content lives in object storage; metadata here).
- **API boundary:** `/v1/media/uploads` (authorization), `/v1/media/{id}`.
- **Publishes:** `MediaUploaded`, `MediaProcessed`, `MediaRemoved`.
- **Consumes:** none required for core function; consumes `ModerationDecisionMade` for takedown.
- **Data dependencies:** Identity (uploader), referenced by Places/Reviews/Contributions (foreign reference only).
- **Security boundary:** untrusted input; strict validation; signed URLs for access where private.

## Notifications

- **Purpose:** deliver notification intents to users across channels.
- **Owned entities:** `Notification`, `NotificationPreference`, `NotificationDeliveryAttempt`.
- **Authoritative data:** yes.
- **API boundary:** `/v1/users/me/notifications`, `/v1/users/me/notification-preferences`.
- **Publishes:** `NotificationDelivered`, `NotificationFailed`.
- **Consumes:** `NotificationRequested` (published by any domain that has something to notify about — see `14-event-queue-architecture.md`).
- **Data dependencies:** Identity.
- **Security boundary:** owner-only read of own notifications.

## Moderation & Administration

- **Purpose:** reports, moderation case management, administrative actions, audit trail.
- **Owned entities:** `Report`, `ModerationCase`, `AdminAction`, `AuditRecord`.
- **Authoritative data:** yes.
- **API boundary:** `/v1/reports`, `/v1/admin/moderation/*`, `/v1/admin/*`.
- **Publishes:** `ReportSubmitted`, `ModerationDecisionMade`, `AdminActionPerformed`.
- **Consumes:** `ContributionSubmitted`, `ReviewCreated`, `MediaUploaded` (as moderation queue inputs), `ReportSubmitted`.
- **Data dependencies:** cross-cutting — acts on other domains through their own APIs/events with elevated authorization, never by direct database access.
- **Security boundary:** highest privilege boundary outside Identity; every action is audited (`AuditRecord`) and non-deletable.

## Analytics

- **Purpose:** aggregate product/operational analytics from the event stream.
- **Owned entities:** derived aggregate datasets only (no canonical entities).
- **Authoritative data:** no.
- **API boundary:** internal reporting API/warehouse access only, not part of the public contract in this volume.
- **Publishes:** none domain-significant.
- **Consumes:** all domain events (read-only, isolated consumer group).
- **Data dependencies:** event bus only.
- **Security boundary:** internal only; must not re-expose raw precise location data (aggregated/anonymized only, per `17-security-privacy-architecture.md`).

---

## Boundary justification for co-located concepts

- **Geocoding is not merged into Search**, despite overlapping infrastructure, because geocoding has a distinct contract (structured address → coordinate with confidence) and distinct latency/accuracy requirements from free-text discovery search. They may share the same OpenSearch cluster operationally, but are separate bounded contexts with separate APIs (see `11-search-geocoding-autocomplete-architecture.md`).
- **Routing and Navigation are separate contexts** despite being adjacent in the user journey: Routing is stateless computation; Navigation is stateful session management with real-time location matching. Merging them would force a stateless computation API to carry session concerns.
- **Traffic and Location Telemetry are separate contexts**: Location Telemetry is raw, privacy-sensitive, per-user/per-device; Traffic is aggregated, anonymized, public-facing. Merging them would risk raw telemetry leaking into a public-facing surface.
- **Places and Contributions are separate contexts**: Places is the canonical read/write-gated store; Contributions is the workflow that proposes changes to it. This preserves the rule that user-submitted content does not become authoritative merely by being submitted (per the Master Prompt).
- **Moderation & Administration is one context, not split by object type** (place moderation vs. review moderation vs. media moderation), because the workflow (report → case → decision → audit) and the authorization model are identical across object types; splitting would duplicate the case/audit machinery without a real boundary benefit.
