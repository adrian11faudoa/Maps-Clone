You are operating in Senior Engineering Team Mode.

Build the production-ready backend foundation for an enterprise-scale global mapping, places, geospatial search, routing, navigation, traffic, and location platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

The backend must follow the approved mapping architecture, domain boundaries, geospatial strategy, map-data architecture, road-network model, routing strategy, location architecture, search architecture, privacy model, security model, event architecture, queue architecture, infrastructure strategy, and Project Index.

Do not redesign the approved architecture.

Do not generate frontend code.

Do not generate mobile code.

Do not generate infrastructure implementation code.

Do not generate Terraform.

Do not generate Kubernetes manifests.

Do not generate CI/CD workflows.

────────────────────────────────────────

MISSION

Build the production-ready backend foundation required for:

• API Gateway
• Application bootstrap
• Configuration
• Request context
• Structured logging
• Error handling
• Validation
• Authentication foundation
• Authorization foundation
• PostgreSQL
• PostGIS
• Prisma
• Redis
• Kafka/Redpanda
• BullMQ
• WebSockets
• Socket.IO
• OpenTelemetry
• Metrics
• Health checks
• Graceful shutdown
• API contracts
• Event contracts
• Queue contracts
• Geospatial abstractions
• Search abstractions
• Routing abstractions
• Location abstractions
• Storage abstractions
• Testing foundation
• Local development

The complete backend must eventually support:

• Users
• Accounts
• Profiles
• Devices
• Location
• Location history
• Location sharing
• Trip sharing
• Places
• Businesses
• POIs
• Addresses
• Categories
• Hours
• Photos
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Map data
• Vector tiles
• Raster tiles
• Map styles
• Road network
• Road restrictions
• Speed limits
• Routing
• Distance matrix
• ETA
• Traffic
• Incidents
• Closures
• Navigation
• Turn-by-turn
• Rerouting
• Saved places
• Collections
• Geofences
• Offline maps
• Contributions
• Reviews
• Ratings
• Moderation
• Safety
• Fraud/abuse
• Notifications
• Analytics
• Administration
• Feature flags
• Configuration
• Audit
• Privacy

────────────────────────────────────────

PRIMARY TECHNOLOGY STACK

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

• Elasticsearch or OpenSearch

Object storage:

• AWS S3

CDN:

• CloudFront

Real-time:

• WebSockets
• Socket.IO

Notifications:

• Firebase Cloud Messaging
• Apple Push Notification Service

Observability:

• OpenTelemetry
• Prometheus
• Grafana
• Loki
• Tempo

Testing:

• Jest
• Supertest
• Integration testing tools

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

Keep business logic outside controllers.

Use repositories for persistence.

Use DTOs for external contracts.

Use centralized validation.

Use centralized error handling.

Use structured logging.

Use idempotency for retriable operations.

Use optimistic concurrency where appropriate.

Never trust client-supplied ownership or authorization.

Never treat client location as authoritative without server validation.

────────────────────────────────────────

BACKEND ARCHITECTURE

Use:

• Clean Architecture
• Domain-Driven Design
• SOLID
• Repository Pattern
• Service Layer
• Dependency Injection
• Feature-first organization
• Explicit domain ownership
• CQRS where justified
• Event-driven communication where appropriate
• Transactional Outbox
• Idempotent consumers
• Stateless services where possible
• Horizontal scalability
• Regional processing
• Geospatial indexing
• Provider abstraction
• Graceful degradation

The implementation must allow future independent extraction of:

• Location
• Search
• Geocoding
• Routing
• Traffic
• Navigation
• Map-data processing
• Tile services

────────────────────────────────────────

MONOREPO BACKEND FOUNDATION

Prepare structure:

apps/

• API Gateway

services/

• Identity
• Accounts
• Profiles
• Devices
• Location
• Location History
• Places
• Businesses
• Addresses
• Geocoding
• Reverse Geocoding
• Autocomplete
• Search
• Map Data
• Tiles
• Map Styles
• Road Network
• Routing
• ETA
• Traffic
• Incidents
• Closures
• Navigation
• Transit
• Saved Places
• Collections
• Location Sharing
• Trip Sharing
• Geofencing
• Offline Maps
• Contributions
• Reviews
• Ratings
• Moderation
• Safety
• Fraud
• Notifications
• Analytics
• Administration
• Audit
• Feature Flags
• Configuration
• Privacy

