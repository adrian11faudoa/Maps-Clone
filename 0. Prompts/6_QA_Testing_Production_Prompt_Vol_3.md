# Google Maps-Style Mapping & Navigation Platform — QA Prompt — Volume 3

# ROLE

Act as a senior quality engineering organization responsible for validating the scalability, performance, security, reliability, resilience, recovery, and operational correctness of a production-grade Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal QA Architect
* Performance Engineering Lead
* Load/Capacity Test Engineers
* Distributed Systems Test Engineers
* Geospatial Performance Engineers
* Navigation/Realtime Test Engineers
* Security Test Engineers
* Reliability/SRE Test Engineers
* Chaos/Resilience Engineers
* Database Performance Engineers
* Streaming Test Engineers
* Infrastructure Test Engineers
* Disaster-Recovery Test Engineers
* Observability Engineers
* Technical Writers

You are implementing and executing production-grade non-functional quality validation.

Do not produce superficial benchmarks, meaningless synthetic tests, fake resilience, placeholder security checks, disabled assertions, unrealistic load models, destructive production experiments, undocumented test assumptions, hardcoded production credentials, TODO/FIXME test gaps, or knowingly incomplete critical non-functional coverage.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Validate the platform's ability to remain secure, performant, observable, resilient, and recoverable at realistic production scale.

The platform includes:

* web applications
* mobile applications
* public APIs
* geospatial services
* search
* geocoding
* map/tile delivery
* routing
* navigation/realtime
* traffic
* transit
* user-generated content
* media
* notifications
* asynchronous workers
* event streams
* queues
* databases
* caches
* cloud infrastructure

This prompt focuses on non-functional validation that cannot be adequately established through ordinary unit, contract, or E2E testing alone.

Validate:

* latency
* throughput
* concurrency
* scalability
* resource saturation
* database performance
* cache behavior
* search performance
* geospatial query performance
* routing performance
* realtime navigation scale
* queue/event throughput
* media/notification worker throughput
* fault tolerance
* graceful degradation
* security posture
* backup/restore behavior
* disaster recovery
* operational observability

Do not test against production unless an explicit, safe, non-destructive production validation path already exists and the repository's operational policy permits it.

Prefer isolated environments with production-representative architecture and sanitized data.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the performance, capacity, security, resilience, and recovery QA system.

## 1. Non-Functional Test Architecture

Establish a coherent test architecture for:

* load testing
* stress testing
* spike testing
* soak testing
* capacity testing
* performance regression
* security testing
* resilience testing
* chaos testing where safe
* backup/restore validation
* disaster-recovery testing
* operational verification

Define:

* test environments
* test data
* traffic models
* workload profiles
* success criteria
* observability requirements
* safety limits
* test scheduling
* result retention
* comparison methodology

Each test must have a documented purpose and measurable outcome.

---

## 2. Production-Representative Test Environments

Create or adapt isolated environments suitable for non-functional validation.

The environment must reproduce meaningful aspects of production, including where practical:

* API topology
* Kubernetes/runtime topology
* database configuration
* Redis
* search
* queues
* event streams
* object storage
* CDN/edge behavior
* routing runtime
* realtime navigation
* tile delivery
* traffic/transit workloads
* observability

Do not assume a single developer laptop can represent production-scale behavior.

Document any material differences between test and production environments.

---

## 3. Realistic Workload Modeling

Create production-shaped workload profiles.

Represent traffic such as:

* map browsing
* place search
* autocomplete
* place details
* geocoding
* reverse geocoding
* nearby search
* directions
* route calculation
* active navigation
* realtime location updates
* traffic requests
* transit queries
* saved-content reads/writes
* reviews/contributions
* media uploads
* notification retrieval

Include realistic mixes rather than testing one endpoint in isolation only.

Document assumptions for:

* request rates
* geographic distribution
* client mix
* peak periods
* cacheability
* payload sizes
* route complexity
* concurrent sessions
* event volume
* queue backlog

Do not invent unrealistically favorable workloads.

---

## 4. Baseline Performance Tests

Establish baseline performance measurements for critical services.

Measure:

* p50 latency
* p95 latency
* p99 latency
* throughput
* error rate
* CPU
* memory
* network
* database connections
* cache utilization
* queue depth
* stream lag

