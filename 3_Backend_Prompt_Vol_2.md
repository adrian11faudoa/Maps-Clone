You are operating in Senior Engineering Team Mode.

Build the production-ready backend for places, businesses, geocoding, reverse geocoding, autocomplete, search, map data, map styles, vector tiles, raster tiles, road networks, road restrictions, speed limits, and map-data versioning for an enterprise-scale global mapping platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

The backend must follow the approved mapping architecture, domain boundaries, PostgreSQL/PostGIS strategy, spatial-indexing strategy, Redis architecture, Kafka/Redpanda architecture, BullMQ architecture, search abstraction, map-data architecture, security model, privacy model, event model, and Project Index.

Do not redesign the approved architecture.

Do not generate frontend code.

Do not generate mobile code.

Do not generate infrastructure implementation code.

Do not generate Terraform.

Do not generate Kubernetes manifests.

Do not generate CI/CD workflows.

────────────────────────────────────────

MISSION

Implement the production-ready backend domains for:

• Places
• Place identity
• Place lifecycle
• Businesses
• Business claims
• POIs
• Addresses
• Administrative areas
• Categories
• Place attributes
• Opening hours
• Holiday hours
• Place photos
• Place status
• Place source references
• Place deduplication
• Place merging
• Place splitting
• Geocoding
• Reverse geocoding
• Autocomplete
• Place search
• Business search
• Address search
• Category search
• Search indexing
• Search deletion
• Search freshness
• Map datasets
• Map dataset versions
• Map styles
• Vector tile metadata
• Raster tile metadata
• Road networks
• Road nodes
• Road segments
• Road restrictions
• Speed limits
• Toll metadata
• Turn restrictions
• Map-data ingestion orchestration
• Dataset validation
• Dataset publication
• Dataset rollback

The implementation must support:

• Billions of geographic objects
• Hundreds of millions of users
• Large business/POI catalogs
• Very high search traffic
• Very high autocomplete traffic
• Very high geocoding traffic
• Very high map-tile traffic
• Large road networks
• Multiple regions
• Multiple map-data sources
• Versioned datasets
• High availability
• Strong data ownership
• Eventual consistency for search and derived indexes

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

• Elasticsearch or OpenSearch

Object storage:

• AWS S3

CDN:

• CloudFront

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
• Spatial testing utilities

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

Use idempotency for retriable mutations and jobs.

Use optimistic concurrency where appropriate.

Never trust client-supplied place ownership.

Never expose internal provider credentials.

Never expose internal object paths unnecessarily.

────────────────────────────────────────

DOMAIN OWNERSHIP

Maintain explicit boundaries between:

• Places
• Businesses
• Addresses
• Categories
• Hours
• Photos
• Map data
• Road data
• Search
• Geocoding
• Autocomplete
• Map styles
• Tiles

Do not combine:

• Search index with place source of truth
• Provider data with canonical platform data
• Road graph with ordinary place CRUD
• Tile artifacts with canonical map records
• Business claims with automatic business ownership
• Place photos with arbitrary object storage

────────────────────────────────────────

PLACE DOMAIN

Implement canonical Place records.

Support:

• Public place ID
• Internal database ID
• Name
• Coordinates
• Address
• Category
• Status
• Region
• Source
• Provider references
• Confidence
• Created time
• Updated time
• Version

────────────────────────────────────────

PLACE STATES

Support:

• Draft
• Pending Validation
• Active
• Temporarily Closed
• Permanently Closed
• Merged
• Split
• Deprecated
• Removed

Define every valid state transition.

Every transition must be:

• Authorized
• Version-aware
• Auditable
• Idempotent where appropriate

────────────────────────────────────────

PLACE IDENTITY

Implement stable public place identifiers.

Support:

• Provider source references
• Duplicate detection
• Merge references
• Split references
• Historical identifiers

When two places merge:

• Preserve historical references
• Redirect old identifiers where policy allows
• Update search references
• Update user saves/reviews through established events
• Maintain audit history

────────────────────────────────────────

PLACE DEDUPLICATION

