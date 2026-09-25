# Google Maps-Style Mapping & Navigation Platform — QA Prompt — Volume 1

# ROLE

Act as a senior quality engineering organization responsible for establishing and executing the production-grade automated quality foundation for a large-scale Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal QA Architect
* Senior Test Automation Engineers
* Backend QA Engineers
* Frontend QA Engineers
* Mobile QA Engineers
* API/Contract Test Engineers
* Database Test Engineers
* Geospatial QA Engineers
* Distributed Systems QA Engineers
* Security Test Engineers
* Accessibility Test Engineers
* Performance Test Engineers
* Reliability/SRE Test Engineers
* Technical Writers

You are implementing and executing quality engineering systems.

Do not produce superficial test checklists, placeholder tests, tests that assert only that screens render, fake integrations, disabled assertions, skipped critical scenarios, hardcoded test secrets, TODO/FIXME test gaps, or knowingly incomplete critical coverage.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Establish the foundational quality-engineering system for the Google Maps-style mapping and navigation platform.

The platform includes:

* web frontend
* mobile applications
* backend APIs
* geospatial services
* search
* geocoding
* vector tiles
* routing
* navigation/realtime
* traffic
* public transit
* user-generated content
* media
* notifications
* administration
* asynchronous workers
* event streams
* queues
* cloud infrastructure

This prompt establishes the automated test foundation and validates the highest-risk shared contracts and backend capabilities.

The goal is to provide reliable automated verification that the platform's major service boundaries agree on:

* identifiers
* timestamps
* coordinates
* geometry
* API contracts
* authentication
* authorization
* errors
* pagination
* idempotency
* data persistence
* events
* queues
* geospatial behavior

Do not attempt to complete all browser/mobile end-to-end, load, security, disaster-recovery, and full-system certification in this prompt. Those are handled by later QA scope.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the core automated QA foundation and backend/contract quality layer.

## 1. Test Architecture

Establish a coherent test architecture across the repository.

Define and implement boundaries for:

* unit tests
* component/service tests
* API tests
* integration tests
* contract tests
* database tests
* event/queue tests
* geospatial tests
* test fixtures
* deterministic test data
* test utilities
* test environment configuration

Clearly distinguish tests intended to verify:

* pure business behavior
* service boundaries
* persistence behavior
* external contracts
* asynchronous processing
* infrastructure-backed integration

Do not let unit tests quietly become integration tests because of uncontrolled global dependencies.

---

## 2. Test Tooling Foundation

Implement the project's test tooling using the existing technology stack and repository conventions.

Provide:

* test runner configuration
* TypeScript integration
* coverage collection
* test discovery
* isolated test environments
* setup/teardown
* deterministic execution
* parallelization where safe
* retries only where technically justified
* test reporting
* failure artifact collection

Do not configure retries to hide flaky tests.

Any retry policy must be documented and limited to infrastructure-transient failures where appropriate.

---

## 3. Deterministic Test Data

Create reusable deterministic fixtures for canonical platform entities.

Include suitable data for:

* users
* sessions
* roles
* permissions
* addresses
* places
* geographic features
* place categories
* saved places
* saved lists
* contributions
* reviews
* ratings
* reports
* media metadata
* notification records
* route requests
* routes
* route legs
* route steps
* navigation sessions
* traffic events
* transit entities

Fixtures must use contract-valid identifiers, timestamps, coordinates, enums, and relationships.

Avoid random data unless randomness is controlled by a deterministic seed.

Do not make tests dependent on the current wall-clock time unless the test explicitly controls the clock.

---

## 4. Test Database Infrastructure

Implement a reliable database-test strategy for PostgreSQL/PostGIS-backed services.

Support:

* isolated test database/schema
* migrations
* schema verification
* transaction isolation where appropriate
* fixture loading
* cleanup
* deterministic seed data
* PostGIS extension availability
* test-specific database configuration

Test database behavior must be close enough to production semantics to detect meaningful defects.

Do not replace PostGIS behavior with an in-memory fake for geospatial correctness tests.

---

## 5. Repository and Migration Validation

Create automated validation for database migrations.

Test:

* fresh database initialization
* complete migration chain
* migration ordering
* schema compatibility
* indexes
* constraints
* foreign keys
* PostGIS objects
* downgrade behavior where supported by the project's migration policy