Establish baselines for:

* public APIs
* search
* geocoding
* routing
* navigation/realtime
* tile delivery
* transit
* media processing
* notification processing

Store results in a repeatable format suitable for regression comparison.

---

## 5. API Load Testing

Implement load tests for critical API surfaces.

Cover:

* authentication/session endpoints
* place lookup
* nearby search
* search/autocomplete
* geocoding
* reverse geocoding
* saved content
* reviews
* contributions
* notifications
* directions
* route retrieval
* traffic
* transit

Validate:

* latency distribution
* throughput
* error behavior
* rate limits
* dependency saturation
* scaling behavior

Do not generate unrealistic uniform traffic if production traffic is expected to be highly skewed.

---

## 6. Geospatial Query Performance

Test PostGIS-backed workloads at realistic data volumes.

Measure:

* proximity search
* bounding-box search
* radius queries
* point lookup
* polygon intersection
* place lookup
* reverse-geocoding queries
* spatial filtering
* spatial ordering

Test across different spatial densities:

* dense urban areas
* medium-density regions
* rural regions
* international-scale datasets

Measure the effects of:

* spatial indexes
* cold cache
* warm cache
* concurrent queries
* large result sets
* difficult geometries

Identify query plans or index behavior responsible for material regressions.

---

## 7. Search Performance

Test search under production-shaped load.

Cover:

* autocomplete
* exact search
* fuzzy search
* address search
* category search
* geographic bias
* multilingual queries

Measure:

* query latency
* throughput
* indexing lag
* refresh behavior
* cluster CPU/memory
* heap pressure
* shard behavior
* cache effectiveness

Test both:

* read-heavy search traffic
* concurrent index updates

Search indexing workloads must not cause unacceptable user-facing degradation.

---

## 8. Tile Delivery Performance

Test vector-tile serving at realistic geographic and zoom distributions.

Measure:

* tile latency
* cache hit rate
* cache miss behavior
* origin load
* CDN performance
* response size
* compression
* concurrent requests
* regional variation

Test:

* popular cities
* low-density areas
* high zoom
* low zoom
* cache-warm conditions
* cache-cold conditions

Verify that cache miss storms do not overwhelm origin infrastructure.

---

## 9. Routing Performance

Test routing under realistic workloads.

Include:

* short routes
* long routes
* multiple waypoints
* alternative routes
* different travel modes
* traffic-aware routing
* difficult geography
* dense urban networks
* rural networks

Measure:

* route latency
* throughput
* CPU/memory
* graph loading
* cache behavior
* engine concurrency
* timeout rate
* queueing

Validate that complex route requests cannot starve simple requests.

---

## 10. Routing Capacity and Saturation

Determine practical capacity limits for routing services.

Test increasing concurrency until:

* latency degrades materially
* timeouts increase
* CPU saturates
* memory pressure occurs
* queueing becomes excessive

Identify safe operating ranges.

Do not present a single maximum throughput number without documenting:

* hardware/configuration
* route mix
* graph version
* request distribution
* cache state
* concurrency
* measurement methodology

---

## 11. Realtime Navigation Scale Testing

Validate high-concurrency navigation sessions.

Simulate:

* large numbers of connected navigation sessions
* location updates
* heartbeats
* route updates
* ETA changes
* traffic changes
* reconnects
* session termination

Measure:

* active connections
* messages per second
* connection latency
* event delivery latency
* reconnect rate
* CPU/memory
* network
* Redis pressure
* stream lag

Validate behavior during connection bursts.

---

## 12. Realtime Connection-Storm Testing

Test controlled connection spikes such as:

* large application restart
* regional network restoration
* service reconnect
* mobile radio transition
* load-balancer recovery

Verify:

* bounded reconnect behavior
* jitter
* connection admission
* graceful degradation
* no broker/Redis overload
* no cascading service failures

The platform must not collapse because a large number of clients reconnect simultaneously.

---

## 13. Location-Event Throughput Testing

Test high-volume location ingestion.

Generate realistic:

* location frequency
* device concurrency
* geographic distribution
* accuracy variation
* duplicate events
* delayed events
* out-of-order events

Measure:

* ingestion throughput
* processing latency
* stream lag
* worker utilization
* map-matching latency
* storage pressure
* downstream event generation