workers/

• Map-data ingestion
• Search indexing
• Geocoding batches
• Road-graph builds
• Traffic aggregation
• Geofence processing
• Offline package generation
• Moderation
• Analytics
• Privacy
• Cleanup

packages/

• Configuration
• Logging
• Errors
• Validation
• Database
• Redis
• Events
• Queues
• Observability
• API contracts
• Geospatial utilities
• Search abstraction
• Routing abstraction
• Provider abstractions
• Storage abstraction
• Testing utilities

────────────────────────────────────────

APPLICATION BOOTSTRAP

Implement:

• NestJS initialization
• Environment loading
• Configuration
• Global validation
• Global exception handling
• Structured logging
• Request IDs
• Correlation IDs
• Trace IDs
• CORS
• Secure headers
• Request limits
• API versioning
• OpenAPI
• Graceful shutdown
• Health checks

Production defaults must be safe.

────────────────────────────────────────

CONFIGURATION

Create strongly typed centralized configuration.

APPLICATION:

• Environment
• Service name
• Version
• Host
• Port
• Region

DATABASE:

• Host
• Port
• Database
• Username
• Password
• TLS
• Connection pool

POSTGIS:

• Spatial configuration
• Database integration

REDIS:

• Host
• Port
• Username
• Password
• TLS

KAFKA:

• Brokers
• Client ID
• Authentication
• TLS
• Consumer groups

BULLMQ:

• Redis configuration
• Retry defaults
• Queue defaults

S3:

• Bucket
• Region
• Endpoint if required

SEARCH:

• Endpoint
• Authentication
• Index prefix

MAP:

• Dataset version
• Style version

GEOCODING:

• Provider configuration
• Timeout
• Retry

ROUTING:

• Provider
• Timeout
• Retry
• Graph version

TRAFFIC:

• Provider
• Update interval
• Expiration

LOCATION:

• Sampling rules
• Accuracy
• Retention references

OBSERVABILITY:

• Log level
• OpenTelemetry endpoint
• Metrics

Never read process.env directly inside domain services.

Validate all configuration at startup.

────────────────────────────────────────

REQUEST CONTEXT

Implement request context containing:

• Request ID
• Correlation ID
• Trace ID
• User ID
• Device ID
• Platform
• Client version
• Region
• Service
• Environment

Propagate through:

• HTTP
• Kafka
• BullMQ
• External APIs
• Logs
• Metrics
• Traces

────────────────────────────────────────

LOGGING

Implement structured logs.

Fields:

• Timestamp
• Service
• Environment
• Region
• Level
• Request ID
• Correlation ID
• Trace ID
• Operation
• Duration
• Result
• Safe error

Never log:

• Passwords
• Tokens
• Provider credentials
• Exact long-term location history unnecessarily
• Live-location sharing secrets
• Private saved places
• Sensitive privacy data

────────────────────────────────────────

ERROR HANDLING

Define normalized backend errors for:

• Validation
• Authentication
• Authorization
• Not found
• Conflict
• Rate limit
• Invalid coordinate
• Unsupported travel mode
• Routing failure
• Geocoding failure
• Search failure
• Location failure
• Dependency unavailable
• Provider timeout
• Invalid map dataset
• Offline package failure
• Internal error

Response:

• Error code
• Safe message
• Request ID
• Correlation ID
• Validation details where safe

Never expose stack traces in production.

────────────────────────────────────────

VALIDATION

Validate:

• Coordinates
• Latitude
• Longitude
• Accuracy
• Heading
• Speed
• Timestamps
• Bounding boxes
• Radius
• Geometry
• Polygon input
• Place identifiers
• Address input
• Search queries
• Route requests
• Waypoints
• Travel modes
• Routing preferences
• Pagination
• Cursors
• Geofence definitions

