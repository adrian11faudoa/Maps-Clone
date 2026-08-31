You are operating in Senior Engineering Team Mode.

Build the complete production-grade QA, testing, security validation, privacy validation, geospatial validation, routing validation, navigation validation, performance validation, resilience validation, accessibility validation, infrastructure validation, and production-readiness system for an enterprise-scale global mapping, search, routing, navigation, traffic, location, places, and offline-map platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

Use the approved backend, frontend, mobile, geospatial-data, routing, traffic, navigation, infrastructure, security, privacy, analytics, moderation, and Project Index architecture as the single source of truth.

Do not redesign the architecture.

Do not implement unrelated product features.

────────────────────────────────────────

MISSION

Build a complete quality-engineering system covering:

• Unit testing
• Integration testing
• API testing
• Contract testing
• WebSocket testing
• Event testing
• Queue testing
• Database testing
• PostGIS testing
• Redis testing
• OpenSearch testing
• S3 testing
• Map-data testing
• Geometry validation
• Spatial-query testing
• Place testing
• Business testing
• Address testing
• Geocoding testing
• Reverse-geocoding testing
• Autocomplete testing
• Search testing
• Map tile testing
• Map style testing
• Road-network testing
• Routing testing
• Route-quality testing
• Distance-matrix testing
• ETA testing
• Traffic testing
• Incident testing
• Closure testing
• Navigation testing
• Turn-by-turn testing
• Off-route testing
• Rerouting testing
• Location testing
• Map-matching testing
• Location-sharing testing
• Trip-sharing testing
• Geofencing testing
• Offline-map testing
• Offline-search testing
• Offline-routing testing
• Review testing
• Rating testing
• Photo testing
• Contribution testing
• Moderation testing
• Fraud/abuse testing
• Notification testing
• Analytics testing
• Administration testing
• Feature-flag testing
• Configuration testing
• Audit testing
• Privacy testing
• Web frontend testing
• Mobile testing
• Accessibility testing
• Security testing
• Performance testing
• Load testing
• Stress testing
• Soak testing
• Resilience testing
• Chaos testing
• Disaster-recovery testing
• Backup restoration testing
• Infrastructure testing
• CI/CD validation
• Production smoke testing
• Regression testing
• Release certification

The final QA system must provide objective evidence for:

• Geospatial correctness
• Search correctness
• Routing correctness
• ETA quality
• Navigation stability
• Location integrity
• Map-data integrity
• Offline-map integrity
• Security
• Privacy
• Availability
• Reliability
• Scalability
• Performance
• Accessibility
• Recoverability
• Maintainability
• Production readiness

────────────────────────────────────────

TECHNOLOGY STACK

BACKEND

• Node.js
• NestJS
• TypeScript
• PostgreSQL
• PostGIS
• Prisma
• Redis
• Kafka/Redpanda
• BullMQ
• OpenSearch/Elasticsearch
• AWS S3
• WebSockets
• Socket.IO

WEB

• Next.js
• React
• TypeScript
• Tailwind CSS
• TanStack Query
• Zustand

MOBILE

• React Native
• Expo
• TypeScript
• React Navigation

MAP

• Vector tiles
• Raster fallback
• Map provider abstraction

ROUTING

• Routing provider abstraction
• Routing graph
• Time-dependent routing
• Traffic-aware routing

INFRASTRUCTURE

• AWS
• Terraform
• Docker
• Kubernetes
• Helm
• GitHub Actions

OBSERVABILITY

• OpenTelemetry
• Prometheus
• Grafana
• Loki
• Tempo

TESTING

• Jest
• Supertest
• React Testing Library
• Playwright
• React Native Testing Library
• Detox or approved E2E framework
• Spatial test utilities
• Load-testing framework
• Accessibility tools
• Security scanners

────────────────────────────────────────

TESTING PRINCIPLES

Use layered testing.

Do not rely on E2E tests alone.

Use:

