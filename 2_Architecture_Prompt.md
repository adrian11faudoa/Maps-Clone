You are operating in Senior Engineering Team Mode.

Design the complete foundational architecture for an enterprise-scale global mapping, places, geospatial search, routing, navigation, traffic, and location platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

This is an ARCHITECTURE PHASE.

Do not implement backend source code.

Do not implement frontend source code.

Do not implement mobile source code.

Do not generate Dockerfiles.

Do not generate Kubernetes manifests.

Do not generate Terraform files.

Do not generate CI/CD workflows.

Do not generate application source code.

Produce architecture, specifications, contracts, schemas, diagrams, state machines, ownership rules, engineering decisions, operational strategies, security models, privacy models, and implementation roadmaps only.

────────────────────────────────────────

PROJECT

Build a global mapping platform supporting:

• Interactive maps
• Vector maps
• Raster fallback
• Map styles
• Map tiles
• Places
• Businesses
• Points of interest
• Addresses
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Nearby search
• Categories
• Reviews
• Ratings
• Photos
• Saved places
• Collections
• Route calculation
• Directions
• Alternative routes
• Traffic-aware routing
• ETA
• Distance matrix
• Driving
• Walking
• Cycling
• Transit foundation
• Road network
• Road restrictions
• Speed limits
• Toll roads
• Closures
• Construction
• Traffic
• Incidents
• Navigation
• Turn-by-turn directions
• Off-route detection
• Rerouting
• Live location
• Location sharing
• Trip sharing
• Location history
• Geofencing
• Offline maps
• Offline navigation foundation
• Map contributions
• Place edits
• Business claims
• Review moderation
• Content moderation
• Fraud/abuse prevention
• Notifications
• Analytics
• Administration
• Feature flags
• Dynamic configuration
• Audit
• Privacy
• Data export
• Data deletion
• Multi-region
• Disaster recovery

────────────────────────────────────────

PRIMARY TECHNOLOGY STACK

WEB

• Next.js
• React
• TypeScript
• Tailwind CSS
• shadcn/ui
• TanStack Query
• Zustand

MOBILE

• React Native
• Expo
• TypeScript

BACKEND

• Node.js
• NestJS
• TypeScript

DATABASE

• PostgreSQL
• PostGIS
• Prisma ORM

CACHE

• Redis

EVENT STREAMING

• Kafka or Redpanda

BACKGROUND PROCESSING

• BullMQ

SEARCH

• Elasticsearch or OpenSearch

OBJECT STORAGE

• AWS S3

CDN

• CloudFront

MAP DATA

• Vector tiles
• Raster tiles
• Versioned datasets

ROUTING

• Provider-neutral routing engine abstraction
• OSRM/GraphHopper/Valhalla/custom routing engine where justified

REAL-TIME

• WebSockets
• Socket.IO where appropriate

NOTIFICATIONS

• FCM
• APNS

OBSERVABILITY

• OpenTelemetry
• Prometheus
• Grafana
• Loki
• Tempo

INFRASTRUCTURE

• Docker
• Kubernetes
• Helm
• Terraform
• GitHub Actions

SECURITY

• IAM
• KMS
• Secrets Manager
• WAF
• RBAC
• NetworkPolicies

────────────────────────────────────────

ARCHITECTURAL PRINCIPLES

Use:

• Clean Architecture
• Domain-Driven Design
• SOLID
• Repository Pattern
• Service Layer
• Dependency Injection
• Explicit domain boundaries
• Event-driven architecture
• Transactional Outbox
• Idempotent consumers
• Horizontal scalability
• Regionalization
• Geospatial indexing
• Versioned datasets
• Provider abstractions
• Graceful degradation
• Rebuildable derived data

Avoid:

• One giant Maps service
• Routing logic embedded inside controllers
• Search as source of truth
• Redis as authoritative geospatial database
• Global synchronous routing dependencies
• Unlimited raw GPS storage
• API-proxied map-tile traffic
• Direct client mutation of authoritative map data
• Permanent public live-location links
• Frontend-only privacy controls

────────────────────────────────────────

ARCHITECTURE APPROACH

Evaluate:

• Modular monolith
• Service-oriented architecture
• Microservices

Base the decision on:

• Geospatial scale
• Routing workload
• Map data ingestion
• Traffic ingestion
• Search workload
• Tile traffic
• Navigation concurrency
• Real-time location traffic
• Multi-region needs
• Team ownership
• Operational complexity
• Cost
• Failure isolation

Clearly identify which components should be independently deployable.

Provide a future service-extraction strategy.

────────────────────────────────────────

DOMAIN DECOMPOSITION

Define bounded contexts for:

IDENTITY

• Accounts
• Profiles
• Devices
• Sessions

LOCATION

• Current location
• Location sessions
• Location history
• Location sharing
• Trip sharing

PLACES