Verify that a clean environment can reproduce the expected schema.

Do not rely solely on a developer's existing local database.

---

## 6. API Contract-Test Foundation

Implement automated contract testing for public and internal HTTP APIs.

Validate:

* request schemas
* response schemas
* status codes
* headers
* content types
* identifiers
* timestamps
* error payloads
* pagination
* filtering
* sorting
* idempotency
* authentication behavior
* authorization behavior

Use the canonical API specifications and schemas available in the repository.

Detect breaking changes automatically.

Do not make a contract test pass by broadly accepting unknown fields or invalid response shapes.

---

## 7. API Error Contract

Create dedicated tests for the canonical API error model.

Cover:

* validation errors
* authentication errors
* authorization errors
* not-found errors
* conflict errors
* rate-limit errors
* dependency failures
* timeouts
* internal failures
* malformed requests

Verify:

* stable error codes
* HTTP status mapping
* machine-readable fields
* safe user-facing messages
* correlation/request identifiers where required
* absence of stack traces or secrets

Ensure internal implementation details do not leak through API errors.

---

## 8. Authentication and Session Testing

Test backend authentication/session behavior comprehensively.

Cover:

* authentication success
* invalid credentials
* expired credentials
* refresh
* refresh rotation where applicable
* logout
* revoked sessions
* multiple devices
* concurrent refresh
* session expiration
* unauthorized access
* token replay protections where implemented
* session cleanup

Test race conditions around concurrent session refresh.

Do not use production credentials.

Test authentication state using controlled test identities.

---

## 9. Authorization Testing

Implement authorization tests for:

* authenticated users
* unauthenticated users
* ordinary users
* privileged users
* administrative roles
* resource owners
* non-owners
* private resources
* public resources
* shared resources

Verify authorization at the API/service boundary rather than trusting UI behavior.

Test horizontal privilege escalation scenarios.

Test vertical privilege escalation scenarios.

---

## 10. Identity and Resource-Isolation Tests

Verify that one user's data cannot be accessed or modified by another user without explicit authorization.

Cover:

* profiles
* saved places
* saved lists
* private notes
* drafts
* contributions
* reviews
* reports
* notification records
* device registrations
* other account-scoped resources

Test both read and write paths.

Do not rely solely on integration-test fixtures that happen to use one user.

---

## 11. API Pagination and Filtering Tests

Validate canonical pagination behavior.

Cover:

* first page
* subsequent pages
* empty page
* end of collection
* invalid cursor
* stale cursor
* duplicate cursor use
* page size limits
* sorting stability
* filters
* combined filters
* authorization-aware filtering

Ensure pagination cannot leak records outside the authorized result set.

Where cursor pagination is used, validate deterministic continuation semantics.

---

## 12. Idempotency and Concurrency Tests

Create tests for idempotent operations.

Cover suitable operations such as:

* save/unsave
* contribution submission
* review submission
* report submission
* media registration
* notification mutations
* route requests where contractually idempotent
* navigation-session operations

Test:

* same request repeated
* same idempotency key with identical payload
* same key with different payload
* concurrent duplicate requests
* timeout followed by retry

Verify the backend does not create duplicate resources or inconsistent state.

---

## 13. Geospatial Contract Tests

Implement dedicated geospatial correctness tests.

Cover:

* latitude/longitude order
* coordinate bounds
* geometry validity
* point geometry
* line geometry
* polygon geometry
* multipolygon behavior where supported
* GeoJSON serialization
* geometry round-trip integrity
* spatial reference conventions
* distance calculations
* bounding-box semantics
* radius searches
* intersection behavior
* proximity ordering

Include coordinates near:

* equator
* poles
* international date line
* hemisphere boundaries
* dense urban areas
* sparse rural areas

Ensure longitude/latitude are never accidentally swapped.

---

## 14. Geospatial Edge Cases

Test:

* antimeridian crossing
* polygons spanning multiple regions
* zero-distance queries
* very small radius
* very large radius
* empty geometry
* invalid geometry
* duplicate coordinates
* degenerate geometry
* precision loss
* high-precision coordinates

Any behavior that has intentional limits must be explicitly tested and documented.

---

## 15. Place and Geocoding Tests

Test core place and geocoding services.

Cover:

* place creation where supported
* lookup
* update
* lifecycle states
* nearby search
* bounding-box search
* forward geocoding
* reverse geocoding
* ambiguous addresses
* missing results
* source provenance
* deduplication
* merge handling
* dataset-version behavior

Verify that unpublished/deleted resources are handled according to the canonical lifecycle.

---

## 16. Search Contract Tests

Test the search service against its canonical contract.

Cover:

* exact place search
* partial query
* autocomplete
* address query
* category query
* localized query
* typo-tolerant query
* coordinate-biased search
* no-result behavior
* pagination
* index-unavailable behavior
* stale index behavior

Validate response structure rather than hardcoding one particular ranking order unless ranking order itself is an explicit deterministic contract.

---

## 17. Search Index Consistency Tests

Test synchronization between canonical place data and derived search indexes.

Cover:

* create → index
* update → reindex
* delete → removal
* merge → redirect/reindex
* repeated events
* out-of-order events
* stale events
* replay
* rebuild
* alias cutover

Verify that duplicate event delivery does not corrupt index state.

---

## 18. Tile and Map-Data Contract Tests

Validate the map-data API and tile contracts.

Cover:

* XYZ addressing
* supported zoom levels
* invalid tile coordinates
* MVT content type
* tile availability
* dataset version
* style references
* cache headers
* missing tiles
* stale dataset behavior
* publication transitions

Validate that public tile delivery never exposes private application data.

---

## 19. Routing Contract Tests

Test the routing API and canonical route model.

Cover:

* origin/destination validation
* travel modes
* waypoints
* alternatives
* constraints
* route geometry
* route distance
* duration
* ETA
* legs
* steps
* maneuvers
* warnings
* traffic enrichment
* route errors
* unsupported modes

Validate invariants such as:

* route geometry exists when required
* distances are non-negative
* durations are non-negative
* step ordering is deterministic
* leg ordering matches the request
* identifiers are stable
* route totals are internally consistent within documented tolerances

---

## 20. Routing-Engine Adapter Tests

Test the routing service's integration boundary to the selected routing engine.

Cover:

* request translation
* mode translation
* waypoint translation
* constraint translation
* geometry translation
* maneuver translation
* engine errors
* engine timeout
* engine unavailability
* malformed engine response
* version compatibility

Verify that provider/engine-specific representation does not leak into the canonical API contract.

---

## 21. Navigation-Session Tests

Test navigation-session backend behavior.

Cover:

* session creation
* route binding
* session state
* session expiration
* session close
* route-version changes
* sequence handling
* stale location events
* out-of-order events
* duplicate events
* malformed events
* invalid session identifiers

Test concurrent updates to the same session.

---

## 22. Realtime Protocol Tests

Implement contract tests for the navigation realtime protocol.

Cover:

* connection establishment
* authentication
* session binding
* heartbeat
* acknowledgement
* event delivery
* sequence validation
* reconnection
* duplicate suppression
* stale events
* unsupported event version
* malformed event
* authorization failure
* session termination

Verify that the server never accepts events that violate the canonical protocol.

---

## 23. Traffic and Incident Tests

Test traffic and incident services.

Cover:

* fresh traffic data
* stale traffic data
* unavailable traffic
* incident creation
* update
* expiration
* deletion
* duplicate feed records
* conflicting updates
* source provenance
* version transitions

Verify freshness metadata.

Do not represent stale data as current.

---

## 24. Transit Contract Tests

Test transit APIs and normalized transit models.

Cover:

* agencies
* stops
* stations
* routes
* trips
* stop times
* calendars
* transfers
* accessibility
* fares where supported
* journeys
* departures
* delays
* cancellations
* service alerts

Validate static-data/realtime-data interaction.

---

## 25. Event and Queue Contract Tests

Test asynchronous contracts.

Validate:

* event envelope
* event type
* schema version
* event ID
* aggregate/resource ID
* timestamp
* producer
* correlation ID
* payload
* ordering assumptions
* duplicate handling

For queues, test:

* successful processing
* retries
* visibility timeout
* dead-lettering
* duplicate delivery
* poison messages
* malformed messages
* idempotent consumers

---

## 26. Worker Processing Tests

Test representative asynchronous workers.

Cover:

* successful processing
* validation failure
* dependency failure
* timeout
* retry
* dead-letter behavior
* partial failure
* duplicate message
* restart during processing
* replay

Verify that failed processing does not silently lose data.

---

## 27. Media Contract Tests

Test media-service boundaries.

Cover:

* upload initialization
* authorization
* size limits
* MIME validation
* object ownership
* upload completion
* processing state
* rejection
* publication
* deletion
* signed-access expiration

Ensure private media cannot be accessed by unauthorized users.

---

## 28. Notification Contract Tests

Test notification-service behavior.

Cover:

* creation
* preference filtering
* deduplication
* delivery state
* retry
* provider failure
* invalid device token
* read/unread state
* notification pagination

Verify account isolation and correct channel preferences.

---

## 29. Audit and Security Event Tests

Test that security-sensitive operations produce the required audit events.

Cover:

* login
* logout
* session changes
* privilege changes
* administrative actions
* content moderation actions
* sensitive account changes
* security configuration changes

Verify:

* event identity
* actor
* target
* timestamp
* action
* outcome
* correlation
* non-sensitive payload design

Do not place credentials or raw secrets into audit events.

---

## 30. API Rate-Limit Tests

Validate rate limiting for relevant APIs.

Test:

* below-limit requests
* limit reached
* burst behavior
* authenticated limits
* unauthenticated limits
* endpoint-specific limits
* retry guidance
* distributed rate-limit consistency where applicable

Ensure rate limits produce the canonical error contract.

---

## 31. Cache-Consistency Tests

Test cache behavior where the backend uses Redis or equivalent caching.

Cover:

* cache hit
* cache miss
* expiry
* invalidation
* stale value
* concurrent refresh
* cache failure
* fallback to source of truth

Verify cache failures do not make the service return fabricated data.

---

## 32. Database Concurrency Tests

Test concurrency-sensitive backend operations.

Cover:

* simultaneous place updates
* saved-place mutation races
* list-order races
* review edits
* moderation transitions where exposed to service boundaries
* session updates
* idempotency records
* unique constraints
* optimistic/pessimistic locking semantics

Verify that concurrent operations result in a deterministic and contract-compliant outcome.

---

## 33. Data Integrity Tests

Test database constraints and business invariants.

Examples include:

* unique identifiers
* foreign-key integrity
* ownership integrity
* valid lifecycle transitions
* valid enum transitions
* non-negative quantities
* valid timestamps
* coordinate bounds
* valid visibility
* valid publication states

Test both valid and invalid mutation paths.

---

## 34. Security Test Foundation

Implement automated security-oriented tests for high-risk backend behavior.

Cover:

* authentication bypass attempts
* authorization bypass attempts
* horizontal access control
* vertical privilege escalation
* malformed input
* injection-resistant queries
* unsafe path handling
* SSRF-sensitive integrations where applicable
* object-access authorization
* rate limiting
* secret leakage in responses/logging
* unsafe error disclosure

Do not rely on one generic security scan.

Tests must target actual platform-specific attack surfaces.

---

## 35. Dependency and Configuration Test Hooks

Integrate automated validation for:

* dependency vulnerabilities
* secret detection
* unsafe configuration
* API-schema drift
* migration drift
* infrastructure contract drift

Do not disable scanners because they produce inconvenient results.

Classify findings and address actionable issues.

---

## 36. Test Environment Isolation

Ensure tests cannot accidentally target production infrastructure.

Implement explicit guards that reject production endpoints/credentials for automated test execution.

Use separate:

* databases
* object-storage locations
* queues
* topics
* search indexes
* credentials
* environment identifiers

where the architecture requires them.

---

## 37. CI Quality Gates

Add CI quality gates for the foundational QA suite.

At minimum, establish gates for:

* formatting
* type checking
* linting
* unit tests
* backend integration tests
* contract tests
* database migration tests
* geospatial tests
* event/queue tests
* security checks

Critical test failures must fail CI.

Do not make required tests informational merely to obtain green builds.

---

## 38. Coverage and Quality Metrics

Configure meaningful coverage reporting.

Track:

* statement coverage
* branch coverage
* function coverage
* line coverage
* contract coverage
* critical-path coverage

Do not treat one global percentage as sufficient.

Identify untested high-risk functionality.

Do not inflate coverage with trivial tests.

---

