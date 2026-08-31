You are operating in Senior Engineering Team Mode.

Build the production-ready backend for offline maps, offline routing, navigation support systems, saved places, collections, reviews, ratings, place photos, map contributions, business management, geofencing completion, notifications, moderation, fraud/abuse prevention, analytics, administration, privacy workflows, and final backend hardening for an enterprise-scale global mapping platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

Use the previously approved architecture and backend volumes as the single source of truth.

Do not redesign the architecture.

Do not generate frontend code.

Do not generate mobile code.

Do not generate infrastructure implementation code.

Do not generate Terraform.

Do not generate Kubernetes manifests.

Do not generate CI/CD workflows.

────────────────────────────────────────

MISSION

Implement the production-ready backend domains for:

• Offline maps
• Offline regions
• Offline tile packages
• Offline styles
• Offline POI packages
• Offline search packages
• Offline routing graph packages
• Offline package versioning
• Offline package integrity
• Saved places
• Favorites
• Collections
• Home/work locations
• Reviews
• Ratings
• Place photos
• Business management
• Business members
• Business hours
• Business attributes
• Business photos
• Map contributions
• Place edits
• Place reports
• Road reports
• Closure reports
• Geofence lifecycle
• Geofence notifications
• Notification preferences
• Traffic notifications
• Route notifications
• Place notifications
• Contribution notifications
• Moderation
• Review moderation
• Contribution moderation
• Business claim moderation
• Fraud and abuse prevention
• Fake-review prevention
• Fake-business prevention
• Map-data abuse prevention
• Location-spoofing detection foundations
• Analytics
• Platform analytics
• Place analytics
• Navigation analytics
• Administration
• Map operations
• Feature flags
• Configuration
• Audit
• Privacy
• Data export
• Data deletion
• Retention
• Reconciliation
• Final backend operational hardening

The implementation must support:

• Hundreds of millions of users
• Billions of map/tile requests
• Millions of navigation sessions
• Large place/business datasets
• Large offline-download workloads
• Large review/contribution workloads
• Massive analytics volumes
• Multiple regions
• High availability
• Strict location privacy
• Strict business ownership controls
• Strong moderation
• Strong abuse prevention

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

• Elasticsearch/OpenSearch

Object storage:

• AWS S3

CDN:

• CloudFront

Real-time:

• WebSockets
• Socket.IO

Notifications:

• FCM
• APNS

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

Never trust client-controlled ownership.

Never expose private location data.

Never expose internal fraud or moderation signals.

────────────────────────────────────────

DOMAIN OWNERSHIP

Maintain clear boundaries between:

• Offline Maps
• Saved Places
• Collections
• Reviews
• Ratings
• Photos
• Businesses
• Contributions
• Moderation
• Notifications
• Fraud
• Analytics
• Administration
• Privacy

Do not combine:

• Offline packages with authoritative map data
• Reviews with business ownership
• Contributions with direct canonical map mutation
• Analytics with transactional source data
• Notifications with notification preferences
• Fraud decisions with irreversible moderation without policy controls

────────────────────────────────────────

OFFLINE MAPS

Implement offline-map management.

Support:

• Region listing
• Region selection
• Package creation
• Package download metadata
• Package version
• Package update
• Package deletion
• Package expiration/update policy
• Package integrity metadata

────────────────────────────────────────

OFFLINE REGION

Represent an offline region with:

• Region ID
• Name
• Geography
• Country
• Map dataset version
• Style version
• POI dataset version
• Search dataset version
• Routing graph version
• Package version
• Size estimate
• Status

────────────────────────────────────────

OFFLINE PACKAGE

States:

• Requested
• Building
• Validating
• Ready
• Deprecated
• Failed
• Deleted

Every transition must be:

• Version-aware
• Auditable
• Idempotent

────────────────────────────────────────

OFFLINE PACKAGE CONTENT

Packages may include:

• Vector tiles
• Raster fallback
• Map style
• POI subset
• Search subset
• Routing graph subset
• Metadata
• Version manifest

Do not include unrelated global data.

────────────────────────────────────────

OFFLINE PACKAGE BUILD

Architecture:

Region
→ Dataset Selection
→ Tile Selection
→ POI Selection
→ Search Selection
→ Routing Graph Selection
→ Package Assembly
→ Integrity Validation
→ Compression
→ Publish
→ CDN

Use asynchronous workers.

────────────────────────────────────────

OFFLINE PACKAGE INTEGRITY

Each package should define:

• Version
• SHA/checksum
• File manifest
• Size
• Dataset versions
• Graph version
• Style version

The client must be able to verify package integrity.

────────────────────────────────────────

OFFLINE DOWNLOAD AUTHORIZATION

Use secure temporary access.

Support:

• Signed downloads
• Expiration
• Region authorization where needed
• Version authorization

Do not expose unrestricted S3 access.

────────────────────────────────────────

OFFLINE PACKAGE UPDATES

Support:

• Full replacement
• Incremental update where architecture supports it
• Version migration
• Compatibility checks

Do not apply incompatible map packages silently.

────────────────────────────────────────

OFFLINE ROUTING

Provide backend support for:

• Routing graph package metadata
• Graph version compatibility
• Regional graph selection
• Offline graph publishing
• Offline graph deprecation

The mobile application performs local routing.

The backend owns package generation and lifecycle.

────────────────────────────────────────

SAVED PLACES

Implement:

• Save place
• Unsave place
• Saved-place list
• Favorite
• Home
• Work
• Custom labels

All saved places are owned by the user.

────────────────────────────────────────

SENSITIVE SAVED PLACES

Treat:

• Home
• Work
• Frequent locations

as highly sensitive.

Restrict access through:

• Authentication
• Resource ownership
• Audit
• Privacy controls

Never expose them through public APIs.

────────────────────────────────────────

COLLECTIONS

Implement:

• Create collection
• Rename
• Delete
• Add item
• Remove item
• Reorder
• Share where explicitly supported

Collection visibility:

• Private
• Shared

Do not allow accidental public exposure.

────────────────────────────────────────

REVIEWS

Implement:

• Create review
• Update own review
• Delete own review
• List reviews
• Report review
• Moderate review

Each review may contain:

• Rating
• Text
• Place ID
• Author
• Created time
• Updated time
• Status
• Moderation reference

────────────────────────────────────────

REVIEW ELIGIBILITY

A user may submit a review only when product policy permits.

Prepare for validation signals such as:

• Verified visit
• Interaction history
• Account age
• Abuse signals

Do not automatically reject legitimate users from one weak signal.

────────────────────────────────────────

RATING

Implement:

• Place rating
• Rating aggregate
• Rating distribution

The individual rating is authoritative.

Aggregates may be eventually consistent.

────────────────────────────────────────

RATING CONCURRENCY

Prevent:

• Duplicate ratings where policy forbids them
• Race conditions
• Aggregate corruption
• Unauthorized edits

Use database constraints and idempotency.

────────────────────────────────────────

REVIEW PAGINATION

Use cursor-based pagination.

Support:

• Recent
• Relevant
• Highest-rated
• Lowest-rated where permitted

Do not expose hidden moderation metadata.

────────────────────────────────────────

PLACE PHOTOS

Implement:

• Photo metadata
• Upload authorization
• Moderation state
• Ordering
• Removal

Actual images reside in S3.

────────────────────────────────────────

PHOTO PROCESSING

Support:

• Resize
• Metadata extraction
• Moderation
• Thumbnail
• CDN publication

Use asynchronous workers.

────────────────────────────────────────

BUSINESS MANAGEMENT

Implement authorized business-management APIs.

Support:

• Business profile
• Members
• Roles
• Hours
• Attributes
• Phone
• Website
• Photos
• Business status
• Special hours

────────────────────────────────────────

BUSINESS MEMBERS

Roles:

• Owner
• Manager
• Editor
• Analyst

Each role gets explicit permissions.

Avoid broad business-admin permissions by default.

────────────────────────────────────────

BUSINESS HOURS

Support:

• Regular hours
• Holiday hours
• Special hours
• Temporary closure

Business hours use local time zone.

────────────────────────────────────────

BUSINESS PHOTOS

Support:

• Upload authorization
• Photo management
• Ordering
• Deletion
• Moderation

────────────────────────────────────────

MAP CONTRIBUTIONS

Implement:

• Add place
• Edit place
• Suggest closure
• Suggest road change
• Suggest category
• Add photo
• Report wrong information

Contribution is not direct canonical mutation.

────────────────────────────────────────

CONTRIBUTION WORKFLOW

Contribution
→ Validation
→ Risk Assessment
→ Moderation
→ Approval
→ Canonical Update
→ Search Update
→ Tile/Graph Update if needed

────────────────────────────────────────

CONTRIBUTION STATES

Support:

• Draft
• Submitted
• Automated Review
• Human Review
• Approved
• Rejected
• Published
• Reverted
• Archived

────────────────────────────────────────

CONTRIBUTION CONFLICTS

Handle:

• Simultaneous edits
• Stale version
• Conflicting contributions
• Business-owner override
• Administrative override

Use:

• Version numbers
• Optimistic concurrency
• Audit

────────────────────────────────────────

PLACE REPORTING

Support reports for:

• Closed place
• Wrong location
• Wrong hours
• Duplicate
• Wrong category
• Wrong contact
• Unsafe information

Reports should feed moderation/contribution workflows.

────────────────────────────────────────

ROAD REPORTING

Support reports for:

• Closure
• Road damage
• Wrong direction
• Wrong restriction
• Wrong speed limit
• Missing road

Do not directly alter the canonical road graph.

────────────────────────────────────────

GEOFENCE MANAGEMENT

Complete geofence lifecycle:

• Create
• Update
• Enable
• Disable
• Delete
• Expire
• Enter
• Exit
• Dwell

Support ownership and permissions.

────────────────────────────────────────

GEOFENCE NOTIFICATIONS

Where explicitly configured:

• Notify on entry
• Notify on exit
• Notify on dwell

Respect:

• User consent
• Notification preferences
• Privacy rules

────────────────────────────────────────

NOTIFICATION DOMAIN

Implement:

• Notification
• Delivery
• Preference
• Device
• Channel
• Priority
• Expiration

────────────────────────────────────────

NOTIFICATION TYPES

Support:

• Traffic alert
• Route change
• Reroute
• Navigation issue
• Saved-place notification
• Business update
• Contribution status
• Review status
• Offline package update
• Security
• Privacy

────────────────────────────────────────

NOTIFICATION DEDUPLICATION

Use:

• Event ID
• Notification ID
• Idempotency key

Avoid duplicate notifications from retries or reconnects.

────────────────────────────────────────

PUSH DELIVERY

Implement provider abstractions for:

• FCM
• APNS

Handle:

• Invalid token
• Token rotation
• Provider timeout
• Provider throttling
• Retry
• Permanent failure

────────────────────────────────────────

MODERATION

Moderate:

• Reviews
• Photos
• Contributions
• Business claims
• Business content
• Place metadata

Support:

• Automated validation
• Human review
• Appeal
• Restoration

────────────────────────────────────────

REVIEW MODERATION

Detect:

• Spam
• Harassment
• Fraud
• Review manipulation
• Offensive content

Actions:

• Allow
• Hide
• Remove
• Restrict
• Escalate

────────────────────────────────────────

CONTRIBUTION MODERATION

Evaluate:

• Source reputation
• Duplicate likelihood
• Geographic plausibility
• Business evidence
• User reputation
• Content quality

Do not let one suspicious signal automatically destroy valid map data.

────────────────────────────────────────

BUSINESS CLAIM SECURITY

Protect against:

• Business impersonation
• Fake ownership
• Unauthorized profile takeover

Use:

• Verification
• Role restrictions
• Audit
• Reverification

────────────────────────────────────────

FRAUD / ABUSE

Detect:

• Fake reviews
• Review bombing
• Fake businesses
• Place spam
• Contribution spam
• Location spoofing
• Geofence abuse
• Search manipulation
• API scraping

Use:

• Rate limits
• Device signals
• Account signals
• Behavioral signals
• Geographic signals
• Reputation
• Manual review

────────────────────────────────────────

LOCATION-SPOOFING FOUNDATION

Detect potential anomalies such as:

• Impossible speed
• Unrealistic jumps
• GPS precision anomalies
• Device/network inconsistency
• Repeated synthetic movement patterns

Produce risk references.

Do not automatically make irreversible decisions without policy.