Implement a provider-neutral duplicate detection service.

Signals may include:

• Coordinates
• Distance
• Name similarity
• Address similarity
• Phone
• Website
• Business identifiers
• Provider references
• Category

Do not make an irreversible merge from a single low-confidence signal.

────────────────────────────────────────

PLACE MERGING

Support:

• Candidate merge
• Validation
• Approval
• Merge
• Redirect
• Search reindex
• Related-reference reconciliation

Merge must be transactional for authoritative records.

────────────────────────────────────────

PLACE SPLITTING

Support:

• Split request
• Validation
• Child-place creation
• Reference migration
• Search reindex
• Audit

Do not silently duplicate business ownership or reviews.

────────────────────────────────────────

BUSINESS DOMAIN

Implement:

• Business profile
• Business identity
• Business owner reference
• Business administrators
• Business status
• Categories
• Address
• Hours
• Phone
• Website
• Attributes
• Photos

────────────────────────────────────────

BUSINESS CLAIMS

Implement:

• Claim creation
• Claim verification
• Claim approval
• Claim rejection
• Ownership update
• Claim withdrawal
• Reverification

Claim states:

• Submitted
• Pending
• Verification Required
• Approved
• Rejected
• Revoked

An unverified user must not directly overwrite authoritative business ownership.

────────────────────────────────────────

BUSINESS PERMISSIONS

Support:

• Owner
• Manager
• Editor
• Analyst

Scope permissions to the business.

Do not permit cross-business access.

────────────────────────────────────────

PLACE CATEGORIES

Implement canonical categories.

Support:

• Category ID
• Parent
• Display name
• Localized name
• Status
• Hierarchy
• Search aliases

Do not hard-code category names throughout application code.

────────────────────────────────────────

PLACE ATTRIBUTES

Support typed attributes such as:

• Accessibility
• Parking
• Outdoor seating
• Reservations
• Payment methods
• Services

Attributes must be schema-validated.

────────────────────────────────────────

PLACE HOURS

Implement:

• Regular hours
• Multiple periods
• Overnight periods
• Holiday hours
• Special hours
• Temporary closure

Associate every place with its local time zone.

Never assume the server's time zone is the place's time zone.

────────────────────────────────────────

HOURS VALIDATION

Validate:

• Day
• Start time
• End time
• Overnight semantics
• Holiday date
• Time zone

Prevent impossible or contradictory schedules.

────────────────────────────────────────

PLACE PHOTOS

Implement metadata for:

• Photo ID
• Place ID
• Object reference
• Source
• Width
• Height
• Status
• Moderation state
• Created time

Actual image bytes belong in S3/object storage.

────────────────────────────────────────

PHOTO UPLOAD AUTHORIZATION

Support:

• Signed upload authorization
• File-size limits
• MIME validation
• Object-key isolation
• Malware scanning boundary
• Moderation

Never trust client-provided file metadata without validation.

────────────────────────────────────────

ADDRESS DOMAIN

Implement normalized address records.

Support:

• Street
• House number
• Unit
• Neighborhood
• City
• Region
• Postal code
• Country
• Country code
• Administrative area
• Coordinates
• Display address
• Normalized address
• Language

────────────────────────────────────────

ADDRESS NORMALIZATION

Normalize:

• Case
• Unicode
• Abbreviations
• Street types
• Country-specific formats
• Postal codes

Preserve original display information where needed.

────────────────────────────────────────

ADMINISTRATIVE AREAS

Support hierarchical geography:

• Country
• State/province
• County/district
• City
• Municipality
• Neighborhood
• Other provider-defined administrative areas

Use PostGIS geometry/polygon data.

────────────────────────────────────────

GEOCODING

Implement the provider-neutral geocoding service.

Input:

• Address
• Region
• Language
• Coordinates bias
• Optional components

Output:

• Coordinates
• Address
• Place
• Confidence
• Match type
• Region

Match types:

• Exact
• Interpolated
• Partial
• Approximate
• Ambiguous

────────────────────────────────────────

