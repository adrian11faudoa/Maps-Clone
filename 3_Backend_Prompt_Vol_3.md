You are operating in Senior Engineering Team Mode.

Build the production-ready backend for routing, route calculation, distance matrix, ETA, traffic, incidents, road closures, navigation sessions, turn-by-turn navigation, rerouting, geofencing, current-location processing, location sharing, trip sharing, and location-history foundations for an enterprise-scale global mapping and navigation platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

The backend must follow the approved mapping architecture, PostgreSQL/PostGIS strategy, spatial-cell strategy, road-network architecture, map-data versioning, routing abstraction, search architecture, Redis architecture, Kafka/Redpanda architecture, BullMQ architecture, security model, privacy model, observability model, and Project Index.

Do not redesign the approved architecture.

Do not generate frontend code.

Do not generate mobile code.

Do not generate infrastructure implementation code.

Do not generate Terraform.

Do not generate Kubernetes manifests.

Do not generate CI/CD workflows.

────────────────────────────────────────

MISSION

Implement the production-ready backend required for:

• Route calculation
• Alternative routes
• Travel modes
• Routing preferences
• Distance matrix
• ETA
• Traffic-aware ETA
• Historical traffic
• Live traffic
• Traffic aggregation
• Traffic confidence
• Incidents
• Road closures
• Construction
• Road restrictions
• Turn restrictions
• Speed restrictions
• Toll references
• Routing graph versions
• Route caching
• Navigation sessions
• Turn-by-turn instructions
• Current navigation step
• Off-route detection
• Rerouting
• Route recalculation
• Live location processing
• Location sharing
• Trip sharing
• Geofencing
• Geofence event detection
• Location-history foundations
• Map-matching foundations
• Location privacy enforcement
• Location-event processing

The implementation must support:

• Hundreds of millions of users
• Millions of concurrent navigation sessions
• Massive location-update traffic
• Large routing workloads
• Large distance-matrix workloads
• Real-time traffic updates
• Multiple routing engines/providers
• Multiple regions
• High availability
• Low latency
• Strong location privacy

────────────────────────────────────────

TECHNOLOGY STACK

Backend:

• Node.js
• NestJS
• TypeScript

Database:

• PostgreSQL
• PostGIS
• Prisma ORM

Cache:

• Redis

Event streaming:

• Kafka or Redpanda

Background processing:

• BullMQ

Search:

• Existing OpenSearch/Elasticsearch abstraction where needed

Object storage:

• AWS S3 where required

Real-time:

• WebSockets
• Socket.IO

Observability:

• OpenTelemetry
• Prometheus
• Grafana
• Loki
• Tempo

Testing:

• Jest
• Supertest
• Integration testing
• Spatial testing

Routing engine abstraction:

• OSRM
• GraphHopper
• Valhalla
• Custom routing engine
• Commercial provider adapters where approved

────────────────────────────────────────

IMPLEMENTATION RULES

Never generate pseudo-code.

Never generate placeholders.

Never generate TODO comments.

Never omit implementations.

Never say:

- "implement similarly"
- "left as an exercise"
- "for brevity"
- "remaining code omitted"

Every generated file must be complete.

Every generated file must compile.

Never regenerate unchanged files.

Only modify existing files when required.

Use strict TypeScript.

Use dependency injection.

Keep controllers thin.

Keep routing logic outside controllers.

Use provider-neutral domain interfaces.

Use repositories for persistence.

Use DTOs for external contracts.

Use centralized validation.

Use centralized error handling.

Use structured logging.

Use idempotency for event and job processing.

Use optimistic concurrency where appropriate.

Never trust client-controlled route-state transitions.

Never expose internal routing graph details unnecessarily.

────────────────────────────────────────

DOMAIN OWNERSHIP

Maintain explicit boundaries between:

• Road network
• Routing graph
• Route calculation
• Traffic
• ETA
• Navigation
• Location
• Geofencing
• Location sharing
• Trip sharing
• Location history