• Unit tests
• Integration tests
• Contract tests
• API tests
• Spatial tests
• Geospatial integration tests
• WebSocket tests
• Event tests
• Queue tests
• E2E tests
• Security tests
• Performance tests
• Resilience tests
• Recovery tests

Avoid:

• Arbitrary sleeps
• Test-order dependence
• Shared mutable state
• Production credentials
• Production personal data
• Real user locations
• Real private-location history

Use deterministic synthetic geographic data.

────────────────────────────────────────

TEST ENVIRONMENTS

Provide isolated environments for:

• Unit
• Integration
• Geospatial
• E2E
• Performance
• Security
• Resilience
• Disaster recovery

Use synthetic datasets.

Do not directly reuse production location data.

────────────────────────────────────────

TEST DATA FACTORIES

Create deterministic factories for:

IDENTITY

• User
• Account
• Profile
• Device
• Session

LOCATION

• Coordinate
• Location event
• Location session
• Navigation session
• Location share
• Trip share
• Geofence

PLACES

• Place
• Business
• Address
• Administrative area
• Category
• Hours
• Photo

MAP

• Road
• Road node
• Road segment
• Restriction
• Speed limit
• Closure
• Map dataset
• Map version
• Routing graph

ROUTING

• Route request
• Route
• Alternative route
• Route step
• ETA
• Traffic snapshot
• Incident

CONTENT

• Review
• Rating
• Contribution
• Moderation case

OFFLINE

• Offline region
• Package
• Manifest

ANALYTICS

• Search event
• Route event
• Navigation event
• Traffic event
• Location event

Support:

• Small
• Medium
• Large
• Global-scale synthetic datasets

────────────────────────────────────────

GEOSPATIAL TESTING

Validate:

• Latitude bounds
• Longitude bounds
• Coordinate precision
• Geometry types
• Geometry validity
• Projection conversion
• Distance calculations
• Bounding boxes
• Radius queries
• Nearest-neighbor
• Polygon containment
• Spatial intersections
• Spatial indexing

Boundary cases:

• North pole
• South pole
• International date line
• Equator
• Null island
• Very small distances
• Very large distances
• Invalid coordinates

────────────────────────────────────────

SPATIAL PRECISION

Test:

• Floating-point tolerance
• Coordinate rounding
• Distance precision
• Geometry simplification
• Map-matching tolerance

Define acceptable error bounds.

Do not require unrealistic centimeter-level accuracy from consumer GPS.

────────────────────────────────────────

POSTGIS TESTING

Test:

• GiST indexes
• SP-GiST where used
• Spatial queries
• Nearest-neighbor
• Polygon containment
• Bounding-box
• Geometry validity
• Spatial joins

Performance-test:

• Millions of places
• Millions of road segments
• Large polygons
• Dense urban areas

────────────────────────────────────────

PLACE TESTING

Test:

• Create
• Update
• Close
• Reopen
• Merge
• Split
• Duplicate detection
• Status changes
• Hours
• Special hours
• Photos

Validate:

• Stable identifiers
• Search propagation
• Saved-place references
• Review references

────────────────────────────────────────

BUSINESS TESTING

Test:

• Claim
• Verification
• Rejection
• Ownership
• Members
• Roles
• Permissions
• Profile updates
• Hours
• Attributes
• Photos

Security:

• Business IDOR
• Cross-business access
• Ownership takeover
• Role escalation

────────────────────────────────────────

ADDRESS TESTING

Test:

• Normalization
• International formats
• Postal codes
• Administrative hierarchy
• Unicode
• Abbreviations
• Missing components

────────────────────────────────────────

GEOCODING TESTING

Test:

• Exact match
• Partial match
• Ambiguous input
• Interpolated address
• No result
• Provider timeout
• Provider outage
• Provider rate limit
• Invalid provider response
• Provider fallback

Validate:

• Coordinates
• Confidence
• Match type
• Address normalization

────────────────────────────────────────

REVERSE GEOCODING

Test:

• Urban
• Rural
• Coastline
• Boundary
• Dense POI area
• Highway
• Empty area
• Low-accuracy coordinate