GEOCODING PROVIDERS

Create provider adapters.

Provider errors must normalize to:

• NoResult
• InvalidRequest
• RateLimited
• Timeout
• Unavailable
• InvalidResponse

Do not leak provider-specific response models through domain contracts.

────────────────────────────────────────

GEOCODING FALLBACK

Support configured provider fallback.

Use:

• Primary provider
• Secondary provider
• Internal dataset

Fallback must preserve:

• Request ID
• Correlation ID
• Trace
• Result confidence

Do not return an unmarked low-confidence result as if it were exact.

────────────────────────────────────────

GEOCODING CACHE

Use Redis for safe geocoding cache.

Key should incorporate normalized:

• Address
• Language
• Region
• Coordinates bias bucket where appropriate
• Provider/configuration version

Define TTL.

Never use cached results when policy requires current data.

────────────────────────────────────────

REVERSE GEOCODING

Implement:

Coordinate
→ Spatial lookup
→ Address/Place
→ Result ranking

Support:

• Place
• Road
• Administrative area
• Country
• Address

────────────────────────────────────────

REVERSE GEOCODING PRECISION

Consider:

• Coordinate accuracy
• Road proximity
• Place radius
• Administrative boundary
• Spatial ambiguity

Do not return false precision.

────────────────────────────────────────

AUTOCOMPLETE

Implement:

• Prefix search
• Geographic bias
• Language
• Region
• Category
• Session context

Results may include:

• Place
• Business
• Address
• Road

────────────────────────────────────────

AUTOCOMPLETE LATENCY

Optimize for very low latency.

Use:

• Redis cache
• Search engine
• Prefix structures
• Query normalization
• Regional indexes

Cancel or ignore stale queries at the service/client layer.

────────────────────────────────────────

PLACE SEARCH

Support:

• Text search
• Nearby search
• Radius
• Bounding box
• Category
• Open now
• Rating filters where supported
• Region
• Language

Search results must pass:

• Place status
• Moderation
• Visibility
• Region

────────────────────────────────────────

SEARCH RANKING

Rank using:

• Text relevance
• Geographic proximity
• Popularity
• Business quality
• Freshness
• User context where permitted
• Region
• Category

Do not expose internal ranking scores.

────────────────────────────────────────

SEARCH QUERY SAFETY

Normalize and validate arbitrary user input.

Protect against:

• Query injection
• Provider-specific syntax injection
• Search abuse
• Excessive wildcard use
• Regex abuse
• Large query payloads

────────────────────────────────────────

SEARCH INDEXING

Architecture:

Canonical Place Data
→ Domain Event
→ Search Queue
→ Search Document
→ Search Index

Support:

• Create
• Update
• Delete
• Bulk index
• Reindex
• Alias switching

────────────────────────────────────────

SEARCH DOCUMENT

Define document fields for:

• Place ID
• Name
• Alternate names
• Address
• Category
• Coordinates
• Administrative hierarchy
• Business status
• Hours summary
• Rating aggregate
• Popularity
• Region
• Language

Do not store unnecessary sensitive user information.

────────────────────────────────────────

SEARCH DELETION

When a place becomes removed/private/ineligible:

• Update authoritative state
• Publish event
• Queue deletion
• Remove/disable search document
• Reconcile residual results

Search may be eventually consistent but must respect safety/privacy deletion requirements.

────────────────────────────────────────

SEARCH REINDEX

Implement administrative rebuild support:

• Create new index
• Bulk load canonical data
• Validate counts
• Validate sample queries
• Swap alias
• Monitor
• Roll back

Never destroy the previous index before the replacement is validated.

────────────────────────────────────────

MAP DATA DOMAIN

Implement:

• Dataset
• Dataset version
• Region
• Source
• Schema version
• Build status
• Quality status
• Effective timestamp

────────────────────────────────────────

MAP DATA STATES

Support:

• Draft
• Downloading
• Validating
• Transforming
• Building
• QA
• Published
• Superseded
• Rolled Back
• Failed

────────────────────────────────────────

MAP DATA SOURCE