Do not combine:

• Static road geometry with live traffic state
• Route calculation with navigation-session state
• Current location with historical location
• Location sharing with ordinary location history
• Traffic aggregation with raw GPS storage
• Geofence policy with arbitrary client-side checks

────────────────────────────────────────

ROUTING ENGINE ABSTRACTION

Implement provider-neutral routing interfaces.

Support:

• Calculate route
• Calculate alternatives
• Calculate matrix
• Calculate ETA
• Recalculate route
• Validate response

Provider adapters must normalize into platform-owned domain contracts.

Provider-specific objects must not leak into controllers or public APIs.

────────────────────────────────────────

ROUTING REQUEST

Support:

• Origin
• Destination
• Waypoints
• Travel mode
• Route preferences
• Departure time
• Arrival time
• Region
• Avoidance rules
• Accessibility preferences

Validate:

• Coordinate ranges
• Waypoint count
• Travel mode
• Departure/arrival compatibility
• Preference combinations

────────────────────────────────────────

TRAVEL MODES

Support:

• Driving
• Walking
• Cycling
• Transit foundation

Each mode may define:

• Routing graph
• Allowed road classes
• Speed model
• Restrictions
• Maneuvers
• ETA behavior

Do not force all modes through identical business logic where their semantics differ.

────────────────────────────────────────

ROUTING PREFERENCES

Support:

• Fastest
• Shortest
• Avoid tolls
• Avoid highways
• Avoid ferries
• Avoid restricted roads
• Accessible route

Preferences are server-authoritative.

────────────────────────────────────────

ROUTE RESULT

Return domain data for:

• Route ID
• Route version
• Distance
• Duration
• Geometry
• Steps
• Warnings
• Toll reference
• Traffic summary
• ETA
• Provider-independent metadata

Do not expose:

• Raw routing graph
• Internal graph identifiers unnecessarily
• Internal ranking/scoring details

────────────────────────────────────────

ALTERNATIVE ROUTES

Support:

• Primary route
• Alternative routes
• Route comparison

Define:

• Distance
• Duration
• ETA
• Difference from primary
• Route geometry

Do not produce meaningless alternatives that are nearly identical.

────────────────────────────────────────

ROUTE QUALITY

Validate provider responses for:

• Geometry validity
• Connectivity
• Non-negative distance
• Non-negative duration
• Required steps
• Valid maneuvers
• Correct origin/destination alignment

Reject malformed route responses.

────────────────────────────────────────

ROUTE CACHE

Implement Redis-backed route caching.

Cache key must account for:

• Origin
• Destination
• Waypoints
• Travel mode
• Preferences
• Departure-time bucket
• Region
• Routing graph version
• Traffic mode

Avoid caching dynamic traffic routes for excessive durations.

────────────────────────────────────────

ROUTE CACHE SAFETY

Prevent:

• Cache poisoning
• Unbounded key cardinality
• Cross-region confusion
• Version mismatch
• Returning stale graph data

Define:

• TTL
• Maximum size
• Version
• Invalidation
• Scope

────────────────────────────────────────

ROUTING GRAPH VERSION

Every route calculation should use an explicit graph version.

Track:

• Graph ID
• Version
• Region
• Effective time
• Build version
• Status

Support:

• Active
• Canary
• Deprecated
• Rolled back

────────────────────────────────────────

ROUTING GRAPH ROLLOUT

Use:

Build
→ Validate
→ Benchmark
→ Canary
→ Regional rollout
→ Monitor
→ Global activation
→ Rollback if necessary

Support simultaneous old/new graph versions during transition.

────────────────────────────────────────

DISTANCE MATRIX

Implement:

• Multiple origins
• Multiple destinations
• Travel mode
• Preferences
• Departure time

Return:

• Distance
• Duration
• ETA where appropriate
• Status per pair