• Place
• Business
• POI
• Address
• Categories
• Hours
• Attributes
• Photos
• Claims

GEOCODING

• Geocoding
• Reverse geocoding
• Address normalization

SEARCH

• Place search
• Business search
• Address search
• Category search
• Autocomplete

MAP DATA

• Base map
• Map styles
• Vector tiles
• Raster tiles
• Dataset versions

ROAD NETWORK

• Roads
• Road segments
• Nodes
• Lanes
• Turn restrictions
• Speed limits
• Toll metadata
• Access restrictions

ROUTING

• Route
• Directions
• Alternatives
• Distance matrix
• ETA
• Travel modes

TRAFFIC

• Traffic speeds
• Congestion
• Historical traffic
• Incidents
• Closures
• Construction

NAVIGATION

• Navigation sessions
• Turn-by-turn
• Current maneuver
• Off-route
• Rerouting

GEOFENCING

• Geofences
• Entry
• Exit
• Dwell
• Spatial rules

OFFLINE

• Offline region
• Tile package
• Style package
• POI package
• Routing graph package

SOCIAL / USER CONTENT

• Saved places
• Collections
• Reviews
• Ratings
• Photos
• Contributions

TRUST

• Moderation
• Reporting
• Safety
• Fraud/abuse

PLATFORM

• Notifications
• Analytics
• Administration
• Feature flags
• Configuration
• Audit
• Privacy

────────────────────────────────────────

SERVICE DECOMPOSITION

Evaluate services such as:

• API Gateway
• Identity Service
• Account Service
• Profile Service
• Device Service
• Location Service
• Location History Service
• Place Service
• Business Service
• Address Service
• Geocoding Service
• Reverse Geocoding Service
• Autocomplete Service
• Search Service
• Tile Service
• Map Style Service
• Map Data Service
• Road Network Service
• Routing Service
• Route Optimization Service
• ETA Service
• Traffic Service
• Incident Service
• Closure Service
• Navigation Service
• Transit Service
• Saved Places Service
• Collection Service
• Location Sharing Service
• Trip Sharing Service
• Geofence Service
• Offline Maps Service
• Contribution Service
• Review Service
• Rating Service
• Photo Service
• Moderation Service
• Safety Service
• Fraud Service
• Notification Service
• Analytics Service
• Administration Service
• Audit Service
• Feature Flag Service
• Configuration Service
• Privacy Service

For every final service define:

• Responsibility
• Owned data
• APIs
• Events produced
• Events consumed
• Synchronous dependencies
• Asynchronous dependencies
• Scaling profile
• Availability requirement
• Security boundary
• Regional ownership

Do not create a separate service solely to appear microservice-oriented.

────────────────────────────────────────

SOURCE-OF-TRUTH MATRIX

Create a complete matrix covering:

• Users
• Accounts
• Devices
• Places
• Businesses
• Addresses
• Categories
• Map styles
• Map datasets
• Road network
• Routing graph
• Traffic
• Incidents
• Closures
• Routes
• Navigation sessions
• Locations
• Location history
• Saved places
• Collections
• Reviews
• Ratings
• Photos
• Contributions
• Geofences
• Offline maps
• Analytics

No service may directly mutate another service's authoritative database.

────────────────────────────────────────

SYSTEM CONTEXT DIAGRAM

Provide a text-based architecture diagram containing:

CLIENTS

• Consumer web
• Consumer mobile
• Navigation mobile
• Business web
• Admin web

EDGE

• DNS
• CDN
• WAF
• Load balancer
• API gateway
• WebSocket gateway

APPLICATION

• Identity
• Places
• Search
• Geocoding
• Routing
• ETA
• Traffic
• Navigation
• Location
• Contributions
• Reviews
• Notifications
• Administration

DATA

• PostgreSQL/PostGIS
• Redis
• Kafka
• OpenSearch
• S3

MAP PLATFORM

• Map data ingestion
• Tile generation
• Tile distribution
• Road graph build
• Routing graph deployment

OBSERVABILITY

• Metrics
• Logs
• Traces
• Alerts

SECURITY

• IAM
• KMS
• Secrets
• Audit
• WAF

Do not produce source code.

────────────────────────────────────────

CLIENT ARCHITECTURE

Define architecture for:

• Web maps
• Mobile maps
• Search UI
• Navigation UI
• Business UI
• Admin UI

Separate:

• UI state
• Server state
• Real-time state
• Offline state
• Secure state

Do not make client-side map state authoritative.

────────────────────────────────────────

GEOSPATIAL DATA LAYERS

Architect the platform in layers:

1. Base map
2. Administrative boundaries
3. Road graph
4. POIs
5. Addresses
6. Businesses
7. Traffic
8. Incidents
9. User-generated content
10. User location

For every layer define:

• Source
• Storage
• Update frequency
• Versioning
• Regional ownership
• Cache
• Indexing
• Retention

────────────────────────────────────────