Support provider-neutral source references:

• Source
• Provider
• Dataset
• Version
• Region
• Source checksum
• Download timestamp

Do not hard-code one data supplier into the domain.

────────────────────────────────────────

MAP DATA INGESTION

Implement orchestration for:

Source
→ Download
→ Verify
→ Parse
→ Normalize
→ Validate
→ Deduplicate
→ Enrich
→ Version
→ Publish

Long-running processing must execute asynchronously.

────────────────────────────────────────

MAP DATA VALIDATION

Validate:

• Schema
• Geometry validity
• Coordinate ranges
• Missing identifiers
• Broken references
• Duplicate objects
• Invalid road topology
• Invalid administrative polygons
• Invalid place associations

Failed datasets must never become active production versions.

────────────────────────────────────────

GEOMETRY VALIDATION

Use PostGIS-compatible validation.

Detect:

• Self-intersections
• Invalid polygons
• Empty geometries
• Geometry type mismatch
• Coordinate anomalies

Define controlled repair where safe.

Do not silently "repair" high-risk geometry without recording the transformation.

────────────────────────────────────────

MAP DATA VERSIONING

Every dataset version must have:

• Version ID
• Region
• Parent version
• Source
• Build version
• Schema version
• Created time
• Effective time
• Validation result
• QA result
• Publication state

────────────────────────────────────────

MAP DATA PUBLICATION

Implement controlled publication:

Validate
→ QA
→ Publish
→ Regional activation
→ Monitor

Support:

• Canary region
• Regional rollout
• Rollback

────────────────────────────────────────

MAP DATA ROLLBACK

Support activation of a previous validated version.

Rollback must:

• Update active version
• Publish event
• Invalidate/version derived caches
• Trigger search/tile/graph reconciliation

────────────────────────────────────────

MAP STYLES

Implement:

• Style
• Style version
• Platform
• Theme
• Dataset compatibility
• Status

Support:

• Light
• Dark
• Navigation
• Accessibility
• Terrain foundation

────────────────────────────────────────

VECTOR TILES

Implement tile metadata/service boundaries.

Support:

• Z
• X
• Y
• Layer
• Dataset version
• Style version
• Content type
• Compression
• Cache metadata

Tile bytes should be generated/distributed outside ordinary API business endpoints where architecture permits.

────────────────────────────────────────

RASTER TILES

Support provider-neutral raster tile metadata.

Use for:

• Fallback clients
• Specialized map layers
• Legacy support

────────────────────────────────────────

TILE VERSIONING

Use immutable/versioned tile paths.

Changing map data should not require destructive mutation of already-cached immutable tiles.

────────────────────────────────────────

ROAD NETWORK

Implement canonical models for:

• Road
• Road node
• Road segment
• Geometry
• Direction
• Road class
• Surface
• Lane metadata
• Speed limit
• Access restriction
• Toll reference
• Turn restriction

────────────────────────────────────────

ROAD SEGMENTS

Each road segment should contain enough information to support future graph construction.

Separate:

• Road identity
• Geometry
• Static attributes
• Dynamic traffic weight

Do not put live traffic directly into canonical road records.

────────────────────────────────────────

SPEED LIMIT

Support:

• Default speed
• Direction-specific speed
• Conditional speed
• Effective dates
• Source
• Confidence

────────────────────────────────────────

ROAD RESTRICTIONS

Support:

• Vehicle restrictions
• Direction restrictions
• Weight/height restrictions
• Time-based restrictions
• Seasonal restrictions
• Turn restrictions

Prepare for travel-mode-specific evaluation.

────────────────────────────────────────

TOLL METADATA

Support:

• Toll road
• Toll segment
• Toll plaza/reference
• Region
• Time-dependent information where available

Do not expose exact toll pricing when only a general toll reference is available.

────────────────────────────────────────

ROAD GRAPH BUILD INTERFACE

Create abstractions for:

• Build graph
• Validate topology
• Validate connectivity
• Publish graph version
• Activate version
• Roll back

Actual routing algorithms belong to the routing implementation phase.