Handle:

• Partial failure
• Invalid points
• Provider limits
• Timeouts

────────────────────────────────────────

DISTANCE MATRIX SCALABILITY

For large matrices:

• Batch requests
• Enforce size limits
• Queue asynchronous processing where appropriate
• Cache reusable results
• Partition by region

Do not allow one request to exhaust routing capacity.

────────────────────────────────────────

ETA

Implement domain-level ETA calculation.

Inputs:

• Route
• Historical traffic
• Live traffic
• Incidents
• Closures
• Current location
• Time

Output:

• Current ETA
• Remaining duration
• Confidence
• Last updated time

────────────────────────────────────────

ETA CONFIDENCE

Define confidence levels such as:

• High
• Medium
• Low
• Stale

Confidence should consider:

• Location freshness
• Traffic freshness
• Provider reliability
• Route stability

────────────────────────────────────────

HISTORICAL TRAFFIC

Aggregate traffic by:

• Road segment
• Spatial cell
• Time bucket
• Day of week
• Region

Support:

• Average speed
• Median speed
• Travel-time factor
• Confidence
• Sample size

Do not preserve unlimited raw individual movement traces as historical traffic data.

────────────────────────────────────────

LIVE TRAFFIC

Implement event-driven traffic ingestion.

Flow:

Location/provider events
→ Kafka
→ Validation
→ Map matching
→ Segment aggregation
→ Traffic state
→ Redis
→ Routing/ETA

Support:

• Update timestamp
• Expiration
• Confidence
• Region

────────────────────────────────────────

TRAFFIC MAP MATCHING

Map-match location samples to:

• Road segment
• Direction
• Region

Use:

• Spatial proximity
• Heading
• Speed
• Previous matched segment

Reject implausible mappings.

────────────────────────────────────────

TRAFFIC AGGREGATION

Compute:

• Segment speed
• Congestion factor
• Delay factor
• Sample count
• Confidence

Use rolling windows.

Avoid oscillating traffic states from small noisy samples.

────────────────────────────────────────

TRAFFIC EXPIRATION

Every live traffic state must have:

• Updated timestamp
• Expiration time
• Confidence

Expired traffic must not be treated as current.

────────────────────────────────────────

TRAFFIC PROVIDER ABSTRACTION

Support external traffic providers.

Normalize:

• Speed
• Congestion
• Delay
• Incident
• Closure

Provider failures:

• Timeout
• Rate limit
• Invalid response
• Outage

must degrade gracefully.

────────────────────────────────────────

TRAFFIC INCIDENTS

Implement:

• Incident
• Geometry
• Type
• Severity
• Source
• Confidence
• Effective time
• Expiration
• Status

Types:

• Accident
• Hazard
• Congestion
• Construction
• Road obstruction
• Police activity where appropriate

────────────────────────────────────────

INCIDENT STATES

Support:

• Active
• Monitoring
• Resolved
• Expired
• Dismissed

────────────────────────────────────────

ROAD CLOSURES

Implement:

• Closure
• Road/segment reference
• Geometry
• Scope
• Direction
• Lane information where supported
• Effective time
• Expiration
• Status

Types:

• Full
• Partial
• Lane
• Scheduled
• Emergency

────────────────────────────────────────

ROUTING + CLOSURES

A route must avoid active closures where appropriate.

If a closure becomes active after a route has been calculated:

• Mark route affected
• Notify navigation
• Trigger reroute where required

────────────────────────────────────────

ROAD RESTRICTIONS

Evaluate:

• Vehicle type
• Road class
• Weight
• Height
• Width
• Direction
• Time
• Season
• Travel mode

Routing must respect the established restrictions.

────────────────────────────────────────

TURN RESTRICTIONS

Support:

• No turn
• Only turn
• Conditional turn

Validate against route graph.

────────────────────────────────────────

SPEED LIMITS

Support:

• Static speed limit
• Direction-specific
• Conditional
• Effective dates
• Source
• Confidence

Do not directly replace traffic speed with speed limits.

────────────────────────────────────────

TOLL METADATA

Routes may reference:

• Toll roads
• Toll segments
• Toll plazas
• Toll zones

Do not fabricate exact monetary tolls if the provider does not supply a reliable price.

────────────────────────────────────────

NAVIGATION SESSION

Implement:

• Navigation ID
• User
• Device
• Route ID
• Route version
• Graph version
• Travel mode
• Destination
• Current position
• Current step
• Next maneuver
• Remaining distance
• Remaining duration
• ETA
• Status

Navigation states:

• Created
• Active
• Paused
• Recalculating
• Completed
• Canceled
• Expired

────────────────────────────────────────

NAVIGATION STATE MACHINE

Implement valid transitions.

Example:

Created
→ Active
→ Recalculating
→ Active
→ Completed

And:

Active
→ Paused
→ Active

Invalid transitions must fail safely.

────────────────────────────────────────

TURN-BY-TURN

Generate normalized maneuver objects.

Support:

• Continue
• Left
• Right
• U-turn
• Merge
• Keep
• Fork
• Roundabout
• Exit
• Ferry
• Destination arrival

Each step contains:

• Instruction
• Maneuver
• Street
• Distance
• Duration
• Coordinate
• Bearing where available

────────────────────────────────────────

CURRENT NAVIGATION STEP

Given current location:

• Determine active step
• Determine distance to maneuver
• Determine next step
• Detect passed maneuver
• Update ETA

Use map-matched location where possible.

────────────────────────────────────────

OFF-ROUTE DETECTION

Evaluate:

• Distance from route
• Location accuracy
• Heading
• Speed
• Travel mode
• Road context

Use hysteresis/cooldowns.

Do not trigger repeated reroutes due to GPS jitter.

────────────────────────────────────────

OFF-ROUTE STATES

Support:

• On route
• Possibly off route
• Confirmed off route
• Rerouting

Use multiple samples where appropriate.

────────────────────────────────────────

REROUTING

Triggers:

• Confirmed off-route
• Major road closure
• Major traffic change
• Destination change
• User deviation
• Route invalidation

Support:

• Cooldown
• Concurrency control
• Reroute version
• Previous route reference

Prevent simultaneous duplicate reroutes.

────────────────────────────────────────

REROUTE CONCURRENCY

Prevent:

• Duplicate recalculation
• Stale route overwrite
• Old reroute replacing newer reroute
• Multiple navigation workers fighting

Use:

• Navigation version
• Request ID
• Optimistic concurrency
• Idempotency

────────────────────────────────────────

LOCATION INGESTION

Implement location ingestion for active navigation.

Each location event includes:

• User/device
• Navigation session
• Latitude
• Longitude
• Accuracy
• Heading
• Speed
• Timestamp
• Sequence where available

Validate before processing.

────────────────────────────────────────

LOCATION FRESHNESS

Define:

• Fresh
• Aging
• Stale
• Expired

Use travel-mode-specific thresholds.

Navigation must not silently rely on very stale position data.

────────────────────────────────────────

LOCATION STREAM PROCESSING

Flow:

Device
→ API/WebSocket
→ Validation
→ Region routing
→ Kafka
→ Navigation processor
→ Map matching
→ Navigation state
→ Client update

Use asynchronous processing where possible without compromising user-visible navigation latency.

────────────────────────────────────────

LOCATION PRIVACY

Enforce access controls for:

• Current location
• Navigation location
• Historical location
• Shared location

Never allow one user to retrieve arbitrary other-user location streams.

────────────────────────────────────────

LOCATION SHARING

Implement:

• Create share
• Get share
• Revoke
• Expire

A share contains:

• Share ID
• Owner
• Recipient/access token reference
• Location scope
• Created time
• Expiration
• Revoked time