Reject invalid spatial data.

────────────────────────────────────────

COORDINATE FOUNDATION

Use:

• WGS84 / EPSG:4326 externally

Define validation:

Latitude:
• -90 to +90

Longitude:
• -180 to +180

Support:

• Coordinate precision
• Accuracy radius
• Altitude
• Heading
• Speed
• Timestamp

Create geospatial utility abstractions for:

• Distance
• Bounding box
• Polygon containment
• Nearest-neighbor support
• Spatial-cell encoding

────────────────────────────────────────

SPATIAL CELL ABSTRACTION

Create a provider-neutral cell abstraction.

Prepare for:

• H3
• Geohash
• S2-like cells

Support:

• Encode point
• Decode cell
• Parent cell
• Children cells
• Neighbor cells
• Resolution
• Region partition

Do not expose provider-specific cell types unnecessarily through public APIs.

────────────────────────────────────────

DATABASE FOUNDATION

Implement PostgreSQL/PostGIS integration using Prisma.

Support:

• Prisma lifecycle
• Connection management
• Transactions
• Health checks
• Graceful shutdown
• Error normalization
• Migration structure
• Query logging controls

PostGIS-specific SQL may be encapsulated where Prisma does not provide sufficient capabilities.

────────────────────────────────────────

PRISMA CONVENTIONS

Define conventions for:

• UUID/public identifiers
• Created timestamp
• Updated timestamp
• Soft deletion where justified
• Version fields
• Optimistic concurrency
• Foreign keys
• Composite indexes
• Spatial columns where supported
• Audit references

Do not force every table to use identical behavior when domain requirements differ.

────────────────────────────────────────

SPATIAL INDEX FOUNDATION

Prepare indexes for:

• Place points
• Road geometries
• Administrative boundaries
• Geofences
• Business locations

Use appropriate:

• GiST
• SP-GiST

indexes.

Define access patterns for:

• Radius search
• Bounding box
• Nearest neighbor
• Polygon containment

────────────────────────────────────────

REDIS FOUNDATION

Implement reusable Redis infrastructure.

Support:

• Connection lifecycle
• TLS
• Authentication
• Health check
• Serialization
• Namespaced keys
• TTL
• Cache abstraction
• Rate limiting
• Short-lived coordination
• Idempotency
• Geospatial operations where appropriate

Prepare Redis for:

• Current location
• Route cache
• ETA
• Search cache
• Geocode cache
• Autocomplete
• Traffic
• Geofence acceleration
• Share state

Redis is never authoritative for:

• Places
• Roads
• User identity
• Location history
• Reviews
• Routes as durable source
• Privacy records

────────────────────────────────────────

REDIS KEY CONVENTIONS

Namespaces:

• location:
• geocode:
• reverse-geocode:
• autocomplete:
• search:
• place:
• route:
• eta:
• traffic:
• geofence:
• share:
• session:
• rate-limit:
• idempotency:

Define:

• Environment
• Region
• Version
• TTL
• Ownership

────────────────────────────────────────

KAFKA / REDPANDA FOUNDATION

Implement reusable:

• Producer
• Consumer
• Consumer group
• Serializer
• Deserializer
• Event validation
• Event envelope
• Retry
• Dead-letter handling
• Graceful shutdown

Event envelope:

• Event ID
• Event type
• Version
• Aggregate type
• Aggregate ID
• Region
• Timestamp
• Producer
• Correlation ID
• Causation ID where appropriate
• Payload

────────────────────────────────────────

TRANSACTIONAL OUTBOX

Implement reusable outbox.

Fields:

• Outbox ID
• Event type
• Version
• Aggregate
• Aggregate ID
• Region
• Payload
• Status
• Retry count
• Next retry
• Published timestamp
• Error
• Created timestamp

Ensure database state and event creation are atomic.

Support retry and duplicate-safe publishing.

────────────────────────────────────────

BULLMQ FOUNDATION

Implement reusable queues/workers.

Support:

• Job schema
• Producer
• Worker
• Job ID
• Retry
• Exponential backoff
• Timeout
• Concurrency
• Dead-letter
• Graceful shutdown
• Metrics