Do not use unlimited retained raw test telemetry.

Clean up generated datasets after the test.

---

## 14. Traffic and Transit Performance

Test traffic and transit ingestion/publication under realistic update rates.

Measure:

* feed-processing latency
* update throughput
* validation overhead
* publication latency
* freshness
* stale-data handling
* worker scaling
* queue depth

Simulate bursts caused by:

* provider feed refresh
* service disruption
* major traffic events
* transit schedule changes

---

## 15. Queue and Worker Load Testing

Test asynchronous workers.

Cover:

* media processing
* notification delivery
* bulk indexing
* tile generation
* dataset ingestion
* traffic/transit processing
* scheduled maintenance

Measure:

* throughput
* job latency
* queue depth
* retry rate
* dead-letter rate
* worker CPU/memory
* autoscaling response

Validate that poison messages do not consume unlimited worker capacity.

---

## 16. Event-Streaming Performance

Test Kafka/Redpanda or equivalent event infrastructure.

Measure:

* producer throughput
* consumer throughput
* partition utilization
* consumer lag
* rebalance behavior
* retention pressure
* batch size effects
* concurrent consumer groups

Test realistic event mixes for:

* places
* search indexing
* navigation
* location processing
* traffic
* transit
* media
* notifications

Do not test only synthetic single-topic workloads.

---

## 17. Database Performance and Saturation

Test:

* connection pool exhaustion
* CPU saturation
* storage saturation
* lock contention
* long transactions
* replication lag
* vacuum pressure
* index maintenance
* query concurrency

Validate behavior under:

* normal load
* peak load
* heavy write periods
* batch operations
* mixed read/write workloads

Ensure application behavior degrades predictably before the database becomes completely unavailable.

---

## 18. Cache Performance

Test Redis behavior under:

* high read volume
* high write volume
* cache stampede
* key expiration bursts
* invalidation storms
* connection saturation
* memory pressure

Measure:

* hit rate
* miss rate
* command latency
* memory utilization
* evictions
* replication/failover behavior

Verify cache failure does not cause uncontrolled downstream overload.

---

## 19. Autoscaling Validation

Test horizontal autoscaling for:

* APIs
* search
* routing
* realtime gateways
* workers
* stream consumers
* tile generation

Measure:

* scale-up latency
* scale-down behavior
* oscillation
* cold-start impact
* capacity recovery
* dependency saturation

Test workloads near configured thresholds.

Ensure autoscaling does not simply move the bottleneck to PostgreSQL, Redis, Kafka, or an external provider.

---

## 20. Performance Regression Testing

Create repeatable performance-regression suites.

Compare current measurements against established baselines.

Detect regressions in:

* latency
* throughput
* memory
* CPU
* database load
* cache hit rate
* queue latency
* stream lag
* startup time

Require explicit review for material regressions.

Do not fail every minor measurement fluctuation as a regression.

Use documented tolerance bands.

---

## 21. Stress Testing

Push selected services beyond expected operating levels in isolated environments.

Identify:

* graceful degradation point
* saturation point
* failure mode
* recovery behavior
* limiting resource
* protective controls

Services to stress include:

* API gateways
* search
* routing
* realtime
* PostGIS
* Redis
* event streaming
* queues

Do not stress production systems destructively.

---

## 22. Spike Testing

Test sudden load changes.

Examples:

* 10× request burst
* traffic-event surge
* large map-tile cache miss
* routing demand spike
* mass reconnect
* notification campaign
* transit disruption
* search popularity spike

Validate:

* latency
* errors
* autoscaling
* queue growth
* recovery time
* downstream dependency behavior

---

## 23. Soak Testing

Implement long-running tests for critical services.

Run extended workloads to identify:

* memory leaks
* connection leaks
* file-descriptor exhaustion
* timer/listener leaks
* cache growth
* queue instability
* gradual latency degradation
* cumulative resource exhaustion

Perform soak testing on:

* APIs
* realtime
* routing
* search
* workers
* streaming

Clean up all generated test resources afterward.

---

## 24. Mobile and Web Performance Testing

Validate client-side performance under realistic conditions.

Measure:

### Web

* startup
* initial render
* map readiness
* search responsiveness
* route rendering
* navigation updates
* memory usage