Verify reasonable nearest address/place.

────────────────────────────────────────

AUTOCOMPLETE TESTING

Test:

• Prefix
• Partial query
• Typo
• Language
• Region
• Geographic bias
• Category
• Rapid query changes

Validate:

• Debounce behavior
• Cancellation
• Stale response rejection
• Latency budget

────────────────────────────────────────

SEARCH TESTING

Test:

• Places
• Businesses
• Addresses
• Roads
• Categories

Search modes:

• Full text
• Prefix
• Nearby
• Radius
• Bounding box
• Filters
• Region
• Language

Security:

• Query injection
• Wildcard abuse
• Search scraping
• Enumeration

────────────────────────────────────────

SEARCH INDEX TESTING

Test:

• Create indexing
• Update indexing
• Delete indexing
• Reindex
• Alias switch
• Failed indexing
• Retry
• Stale document
• Deleted place

Verify search remains rebuildable from canonical data.

────────────────────────────────────────

MAP DATA TESTING

Test:

• Dataset download
• Checksum
• Parsing
• Normalization
• Geometry validation
• Duplicate detection
• Referential integrity
• Versioning
• Publication
• Rollback

A corrupted dataset must never become active.

────────────────────────────────────────

ROAD-NETWORK TESTING

Validate:

• Node connectivity
• Edge direction
• Segment geometry
• Road class
• Speed limits
• Restrictions
• Turn restrictions
• Toll references
• Road continuity

Detect:

• Disconnected graph
• Impossible geometry
• Duplicate segments
• Broken references

────────────────────────────────────────

ROUTING TESTING

Test all supported modes:

• Driving
• Walking
• Cycling
• Transit foundation

Test:

• Origin
• Destination
• Waypoints
• Alternatives
• Preferences
• Restrictions
• Tolls
• Closures
• Incidents
• Traffic
• Departure time

────────────────────────────────────────

ROUTE CORRECTNESS

Validate:

• Origin alignment
• Destination alignment
• Geometry continuity
• Distance
• Duration
• Maneuvers
• Restrictions
• Closure avoidance

Define tolerance ranges for:

• Distance
• Duration
• ETA

Do not require bit-for-bit equality across different routing engines.

────────────────────────────────────────

ROUTE REGRESSION

Maintain golden geographic scenarios:

• Urban core
• Suburban
• Rural
• Mountain
• Coastal
• Border crossing
• Highway
• Complex intersection
• Roundabout
• Multi-waypoint
• Toll route

For every routing engine change compare:

• Distance
• Duration
• Route shape
• Maneuvers
• Restriction compliance

────────────────────────────────────────

DISTANCE MATRIX

Test:

• Small matrix
• Medium matrix
• Maximum allowed matrix
• Invalid origin
• Invalid destination
• Partial failure
• Timeout
• Provider failure
• Cache hit

Verify quotas and protection against resource exhaustion.

────────────────────────────────────────

ETA TESTING

Test:

• Static route
• Historical traffic
• Live traffic
• Incidents
• Closures
• Stale traffic
• Location updates
• Reroutes

Track:

• ETA deviation
• Confidence
• Freshness

────────────────────────────────────────

TRAFFIC TESTING

Test:

• Segment speed
• Congestion
• Delay
• Historical aggregation
• Live updates
• Expiration
• Confidence

Scenarios:

• Traffic spike
• Traffic drop
• Sparse data
• Conflicting provider data
• Provider outage
• Delayed events

────────────────────────────────────────

TRAFFIC MAP-MATCHING

Test:

• Straight road
• Parallel roads
• Intersections
• Highway ramps
• GPS jitter
• Wrong heading
• Tunnel-like gaps
• Sparse samples

Validate:

• Correct segment
• Direction
• Confidence
• Continuity

────────────────────────────────────────

INCIDENT TESTING

Test:

• Accident
• Hazard
• Construction
• Closure
• Obstruction
• Resolution
• Expiration

Verify routing reacts correctly.

────────────────────────────────────────