SPATIAL INDEXING

Evaluate:

• PostGIS GiST
• PostGIS SP-GiST
• Geography
• Geometry
• H3
• Geohash
• S2-like cells

Use different approaches for different workloads.

For each spatial structure define:

• Use case
• Resolution
• Partitioning
• Query pattern
• Storage cost
• Update pattern

────────────────────────────────────────

COORDINATE STANDARD

Use:

• WGS84 / EPSG:4326 externally

Define:

• Latitude range
• Longitude range
• Precision
• Altitude
• Accuracy
• Heading
• Speed
• Timestamp

Invalid geographic coordinates must be rejected.

────────────────────────────────────────

LOCATION ARCHITECTURE

Define current-location pipeline:

Device
→ Location Session
→ API/WebSocket
→ Validation
→ Region Routing
→ Real-time Processing
→ Redis / ephemeral store
→ Kafka
→ Aggregation
→ Analytics/History

Separate:

• Live operational location
• Historical location
• Shared location
• Analytics location

────────────────────────────────────────

LOCATION PRIVACY

Classify:

• Precise live location
• Historical location
• Shared location
• Home/work
• Background location
• Geofence events

For each define:

• Access
• Retention
• Consent
• Encryption
• Audit
• Deletion

────────────────────────────────────────

LOCATION HISTORY

Design:

Raw location
→ Filtering
→ Map matching
→ Visit inference
→ Activity inference
→ Aggregation

Do not retain raw high-frequency GPS indefinitely.

Define storage optimized for high-volume temporal/spatial data.

────────────────────────────────────────

PLACE ARCHITECTURE

Define canonical Place model.

Include:

• Stable place identifier
• Name
• Coordinates
• Address
• Category
• Hours
• Attributes
• Contact information
• Website
• Photos
• Status
• Region
• Source references
• Quality/confidence

────────────────────────────────────────

PLACE LIFECYCLE

Support:

• Created
• Active
• Temporarily closed
• Permanently closed
• Merged
• Split
• Deprecated

Define merge/split semantics.

────────────────────────────────────────

PLACE DUPLICATES

Design duplicate detection using:

• Coordinates
• Name similarity
• Address
• Phone
• Business identity
• Provider references

Duplicate resolution must be auditable.

────────────────────────────────────────

BUSINESS CLAIMS

Support:

• Business claim
• Verification
• Ownership
• Business administrators
• Business profile edits

Never allow an unverified requester to directly overwrite authoritative business information.

────────────────────────────────────────

PLACE HOURS

Support:

• Multiple periods
• Overnight hours
• Holiday hours
• Temporary closures
• Special hours

Associate hours with the place's local time zone.

────────────────────────────────────────

ADDRESS ARCHITECTURE

Support:

• Structured address
• Display address
• Administrative hierarchy
• Postal code
• Street
• Number
• Unit
• Region
• Country
• Coordinates

Keep normalized representation separate from display representation.

────────────────────────────────────────

GEOCODING ARCHITECTURE

Define provider-neutral interface.

Input:

• Address text
• Region
• Language
• Optional context

Output:

• Coordinates
• Normalized address
• Place reference
• Confidence
• Match type
• Region

Support:

• Exact
• Partial
• Interpolated
• Ambiguous

────────────────────────────────────────

REVERSE GEOCODING

Input:

• Coordinates

Output:

• Address
• Place
• Road
• Administrative hierarchy
• Region

Use:

• Spatial indexes
• Cached provider results
• Provider fallback

────────────────────────────────────────

AUTOCOMPLETE

Support:

• Prefix query
• Geographic bias
• Language
• Region
• Category
• Session context

Return:

• Place
• Business
• Address
• Road

Define aggressive latency targets.

────────────────────────────────────────

SEARCH ARCHITECTURE

Search:

• Places
• Businesses
• Addresses
• Roads
• Categories
• Administrative regions

Support:

• Full text
• Prefix
• Typo tolerance
• Geographic relevance
• Popularity
• Recency
• Language
• Regionalization

Search must be rebuildable.

────────────────────────────────────────

SEARCH INDEX VERSIONING

Support:

• Index version
• Alias
• Incremental indexing
• Full rebuild
• Validation
• Cutover
• Rollback

Never make the search index the source of truth.

────────────────────────────────────────

MAP DATA ARCHITECTURE

Sources may include:

• Open data
• Licensed datasets
• Provider APIs
• Internal contributions

Architecture:

Source
→ Download
→ Validate
→ Normalize
→ Deduplicate
→ Enrich
→ Version
→ QA
→ Publish
→ Tile/Graph build
→ Index
→ Regional distribution

────────────────────────────────────────

MAP DATA VERSION

Every map release should contain:

• Dataset ID
• Version
• Region
• Source
• Schema version
• Build timestamp
• Effective timestamp
• Validation result
• Quality score
• Status

States:

• Draft
• Validating
• Published
• Superseded
• Rolled back

────────────────────────────────────────

VECTOR TILE ARCHITECTURE

Support:

• Tile coordinate
• Zoom
• Layer
• Dataset version
• Style version

Use CDN distribution.

Map tile traffic must not pass through standard API servers.

────────────────────────────────────────

RASTER FALLBACK

Support raster tiles for:

• Legacy clients
• Specialized imagery
• Fallback rendering

Cache aggressively through CDN.

────────────────────────────────────────

MAP STYLE ARCHITECTURE

Define versioned styles:

• Light
• Dark
• Navigation
• Accessibility
• Terrain
• Satellite foundation where supported

Styles must be independently cacheable.

────────────────────────────────────────

ROAD NETWORK

Model:

• Nodes
• Directed edges
• Road segments
• Geometry
• Road class
• Direction
• Surface
• Speed
• Lanes
• Turn restrictions
• Access restrictions
• Toll metadata

Separate canonical road data from routing weights.

────────────────────────────────────────

ROAD GRAPH

Design graph representation supporting:

• Directed edges
• Edge weight
• Distance
• Travel time
• Turn costs
• Restrictions
• Conditional rules
• Traffic-adjusted weights

Prepare time-dependent weights.

────────────────────────────────────────

ROUTING

Support:

• Driving
• Walking
• Cycling
• Transit foundation

Inputs:

• Origin
• Destination
• Waypoints
• Travel mode
• Preferences
• Departure time
• Arrival time

Output:

• Route
• Distance
• Duration
• Geometry
• Steps
• Warnings
• Toll references
• Restrictions
• ETA

────────────────────────────────────────

ROUTING PREFERENCES

Support:

• Fastest
• Shortest
• Avoid tolls
• Avoid highways
• Avoid ferries
• Avoid restricted roads
• Accessible routing

Preferences must be validated server-side.

────────────────────────────────────────

ROUTING ENGINE ABSTRACTION

Create a provider-neutral architecture supporting future engines such as:

• OSRM
• GraphHopper
• Valhalla
• Custom routing engine
• Commercial provider

Provider-specific details must not leak into public API contracts.

────────────────────────────────────────

ROUTING GRAPH BUILD

Pipeline:

Road Dataset
→ Validation
→ Graph Build
→ Routing QA
→ Performance Test
→ Regional Publish
→ Monitor
→ Rollback

Graph versions must coexist during transition.

────────────────────────────────────────

ROUTE CACHE

Define cache keys from:

• Origin
• Destination
• Waypoints
• Mode
• Preferences
• Departure bucket
• Region
• Routing graph version

Do not cache highly dynamic traffic results indefinitely.

────────────────────────────────────────

ETA ARCHITECTURE

Define:

Static Route Duration
+
Historical Traffic
+
Live Traffic
+
Incident/Closure Effects
========================

Dynamic ETA

Support:

• Pickup ETA where applicable
• Destination ETA
• Waypoint ETA
• Arrival time

────────────────────────────────────────

DISTANCE MATRIX

Support:

• Batch origins
• Batch destinations
• Multiple modes
• Time-dependent routing

Use asynchronous or specialized infrastructure for very large matrices.

────────────────────────────────────────

TRAFFIC ARCHITECTURE

Inputs:

• Aggregated location-derived speeds
• Provider feeds
• Road sensors
• Incident data
• Historical patterns

Outputs:

• Speed
• Congestion
• Delay
• Effective time

Protect individual movement privacy.

────────────────────────────────────────

HISTORICAL TRAFFIC

Aggregate by:

• Road segment
• Spatial cell
• Time bucket
• Day of week
• Region

Store derived traffic, not unlimited raw GPS.

────────────────────────────────────────

LIVE TRAFFIC

Pipeline:

Location/Provider Events
→ Kafka
→ Stream Processor
→ Spatial Aggregation
→ Traffic State
→ Redis
→ Routing/ETA

Define:

• Update frequency
• Staleness
• Expiration
• Confidence

────────────────────────────────────────

INCIDENTS

Support:

• Accident
• Hazard
• Congestion
• Closure
• Construction
• Road obstruction

Track:

• Geometry
• Severity
• Source
• Confidence
• Effective time
• Expiration

────────────────────────────────────────

ROAD CLOSURES

Support:

• Full closure
• Partial closure
• Lane closure
• Scheduled closure
• Emergency closure

Integrate with routing graph/weights.

────────────────────────────────────────

NAVIGATION ARCHITECTURE

Support navigation session:

• Navigation ID
• Route version
• Current location
• Current step
• Next maneuver
• Remaining distance
• Remaining duration
• Destination
• Route status

────────────────────────────────────────

TURN-BY-TURN

Define maneuver types:

• Continue
• Turn left
• Turn right
• U-turn
• Merge
• Keep
• Fork
• Roundabout
• Exit

Each step should include:

• Instruction
• Distance
• Duration
• Street
• Maneuver position

────────────────────────────────────────

OFF-ROUTE DETECTION

Use:

• Current coordinate
• Route geometry
• Accuracy
• Heading
• Speed
• Travel mode

Define different thresholds for:

• City
• Highway
• Walking
• Cycling

Avoid route oscillation.

────────────────────────────────────────

REROUTING

Triggers:

• Off-route
• Closure
• Incident
• Major traffic change
• User deviation
• Destination change

Use:

• Cooldown
• Hysteresis
• Bounded recalculation

────────────────────────────────────────

GEOFENCING

Support:

• Circle
• Polygon
• Cell-based regions

Events:

• Enter
• Exit
• Dwell

Use spatial indexing for scalability.

────────────────────────────────────────

LOCATION SHARING

Support:

• Share location
• Live location
• Recipient
• Expiration
• Revocation

Use short-lived secure authorization.

────────────────────────────────────────

TRIP SHARING

Support:

• Route
• ETA
• Current location
• Destination
• Navigation/trip status
• Expiration
• Revocation

Never expose unnecessary personal information.

────────────────────────────────────────

OFFLINE MAP ARCHITECTURE

Support downloadable regions containing:

• Vector tiles
• Map style
• POI data
• Search subset
• Routing graph subset where supported

Define:

• Download
• Pause
• Resume
• Update
• Delete
• Version
• Storage quota

────────────────────────────────────────

OFFLINE ROUTING

Provide architecture for:

• Local graph
• Local routing
• Turn-by-turn
• Limited rerouting
• Offline search

Offline routing must be regional rather than requiring the global graph.

────────────────────────────────────────

SAVED PLACES

Support:

• Home
• Work
• Favorites
• Custom saved locations
• Collections

Sensitive saved locations require enhanced privacy controls.

────────────────────────────────────────

REVIEWS

Support:

• Place review
• Rating
• Photos
• Edit
• Delete
• Report
• Moderation

Prevent:

• Review spam
• Fake reviews
• Coordinated review abuse

────────────────────────────────────────

MAP CONTRIBUTIONS

Support:

• Add place
• Edit place
• Report incorrect place
• Suggest closure
• Suggest road update
• Add photo
• Update business data

All contributions go through validation/moderation.

────────────────────────────────────────

CONTRIBUTION STATES

Support:

• Submitted
• Automated validation
• Pending review
• Approved
• Rejected
• Published
• Reverted

Never directly publish arbitrary user-submitted map data without required validation.

────────────────────────────────────────

BUSINESS DISCOVERY

Support:

• Business search
• Nearby business
• Category
• Open now
• Rating
• Address
• Contact
• Photos

Respect business visibility and moderation.

────────────────────────────────────────

NOTIFICATIONS

Support:

• Saved-place reminders where applicable
• Traffic alerts
• Route changes
• Business updates
• Contribution status
• Safety alerts
• Account security

Respect notification preferences and privacy.

────────────────────────────────────────

MODERATION

Moderate:

• Reviews
• Photos
• Business data
• Place edits
• Contributions
• Business claims

Use:

Content
→ Validation
→ Moderation
→ Enforcement
→ Appeal
→ Restoration

────────────────────────────────────────

FRAUD AND ABUSE

Protect against:

• Fake places
• Fake businesses
• Business impersonation
• Fake reviews
• Review bombing
• Location spoofing
• Geofence abuse
• API scraping
• Map-data scraping
• Search manipulation

Use:

• Rate limits
• Account signals
• Device signals
• Graph signals
• Reputation
• Manual review

────────────────────────────────────────

PRIVACY

Protect:

• Precise location
• Location history
• Search history
• Home/work
• Saved places
• Live sharing
• Trip sharing
• Geofence history
• Business-linked personal data

Support:

• Location permission controls
• History controls
• Sharing controls
• Data access
• Data export
• Data deletion

────────────────────────────────────────

DATA RETENTION

Define separate policies for:

• Live location
• Operational location
• Historical location
• Traffic aggregates
• Search history
• Navigation history
• Analytics

Do not retain precise location longer than necessary.

────────────────────────────────────────

EVENT ARCHITECTURE

Define events:

IDENTITY

• UserCreated
• DeviceRegistered

LOCATION

• LocationSessionStarted
• LocationUpdated
• LocationSessionEnded

PLACES

• PlaceCreated
• PlaceUpdated
• PlaceMerged
• PlaceClosed

BUSINESSES

• BusinessClaimSubmitted
• BusinessVerified
• BusinessUpdated

SEARCH

• SearchPerformed
• AutocompletePerformed
• SearchIndexUpdated
• SearchIndexDeleted

MAP

• MapDatasetPublished
• MapDatasetRolledBack
• MapStylePublished

ROUTING

• RouteRequested
• RouteCalculated
• RouteFailed
• RouteCacheUpdated
• RerouteRequested
• RerouteCompleted