Use short-lived authorization.

────────────────────────────────────────

LIVE LOCATION SHARING

Support current or continuously updated shared location.

Use:

• WebSocket where appropriate
• Redis ephemeral state
• Kafka events

Do not persist every live update indefinitely.

────────────────────────────────────────

TRIP SHARING

Support:

• Trip share creation
• Route
• Current position
• ETA
• Destination
• Navigation status
• Expiration
• Revoke

Do not expose:

• Payment details
• Account details
• Unrelated location history

────────────────────────────────────────

SHARE AUTHORIZATION

A recipient may access a share only if:

• Share exists
• Share has not expired
• Share has not been revoked
• Access token is valid
• Policy allows access

Share authorization must be server-side.

────────────────────────────────────────

GEOFENCING

Implement:

• Circle geofence
• Polygon geofence
• Spatial-cell geofence

Fields:

• Geofence ID
• Owner
• Geometry
• Region
• Trigger types
• Status
• Expiration

Triggers:

• Enter
• Exit
• Dwell

────────────────────────────────────────

GEOFENCE EVALUATION

Use:

• PostGIS
• Spatial cells
• Redis current-location state

Optimize candidate geofences before exact geometry evaluation.

────────────────────────────────────────

GEOFENCE EVENT IDEMPOTENCY

Prevent duplicate:

• Enter
• Exit
• Dwell

Use:

• Location sequence
• Geofence version
• Transition state
• Idempotency keys

────────────────────────────────────────

LOCATION HISTORY

Implement foundation for:

• Location events
• Location sessions
• Historical queries
• Delete request

Support:

• Temporal partitioning
• Spatial partitioning
• Region

Do not store unlimited raw location data in the transactional database without retention controls.

────────────────────────────────────────

MAP MATCHING

Create provider-neutral map-matching abstraction.

Input:

• Location samples
• Road network version
• Travel mode

Output:

• Road segment
• Position on segment
• Confidence
• Direction
• Matched timestamp

────────────────────────────────────────

MAP MATCHING QUALITY

Use:

• Distance
• Heading
• Speed
• Continuity
• Road topology

Reject implausible matches.

────────────────────────────────────────

LOCATION ANOMALIES

Detect signals such as:

• Impossible speed
• Large coordinate jump
• Stale timestamp
• Reversed clock
• Repeated identical coordinates

Store normalized anomaly references where useful.

Do not automatically classify every anomaly as malicious.

────────────────────────────────────────

DATABASE

Implement Prisma/PostGIS models and migrations for:

• RoutingGraph
• RoutingGraphVersion
• RouteRequest
• Route
• RouteAlternative
• RouteStep
• RouteWarning
• RouteTrafficSummary
• NavigationSession
• NavigationState
• NavigationReroute
• TrafficSnapshot
• TrafficSegmentState
• TrafficHistoryAggregate
• TrafficIncident
• RoadClosure
• RoadRestrictionReference
• SpeedLimitReference
• TollReference
• LocationSession
• LocationEventReference
• MapMatchReference
• LocationShare
• TripShare
• Geofence
• GeofenceTransition
• DistanceMatrixRequest
• DistanceMatrixResult

Use:

• Foreign keys
• Unique constraints
• Composite indexes
• Version fields
• Effective timestamps
• Expiration timestamps
• Region references

────────────────────────────────────────

DATABASE INDEXING

Create indexes for:

ROUTES

• User
• Created time
• Region
• Graph version

NAVIGATION

• User/device
• Active status
• Updated time

TRAFFIC

• Road segment
• Region
• Time bucket

INCIDENTS

• Region
• Status
• Effective time
• Expiration

CLOSURES

• Road segment
• Status
• Effective time

SHARING

• Owner
• Token reference
• Expiration
• Revocation

GEOFENCING

• Owner
• Status
• Region
• Geometry

LOCATION