CLOSURE TESTING

Test:

• Full closure
• Partial closure
• Lane closure
• Scheduled closure
• Emergency closure
• Expired closure

Verify:

• Routes avoid closure
• Active navigation detects affected route
• Rerouting is triggered correctly

────────────────────────────────────────

NAVIGATION TESTING

Test:

• Start
• Pause
• Resume
• Complete
• Cancel
• Destination reached
• Route replacement

Verify state transitions are valid and idempotent.

────────────────────────────────────────

TURN-BY-TURN TESTING

Test:

• Continue
• Left
• Right
• U-turn
• Merge
• Keep
• Fork
• Roundabout
• Exit
• Arrival

Validate:

• Step ordering
• Distance
• Street name
• Maneuver location

────────────────────────────────────────

OFF-ROUTE TESTING

Simulate:

• Small GPS drift
• Large deviation
• Wrong turn
• Missed exit
• Parallel road
• Highway exit
• GPS jumps

Verify hysteresis prevents unnecessary reroutes.

────────────────────────────────────────

REROUTING TESTING

Test:

• Off-route
• Closure
• Traffic change
• Destination change
• User deviation

Concurrency:

• Multiple simultaneous reroutes
• Stale route
• New route superseding old route
• Duplicate requests

────────────────────────────────────────

LOCATION TESTING

Test:

• Valid location
• Invalid coordinate
• Stale timestamp
• Duplicate event
• Out-of-order event
• Impossible speed
• Large coordinate jump
• Poor accuracy

Verify suspicious data does not corrupt navigation.

────────────────────────────────────────

LOCATION PRIVACY TESTING

Verify:

• Current location access
• Historical location access
• Sharing
• Revocation
• Expiration
• Deletion

Security:

• Location IDOR
• Unauthorized tracking
• Share-token replay
• Expired link
• Revoked link

────────────────────────────────────────

GEOFENCING TESTING

Test:

• Circle
• Polygon
• Cell-based
• Enter
• Exit
• Dwell

Boundary scenarios:

• Exactly on boundary
• Rapid boundary crossing
• GPS jitter
• Duplicate updates
• Geofence version changes

────────────────────────────────────────

LOCATION SHARING

Test:

• Create
• Access
• Expiration
• Revoke
• Reconnect
• Multiple recipients
• Unauthorized user

────────────────────────────────────────

TRIP SHARING

Test:

• Create
• Access
• Route updates
• ETA updates
• Navigation changes
• Expiration
• Revocation

Verify unrelated location history is never exposed.

────────────────────────────────────────

OFFLINE MAP TESTING

Test:

• Region selection
• Package request
• Download
• Pause
• Resume
• Update
• Delete
• Corruption
• Checksum failure
• Version mismatch
• Storage exhaustion

────────────────────────────────────────

OFFLINE SEARCH

Test:

• Place search
• Address search
• Category search
• Region boundaries
• Missing region
• Stale dataset

Clearly distinguish offline results from online results.

────────────────────────────────────────

OFFLINE ROUTING

Test:

• Route within package
• Route crossing package boundary
• No package
• Outdated graph
• Corrupt graph
• Offline reroute
• Reconnect

────────────────────────────────────────

OFFLINE NAVIGATION

Verify:

• Current route remains available
• Turn-by-turn remains functional
• Offline reroute works where supported
• No fabricated traffic
• Network recovery restores online state

────────────────────────────────────────

SAVED PLACES

Test:

• Save
• Unsave
• Home
• Work
• Favorites
• Collections

Security:

• User ownership
• Cross-user access
• Sensitive-location protection

────────────────────────────────────────

REVIEWS / RATINGS

Test:

• Create
• Update
• Delete
• Rating
• Pagination
• Reporting
• Moderation

Prevent:

• Duplicate review
• Fake rating manipulation
• Unauthorized editing
• Aggregate corruption

────────────────────────────────────────

PHOTOS

Test:

• Upload
• Processing
• Moderation
• CDN delivery
• Delete
• Unauthorized access
• Invalid file