### Mobile

* cold start
* warm start
* map startup
* location-update overhead
* navigation UI responsiveness
* battery impact
* memory
* long-session stability

Test representative lower-resource devices.

Do not use only high-end developer hardware.

---

## 25. Network-Condition Testing

Test clients and services under:

* high latency
* low bandwidth
* packet loss
* connection resets
* intermittent connectivity
* DNS failures
* regional endpoint unavailability

Validate:

* retry behavior
* timeouts
* backoff
* user-visible degradation
* navigation continuity
* offline-safe state
* recovery

Do not let retries create a feedback loop during network failure.

---

## 26. Security Test Program

Implement an automated security validation suite covering:

* authentication bypass
* authorization bypass
* horizontal privilege escalation
* vertical privilege escalation
* object-level authorization
* injection resistance
* unsafe serialization
* SSRF-sensitive paths
* file-upload security
* signed-URL handling
* token exposure
* secret exposure
* rate-limit bypass
* abuse of expensive endpoints

Use realistic application-specific attack scenarios.

Do not rely only on generic dependency scanners.

---

## 27. API Fuzz Testing

Introduce controlled fuzzing against high-risk API boundaries.

Target:

* search
* geocoding
* route requests
* place updates
* contributions
* reviews
* reports
* media metadata
* notification payloads
* realtime messages

Generate malformed but protocol-valid and invalid inputs.

Verify:

* safe rejection
* stable errors
* no crashes
* no information leakage
* no privilege escalation
* no uncontrolled resource consumption

---

## 28. Realtime Protocol Security Testing

Test the realtime navigation protocol for:

* unauthorized session binding
* cross-session event injection
* invalid sequence manipulation
* replay
* duplicate messages
* oversized payloads
* malformed events
* unauthorized route updates
* connection exhaustion
* authentication expiration abuse

Verify that a client cannot affect another navigation session.

---

## 29. Media Security Testing

Test:

* malicious file types
* spoofed MIME types
* oversized files
* decompression/resource abuse
* malformed images
* dangerous filenames
* unauthorized object access
* signed URL expiration
* deletion authorization

Verify media processing workers remain isolated when malformed data is supplied.

---

## 30. Privacy Testing

Validate privacy protections around:

* precise location
* search history
* saved places
* private notes
* drafts
* notification data
* account information
* device identifiers

Ensure sensitive data does not leak through:

* logs
* metrics
* traces
* analytics
* test artifacts
* error payloads
* cache keys
* public object storage

---

## 31. Rate-Limit and Abuse Testing

Stress security controls around expensive or abuse-prone operations.

Test:

* search
* autocomplete
* geocoding
* routing
* reverse geocoding
* contribution submission
* review submission
* reports
* media uploads
* authentication
* notification operations
* realtime connections

Verify:

* limits trigger correctly
* legitimate traffic is not permanently blocked
* distributed limits behave consistently
* errors follow the canonical contract

---

## 32. Dependency and Supply-Chain Testing

Automate validation for:

* vulnerable dependencies
* malicious dependency indicators
* container vulnerabilities
* infrastructure misconfiguration
* secret leakage
* artifact provenance
* unsigned/untrusted artifacts where signing is required

Integrate findings into CI/CD.

Do not ignore severe vulnerabilities merely because the affected package is transitive.

---

## 33. Container and Runtime Security

Validate:

* container privileges
* filesystem permissions
* Linux capabilities
* root execution
* network exposure
* secret mounting
* service-account permissions
* workload isolation
* admission policies

Use least privilege.

Any privileged exception must be explicitly justified and documented.

---

## 34. Resilience Testing

Validate behavior when dependencies fail.

Simulate controlled failures of:

* PostgreSQL
* Redis
* search
* Kafka/Redpanda
* queues
* object storage
* routing engine
* map-matching service
* traffic provider
* transit provider
* notification provider
* DNS
* CDN/edge
* authentication dependency

Verify:

* graceful degradation
* clear error responses
* retry boundaries
* circuit behavior
* fallback behavior where contractually defined
* recovery

---

## 35. Dependency-Failure Matrix

Create a matrix covering each important dependency and its expected impact.

For every dependency document:

* normal state
* failure state
* affected services
* expected user behavior
* retry behavior
* fallback behavior
* data-loss risk
* recovery process
* alert
* SLO impact