────────────────────────────────────────

ANALYTICS

Track:

• Map views
• Place views
• Place searches
• Autocomplete
• Route requests
• Navigation starts
• Navigation completions
• Reroutes
• Off-route events
• Saved places
• Reviews
• Ratings
• Contributions
• Offline downloads
• Traffic interactions
• Location sharing
• Geofence events

────────────────────────────────────────

PLACE ANALYTICS

Provide aggregate metrics:

• Views
• Searches
• Directions requests
• Calls/clicks where available
• Saves
• Reviews
• Ratings

Business users see only authorized analytics.

────────────────────────────────────────

NAVIGATION ANALYTICS

Track aggregate:

• Route success
• Navigation completion
• Reroute rate
• Off-route rate
• ETA deviation
• Traffic impact

Do not expose individual user routes to business users.

────────────────────────────────────────

ANALYTICS PRIVACY

Separate:

• Raw event
• Aggregated metric
• User-level data

Apply retention policies.

Avoid storing unnecessary precise coordinates.

────────────────────────────────────────

ADMINISTRATION

Implement backend administration APIs for:

• Places
• Businesses
• Road data
• Map data
• Reviews
• Contributions
• Traffic
• Incidents
• Offline packages
• Moderation
• Fraud
• Users
• Analytics
• Feature flags
• Configuration
• Privacy
• Audit

────────────────────────────────────────

MAP OPERATIONS

Support authorized operators with:

• Dataset version
• Active version
• Rollout status
• Routing graph version
• Tile version
• Search index version
• Offline-package version

Provide controlled rollback.

────────────────────────────────────────

FEATURE FLAGS

Support:

• Region
• Country
• Platform
• App version
• User cohort
• Percentage rollout

Examples:

• New geocoder
• New search ranking
• New routing engine
• New traffic model
• New map style
• New offline format
• New geofence evaluator

────────────────────────────────────────

SYSTEM CONFIGURATION

Support typed configuration for:

• Search
• Autocomplete
• Routing
• ETA
• Traffic
• Geofencing
• Offline packages
• Notification thresholds
• Review moderation
• Contribution thresholds
• Rate limits

Configuration must be:

• Validated
• Versioned
• Audited
• Rollback-capable

────────────────────────────────────────

AUDIT

Audit:

• Business ownership changes
• Business member changes
• Review moderation
• Contribution decisions
• Road-data changes
• Map-data publication
• Routing graph rollout
• Offline-package publication
• Feature flags
• Configuration
• Privacy requests
• Administrative actions

Store:

• Actor
• Role
• Action
• Resource
• Reason
• Request ID
• Correlation ID
• Region
• Timestamp
• Result

────────────────────────────────────────

PRIVACY

Support:

• Data access
• Data export
• Data deletion
• Location-history deletion
• Search-history deletion
• Saved-place deletion
• Share revocation
• Geofence deletion
• Account deletion

Use asynchronous workflows where required.

────────────────────────────────────────

DATA EXPORT

Export authorized user data including, where applicable:

• Profile
• Saved places
• Collections
• Reviews
• Contributions
• Settings
• Location-history data available under policy
• Search history where retained

Generate export artifacts in secure S3 storage.

Use short-lived download authorization.

────────────────────────────────────────

DATA DELETION

Implement deletion/anonymization workflows for:

• Saved places
• Collections
• Reviews
• Contributions
• Location history
• Search history
• Geofences
• Location shares
• Trip shares

Coordinate with:

• Analytics
• Search
• Notifications
• Audit
• Moderation

────────────────────────────────────────

RETENTION

Define separate retention for:

• Live location
• Location history
• Search history
• Notification history
• Reviews
• Contributions
• Analytics
• Audit
• Fraud references

Do not treat all data identically.

────────────────────────────────────────

RECONCILIATION

Implement reconciliation for:

OFFLINE

• Package manifest vs objects

PLACES

• Canonical place vs search index

BUSINESSES

• Business ownership vs memberships

REVIEWS

• Review state vs rating aggregate

MAP DATA

• Active dataset vs tiles
• Active dataset vs routing graph

GEOFENCING

• Geofence state vs event state

NOTIFICATIONS

• Notification state vs delivery state