────────────────────────────────────────

CONTRIBUTIONS

Test:

• Add place
• Edit place
• Suggest closure
• Report road issue
• Add photo
• Validation
• Approval
• Rejection
• Reversion

Concurrency:

• Conflicting edits
• Stale version
• Canonical update during contribution review

────────────────────────────────────────

NOTIFICATIONS

Test:

• Traffic alert
• Route change
• Navigation event
• Contribution status
• Review status
• Business update
• Offline package update
• Security notification

Test:

• FCM
• APNS
• Invalid token
• Retry
• Deduplication

────────────────────────────────────────

WEB TESTING

CONSUMER:

• Load map
• Search
• Autocomplete
• Open place
• Save place
• Directions
• Route selection
• Traffic
• Review
• Share location

BUSINESS:

• Claim
• Verify
• Edit profile
• Edit hours
• Upload photo
• Review analytics

ADMIN:

• Search place
• Review contribution
• Moderate review
• Publish dataset
• Inspect routing graph
• View traffic
• Change feature flag
• View audit

────────────────────────────────────────

WEB MAP TESTING

Test:

• Pan
• Zoom
• Rotation
• Layer toggles
• Markers
• Clusters
• Route rendering
• Traffic overlays
• Incident markers
• Geofences
• Current location

Performance:

• Dense marker areas
• Large routes
• Heavy traffic overlays
• Large search result sets

────────────────────────────────────────

MOBILE TESTING

CONSUMER:

• Authentication
• Map
• Search
• Place
• Directions
• Navigation
• Traffic
• Saved places
• Reviews
• Sharing
• Offline maps

BUSINESS / CONTRIBUTOR:

• Business management
• Contribution
• Photo upload

────────────────────────────────────────

MOBILE LOCATION TESTING

Test:

• Permission granted
• Permission denied
• Approximate location
• Precise location
• Background location
• GPS jitter
• No GPS
• Poor GPS
• Battery saver

────────────────────────────────────────

MOBILE NAVIGATION TESTING

Test:

• Start
• Pause
• Resume
• Off-route
• Reroute
• Traffic update
• Closure
• Network loss
• GPS loss
• Offline routing

────────────────────────────────────────

MOBILE LIFECYCLE TESTING

Test:

• Launch
• Background
• Foreground
• Screen lock
• Phone call
• Notification open
• Deep link
• App termination
• OS process kill
• Reconnect

Verify navigation and downloads recover safely.

────────────────────────────────────────

ACCESSIBILITY TESTING

WEB target:

• WCAG 2.2 AA

Test:

• Keyboard
• Screen reader
• Focus
• Search
• Directions
• Route steps
• Tables
• Dialogs
• Color contrast
• Reduced motion
• Accessible map alternatives

MOBILE:

• VoiceOver
• TalkBack
• Dynamic Type
• Labels
• Touch targets
• Reduced motion
• Accessible navigation instructions

────────────────────────────────────────

SECURITY TESTING

Test:

• Authentication bypass
• Authorization bypass
• IDOR
• Privilege escalation
• SQL injection
• XSS
• SSRF where applicable
• Query injection
• Path traversal
• Malicious uploads
• Token replay
• Share-token theft
• API scraping
• Search scraping
• Map-data scraping
• Tile-origin bypass
• Admin escalation

────────────────────────────────────────

LOCATION SECURITY

Specifically test:

• Unauthorized current-location access
• Unauthorized history access
• Location sharing bypass
• Trip sharing bypass
• Geofence access
• Home/work exposure
• Search-history exposure

────────────────────────────────────────

BUSINESS SECURITY

Test:

• Business claim takeover
• Cross-business access
• Unauthorized member changes
• Role escalation
• Private business information leakage

────────────────────────────────────────

ABUSE TESTING

Test:

• Fake places
• Fake businesses
• Fake reviews
• Review bombing
• Contribution spam
• Location spoofing
• API scraping
• Route scraping
• Geofence abuse
• Search manipulation