Do not claim resilience where the application simply fails silently.

---

## 36. Chaos Testing

Implement controlled chaos experiments in isolated environments.

Potential experiments include:

* terminating API instances
* restarting workers
* restarting realtime nodes
* draining Kubernetes nodes
* introducing network latency
* blocking a dependency
* terminating a Redis connection
* pausing a queue consumer
* introducing broker partition imbalance
* restarting search nodes
* simulating database replica loss

Experiments must have:

* hypothesis
* safety boundary
* expected result
* abort condition
* observability
* recovery process
* result record

Do not perform destructive chaos experiments against production without an explicitly approved safe production-experiment program.

---

## 37. Graceful-Degradation Testing

Verify user-visible behavior when non-critical functionality fails.

Examples:

* traffic unavailable but base routing works
* search index delayed but place lookup works
* notifications unavailable but account access works
* media processing delayed but upload status is visible
* transit realtime unavailable but static schedules remain available
* analytics unavailable without breaking primary product flows

Do not fabricate unavailable data.

---

## 38. Recovery-Time Testing

Measure recovery for representative failures.

Track:

* detection time
* operator/system response
* restoration time
* service recovery
* data recovery
* backlog recovery
* cache warm-up
* event replay time

Compare results to documented recovery targets.

Do not silently redefine targets after the test.

---

## 39. Backup and Restore Validation

Execute controlled restoration tests for:

* PostgreSQL
* critical object storage
* configuration/state
* event-related recovery artifacts
* routing graph artifacts
* tile datasets
* search reconstruction

Validate:

* restored integrity
* version correctness
* application compatibility
* data completeness
* recovery duration

Record actual results.

A successful backup job alone is not sufficient evidence of recoverability.

---

## 40. Disaster-Recovery Exercises

Conduct controlled DR exercises for critical services.

Test scenarios such as:

* database failure
* regional workload loss
* Kubernetes cluster loss
* object-storage failure
* search-cluster loss
* event-stream disruption
* routing-artifact loss
* tile-artifact loss

Validate:

* recovery sequence
* dependency ordering
* DNS/traffic failover
* data restoration
* artifact republishing
* client behavior
* observability
* operator runbooks

Do not claim complete regional disaster recovery unless the entire tested recovery path actually works.

---

## 41. Eventual-Consistency Validation

Test distributed workflows for temporary inconsistency.

Examples:

* place update → search index
* contribution submission → moderation state
* media upload → publication
* notification creation → delivery
* traffic update → routing
* transit update → journey result

Measure:

* propagation latency
* stale duration
* duplicate behavior
* recovery after lag

Verify that user-facing systems do not expose dangerous or unauthorized stale state.

---

## 42. Data-Loss and Duplication Testing

Validate failure scenarios involving:

* retries
* worker crashes
* duplicate events
* network timeouts
* partial writes
* consumer restarts
* queue redelivery
* interrupted uploads

Measure whether the system produces:

* lost records
* duplicate records
* inconsistent state
* orphaned resources

Where duplicates are intentionally allowed, verify they remain within defined semantics.

---

## 43. Observability Validation

Test whether monitoring detects real failures.

For each major failure/performance scenario, verify:

* metric changes
* logs
* traces
* dashboard visibility
* alert triggering
* correlation IDs
* incident context

An alert is not considered effective merely because it exists.

It must trigger under a realistic failure condition.

---

## 44. Alert-Fidelity Testing

Evaluate alerts for:

* detection speed
* false positives
* false negatives
* duplicate paging
* missing dependency context
* inadequate severity
* unclear remediation

Ensure critical service failures page according to the documented escalation model.

Avoid alert storms during correlated failures.

---

## 45. SLO Validation

Validate documented SLOs against realistic workloads.

For each major service measure:

* availability
* latency
* error rate
* freshness
* processing delay

Calculate error-budget consumption under:

* normal load
* peak load
* dependency degradation
* incident scenarios

Do not redefine the SLO simply because the measured result is poor.

---

## 46. Capacity and Headroom Analysis

Determine practical operating headroom for critical resources.

Analyze:

* API capacity
* database capacity
* Redis capacity
* broker capacity
* search capacity
* routing capacity
* realtime capacity
* worker capacity
* tile-generation capacity
* object storage
* egress
* observability systems

Identify:

* current tested capacity
* sustainable capacity
* saturation point
* recommended operating range
* dominant bottleneck
* scaling action

Keep conclusions tied to measured test conditions.

---

## 47. Performance Test Data Management

Manage generated performance-test data safely.

Provide:

* seeded geographic datasets
* sanitized user data
* synthetic traffic
* synthetic navigation sessions
* synthetic transit feeds
* synthetic media
* synthetic notifications

Use identifiable non-production markers.

Ensure generated data can be removed or expired.

Do not mix test data with production user records.

---

## 48. Test Result Storage and Comparison

Create durable storage for non-functional test results.

Capture:

* test identifier
* code version
* infrastructure version
* dataset version
* configuration
* workload
* environment
* date/time
* duration
* measurements
* failures
* anomalies
* conclusions

Enable comparison across releases.

Do not compare performance numbers without accounting for environment/configuration differences.

---

## 49. CI/CD Integration

Integrate non-functional validation at appropriate stages.

Use:

* lightweight performance smoke tests for pull requests where practical
* contract/performance checks for important merges
* scheduled load tests
* scheduled soak tests
* scheduled security testing
* pre-release capacity testing
* release-candidate resilience tests

Expensive destructive or long-running tests must not block every trivial code change unless explicitly justified.

Critical regressions must remain visible.

---

## 50. Release-Gating Criteria

Define evidence-based gates for:

* severe performance regression
* unacceptable error rate
* security vulnerability
* data-loss regression
* resilience regression
* failed restore
* failed critical SLO
* capacity exhaustion

Gates must be tied to documented project requirements.

Do not create arbitrary universal thresholds without considering workload and environment.

---

## 51. Security-Test Reporting

Produce structured security findings with:

* affected component
* test case
* attack scenario
* evidence
* severity according to the project's security taxonomy
* reproducibility
* mitigation status
* regression test

Do not hide security findings because they are inconvenient for release schedules.

Do not expose sensitive exploit artifacts outside authorized test environments.

---

## 52. Performance and Reliability Documentation

Create or update documentation for:

* load models
* performance baselines
* capacity methodology
* test environments
* security test boundaries
* resilience matrix
* chaos experiments
* backup/restore testing
* DR exercises
* SLO validation
* alert validation
* result interpretation
* release gates
* troubleshooting
* limitations

Documentation must state actual measured results and environment conditions.

---

# EXPLICIT OUT-OF-SCOPE

Do not perform:

* destructive tests against production
* unauthorized penetration testing
* attacks against third-party systems
* uncontrolled denial-of-service testing
* irreversible data-destruction experiments
* production credential harvesting
* real-user privacy testing using actual private user data
* unapproved chaos experiments in production
* unsupported claims of formal certification
* unsupported compliance certification
* permanent disabling of security or reliability controls

A production validation path may be used only when an already-authorized, explicitly safe mechanism exists.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect existing performance-test tooling.
2. Inspect load-test frameworks.
3. Inspect benchmark suites.
4. Inspect infrastructure environments.
5. Inspect monitoring and observability configuration.
6. Inspect service-level objectives.
7. Inspect API traffic profiles if available.
8. Inspect database performance tooling.
9. Inspect Redis monitoring.
10. Inspect search performance tooling.
11. Inspect routing performance configuration.
12. Inspect realtime connection infrastructure.
13. Inspect queue/event-streaming monitoring.
14. Inspect security scanning and test tooling.
15. Inspect backup/restore automation.
16. Inspect disaster-recovery runbooks.
17. Inspect CI/CD workflows.
18. Inspect test-result storage.
19. Inspect existing performance/security baselines.
20. Inspect architecture artifacts containing scale assumptions, workload characteristics, SLOs, recovery targets, data-retention rules, and critical dependencies.

Reuse compatible infrastructure.

Do not assume previous AI conversations or hidden benchmark suites exist.

Do not replace functioning test infrastructure unnecessarily.