Prepare queues for:

• Map ingestion
• Search indexing
• Geocoding batches
• Road graph
• Traffic
• Geofencing
• Offline maps
• Reviews
• Moderation
• Analytics
• Privacy
• Cleanup

────────────────────────────────────────

WEBSOCKET FOUNDATION

Implement:

• Connection establishment
• Authentication
• Authorization
• Heartbeats
• Reconnect
• Connection metadata
• Region
• Channels/rooms
• Rate limiting
• Backpressure

Prepare channels for:

• Live location
• Navigation
• Traffic updates
• Trip sharing
• Notifications
• Place/contribution updates

────────────────────────────────────────

SOCKET.IO FOUNDATION

Implement where approved:

• Gateway
• Authentication middleware
• Connection tracking
• Room management
• Event validation
• Error handling
• Heartbeats
• Rate limits

Prepare horizontal scaling with Redis coordination.

────────────────────────────────────────

LOCATION FOUNDATION

Create location-session architecture.

Support:

• Session start
• Session end
• Device reference
• Current location
• Last known location
• Accuracy
• Timestamp
• Heading
• Speed
• Region

Separate operational location from historical location.

────────────────────────────────────────

LOCATION VALIDATION

Validate:

• Coordinate range
• Timestamp freshness
• Accuracy
• Speed
• Heading
• Sequence if provided

Detect suspicious:

• Impossible movement
• Extreme jumps
• Stale timestamps

Do not automatically classify all anomalies as fraud.

────────────────────────────────────────

LIVE LOCATION

Implement infrastructure for current location.

Use Redis for low-latency ephemeral state.

Support:

• Set current location
• Get current location
• Expiration
• Region
• Accuracy
• Timestamp

Authoritative history must be separate.

────────────────────────────────────────

LOCATION EVENTS

Define:

• LocationSessionStarted
• LocationUpdated
• LocationSessionEnded

Location events must:

• Be versioned
• Be idempotent
• Respect privacy
• Include region
• Include timestamp
• Avoid unnecessary personal data

────────────────────────────────────────

LOCATION HISTORY ABSTRACTION

Create service interfaces for:

• Store location event
• Query history
• Delete history
• Aggregate history

Do not immediately implement unlimited raw location retention.

Prepare:

• Temporal partitioning
• Spatial partitioning
• Regional ownership
• Retention policies

────────────────────────────────────────

PLACE FOUNDATION

Create foundational models/services for:

• Place
• Address
• Business
• Category
• Place status
• Place hours
• Place attributes

Do not implement the entire place-management product in this milestone.

────────────────────────────────────────

PLACE IDENTITY

Define:

• Public place ID
• Internal database ID
• Source/provider reference
• Canonical status

Prepare support for:

• Duplicate
• Merge
• Split
• Relocation

────────────────────────────────────────

ADDRESS FOUNDATION

Implement:

• Structured address
• Display address
• Normalized fields
• Coordinates
• Administrative references
• Postal code
• Region
• Country

Separate normalized representation from display text.

────────────────────────────────────────

GEOCODING ABSTRACTION

Create provider-neutral interfaces:

• Geocode
• Reverse geocode

Normalize responses to platform-owned contracts.

Support:

• Coordinates
• Place reference
• Address
• Confidence
• Match type
• Region

────────────────────────────────────────

GEOCODING PROVIDER ABSTRACTION

Provider failures must normalize to:

• Timeout
• Rate limit
• Unavailable
• Invalid response
• No result

Support future multiple-provider fallback.

Do not expose provider-specific errors to public APIs.

────────────────────────────────────────

SEARCH ABSTRACTION

Create provider-neutral interfaces for:

• Search
• Suggest
• Index
• Update
• Delete
• Bulk index

Prepare search for:

• Places
• Businesses
• Addresses
• Roads
• Categories

────────────────────────────────────────

ROUTING ABSTRACTION

Create provider-neutral route interfaces.

Support:

• Driving
• Walking
• Cycling
• Transit foundation