Verify:

• Detection
• Rate limiting
• Restriction
• Review workflow

────────────────────────────────────────

PERFORMANCE BUDGETS

Define measurable budgets for:

• Map startup
• Tile delivery
• Search
• Autocomplete
• Geocoding
• Reverse geocoding
• Route calculation
• ETA
• Navigation state
• Location processing
• Geofence evaluation
• Offline package generation

Record:

• P50
• P95
• P99
• Error rate

────────────────────────────────────────

LOAD TESTING

Simulate:

• Normal load
• Peak load
• Burst load
• Regional traffic surge
• Major event
• Search spike
• Routing spike
• Navigation spike
• Location spike
• Tile spike
• Offline-download spike

Measure:

• Throughput
• Latency
• Errors
• CPU
• Memory
• Database load
• Redis
• Kafka lag
• Queue depth
• OpenSearch load

────────────────────────────────────────

MAP TILE LOAD TESTING

Simulate:

• High zoom
• Low zoom
• Dense urban region
• Global viewport movement
• Cache hit
• Cache miss
• Popular tile hotspots

Verify CDN absorbs expected tile traffic without unnecessary application load.

────────────────────────────────────────

ROUTING LOAD TESTING

Simulate:

• Thousands of route requests
• Large matrix workloads
• Navigation refresh
• Reroute spikes
• Traffic-event spikes

Ensure batch matrices do not starve interactive routes.

────────────────────────────────────────

LOCATION LOAD TESTING

Simulate:

• Large active-user population
• Frequent location updates
• WebSocket connections
• Reconnect storms
• Navigation bursts

Measure:

• Events/sec
• Latency
• Kafka lag
• Redis load
• Memory
• WebSocket stability

────────────────────────────────────────

SEARCH LOAD TESTING

Simulate:

• Autocomplete
• Nearby search
• Full-text
• Typo searches
• Massive concurrent requests
• Reindex during live traffic

Ensure production search remains within SLO.

────────────────────────────────────────

STRESS TESTING

Exceed designed capacity and identify:

• Failure point
• Saturation component
• Failure mode
• Recovery behavior
• Scaling action

Test:

• Routing
• Search
• Location
• Kafka
• Redis
• PostgreSQL
• OpenSearch
• WebSockets
• CDN origin

────────────────────────────────────────

SOAK TESTING

Run long-duration workloads to identify:

• Memory leaks
• Connection leaks
• Kafka lag
• Queue growth
• Redis memory growth
• Database degradation
• Search instability
• Navigation-state degradation

────────────────────────────────────────

RESILIENCE TESTING

Inject failures into:

• PostgreSQL
• PostGIS
• Redis
• Kafka
• BullMQ
• OpenSearch
• S3
• Routing providers
• Geocoding providers
• Traffic providers
• Map-data workers
• Tile workers
• Navigation workers
• WebSocket gateways

Verify:

• Timeout
• Retry
• Fallback
• Degraded mode
• Recovery
• Reconciliation

────────────────────────────────────────

CHAOS TESTING

Test:

• Pod termination
• Node termination
• AZ failure
• Redis failover
• PostgreSQL failover
• Kafka broker failure
• OpenSearch node failure
• Routing worker failure
• Location gateway failure
• Search worker failure
• Map-data worker failure
• Regional failure

Run first in:

• Test
• Staging

Production chaos only under controlled operations.

────────────────────────────────────────

DISASTER RECOVERY

Validate:

• PostgreSQL restore
• PostGIS restore
• Redis recovery
• Kafka recovery
• OpenSearch restore
• S3 restore
• EKS rebuild
• Terraform rebuild
• Map-data rebuild
• Tile rebuild
• Routing graph rebuild
• Regional failover
• Regional failback

Measure:

• Actual RTO
• Actual RPO

────────────────────────────────────────

BACKUP TESTING

A backup is valid only after successful restore.

Test:

• Database backup
• S3 backup/replication
• Search snapshot
• Terraform state
• Critical configuration

Record:

• Date
• Duration
• Result
• Data integrity

────────────────────────────────────────

DATA CONSISTENCY TESTING

Validate:

STRONG CONSISTENCY

• Business ownership
• User account
• Saved places
• Privacy controls
• Share authorization
• Admin permissions

EVENTUAL CONSISTENCY

• Search
• Traffic
• Analytics
• Popularity
• Reviews aggregates
• Tile datasets

Ensure staleness stays within approved limits.

────────────────────────────────────────

RECONCILIATION TESTING

Test:

• Place vs search index
• Map dataset vs tiles
• Map dataset vs graph
• Graph vs routing service
• Traffic vs routing
• Review vs rating aggregate
• Offline manifest vs S3 objects
• Contribution vs canonical place
• Deleted location vs derived storage
• Privacy deletion vs search/cache/analytics

────────────────────────────────────────

INFRASTRUCTURE TESTING

Validate:

• Terraform fmt
• Terraform validate
• Terraform plan
• Terraform policy
• Helm lint
• Kubernetes schemas
• Kubernetes security
• Docker build
• Container scan
• SBOM
• Image signing
• IAM validation
• Security groups
• NetworkPolicies
• WAF
• TLS
• Backup policies
• Autoscaling

────────────────────────────────────────

CI/CD QUALITY GATES

PULL REQUEST:

• Format
• Lint
• Type-check
• Unit tests
• Integration tests
• Spatial tests
• Contract tests
• Security scans
• Secret scanning
• Dependency scanning
• Docker validation
• Terraform validation
• Helm validation
• Kubernetes validation

RELEASE:

• Build
• Unit tests
• Integration tests
• Contracts
• E2E
• Security
• Performance gates
• Deployment validation
• Smoke tests

────────────────────────────────────────

PRODUCTION SMOKE TESTS

After deployment validate:

• Map loading
• Tile delivery
• Search
• Autocomplete
• Place details
• Geocoding
• Routing
• ETA
• Traffic
• Navigation
• Location ingestion
• Saved places
• Business APIs
• Offline package metadata
• Notifications
• Privacy endpoints
• Administration

Use synthetic, non-sensitive accounts and geographic scenarios.

────────────────────────────────────────

REGRESSION STRATEGY

Every production defect must result in:

• Root-cause analysis
• Regression test
• Monitoring improvement where appropriate
• Documentation update where appropriate

Maintain a protected critical-path regression suite.

────────────────────────────────────────

ROUTING REGRESSION LIBRARY

Maintain a permanent golden dataset covering:

• Major cities
• Rural roads
• Highways
• Complex intersections
• Roundabouts
• Bridges
• Tunnels
• Toll roads
• Borders
• Closures
• Traffic scenarios
• Pedestrian routes
• Cycling routes

Track:

• Expected route class
• Distance range
• Duration range
• Required restrictions
• Expected maneuvers

────────────────────────────────────────

QUALITY METRICS

Track:

• Unit-test coverage
• Integration coverage
• Contract coverage
• Spatial-test coverage
• E2E critical-path coverage
• Test pass rate
• Flaky-test rate
• Test duration
• Security findings
• Critical defects
• Routing regressions
• Search regressions
• Geospatial defects
• Performance regressions
• Recovery success
• Release failure rate

Do not use code coverage as the only quality metric.

────────────────────────────────────────

FLAKY TEST MANAGEMENT

Track:

• Test
• Failure rate
• Environment
• Failure signature
• Owner
• Status

Do not permanently disable tests without documented justification.

────────────────────────────────────────

RELEASE CERTIFICATION

A release is production-ready only when:

• Required tests pass
• Spatial tests pass
• Routing regression passes
• Critical-path E2E passes
• Security gates pass
• Privacy gates pass
• Performance budgets pass
• Contract compatibility passes
• Infrastructure validation passes
• Smoke tests pass
• Monitoring is operational
• Backup restoration is current
• Rollback is available
• Known risks are documented
• Required approvals are complete

────────────────────────────────────────