PRIVACY

• Deleted data vs derived indexes

────────────────────────────────────────

OFFLINE RECONCILIATION

Detect:

• Missing package objects
• Incorrect checksums
• Incomplete manifests
• Stale package versions
• Dataset/version mismatch

Invalidate broken packages.

────────────────────────────────────────

REVIEW AGGREGATE RECONCILIATION

Compare:

• Authoritative rating records
• Aggregate rating
• Distribution

Repair derived aggregates.

────────────────────────────────────────

MAP DATA RECONCILIATION

Verify:

• Dataset version
• Search index
• Tile version
• Routing graph version
• Offline package version

Every derived artifact must identify its source dataset version.

────────────────────────────────────────

SECURITY HARDENING

Perform final review for:

• Place IDOR
• Business IDOR
• Saved-place IDOR
• Review IDOR
• Contribution authorization
• Geofence authorization
• Location-share authorization
• Offline-package authorization
• Admin privilege escalation
• Search scraping
• Route scraping
• Map-data scraping

────────────────────────────────────────

PERFORMANCE REVIEW

Audit:

• Spatial queries
• Review pagination
• Business queries
• Contribution queues
• Offline package generation
• Notification fan-out
• Geofence evaluation
• Analytics processing

Optimize using:

• Spatial indexes
• Redis
• Batching
• Queues
• Cursor pagination
• Aggregates
• Regional processing

────────────────────────────────────────

DATABASE

Implement Prisma migrations for:

• OfflineRegion
• OfflinePackage
• OfflinePackageManifest
• SavedPlace
• Collection
• CollectionItem
• Review
• Rating
• ReviewReport
• PlacePhoto
• BusinessProfile
• BusinessMember
• BusinessClaim
• BusinessHours
• BusinessAttribute
• Contribution
• ContributionRevision
• PlaceReport
• RoadReport
• Geofence
• GeofenceTransition
• Notification
• NotificationPreference
• NotificationDelivery
• NotificationDevice
• AnalyticsAggregate
• PrivacyRequest

Use:

• Foreign keys
• Unique constraints
• Composite indexes
• Version fields
• Status
• Expiration
• Timestamps

────────────────────────────────────────

REDIS

Use Redis for:

• Offline package metadata cache
• Saved-place cache
• Collection cache
• Review aggregate cache
• Geofence acceleration
• Notification deduplication
• Provider throttling
• Abuse controls
• Rate limiting

Never make Redis authoritative for:

• Reviews
• Business ownership
• Contributions
• Privacy requests
• Location history
• Offline package ownership

────────────────────────────────────────

KAFKA EVENTS

Publish:

OFFLINE

• OfflinePackageRequested
• OfflinePackageReady
• OfflinePackageDeprecated
• OfflinePackageDeleted

SAVED PLACES

• PlaceSaved
• PlaceUnsaved
• CollectionChanged

REVIEWS

• ReviewCreated
• ReviewUpdated
• ReviewRemoved
• RatingUpdated

BUSINESSES

• BusinessClaimSubmitted
• BusinessClaimApproved
• BusinessUpdated
• BusinessMemberChanged

CONTRIBUTIONS

• ContributionSubmitted
• ContributionApproved
• ContributionRejected
• ContributionReverted

GEOFENCE

• GeofenceCreated
• GeofenceUpdated
• GeofenceEntered
• GeofenceExited
• GeofenceDeleted

NOTIFICATIONS

• NotificationCreated
• NotificationDelivered
• NotificationFailed

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

• FeatureFlagChanged
• ConfigurationChanged
• AdministrativeActionTaken

All events must be:

• Versioned
• Idempotent
• Privacy-aware
• Region-aware

────────────────────────────────────────

BULLMQ

Implement queues for:

• Offline package generation
• Offline package cleanup
• Photo processing
• Review moderation
• Contribution validation
• Contribution moderation
• Business verification
• Notification delivery
• Geofence maintenance
• Analytics aggregation
• Privacy export
• Privacy deletion
• Reconciliation
• Cleanup

Every queue must define:

• Retry
• Backoff
• Timeout
• Concurrency
• Dead-letter handling
• Metrics
• Idempotency

────────────────────────────────────────

API