────────────────────────────────────────

REDIS

Use Redis for:

• Place cache
• Geocode cache
• Reverse-geocode cache
• Autocomplete cache
• Search suggestions
• Tile metadata cache
• Dataset version lookup
• Active routing graph version
• Place popularity cache
• Rate limiting

Every key must define:

• Namespace
• Scope
• Version
• TTL
• Invalidation

────────────────────────────────────────

KAFKA / REDPANDA EVENTS

Publish:

PLACES

• PlaceCreated
• PlaceUpdated
• PlaceStatusChanged
• PlaceMerged
• PlaceSplit
• PlaceClosed

BUSINESSES

• BusinessCreated
• BusinessClaimSubmitted
• BusinessClaimApproved
• BusinessClaimRejected
• BusinessUpdated

ADDRESSES

• AddressCreated
• AddressUpdated

SEARCH

• SearchPerformed
• AutocompletePerformed
• SearchIndexRequested
• SearchIndexDeleted

MAP DATA

• MapDatasetCreated
• MapDatasetValidated
• MapDatasetPublished
• MapDatasetRolledBack

MAP STYLES

• MapStylePublished

ROAD NETWORK

• RoadNetworkUpdated
• RoadGraphBuildRequested
• RoadGraphPublished

All events must:

• Be versioned
• Be idempotent
• Include region
• Include correlation metadata
• Minimize personal data

────────────────────────────────────────

BULLMQ

Implement queues for:

• Place validation
• Duplicate detection
• Place merging
• Search indexing
• Search deletion
• Full search reindex
• Geocoding batches
• Map-data ingestion
• Geometry validation
• Dataset build
• Dataset QA
• Road-graph build
• Tile generation where applicable
• Photo moderation
• Object cleanup

Every queue must implement:

• Job schema
• Producer
• Consumer
• Job ID
• Retry
• Backoff
• Timeout
• Concurrency
• Dead-letter handling
• Metrics

────────────────────────────────────────

DATABASE

Implement Prisma/PostGIS models and migrations for:

• Place
• PlaceAddress
• PlaceCategory
• PlaceAttribute
• PlaceHour
• PlaceHolidayHour
• PlacePhoto
• PlaceStatusHistory
• PlaceSourceReference
• PlaceMerge
• PlaceSplit
• BusinessProfile
• BusinessClaim
• BusinessMember
• Address
• AdministrativeArea
• Category
• MapDataset
• MapDatasetVersion
• MapDatasetSource
• MapStyle
• MapStyleVersion
• Road
• RoadNode
• RoadSegment
• RoadRestriction
• SpeedLimit
• TollReference
• TurnRestriction
• SearchConfiguration
• SearchIndexVersion

Use:

• Foreign keys
• Unique constraints
• Composite indexes
• Geometry indexes
• Version fields
• State fields
• Effective timestamps

────────────────────────────────────────

SPATIAL INDEXES

Create suitable PostGIS indexes for:

• Place geometry
• Road geometry
• Administrative polygon
• Geofence-compatible areas where relevant

Support:

• Bounding box
• Radius
• Nearest neighbor
• Polygon containment

────────────────────────────────────────

CURSOR PAGINATION

Implement cursor pagination for:

• Places
• Businesses
• Search
• Place photos
• Business members
• Place history

Cursors must be opaque.

────────────────────────────────────────

API

PLACES

• Create where authorized
• Get place
• Update place
• Get place status
• Get hours
• Get categories
• Get photos

BUSINESSES

• Get business
• Update business
• Submit claim
• Get claim status
• Manage members

ADDRESS

• Normalize address
• Get address

GEOCODING

• Geocode
• Reverse geocode

AUTOCOMPLETE

• Suggest places
• Suggest businesses
• Suggest addresses
• Suggest roads

SEARCH

• Search places
• Search businesses
• Search addresses
• Search categories

MAP DATA

• Get active dataset version
• Get dataset metadata
• Get style metadata
• Get tile metadata where appropriate

ROAD NETWORK