PROJECT INDEX

Maintain the QA Project Index.

Track:

• Unit suites
• Integration suites
• Contract suites
• Spatial suites
• Geospatial regression suites
• API tests
• WebSocket tests
• Event tests
• Queue tests
• Database tests
• PostGIS tests
• Redis tests
• OpenSearch tests
• S3 tests
• Map-data tests
• Place tests
• Business tests
• Address tests
• Geocoding tests
• Reverse-geocoding tests
• Autocomplete tests
• Search tests
• Tile tests
• Map-style tests
• Road-network tests
• Routing tests
• Route regression tests
• Distance-matrix tests
• ETA tests
• Traffic tests
• Incident tests
• Closure tests
• Navigation tests
• Turn-by-turn tests
• Off-route tests
• Rerouting tests
• Location tests
• Map-matching tests
• Location-sharing tests
• Trip-sharing tests
• Geofencing tests
• Offline-map tests
• Offline-search tests
• Offline-routing tests
• Review tests
• Rating tests
• Photo tests
• Contribution tests
• Notification tests
• Moderation tests
• Fraud tests
• Analytics tests
• Administration tests
• Feature-flag tests
• Configuration tests
• Audit tests
• Privacy tests
• Web frontend tests
• Mobile tests
• Accessibility tests
• Security tests
• Abuse tests
• Performance tests
• Load tests
• Stress tests
• Soak tests
• Resilience tests
• Chaos tests
• Disaster-recovery tests
• Backup tests
• Infrastructure tests
• CI/CD tests
• Production smoke tests
• Regression tests
• Release certification
• Quality metrics
• Flaky tests
• Known defects
• Known risks
• Generated files
• Remaining work
• Current milestone
• Production-readiness status

────────────────────────────────────────

IMPLEMENTATION MILESTONES

QA MILESTONE 11

Testing infrastructure, fixtures, factories, synthetic geospatial datasets, PostGIS utilities, integration environments, test reporting, and CI foundations.

QA MILESTONE 12

Identity, accounts, devices, location permissions, current location, location history, sharing, trip sharing, geofencing, and privacy.

QA MILESTONE 13

Places, businesses, addresses, categories, hours, photos, geocoding, reverse geocoding, autocomplete, and search.

QA MILESTONE 14

Map datasets, geometry validation, road networks, road restrictions, speed limits, map styles, vector/raster tiles, indexing, and dataset rollback.

QA MILESTONE 15

Routing, route quality, routing regression, alternatives, distance matrix, ETA, traffic, incidents, closures, and graph-version testing.

QA MILESTONE 16

Navigation, turn-by-turn, off-route detection, rerouting, map matching, real-time location, WebSockets, and navigation resilience.

QA MILESTONE 17

Saved places, collections, reviews, ratings, photos, contributions, notifications, moderation, fraud/abuse, analytics, and administration.

QA MILESTONE 18

Offline maps, offline packages, offline search, offline routing, offline navigation, versioning, storage integrity, and synchronization.

QA MILESTONE 19

Web and mobile E2E, accessibility, performance, security, network resilience, background/foreground behavior, battery, and device compatibility.

QA MILESTONE 20

Full load/stress/soak testing, resilience, chaos, disaster recovery, backup restoration, infrastructure validation, production smoke testing, regression certification, release certification, documentation, and final Project Index completion.

Each milestone should contain approximately 20–40 files where practical.

Every milestone must produce measurable and verifiable results.

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never truncate code.

Never summarize implementation instead of generating it.

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

This prompt is dedicated to:

• QA
• Testing
• Geospatial validation
• Routing validation
• Navigation validation
• Security validation
• Privacy validation
• Abuse validation
• Performance validation
• Scalability validation
• Resilience validation
• Accessibility validation
• Infrastructure validation
• Disaster-recovery validation
• Backup validation
• CI/CD quality gates
• Regression testing
• Production smoke testing
• Release certification
• Production-readiness validation

Do not redesign the approved architecture.

Do not implement unrelated product features.