OFFLINE:

• List regions
• Get region
• Request package
• Get package status
• Download authorization
• Update package
• Delete package

SAVED PLACES:

• Save
• Unsave
• List
• Get

COLLECTIONS:

• Create
• Update
• Delete
• Add item
• Remove item
• Reorder
• Share where supported

REVIEWS:

• Create
• Update own
• Delete own
• List
• Report

RATINGS:

• Rate
• Update
• Get aggregate

PHOTOS:

• Upload authorization
• List
• Delete own

BUSINESSES:

• Get business
• Update
• Manage members
• Update hours
• Update attributes
• Manage photos

CONTRIBUTIONS:

• Create
• Submit
• Get status
• Withdraw where allowed

REPORTS:

• Report place
• Report road
• Report review

GEOFENCES:

• Create
• Update
• Delete
• List

NOTIFICATIONS:

• List
• Mark read
• Preferences
• Devices

PRIVACY:

• Request export
• Request deletion
• Get request status

ADMIN:

• Map operations
• Offline package operations
• Moderation
• Business operations
• Contribution operations
• Analytics
• Feature flags
• Configuration
• Audit

Every endpoint must implement:

• Authentication
• Authorization
• Validation
• Rate limiting
• Idempotency where appropriate
• OpenAPI
• Consistent errors
• Audit where required

────────────────────────────────────────

OBSERVABILITY

Instrument:

• Offline package builds
• Review submissions
• Review moderation
• Contributions
• Business changes
• Geofencing
• Notifications
• Privacy workflows
• Reconciliation
• Analytics

Track:

• Offline build duration
• Package size
• Package failure rate
• Review throughput
• Moderation latency
• Contribution latency
• Geofence event latency
• Notification latency
• Privacy workflow duration
• Reconciliation mismatches
• Queue depth
• Kafka lag

Never log:

• Precise private location
• Share tokens
• Private saved places
• Private review evidence
• Notification secrets

────────────────────────────────────────

TESTING

UNIT TESTS

Test:

• Offline package state
• Saved-place ownership
• Collection permissions
• Review eligibility
• Rating aggregation
• Business permissions
• Contribution state
• Geofence state
• Notification preferences
• Privacy workflows

OFFLINE TESTS

Test:

• Package build
• Version mismatch
• Integrity validation
• Missing object
• Resume/update
• Expiration
• Secure download

REVIEW TESTS

Test:

• Create
• Update
• Delete
• Report
• Moderation
• Rating aggregation
• Duplicate prevention

BUSINESS TESTS

Test:

• Claim
• Approval
• Role changes
• Permissions
• Hours
• Photos

CONTRIBUTION TESTS

Test:

• Submit
• Validate
• Approve
• Reject
• Revert
• Conflict

GEOFENCE TESTS

Test:

• Create
• Enter
• Exit
• Dwell
• Boundary
• Expiration
• Duplicate event

NOTIFICATION TESTS

Test:

• Push
• Token rotation
• Deduplication
• Retry
• Preferences

PRIVACY TESTS

Test:

• Export
• Deletion
• Anonymization
• Retention
• Cross-domain cleanup

SECURITY TESTS

Test:

• Saved-place IDOR
• Business IDOR
• Review IDOR
• Contribution authorization
• Geofence access
• Share access
• Admin escalation

PERFORMANCE TESTS

Test:

• Offline package generation
• Review ingestion
• Contribution ingestion
• Geofence evaluation
• Notification throughput
• Analytics ingestion

────────────────────────────────────────

DOCUMENTATION

Generate:

• Offline maps
• Offline regions
• Offline package lifecycle
• Offline package integrity
• Offline routing packages
• Saved places
• Sensitive saved places
• Collections
• Reviews
• Ratings
• Photos
• Business management
• Business members
• Business hours
• Business photos
• Map contributions
• Contribution workflow
• Contribution conflicts
• Place reporting
• Road reporting
• Geofence lifecycle
• Geofence notifications
• Notification architecture
• Review moderation
• Contribution moderation
• Business claim security
• Fraud/abuse
• Location spoofing foundation
• Analytics
• Privacy
• Administration
• Feature flags
• Configuration
• Audit
• Reconciliation
• Security
• Performance
• Testing