• Get road metadata
• Get road segment metadata where authorized

All endpoints must support:

• Authentication where required
• Authorization
• Validation
• Rate limiting
• Cursor pagination
• Consistent errors
• OpenAPI

────────────────────────────────────────

SEARCH API RESPONSE

Return:

• Public place ID
• Name
• Address
• Coordinates
• Category
• Business status
• Hours summary where applicable
• Rating aggregate where available

Do not return internal:

• Provider secrets
• Ranking scores
• Fraud signals
• Moderation internals
• Internal database identifiers unnecessarily

────────────────────────────────────────

SECURITY

Protect against:

• Place scraping
• Map-data scraping
• Search scraping
• Business impersonation
• Unauthorized edits
• Claim abuse
• Object enumeration
• Provider abuse
• Query injection
• Tile-origin bypass

Use:

• Rate limits
• Authentication
• Authorization
• Resource ownership
• Signed access
• Audit

────────────────────────────────────────

PRIVACY

Protect:

• User-submitted location
• Business-owner data
• Search history
• Private saved places references
• Personal addresses
• Sensitive administrative data

Never expose user search history through ordinary search APIs.

────────────────────────────────────────

OBSERVABILITY

Instrument:

• Place APIs
• Business APIs
• Search
• Autocomplete
• Geocoding
• Reverse geocoding
• Map-data ingestion
• Dataset validation
• Dataset publication
• Road-graph build
• Tile metadata

Track:

• Search latency
• Autocomplete latency
• Geocoding latency
• Reverse-geocoding latency
• Indexing latency
• Search freshness
• Dataset build duration
• Dataset failure rate
• Road-graph build duration
• Cache hit rate
• Queue depth
• Kafka lag

────────────────────────────────────────

TESTING

UNIT TESTS

Test:

• Place state transitions
• Business-claim state
• Address normalization
• Hours
• Category validation
• Geometry validation
• Dataset state
• Search normalization

SPATIAL TESTS

Test:

• Radius search
• Bounding box
• Nearest neighbor
• Polygon containment
• Geometry validity
• Coordinate boundaries

PLACE TESTS

Test:

• Create
• Update
• Merge
• Split
• Close
• Reopen
• Duplicate detection

BUSINESS TESTS

Test:

• Claim
• Approval
• Rejection
• Permissions
• Cross-business access

GEOCODING TESTS

Test:

• Exact
• Partial
• Ambiguous
• No result
• Timeout
• Provider failure
• Provider fallback

SEARCH TESTS

Test:

• Prefix
• Full text
• Typo
• Nearby
• Category
• Region
• Deleted place
• Closed place

MAP DATA TESTS

Test:

• Dataset ingestion
• Validation
• Invalid geometry
• Duplicate data
• Versioning
• Publication
• Rollback

SECURITY TESTS

Test:

• Business IDOR
• Place-update authorization
• Claim abuse
• Search scraping
• Query injection
• Object-key manipulation

CONCURRENCY TESTS

Test:

• Concurrent place updates
• Concurrent claims
• Merge/update race
• Dataset publication race
• Search update/delete race

PERFORMANCE TESTS

Test:

• Autocomplete
• Nearby search
• Place lookup
• Search
• Geocoding
• Bulk indexing
• Dataset processing

────────────────────────────────────────

DOCUMENTATION

Generate:

• Place architecture
• Place lifecycle
• Place identity
• Deduplication
• Merge/split
• Business architecture
• Business claims
• Business permissions
• Categories
• Attributes
• Hours
• Photos
• Address normalization
• Administrative areas
• Geocoding
• Reverse geocoding
• Provider abstraction
• Autocomplete
• Search
• Search ranking
• Search indexing
• Search deletion
• Search reindexing
• Map-data architecture
• Dataset versioning
• Dataset validation
• Dataset publication
• Dataset rollback
• Map styles
• Vector tiles
• Raster tiles
• Tile versioning
• Road network
• Speed limits
• Restrictions
• Toll metadata
• Road graph interface
• Redis key catalog
• Kafka event catalog
• BullMQ queue catalog
• Database schema
• Security
• Privacy
• Observability
• Testing