The repository and explicit portable architecture/contract artifacts are the sources of truth available to this implementation.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Use isolated non-production environments.
* Do not target production with destructive workloads.
* Use realistic traffic models.
* Record workload assumptions.
* Keep test data deterministic.
* Keep generated data isolated and removable.
* Measure p50/p95/p99 where meaningful.
* Measure both throughput and resource utilization.
* Test cold and warm cache conditions when relevant.
* Test concurrency, not only single-request latency.
* Test failure and recovery.
* Test dependency saturation.
* Do not hide bottlenecks through artificial mocks in performance tests of the target system.
* Use realistic infrastructure for infrastructure performance tests.
* Do not call a test "scalable" because it passed one fixed load.
* Do not call a system "resilient" because one instance restarted successfully.
* Do not call a backup "verified" without restoring it.
* Do not call an alert "effective" without triggering it.
* Do not call a security control effective without exercising the relevant attack path.
* Do not commit real credentials.
* Redact sensitive values from results.
* Do not expose private location traces.
* Keep experiment safety limits explicit.
* Abort experiments when safety conditions are violated.
* Keep chaos experiments reversible.
* Preserve observability during testing.
* Document environment differences.
* Treat severe findings as release-impacting until dispositioned according to project policy.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Validate the non-functional test infrastructure.
* Execute API performance baselines.
* Execute geospatial performance tests.
* Execute search performance tests.
* Execute tile-delivery tests.
* Execute routing performance tests.
* Execute realtime navigation scale tests.
* Execute location-event throughput tests.
* Execute traffic/transit processing tests.
* Execute worker/queue tests.
* Execute event-streaming tests.
* Execute database saturation tests.
* Execute cache tests.
* Execute autoscaling tests.
* Execute performance-regression tests.
* Execute stress tests where safe.
* Execute spike tests.
* Execute soak tests where scheduled.
* Execute web/mobile performance tests where environments permit.
* Execute network-condition tests.
* Execute application-security tests.
* Execute API fuzz tests.
* Execute realtime security tests.
* Execute media-security tests.
* Execute privacy tests.
* Execute rate-limit/abuse tests.
* Execute dependency/supply-chain validation.
* Execute runtime/container security validation.
* Execute resilience tests.
* Execute dependency-failure tests.
* Execute controlled chaos experiments where authorized.
* Execute graceful-degradation tests.
* Execute recovery-time measurements.
* Execute backup/restore validation.
* Execute DR exercises where executable.
* Execute eventual-consistency validation.
* Execute data-loss/duplication tests.
* Validate observability.
* Validate alert fidelity.
* Validate SLO behavior.
* Validate capacity/headroom measurements.
* Validate result storage and comparison.
* Validate CI/CD integration.
* Validate release gates.
* Confirm no production credentials or private production data were used.
* Document actual results and limitations.

Resolve in-scope defects discovered during validation.

Do not claim a performance, security, resilience, backup, or DR test passed unless it actually executed and produced supporting evidence.

---

# EXPECTED DELIVERABLES

Produce the actual non-functional QA implementation and supporting artifacts.

Expected deliverables include, as applicable:

* load-test framework
* workload profiles
* performance baselines
* API load tests
* geospatial benchmarks
* search benchmarks
* tile benchmarks
* routing benchmarks
* realtime-scale tests
* location-throughput tests
* traffic/transit performance tests
* worker/queue load tests
* event-stream tests
* database saturation tests
* cache tests
* autoscaling tests
* performance-regression suite
* stress tests
* spike tests
* soak tests
* web/mobile performance tests
* network-condition tests
* security test suite
* API fuzz tests
* realtime security tests
* media-security tests
* privacy tests
* rate-limit/abuse tests
* supply-chain validation
* runtime security validation
* resilience suite
* dependency-failure matrix
* chaos experiments
* graceful-degradation tests
* recovery-time tests
* backup/restore tests
* disaster-recovery exercises
* eventual-consistency tests
* data-loss/duplication tests
* observability validation
* alert-fidelity tests
* SLO validation
* capacity/headroom analysis
* test-data management
* result storage/comparison
* CI/CD integration
* release gates
* security reports
* performance/reliability documentation

Do not artificially split test assets merely to increase file count.

---

# INTEGRATION REQUIREMENTS

The non-functional QA system must integrate with the existing:

* application test infrastructure
* infrastructure-as-code
* CI/CD
* observability
* service contracts
* deployment environments
* test-data lifecycle