## 39. Flaky-Test Detection

Implement a process for identifying flaky tests.

Capture:

* test name
* execution environment
* failure type
* repeatability
* timing
* relevant logs/artifacts

Do not automatically quarantine important tests indefinitely.

Flaky tests must remain visible until addressed.

---

## 40. Test Failure Artifacts

Configure automated preservation of useful failure artifacts.

Examples:

* logs
* API request/response captures with secrets redacted
* database diagnostics
* event payloads with sensitive fields removed
* screenshots where applicable
* traces
* timing information
* test metadata

Never upload access tokens, credentials, private user content, or signed secrets as failure artifacts.

---

## 41. Documentation

Document:

* QA architecture
* test taxonomy
* local test execution
* CI test execution
* fixture conventions
* test database setup
* contract testing
* geospatial test strategy
* event/queue testing
* authentication test identities
* security test practices
* coverage expectations
* flaky-test policy
* debugging failed tests
* artifact collection
* environment-isolation rules

Documentation must describe actual test infrastructure.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement:

* complete browser end-to-end regression suite
* complete mobile end-to-end suite
* full accessibility certification
* large-scale load testing
* soak testing
* chaos engineering
* formal penetration testing
* full disaster-recovery exercises
* complete visual-regression program
* production canary validation
* organization-wide QA infrastructure unrelated to this project

Do not create placeholder versions of these systems.

Only establish foundational hooks where later QA prompts will build them.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect existing test runners.
2. Inspect unit-test configuration.
3. Inspect integration-test configuration.
4. Inspect API specifications.
5. Inspect generated types/schemas.
6. Inspect database migrations.
7. Inspect backend services.
8. Inspect PostgreSQL/PostGIS configuration.
9. Inspect Redis configuration.
10. Inspect search/indexing contracts.
11. Inspect routing contracts.
12. Inspect navigation/realtime contracts.
13. Inspect traffic and transit contracts.
14. Inspect event and queue contracts.
15. Inspect media and notification contracts.
16. Inspect authentication/session behavior.
17. Inspect existing CI/CD workflows.
18. Inspect security scanners.
19. Inspect existing fixtures and test utilities.
20. Inspect architecture and portable contract artifacts.

Reuse compatible test infrastructure.

Do not assume previous AI conversations or hidden test suites exist.

The repository and explicit contracts are the implementation sources of truth.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real tests.
* Do not use empty tests.
* Do not use assertions such as `expect(true).toBe(true)` to manufacture coverage.
* Do not disable tests to obtain green CI.
* Do not permanently skip critical paths.
* Do not rely on production infrastructure for automated tests.
* Keep test data deterministic.
* Keep tests isolated.
* Clean up test-created resources.
* Redact secrets from test artifacts.
* Do not use production credentials.
* Do not test geospatial correctness with fake spatial arithmetic when PostGIS behavior is the contract.
* Do not treat mocks as substitutes for contract validation.
* Use integration tests where behavior depends on real infrastructure semantics.
* Make asynchronous tests deterministic.
* Test duplicate and out-of-order delivery.
* Test failure and recovery paths.
* Test authorization explicitly.
* Test account isolation explicitly.
* Prevent tests from reaching production systems.
* Fail CI for critical regressions.
* Keep test duration reasonable without removing critical coverage.
* Document justified test doubles.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Run the unit-test suite.
* Run backend integration tests.
* Run contract tests.
* Run database migration tests.
* Run PostGIS/geospatial tests.
* Run authentication/session tests.
* Run authorization tests.
* Run idempotency/concurrency tests.
* Run search contract tests.
* Run routing contract tests.
* Run navigation/realtime contract tests.
* Run traffic/transit contract tests.
* Run event/queue tests.
* Run media/notification contract tests.
* Run security-oriented automated tests.
* Run linting.
* Run type checking.
* Generate coverage reports.
* Validate CI quality gates.
* Validate test-environment isolation.
* Confirm automated tests cannot target production.
* Review failures and resolve in-scope defects.
* Confirm test artifacts contain no secrets or private data.
* Validate QA documentation.

Do not report a passing test suite if tests were skipped, suppressed, or marked non-blocking without disclosure.

---

# EXPECTED DELIVERABLES

Produce the actual QA implementation and supporting artifacts.