Input:

• Origin
• Destination
• Waypoints
• Mode
• Preferences
• Departure
• Arrival

Output:

• Route reference
• Distance
• Duration
• Geometry
• Steps
• Warnings
• ETA reference

Do not expose provider-specific routing response structures.

────────────────────────────────────────

ROUTE DOMAIN FOUNDATION

Create abstractions for:

• Route request
• Route result
• Alternative routes
• Route version
• Routing graph version
• Provider
• Region

Do not yet implement the final routing algorithm.

────────────────────────────────────────

ROUTE CACHE FOUNDATION

Create cache abstraction for:

• Route
• Distance matrix
• ETA

Keys should include normalized:

• Origin
• Destination
• Waypoints
• Mode
• Preferences
• Departure-time bucket
• Region
• Routing version

Do not cache dynamic traffic indefinitely.

────────────────────────────────────────

ETA FOUNDATION

Create provider-neutral ETA interface.

Support:

• Route duration
• Dynamic ETA
• Waypoint ETA
• Arrival time

Prepare inputs for:

• Historical traffic
• Live traffic
• Closures
• Incidents

────────────────────────────────────────

MAP DATA FOUNDATION

Create abstractions for:

• Map dataset
• Dataset version
• Region
• Source
• Build
• Validation
• Publication

Dataset states:

• Draft
• Validating
• Published
• Superseded
• Rolled Back

────────────────────────────────────────

MAP STYLE FOUNDATION

Create versioned map-style abstraction.

Support:

• Light
• Dark
• Navigation
• Accessibility
• Terrain foundation

Styles must be independently cacheable.

────────────────────────────────────────

TILE FOUNDATION

Create provider-neutral tile service interfaces.

Support:

• Vector tiles
• Raster tiles
• Tile coordinate
• Zoom
• Layer
• Dataset version
• Style version

The API application should not proxy tile bytes unnecessarily.

────────────────────────────────────────

ROAD NETWORK FOUNDATION

Create domain abstractions for:

• Road
• Road node
• Road segment
• Geometry
• Road class
• Direction
• Surface
• Speed limit
• Lane metadata
• Access restriction
• Toll reference
• Turn restriction

Do not place full routing graph logic into API controllers.

────────────────────────────────────────

ROAD GRAPH FOUNDATION

Create interfaces for:

• Build graph
• Validate graph
• Publish graph
• Activate graph version
• Roll back graph

Graph version must be explicit.

────────────────────────────────────────

TRAFFIC FOUNDATION

Create interfaces for:

• Live traffic
• Historical traffic
• Segment speed
• Congestion
• Delay
• Confidence

Use Kafka/event streams for high-frequency inputs.

Redis may hold current ephemeral traffic state.

────────────────────────────────────────

INCIDENT FOUNDATION

Create models/services for:

• Incident
• Geometry
• Severity
• Source
• Confidence
• Effective timestamp
• Expiration

Prepare states:

• Active
• Resolved
• Expired

────────────────────────────────────────

CLOSURE FOUNDATION

Create models/services for:

• Closure
• Road reference
• Geometry
• Scope
• Effective time
• Expiration
• Status

Prepare for:

• Full closure
• Partial closure
• Lane closure

────────────────────────────────────────

GEOFENCE FOUNDATION

Create:

• Geofence
• Geometry
• Event configuration
• Status
• Ownership

Support:

• Circle
• Polygon
• Spatial-cell region

Prepare events:

• Enter
• Exit
• Dwell

────────────────────────────────────────

SHARING FOUNDATION

Create abstractions for:

• Location share
• Trip share

Include:

• Owner
• Recipient/access model
• Expiration
• Revocation
• Share ID

Use short-lived authorization.

────────────────────────────────────────

SAVED PLACES FOUNDATION

Prepare models for:

• Saved place
• Collection
• Collection item

Enforce ownership.

────────────────────────────────────────

OBSERVABILITY

Implement:

• Structured logging
• OpenTelemetry
• Metrics
• Distributed tracing
• Request IDs
• Correlation IDs

Track:

• Geocoding latency
• Reverse geocoding latency
• Autocomplete latency
• Search latency
• Route latency
• ETA latency
• Location event throughput
• WebSocket connections
• Traffic update rate
• Queue depth
• Kafka lag
• Map-data build duration

Never expose sensitive location data in telemetry.

────────────────────────────────────────

HEALTH CHECKS

Implement:

• Liveness
• Readiness
• Startup

Health modules for:

• PostgreSQL
• PostGIS
• Redis
• Kafka
• BullMQ
• Search
• S3

Liveness must not fail solely because an external optional provider is down.

────────────────────────────────────────

GRACEFUL SHUTDOWN

Gracefully stop:

• HTTP
• WebSockets
• Prisma
• Redis
• Kafka producers
• Kafka consumers
• BullMQ workers

Stop new work before closing dependencies.

────────────────────────────────────────

SECURITY FOUNDATION

Implement:

• Authentication guards
• Authorization guards
• RBAC foundations
• Resource-ownership checks
• Rate-limit foundation
• Secure headers
• CORS
• Input validation
• Audit hooks

Prepare security boundaries for:

• Location
• Places
• Business data
• Route data
• Shares
• Admin functions

────────────────────────────────────────

PRIVACY FOUNDATION

Create policy boundaries for:

• Current location
• Historical location
• Search history
• Saved places
• Location sharing
• Trip sharing
• Geofences

Support:

• Retention references
• Delete interfaces
• Access controls
• Consent references
• Audit references

────────────────────────────────────────

API FOUNDATION

Create consistent REST conventions for:

• Pagination
• Cursor pagination
• Errors
• Authentication
• Authorization
• Idempotency
• Resource versions
• OpenAPI

Prepare endpoint groups:

• Auth
• Location
• Places
• Search
• Geocoding
• Routing
• Traffic
• Navigation
• Sharing

────────────────────────────────────────

TESTING FOUNDATION

Implement:

• Jest
• Unit helpers
• Integration helpers
• API test helpers
• Database fixtures
• Redis fixtures
• Kafka fixtures
• BullMQ fixtures
• WebSocket test utilities
• Spatial test utilities

Create deterministic factories for:

• Coordinates
• Places
• Addresses
• Roads
• Routes
• Traffic
• Incidents
• Geofences
• Users
• Devices

────────────────────────────────────────

LOCAL DEVELOPMENT

Prepare Docker-based local development for:

• PostgreSQL
• PostGIS
• Redis
• Kafka/Redpanda
• OpenSearch
• S3-compatible object storage

Do not use production secrets.

────────────────────────────────────────

DOCUMENTATION

Generate:

• Backend architecture
• Monorepo structure
• Configuration
• Request context
• Logging
• Error model
• Validation
• PostgreSQL
• PostGIS
• Prisma
• Redis
• Kafka
• Transactional Outbox
• BullMQ
• WebSockets
• Location architecture
• Geospatial abstraction
• Place foundation
• Address foundation
• Geocoding abstraction
• Search abstraction
• Routing abstraction
• ETA abstraction
• Map-data foundation
• Tile foundation
• Road-network foundation
• Traffic foundation
• Incident foundation
• Closure foundation
• Geofence foundation
• Sharing foundation
• Saved-place foundation
• Security
• Privacy
• Observability
• Testing
• Local development

────────────────────────────────────────

PROJECT INDEX

Update the backend Project Index with:

• Applications
• Services
• Workers
• Shared packages
• Configuration
• Identity
• Accounts
• Profiles
• Devices
• Location
• Location history
• Places
• Businesses
• Addresses
• Categories
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Map data
• Map styles
• Tiles
• Roads
• Road graph
• Routing
• ETA
• Distance matrix
• Traffic
• Incidents
• Closures
• Navigation foundation
• Geofencing
• Location sharing
• Trip sharing
• Saved places
• Collections
• PostgreSQL/PostGIS
• Redis
• Kafka
• BullMQ
• WebSockets
• S3
• APIs
• Events
• Queues
• Redis keys
• Spatial indexes
• Observability
• Security
• Privacy
• Tests
• Generated files
• Modified files
• Remaining work
• Current milestone
• Dependencies