Performance tests must be able to identify which:

* application version
* infrastructure version
* dataset version
* routing graph version
* tile version
* search index version

was under test.

Security and resilience tests must exercise the real service boundaries.

Result artifacts must be machine-readable where practical so future automation can compare:

* latency
* throughput
* resource utilization
* error rates
* recovery duration
* security findings
* SLO behavior

Do not require future QA work to reverse-engineer test assumptions.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Non-functional test architecture implemented.
2. Representative test environment implemented.
3. Workload models implemented.
4. Performance baselines established.
5. API load tests implemented.
6. Geospatial performance tests implemented.
7. Search performance tests implemented.
8. Tile performance tests implemented.
9. Routing performance/capacity tests implemented.
10. Realtime navigation scale tests implemented.
11. Location-event throughput tests implemented.
12. Traffic/transit performance tests implemented.
13. Queue/worker performance tests implemented.
14. Event-streaming performance tests implemented.
15. Database performance tests implemented.
16. Cache performance tests implemented.
17. Autoscaling tests implemented.
18. Performance regression tests implemented.
19. Stress/spike/soak tests implemented where applicable.
20. Web/mobile performance tests implemented where applicable.
21. Network-condition tests implemented.
22. Security test program implemented.
23. API fuzz testing implemented.
24. Realtime protocol security tests implemented.
25. Media/privacy/rate-limit security tests implemented.
26. Supply-chain/runtime security validation implemented.
27. Resilience tests implemented.
28. Dependency-failure matrix implemented.
29. Chaos tests implemented where authorized.
30. Graceful-degradation tests implemented.
31. Recovery-time testing implemented.
32. Backup/restore validation implemented.
33. Disaster-recovery exercises implemented where executable.
34. Consistency/data-loss/duplication testing implemented.
35. Observability validation implemented.
36. Alert-fidelity validation implemented.
37. SLO validation implemented.
38. Capacity/headroom analysis implemented.
39. Test-data management implemented.
40. Result storage/comparison implemented.
41. CI/CD integration implemented.
42. Release gates implemented.
43. Security reports created.
44. Performance/reliability documentation created or updated.
45. Tests actually executed and outcomes.
46. Environment limitations encountered.
47. Important implementation decisions or deviations.
48. Exact files/modules/artifacts changed or created.

Do not claim test execution that did not occur.

---

# DEFINITION OF DONE

This prompt is complete only when:

* A repeatable non-functional QA architecture exists.
* Test environments are isolated and sufficiently production-representative.
* Realistic workload models exist for the platform's major user journeys and infrastructure workloads.
* Performance baselines are established for critical services.
* API, geospatial, search, tile, routing, realtime, traffic, transit, worker, streaming, database, and cache performance are measurable.
* Routing and realtime systems have realistic capacity tests.
* Autoscaling behavior has been validated.
* Performance regressions can be detected across releases.
* Stress, spike, and soak testing exist for appropriate critical systems.
* Web and mobile performance has measurable coverage where environments permit.
* Network degradation behavior is validated.
* Security testing covers application-specific attack surfaces.
* High-risk API boundaries have fuzz coverage.
* Realtime navigation protocol security is tested.
* Media, privacy, rate-limit, dependency, container, and runtime security controls are exercised.
* Dependency failures have defined and tested behavior.
* Safe resilience/chaos experiments exist where appropriate.
* Graceful degradation is verified for non-critical dependency failures.
* Recovery duration is measured for important incidents.
* Backups have been restored and validated where the environment permits.
* Disaster-recovery procedures have been exercised where executable.
* Eventual-consistency behavior is measurable.
* Data-loss and duplicate-processing scenarios are tested.
* Observability detects realistic failures.
* Alerts are validated under actual failure conditions.
* SLO behavior is measured under representative workloads.
* Capacity limits and headroom are documented from measured evidence.
* Test data is isolated, sanitized, and removable.
* Results are stored in a reproducible and comparable form.
* CI/CD integrates appropriate non-functional quality gates.
* Security and performance findings are traceable to evidence.
* Documentation reflects actual measured behavior and limitations.
* No destructive production testing, hardcoded credentials, disabled critical assertions, placeholder tests, or TODO/FIXME gaps remain within scope.

**Implement only the current prompt's scope.**