• Session
• Region
• Time

────────────────────────────────────────

REDIS

Implement Redis usage for:

• Route cache
• ETA cache
• Live traffic
• Current location
• Navigation session acceleration
• Geofence candidate lookup
• Location-share state
• Trip-share state
• Routing graph active version
• Rate limiting
• Reroute deduplication

Define:

• Namespace
• Region
• Version
• TTL
• Ownership

Redis is not authoritative for durable navigation/history records.

────────────────────────────────────────

KAFKA EVENTS

Publish:

ROUTING

• RouteRequested
• RouteCalculated
• RouteFailed
• RerouteRequested
• RerouteCompleted

NAVIGATION

• NavigationStarted
• NavigationPaused
• NavigationResumed
• NavigationCompleted
• OffRouteDetected

LOCATION

• LocationReceived
• LocationValidated
• LocationAnomalyDetected
• LocationMatched

TRAFFIC

• TrafficUpdated
• IncidentCreated
• IncidentResolved
• RoadClosureCreated
• RoadClosureRemoved

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

All events must:

• Be versioned
• Be idempotent
• Include region
• Include correlation metadata
• Minimize precise personal-location data

────────────────────────────────────────

BULLMQ

Implement jobs for:

• Traffic aggregation
• Traffic expiration
• Route cleanup
• Navigation cleanup
• Reroute processing where asynchronous
• Geofence maintenance
• Location-history retention
• Location-share expiration
• Trip-share expiration
• Incident expiration
• Matrix processing
• Traffic backfill

Every job must support:

• Retry
• Backoff
• Timeout
• Concurrency
• Idempotency
• Dead-letter handling
• Metrics

────────────────────────────────────────

API

ROUTING

• Calculate route
• Get route
• Get alternatives
• Calculate matrix
• Get route metadata

ETA

• Calculate ETA
• Get ETA
• Refresh ETA

TRAFFIC

• Get traffic
• Get incident
• Get active closures

NAVIGATION

• Start navigation
• Get navigation state
• Update navigation location
• Pause
• Resume
• Complete
• Cancel
• Request reroute

LOCATION

• Start location session
• Submit location
• Get current location where authorized
• End session

SHARING

• Create location share
• Get share
• Revoke share
• Create trip share
• Get trip share
• Revoke trip share

GEOFENCE

• Create
• Update
• Delete
• Get
• List

Every API must implement:

• Authentication
• Authorization
• Validation
• Rate limiting
• Idempotency where required
• OpenAPI
• Consistent errors

────────────────────────────────────────

ROUTING API LIMITS

Protect against abusive requests.

Limit:

• Waypoints
• Matrix size
• Request rate
• Geometry payload size
• Concurrent navigation sessions
• Reroute frequency

Use user/application-specific quotas.

────────────────────────────────────────

NAVIGATION API

Navigation location updates must be optimized for:

• Low latency
• Mobile networks
• Temporary disconnects
• Duplicate events

Support sequence/revision numbers where needed.

────────────────────────────────────────

WEBSOCKETS

Implement real-time channels for:

• Navigation state
• Reroute
• Traffic/incident updates
• Location sharing
• Trip sharing
• Geofence events

Every channel must verify authorization.

────────────────────────────────────────

SECURITY

Protect against:

• Location stalking
• Share-token theft
• Route scraping
• API abuse
• Navigation-session hijacking
• Geofence abuse
• Unauthorized current-location access
• Historical-location access
• Route manipulation
• Provider credential exposure

Use:

• Authentication
• Authorization
• RBAC
• Short-lived share access
• Rate limiting
• Audit
• Encryption in transit
• Minimal data exposure

────────────────────────────────────────

PRIVACY

Treat precise location as highly sensitive.

Do not expose:

• Raw location history
• Home/work inference
• Private navigation history
• Private share information

through ordinary public APIs.

Provide deletion/retention hooks for:

• Location sessions
• Location history
• Shares
• Geofence history

────────────────────────────────────────

OBSERVABILITY

Instrument:

• Route calculation
• Matrix
• ETA
• Navigation
• Location ingestion
• Map matching
• Traffic
• Incidents
• Closures
• Sharing
• Geofencing
• Rerouting

Track:

• Route latency
• ETA latency
• Reroute latency
• Navigation update latency
• Location freshness
• Traffic freshness
• Map-match confidence
• Off-route rate
• Reroute rate
• WebSocket connection count
• Queue depth
• Kafka lag
• Cache hit rate

Never log:

• Raw precise coordinates unnecessarily
• Share tokens
• Private location history
• Authentication credentials

────────────────────────────────────────

TESTING

UNIT TESTS

Test:

• Route validation
• Route preferences
• Navigation state machine
• Off-route detection
• Rerouting rules
• ETA confidence
• Traffic aggregation
• Incident state
• Closure state
• Geofence logic
• Share authorization
• Location retention

ROUTING TESTS

Test:

• Driving
• Walking
• Cycling
• Waypoints
• Alternatives
• Restrictions
• Closures
• Tolls
• Traffic

DISTANCE MATRIX

Test:

• Valid matrix
• Oversized matrix
• Partial provider failure
• Timeout
• Cache

ETA

Test:

• Static
• Historical traffic
• Live traffic
• Stale traffic
• Incident
• Closure

NAVIGATION

Test:

• Start
• Pause
• Resume
• Complete
• Off-route
• Reroute
• Destination reached
• Stale location
• Concurrent reroute

LOCATION

Test:

• Valid
• Invalid
• Stale
• Duplicate
• Out-of-order
• Impossible movement

SHARING

Test:

• Create
• Access
• Expiration
• Revoke
• Unauthorized access
• Token replay

GEOFENCING

Test:

• Enter
• Exit
• Dwell
• Boundary
• Duplicate event
• Deleted geofence

SECURITY

Test:

• Location IDOR
• Share-token theft
• Navigation hijacking
• Unauthorized history
• Geofence access
• Route abuse

CONCURRENCY

Test:

• Concurrent navigation updates
• Simultaneous reroutes
• Route-version race
• Closure/routing race
• Share/revoke race

PERFORMANCE

Test:

• Route throughput
• Matrix throughput
• ETA throughput
• Location ingestion
• Traffic aggregation
• WebSocket navigation

────────────────────────────────────────

DOCUMENTATION

Generate:

• Routing architecture
• Routing engine abstraction
• Route request
• Route result
• Alternatives
• Route caching
• Routing graph versions
• Distance matrix
• ETA
• ETA confidence
• Historical traffic
• Live traffic
• Traffic map matching
• Traffic aggregation
• Traffic expiration
• Incidents
• Closures
• Road restrictions
• Speed limits
• Toll metadata
• Navigation sessions
• Navigation state machine
• Turn-by-turn
• Off-route detection
• Rerouting
• Location ingestion
• Location processing
• Map matching
• Location sharing
• Trip sharing
• Share authorization
• Geofencing
• Location history
• Privacy
• Security
• Event catalog
• Queue catalog
• Database schema
• Redis key catalog
• Testing strategy
• Observability
• Failure handling

────────────────────────────────────────

PROJECT INDEX

Update the backend Project Index with:

• Routing service
• Routing providers
• Routing graph versions
• Routes
• Alternative routes
• Route steps
• Route warnings
• Route cache
• Distance matrix
• ETA
• ETA confidence
• Traffic
• Historical traffic
• Live traffic
• Incidents
• Closures
• Road restrictions
• Speed limits
• Toll references
• Navigation sessions
• Navigation state
• Rerouting
• Location ingestion
• Location sessions
• Map matching
• Location shares
• Trip shares
• Geofences
• Geofence transitions
• Kafka topics
• BullMQ queues
• Redis keys
• Database migrations
• APIs
• WebSocket events
• Tests
• Security
• Privacy
• Observability
• Generated files
• Modified files
• Remaining work
• Current milestone
• Dependencies