TRAFFIC

• TrafficUpdated
• IncidentCreated
• IncidentResolved
• ClosureCreated
• ClosureRemoved

NAVIGATION

• NavigationStarted
• NavigationCompleted
• OffRouteDetected

SHARING

• LocationShareCreated
• LocationShareRevoked
• TripShareCreated
• TripShareRevoked

GEOFENCE

• GeofenceCreated
• GeofenceEntered
• GeofenceExited
• GeofenceDeleted

OFFLINE

• OfflineRegionRequested
• OfflineRegionReady
• OfflineRegionUpdated
• OfflineRegionDeleted

CONTENT

• ReviewCreated
• ReviewUpdated
• ReviewRemoved
• PhotoAdded
• PhotoRemoved

CONTRIBUTIONS

• ContributionSubmitted
• ContributionApproved
• ContributionRejected
• ContributionReverted

MODERATION

• ModerationCaseCreated
• ModerationActionTaken
• AppealCreated
• AppealResolved

PRIVACY

• PrivacyRequestCreated
• DataExportCompleted
• DataDeletionCompleted

ADMIN

• AdministrativeActionTaken
• FeatureFlagChanged
• ConfigurationChanged

All events must be:

• Versioned
• Idempotent
• Privacy-aware
• Correlation-aware

────────────────────────────────────────

QUEUE ARCHITECTURE

Define BullMQ queues for:

• Map-data ingestion
• Map-data validation
• Tile generation
• Road-graph generation
• Search indexing
• Geocode batch processing
• Traffic aggregation
• Incident expiration
• Geofence processing
• Offline-region generation
• Review moderation
• Contribution processing
• Analytics
• Privacy export
• Privacy deletion
• Cleanup

For each define:

• Producer
• Consumer
• Job schema
• Retry
• Backoff
• Timeout
• Concurrency
• Dead-letter
• Scaling
• Monitoring

────────────────────────────────────────

DATABASE ARCHITECTURE

Use PostgreSQL/PostGIS as authoritative storage for structured geospatial data.

Conceptual entities:

• User
• Account
• Profile
• Device
• LocationSession
• Place
• PlaceAddress
• PlaceCategory
• PlaceHour
• PlaceAttribute
• PlacePhoto
• PlaceStatus
• BusinessProfile
• BusinessClaim
• Address
• AdministrativeArea
• Road
• RoadNode
• RoadSegment
• RoadRestriction
• SpeedLimit
• TollReference
• MapDataset
• MapDatasetVersion
• MapStyle
• RoutingGraphVersion
• RouteReference
• NavigationSession
• SavedPlace
• Collection
• LocationShare
• TripShare
• Geofence
• Review
• Rating
• Contribution
• ModerationCase
• AuditLog
• PrivacyRequest
• FeatureFlag
• Configuration

High-frequency GPS and traffic telemetry should use purpose-built event/aggregation storage rather than ordinary relational rows indefinitely.

────────────────────────────────────────

SPATIAL INDEX DESIGN

Define PostGIS indexes for:

• Places
• Roads
• Administrative areas
• Geofences

Define cell indexes for:

• Traffic
• Location aggregation
• Nearby search
• Routing preprocessing
• Regional partitioning

────────────────────────────────────────

SEARCH DATA MODEL

Separate:

Authoritative Place Data

from:

• Search document
• Ranking data
• Suggestion data
• Popularity data

Search must be rebuildable.

────────────────────────────────────────

REDIS ARCHITECTURE

Use Redis for:

• Current location
• Autocomplete cache
• Geocode cache
• Reverse-geocode cache
• Nearby-place cache
• Route cache
• ETA cache
• Traffic state
• Geofence acceleration
• Session state
• Share state
• Rate limiting

Redis must never be authoritative for:

• Users
• Places
• Roads
• Reviews
• Location history
• Contributions
• Privacy requests

────────────────────────────────────────

CACHE VERSIONING

Cache keys should include:

• Environment
• Region
• Dataset version
• Routing graph version
• Style version

Invalidate or version on:

• Map publication
• Road closure
• Place changes
• Routing changes
• Rights/moderation changes

────────────────────────────────────────

MULTI-REGION

Design:

• Regional APIs
• Regional geocoding
• Regional search
• Regional routing
• Regional traffic
• Regional location
• Global CDN
• Global DNS

Keep latency-sensitive operations within region where possible.

────────────────────────────────────────

REGIONAL OWNERSHIP

Define geographic ownership for:

• Location
• Places
• Road data
• Traffic
• Routing graph
• Search
• Navigation sessions

Avoid unnecessary cross-region synchronous operations.

────────────────────────────────────────

MAP DATA ROLLOUT

Use:

Build
→ Validate
→ Canary region
→ Performance validation
→ Regional rollout
→ Global rollout
→ Monitoring
→ Rollback