────────────────────────────────────────

PROJECT INDEX

Update the backend Project Index with:

• Offline maps
• Offline regions
• Offline packages
• Offline package manifests
• Offline versions
• Offline routing packages
• Saved places
• Favorites
• Home/work
• Collections
• Reviews
• Ratings
• Review reports
• Place photos
• Business profiles
• Business members
• Business claims
• Business hours
• Business attributes
• Business photos
• Contributions
• Contribution revisions
• Place reports
• Road reports
• Geofences
• Geofence transitions
• Notifications
• Notification preferences
• Notification devices
• Analytics
• Privacy requests
• Reconciliation
• APIs
• Kafka topics
• BullMQ queues
• Redis keys
• Database migrations
• Tests
• Security
• Observability
• Generated files
• Modified files
• Remaining work
• Current milestone
• Dependencies

────────────────────────────────────────

IMPLEMENTATION MILESTONES

BACKEND MILESTONE 31

Offline regions, offline packages, manifests, versioning, package generation, integrity validation, secure download authorization, updates, expiration, and CDN integration.

BACKEND MILESTONE 32

Saved places, favorites, home/work, collections, ownership, privacy, sharing, pagination, and reconciliation.

BACKEND MILESTONE 33

Reviews, ratings, aggregates, review reporting, review moderation integration, pagination, spam controls, and analytics.

BACKEND MILESTONE 34

Place photos, photo-processing integration, moderation, CDN access, ordering, deletion, and reconciliation.

BACKEND MILESTONE 35

Business management, members, roles, hours, attributes, business photos, ownership controls, claims, verification, and audit.

BACKEND MILESTONE 36

Map contributions, place reports, road reports, revision history, conflict handling, validation, moderation, publication, and rollback.

BACKEND MILESTONE 37

Geofence lifecycle, event processing, notifications, push providers, preferences, deduplication, retries, and real-time updates.

BACKEND MILESTONE 38

Fraud/abuse prevention, review abuse, contribution abuse, business impersonation protection, location-spoofing foundations, risk references, and rate controls.

BACKEND MILESTONE 39

Analytics, administration, feature flags, configuration, privacy export/deletion, retention, reconciliation, security hardening, and operational diagnostics.

BACKEND MILESTONE 40

Full integration, offline, reviews, businesses, contributions, geofencing, notifications, privacy, security, concurrency, load, resilience, disaster recovery, production testing, documentation, and final Project Index completion.

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

• Offline maps
• Offline routing packages
• Saved places
• Collections
• Reviews
• Ratings
• Photos
• Business management
• Business claims
• Business members
• Business hours
• Contributions
• Place reports
• Road reports
• Geofencing
• Notifications
• Review moderation integration
• Contribution moderation
• Fraud and abuse foundations
• Analytics
• Administration
• Feature flags
• Configuration
• Audit
• Privacy
• Data export
• Data deletion
• Retention
• Reconciliation
• Security hardening
• Performance hardening
• Final backend integration

Do not redesign or reimplement previously completed:

• Identity
• Profiles
• Devices
• Location
• Places
• Addresses
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Map datasets
• Map styles
• Tiles
• Roads
• Routing
• ETA
• Traffic
• Incidents
• Closures
• Navigation
• Location sharing
• Trip sharing

Use their established APIs, events, repositories, and ownership boundaries.

Do not implement:

• Frontend
• Mobile
• Infrastructure
• Terraform
• Kubernetes
• CI/CD

────────────────────────────────────────

QUALITY BAR

Treat offline maps, business ownership, reviews, contributions, geofencing, notifications, privacy, and administration as enterprise-critical systems.

Assume:

• Hundreds of millions of users
• Billions of map requests
• Millions of offline downloads
• Millions of business profiles
• Massive review traffic
• Massive contribution traffic
• Large geofence workloads
• Large notification traffic
• Massive analytics streams
• Multiple regions
• Strict privacy
• High availability

Prioritize:

• Data integrity
• Location privacy
• Business ownership security
• Review integrity
• Contribution quality
• Package integrity
• Geofence correctness
• Notification reliability
• Abuse resistance
• Idempotency
• Auditability
• Reconciliation
• Scalability
• Observability
• Production readiness