────────────────────────────────────────

IMPLEMENTATION MILESTONES

BACKEND MILESTONE 21

Routing engine abstraction, routing requests, route results, alternatives, routing preferences, validation, provider adapters, and route caching.

BACKEND MILESTONE 22

Routing graph versions, graph activation, version-safe routing, graph rollout support, route metadata, and routing observability.

BACKEND MILESTONE 23

Distance matrix, batching, size limits, asynchronous processing, partial failures, caching, and performance protection.

BACKEND MILESTONE 24

ETA, historical traffic, live traffic, traffic aggregation, map matching, traffic confidence, and traffic expiration.

BACKEND MILESTONE 25

Traffic incidents, road closures, construction, restrictions, speed limits, toll references, routing integration, and event propagation.

BACKEND MILESTONE 26

Navigation sessions, state machine, turn-by-turn, current-step computation, location updates, off-route detection, and rerouting.

BACKEND MILESTONE 27

Location sessions, current-location processing, map matching, location anomalies, location privacy, retention hooks, and event pipelines.

BACKEND MILESTONE 28

Location sharing, live sharing, trip sharing, secure share authorization, WebSockets, expiration, revocation, and privacy controls.

BACKEND MILESTONE 29

Geofencing, spatial candidate lookup, enter/exit/dwell events, concurrency, retention, queues, reconciliation, and observability.

BACKEND MILESTONE 30

Full routing, ETA, traffic, navigation, location, sharing, geofencing, concurrency, security, performance, resilience, and integration testing.

Each milestone should contain approximately 20–40 files where practical.

Every milestone must compile before proceeding.

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never truncate code.

Never summarize source code instead of generating it.

Never generate pseudo-code.

Never generate placeholders.

Never generate TODO implementations.

When modifying an existing file:

1. Provide the exact file path.
2. State why it must change.
3. Provide the complete updated file.

Never regenerate unchanged files.

────────────────────────────────────────

SCOPE RESTRICTION

This volume covers:

• Routing
• Route calculation
• Alternative routes
• Travel modes
• Routing preferences
• Route caching
• Routing graph versions
• Distance matrix
• ETA
• Historical traffic
• Live traffic
• Traffic aggregation
• Traffic map matching
• Traffic incidents
• Road closures
• Construction
• Road restrictions
• Speed limits
• Toll references
• Navigation sessions
• Turn-by-turn navigation
• Off-route detection
• Rerouting
• Location ingestion
• Location sessions
• Map matching
• Location anomalies
• Location sharing
• Trip sharing
• Share authorization
• Geofencing
• Location-history foundations
• Related APIs
• Related WebSockets
• Related events
• Related queues
• Related workers

Do not implement complete:

• Offline map generation
• Offline routing
• Full review system
• Ratings
• User contributions
• Business administration
• Full moderation platform
• Full fraud platform
• Complete analytics platform
• Administration UI
• Frontend
• Mobile
• Infrastructure

Use the existing identity, place, address, road-network, map-data, Redis, Kafka, BullMQ, and security foundations.

────────────────────────────────────────

QUALITY BAR

Treat routing, navigation, traffic, and location systems as mission-critical.

Assume:

• Hundreds of millions of users
• Millions of concurrent navigation sessions
• Massive location-update streams
• Large routing traffic
• Large matrix workloads
• Multiple routing providers
• Multiple regions
• Rapid traffic changes
• Strict location privacy

Prioritize:

• Routing correctness
• Low latency
• Navigation stability
• Location freshness
• Traffic quality
• Reroute correctness
• Privacy
• Security
• Provider abstraction
• Idempotency
• Scalability
• Observability
• Resilience
• Maintainability
• Production readiness