Do not replace every region simultaneously.

────────────────────────────────────────

ROUTING GRAPH ROLLOUT

Support:

• Version coexistence
• Regional activation
• Canary
• Rollback
• Performance comparison
• Route-quality comparison

────────────────────────────────────────

OFFLINE PACKAGE DISTRIBUTION

Use CDN/object storage for:

• Tile packages
• Style packages
• POI packages
• Search packages
• Routing graph packages

Support:

• Signed download
• Version
• Expiration
• Resume
• Integrity checksum

────────────────────────────────────────

SECURITY ARCHITECTURE

Protect:

• Location
• Navigation
• Places
• Business ownership
• Search
• Route APIs
• Offline packages
• Map datasets
• Administration

Use:

• Authentication
• Authorization
• RBAC
• Rate limiting
• WAF
• Signed access
• Encryption
• Audit

────────────────────────────────────────

THREAT MODEL

Analyze:

• Location scraping
• Location stalking
• Share-token theft
• Route abuse
• Search scraping
• Map-data scraping
• Fake-business attacks
• Review manipulation
• GPS spoofing
• Geofence abuse
• Admin privilege escalation
• Supply-chain attack
• DDoS

For each:

• Prevention
• Detection
• Response
• Recovery

────────────────────────────────────────

OBSERVABILITY

Define metrics:

• Tile requests
• Tile cache hit
• Search latency
• Autocomplete latency
• Geocoding latency
• Reverse-geocoding latency
• Routing latency
• ETA latency
• Route failure
• Navigation sessions
• Off-route rate
• Reroute rate
• Location freshness
• Traffic freshness
• Map-data freshness
• Contribution backlog
• Review backlog
• Queue depth
• Kafka lag

Define distributed tracing for:

• Search
• Geocoding
• Routing
• Navigation
• Location
• Traffic
• Contribution

────────────────────────────────────────

SLO / SLI

Define SLOs for:

• Tile delivery
• Autocomplete
• Place search
• Geocoding
• Reverse geocoding
• Routing
• ETA
• Navigation state
• Location updates
• Traffic freshness
• Offline package generation

For each:

• SLI
• Measurement
• Target
• Error budget
• Alert threshold

────────────────────────────────────────

FAILURE SCENARIOS

Define degraded modes for:

• Search outage
• Geocoding provider outage
• Routing provider outage
• Traffic provider outage
• PostgreSQL outage
• PostGIS outage
• Redis outage
• Kafka outage
• OpenSearch outage
• S3 outage
• Tile origin outage
• WebSocket outage
• Region outage

Fallbacks may include:

• Cached data
• Alternate provider
• Last-known traffic
• Static routing
• Offline maps

────────────────────────────────────────

DISASTER RECOVERY

Define:

• PostgreSQL recovery
• PostGIS recovery
• Search rebuild
• Redis recovery
• Kafka recovery
• S3 recovery
• Map dataset rebuild
• Tile regeneration
• Routing graph rebuild
• Regional recovery

All derived assets must be rebuildable from authoritative source data.

────────────────────────────────────────

DATA CONSISTENCY

STRONG consistency for:

• Place ownership
• Business ownership
• User account
• Saved-place ownership
• Privacy controls
• Live-share authorization
• Administrative permissions

EVENTUAL consistency for:

• Search
• Tile datasets
• Traffic aggregates
• Reviews counters
• Popularity
• Analytics
• Recommendations/discovery

Clearly define acceptable staleness.

────────────────────────────────────────

TESTING ARCHITECTURE

UNIT:

• Coordinate validation
• Spatial utilities
• Address normalization
• Geofence rules
• Navigation state
• Off-route detection
• ETA rules
• Search normalization
• Business claim state
• Contribution state
• Privacy rules

INTEGRATION:

• PostgreSQL
• PostGIS
• Redis
• Kafka
• BullMQ
• OpenSearch
• S3
• WebSockets

GEOSPATIAL:

• Radius
• Nearest neighbor
• Polygon containment
• Boundary conditions
• Dateline behavior
• Coordinate precision

ROUTING:

• Origin/destination
• Waypoints
• Restrictions
• Traffic
• Closures
• Alternatives
• Rerouting

NAVIGATION:

• On-route
• Off-route
• GPS jitter
• Rerouting
• Stale location

SEARCH:

• Full text
• Prefix
• Typo
• Geographic bias
• Filters
• Regionalization

LOCATION:

• Current
• Background
• History
• Sharing
• Privacy

OFFLINE:

• Download
• Resume
• Update
• Delete
• Version mismatch
• Corruption

SECURITY:

• Location access
• Share-token theft
• API scraping
• Route abuse
• Business impersonation
• Admin escalation

PERFORMANCE:

• Tile delivery
• Autocomplete
• Search
• Geocoding
• Routing
• ETA
• Navigation

────────────────────────────────────────