────────────────────────────────────────

IMPLEMENTATION MILESTONES

BACKEND MILESTONE 1

Monorepo backend structure, NestJS bootstrap, configuration, request context, logging, error handling, validation, security foundation, API foundation, health checks, and graceful shutdown.

BACKEND MILESTONE 2

PostgreSQL, PostGIS, Prisma, spatial indexes, migrations, transaction utilities, database conventions, and test database infrastructure.

BACKEND MILESTONE 3

Redis infrastructure, geospatial cache primitives, namespaced keys, TTLs, idempotency, rate limiting, and ephemeral-state abstractions.

BACKEND MILESTONE 4

Kafka/Redpanda, event envelopes, producers, consumers, schemas, retries, dead-letter handling, and transactional outbox.

BACKEND MILESTONE 5

BullMQ, queue infrastructure, job schemas, retries, backoff, timeouts, dead-letter handling, and worker observability.

BACKEND MILESTONE 6

WebSockets and Socket.IO, authentication, authorization, rooms, Redis coordination, heartbeats, reconnects, backpressure, and location/trip sharing channels.

BACKEND MILESTONE 7

Location sessions, current location, location validation, location events, privacy boundaries, history abstractions, geospatial utilities, and spatial-cell abstractions.

BACKEND MILESTONE 8

Places, businesses, addresses, categories, hours, place identity, geocoding abstraction, reverse geocoding abstraction, and autocomplete foundation.

BACKEND MILESTONE 9

Search abstraction, map-data abstraction, map styles, tiles, road network abstractions, routing abstraction, ETA abstraction, traffic abstraction, incidents, closures, geofences, saved places, and sharing foundations.

BACKEND MILESTONE 10

Testing infrastructure, integration coverage, security tests, spatial tests, provider-failure tests, concurrency tests, observability hardening, local development, documentation, and Project Index completion.

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

This volume covers backend foundations for:

• Application bootstrap
• Configuration
• Request context
• Logging
• Errors
• Validation
• Security
• PostgreSQL
• PostGIS
• Prisma
• Redis
• Kafka/Redpanda
• Transactional Outbox
• BullMQ
• WebSockets
• Socket.IO
• S3 foundation
• Location foundation
• Geospatial utilities
• Spatial-cell abstraction
• Place foundation
• Business foundation
• Address foundation
• Geocoding abstraction
• Reverse geocoding abstraction
• Autocomplete foundation
• Search abstraction
• Map-data foundation
• Map-style foundation
• Tile foundation
• Road-network foundation
• Routing abstraction
• ETA abstraction
• Traffic foundation
• Incident foundation
• Closure foundation
• Geofence foundation
• Sharing foundation
• Saved-place foundation
• Testing foundation
• Observability
• Privacy foundation
• Local development

Do not implement complete:

• Place search business logic
• Full map-data ingestion
• Full vector-tile generation
• Full road-graph generation
• Full routing algorithms
• Traffic aggregation engine
• Navigation state machine
• Turn-by-turn engine
• Offline-map generation
• Reviews
• Ratings
• Contributions
• Moderation platform
• Fraud platform
• Notifications business logic
• Analytics platform
• Administration
• Privacy export/deletion workflows
• Infrastructure
• Frontend
• Mobile

Those belong to later implementation volumes.

────────────────────────────────────────

QUALITY BAR

Treat geospatial primitives, location security, spatial persistence, routing abstractions, and provider integrations as critical backend infrastructure.

Assume:

• Hundreds of millions of users
• Billions of map requests
• Massive location traffic
• Millions of navigation sessions
• Large place databases
• Large road graphs
• Large routing traffic
• Multiple providers
• Multiple regions
• Strict location privacy
• High availability

Prioritize:

• Geospatial correctness
• Coordinate integrity
• Location privacy
• Low latency
• Provider abstraction
• Idempotency
• Spatial indexing
• Regional scalability
• Observability
• Fault isolation
• Testability
• Maintainability
• Production readiness