Expected deliverables include, as applicable:

* test architecture
* test-runner configuration
* deterministic fixtures
* test utilities
* test database infrastructure
* migration validation
* API contract tests
* error-contract tests
* authentication tests
* authorization tests
* identity-isolation tests
* pagination tests
* idempotency tests
* concurrency tests
* geospatial tests
* place/geocoding tests
* search tests
* index-consistency tests
* tile contract tests
* routing tests
* navigation-session tests
* realtime protocol tests
* traffic/incident tests
* transit contract tests
* event/queue tests
* worker tests
* media tests
* notification tests
* audit-event tests
* rate-limit tests
* cache-consistency tests
* data-integrity tests
* security tests
* dependency/configuration validation
* CI quality gates
* coverage reporting
* flaky-test detection
* failure-artifact collection
* QA documentation

Do not artificially fragment tests solely to increase file count.

---

# INTEGRATION REQUIREMENTS

The QA foundation must support all future quality-engineering volumes.

Provide stable mechanisms for later testing of:

* web
* mobile
* backend
* APIs
* realtime
* geospatial workloads
* map rendering
* routing
* traffic
* transit
* user-generated content
* media
* notifications
* infrastructure

Keep contract definitions centralized.

Test utilities must not create a second incompatible interpretation of production schemas.

Fixtures must be reusable across later QA volumes.

CI quality gates must be extendable without redesigning the test architecture.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Test architecture implemented.
2. Test tooling implemented.
3. Deterministic fixtures implemented.
4. Test database infrastructure implemented.
5. Migration validation implemented.
6. API contract tests implemented.
7. Error-contract tests implemented.
8. Authentication/session tests implemented.
9. Authorization tests implemented.
10. Identity/resource-isolation tests implemented.
11. Pagination/filtering tests implemented.
12. Idempotency/concurrency tests implemented.
13. Geospatial tests implemented.
14. Place/geocoding tests implemented.
15. Search/index tests implemented.
16. Tile contract tests implemented.
17. Routing tests implemented.
18. Navigation/realtime tests implemented.
19. Traffic/incident tests implemented.
20. Transit contract tests implemented.
21. Event/queue tests implemented.
22. Worker tests implemented.
23. Media/notification tests implemented.
24. Audit/security tests implemented.
25. Rate-limit/cache tests implemented.
26. Data-integrity tests implemented.
27. CI quality gates implemented.
28. Coverage reporting implemented.
29. Flaky-test detection implemented.
30. Failure-artifact handling implemented.
31. Tests actually executed and outcomes.
32. Important implementation decisions or deviations.
33. Environment limitations encountered.
34. Exact files/modules/artifacts changed or created.
35. Documentation created or updated.

Do not claim a test or validation was executed unless it actually ran.

---

# DEFINITION OF DONE

This prompt is complete only when:

* A coherent automated QA architecture exists.
* Unit, integration, contract, database, event/queue, and geospatial test boundaries are explicit.
* Deterministic production-shaped fixtures exist.
* PostgreSQL/PostGIS-backed testing can reproduce meaningful production semantics.
* Database migrations are automatically validated.
* API contracts are automatically checked.
* Error responses follow the canonical contract.
* Authentication and session behavior is covered.
* Authorization and account isolation are explicitly tested.
* Pagination, idempotency, concurrency, and data-integrity behavior are covered.
* Geospatial coordinate and geometry semantics are thoroughly tested.
* Place and geocoding behavior is tested.
* Search and index synchronization are tested.
* Tile/map-data contracts are tested.
* Routing contracts and routing-engine boundaries are tested.
* Navigation-session and realtime protocols are tested.
* Traffic and transit contracts are tested.
* Event streams and queues are tested for duplicates, ordering, retries, and dead-letter behavior.
* Media and notification boundaries are tested.
* Security-sensitive backend behavior has automated coverage.
* Tests cannot accidentally target production infrastructure.
* Critical test failures block CI.
* Coverage reporting identifies meaningful gaps.
* Flaky tests remain visible and diagnosable.
* Failure artifacts are useful and privacy-safe.
* QA documentation reflects actual implementation.
* No fake tests, disabled critical assertions, hardcoded production credentials, TODO/FIXME test gaps, or placeholder quality gates remain in scope.

**Implement only the current prompt's scope.**