ARCHITECTURAL DECISION RECORDS

Create ADRs for:

• Architecture approach
• PostGIS
• H3/geohash/S2
• Map-data sourcing
• Map-data versioning
• Tile architecture
• CDN
• Search
• Geocoding
• Routing engine
• Road graph
• Traffic
• ETA
• Navigation
• Location storage
• Location history
• Geofencing
• Offline maps
• Offline routing
• Contributions
• Reviews
• Multi-region
• Provider abstraction
• Privacy
• Security
• Observability
• Disaster recovery

Each ADR contains:

• Context
• Decision
• Alternatives
• Consequences

────────────────────────────────────────

ARCHITECTURE VOLUME 1 OUTPUT

Produce:

1. Executive Architecture Overview
2. System Context
3. Architecture Approach
4. Domain Decomposition
5. Service Decomposition
6. Service Ownership Matrix
7. Source-of-Truth Matrix
8. System Context Diagram
9. Client Architecture
10. Geospatial Data Layers
11. Spatial Indexing
12. Coordinate Standard
13. Location Architecture
14. Location Privacy
15. Location History
16. Place Architecture
17. Place Lifecycle
18. Duplicate Place Strategy
19. Business Claims
20. Place Hours
21. Address Architecture
22. Geocoding Architecture
23. Reverse Geocoding
24. Autocomplete
25. Search Architecture
26. Search Versioning
27. Map Data Architecture
28. Map Dataset Versioning
29. Vector Tile Architecture
30. Raster Fallback
31. Map Styles
32. Road Network
33. Road Graph
34. Routing
35. Routing Preferences
36. Routing Engine Abstraction
37. Routing Graph Build
38. Route Cache
39. ETA
40. Distance Matrix
41. Traffic Architecture
42. Historical Traffic
43. Live Traffic
44. Incidents
45. Road Closures
46. Navigation
47. Turn-by-Turn
48. Off-Route Detection
49. Rerouting
50. Geofencing
51. Location Sharing
52. Trip Sharing
53. Offline Maps
54. Offline Routing
55. Saved Places
56. Reviews
57. Map Contributions
58. Contribution States
59. Business Discovery
60. Notifications
61. Moderation
62. Fraud/Abuse
63. Privacy
64. Data Retention
65. Events
66. Queue Architecture
67. Database Architecture
68. Spatial Database Strategy
69. Search Data Model
70. Redis Architecture
71. Cache Versioning
72. Multi-Region
73. Regional Ownership
74. Map Data Rollout
75. Routing Graph Rollout
76. Offline Package Distribution
77. Security Architecture
78. Threat Model
79. Observability
80. SLO/SLI
81. Failure Scenarios
82. Disaster Recovery
83. Data Consistency
84. Testing Architecture
85. Architectural Decision Records

────────────────────────────────────────

QUALITY REQUIREMENTS

Every architectural decision must evaluate:

• Geospatial correctness
• Routing quality
• ETA accuracy
• Location accuracy
• Search relevance
• Data freshness
• Latency
• Scalability
• Availability
• Security
• Privacy
• Regional resilience
• Disaster recovery
• Operational complexity
• Cost
• Maintainability
• Future extensibility

Prefer:

• PostGIS for authoritative structured spatial data
• H3/geohash/S2-like cells for appropriate partitioning
• CDN-first tile delivery
• Versioned datasets
• Versioned routing graphs
• Provider abstraction
• Event-driven traffic
• Queue-driven map ingestion
• Regional processing
• Offline capability
• Rebuildable search
• Rebuildable graph/tile artifacts
• Short-lived sharing
• Strict location authorization

Avoid:

• Unlimited raw GPS retention
• API-proxied tile traffic
• Search as source of truth
• Redis as source of truth
• Global synchronous routing
• Permanent live-location URLs
• Client-authoritative geographic data
• Unversioned global map updates
• Frontend-only privacy enforcement
• One-provider hard coupling
• One database handling every global geospatial workload

────────────────────────────────────────

OUTPUT RULES

This is an architecture document only.

Do not generate source code.

Do not generate Dockerfiles.

Do not generate Kubernetes manifests.

Do not generate Terraform.

Do not generate CI/CD files.

Do not generate frontend components.

Do not generate mobile components.

Do not implement backend services.

Provide detailed:

• Architecture
• Domain boundaries
• Service responsibilities
• State machines
• Data ownership
• API contracts
• Event contracts
• Queue contracts
• Geospatial strategy
• Map-data strategy
• Routing strategy
• Navigation strategy
• Privacy model
• Security model
• Multi-region model
• Disaster recovery
• Testing architecture
• ADRs
• Implementation roadmaps

The resulting architecture must be sufficiently detailed that independent backend, web, mobile, geospatial-data, routing, navigation, infrastructure, DevOps, QA, security, moderation, analytics, and operations teams can implement the complete platform without making major architectural decisions themselves.