────────────────────────────────────────

PROJECT INDEX

Update the backend Project Index with:

• Places
• Place identities
• Place states
• Place merges
• Place splits
• Businesses
• Business claims
• Business members
• Categories
• Attributes
• Hours
• Holiday hours
• Photos
• Addresses
• Administrative areas
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Search documents
• Search index versions
• Map datasets
• Dataset versions
• Dataset sources
• Map styles
• Map style versions
• Vector tiles
• Raster tiles
• Roads
• Road nodes
• Road segments
• Restrictions
• Speed limits
• Toll references
• Turn restrictions
• Kafka events
• BullMQ queues
• Redis keys
• Database models
• APIs
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

BACKEND MILESTONE 11

Places, place identity, lifecycle, statuses, addresses, categories, attributes, hours, photos, and foundational APIs.

BACKEND MILESTONE 12

Businesses, business claims, ownership, members, permissions, verification, and business administration.

BACKEND MILESTONE 13

Place deduplication, merge/split workflows, source references, reconciliation, auditing, and concurrency protection.

BACKEND MILESTONE 14

Geocoding, reverse geocoding, provider abstractions, fallback, caching, normalization, confidence, and batch processing.

BACKEND MILESTONE 15

Autocomplete, place search, business search, address search, category search, query normalization, ranking, and API pagination.

BACKEND MILESTONE 16

Search indexing, deletion, aliases, reindexing, index validation, freshness monitoring, and search reconciliation.

BACKEND MILESTONE 17

Map datasets, sources, ingestion, normalization, geometry validation, versioning, QA, publication, regional rollout, and rollback.

BACKEND MILESTONE 18

Map styles, tile metadata, vector/raster abstractions, CDN integration boundaries, versioning, and cache management.

BACKEND MILESTONE 19

Road network, road segments, speed limits, restrictions, toll metadata, turn restrictions, graph-build interfaces, events, and jobs.

BACKEND MILESTONE 20

Full integration, spatial testing, search testing, business/claim testing, concurrency, security, performance, observability, documentation, and Project Index completion.

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

• Places
• Businesses
• POIs
• Addresses
• Administrative areas
• Categories
• Attributes
• Hours
• Photos
• Place lifecycle
• Place deduplication
• Place merge/split
• Business claims
• Geocoding
• Reverse geocoding
• Autocomplete
• Place search
• Business search
• Address search
• Search indexing
• Search deletion
• Search reindexing
• Map datasets
• Dataset ingestion
• Dataset validation
• Dataset versioning
• Dataset publication
• Dataset rollback
• Map styles
• Tile metadata
• Vector/raster abstractions
• Roads
• Road segments
• Speed limits
• Restrictions
• Toll metadata
• Turn restrictions
• Road graph interfaces
• Related events
• Related queues
• Related workers

Do not implement complete:

• Routing algorithms
• Distance matrix engine
• Dynamic ETA engine
• Traffic aggregation engine
• Navigation state machine
• Turn-by-turn engine
• Offline map generation
• Reviews/rating business logic
• Location-sharing workflows
• Trip-sharing workflows
• Full geofencing
• Full contribution moderation
• Administration UI
• Frontend
• Mobile
• Infrastructure

Use the approved architecture and previous backend foundation.

────────────────────────────────────────

QUALITY BAR

Treat places, search, map data, and road-network data as foundational infrastructure.

Assume:

• Billions of geographic records
• Hundreds of millions of users
• Massive search traffic
• Massive autocomplete traffic
• Massive geocoding traffic
• Large map datasets
• Large road graphs
• Multiple providers
• Multiple regions
• Continuous map-data updates

Prioritize:

• Geospatial correctness
• Canonical data ownership
• Search relevance
• Low latency
• Dataset integrity
• Versioning
• Rollback
• Provider abstraction
• Idempotency
• Spatial indexing
• Privacy
• Security
• Observability
• Scalability
• Maintainability
• Production readiness
