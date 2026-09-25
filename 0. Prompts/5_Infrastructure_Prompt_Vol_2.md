# Google Maps-Style Mapping & Navigation Platform — Infrastructure Prompt — Volume 2

# ROLE

Act as a senior platform engineering organization responsible for implementing the specialized data-processing, geospatial-compute, routing, map-publication, realtime, workload-scaling, resilience, disaster-recovery, security-hardening, and operational automation infrastructure for a production-grade Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal Infrastructure Architect
* Senior Cloud Engineers
* Kubernetes Engineers
* Geospatial Infrastructure Engineers
* Data Platform Engineers
* Distributed Systems Engineers
* SREs
* Database Reliability Engineers
* Streaming Engineers
* Routing/Map Infrastructure Engineers
* Security Engineers
* Performance Engineers
* Disaster-Recovery Engineers
* FinOps Engineers
* CI/CD Engineers
* Technical Writers

You are implementing production infrastructure.

Do not produce pseudo-infrastructure, placeholder resources, fake data-processing jobs, simulated routing infrastructure, undocumented manual pipelines, hardcoded credentials, TODO/FIXME gaps, insecure defaults, or knowingly incomplete critical infrastructure paths.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Extend the platform infrastructure beyond the shared cloud/runtime foundation into the specialized infrastructure required to operate high-volume geospatial and realtime workloads.

This infrastructure must support:

* geographic data ingestion
* normalization and validation
* place-data publication
* geospatial processing
* search-index rebuilds
* vector-tile generation
* map-data publication
* routing graph preparation
* routing-engine execution
* map matching
* navigation/realtime workloads
* traffic ingestion and publication
* transit-feed ingestion and publication
* media processing
* notification workers
* scheduled maintenance
* large-scale background processing
* event replay
* controlled backfills
* disaster recovery
* capacity management
* production reliability

The platform must be capable of handling large spatial datasets and bursty workloads without allowing batch processing to destabilize latency-sensitive APIs or realtime navigation.

---

# CURRENT IMPLEMENTATION SCOPE

Implement specialized production infrastructure for geospatial pipelines, routing, map publication, realtime workloads, scheduled processing, resilience, and operational automation.

## 1. Geospatial Data-Ingestion Infrastructure

Implement infrastructure for importing large geographic datasets into controlled processing environments.

Support data sources such as:

* authoritative geographic datasets
* address datasets
* place datasets
* road-network datasets
* boundary datasets
* map feature datasets
* externally supplied geographic data feeds

Provide isolated ingestion workloads for:

* download
* integrity verification
* staging
* decompression
* validation
* normalization
* transformation
* quarantine
* publication

Use object storage as the durable staging boundary where appropriate.

Do not allow unvalidated source data to become automatically visible to production-serving systems.

---

## 2. Data-Quality and Validation Pipeline Infrastructure

Implement dedicated infrastructure for validating incoming geospatial data.

Support checks such as:

* schema validation
* file integrity
* coordinate-system validation
* geometry validity
* duplicate detection
* referential integrity
* required-field validation
* range validation
* geographic-boundary consistency
* dataset completeness
* record-count anomaly detection

Invalid or suspicious datasets must be isolated rather than silently published.

Provide measurable pipeline outcomes including:

* accepted records
* rejected records
* quarantined records
* warnings
* processing duration
* dataset version
* source version
* checksum

---

## 3. Dataset Versioning and Publication Infrastructure

Provide infrastructure that supports immutable dataset versions.

Implement:

* source dataset identifiers
* processing version
* publication version
* content checksums
* lineage metadata
* publication timestamps
* validation status
* promotion state
* rollback target

Production-serving services must be able to identify which published dataset version they are consuming.

Avoid mutable replacement of production data without an explicit version transition.

---

## 4. Geospatial Processing Workloads

Provision scalable worker infrastructure for computationally expensive geographic operations.

Support workloads such as:

* geometry normalization
* simplification
* clipping
* spatial joins
* indexing
* boundary processing
* road-network transformation
* place enrichment
* deduplication preparation
* geocoding dataset preparation
* tile-source preparation

Use dedicated worker pools where CPU, memory, storage, or temporary local disk requirements differ materially.

Do not allow large geospatial batch jobs to consume all capacity needed by latency-sensitive APIs.

---

## 5. PostGIS Operational Infrastructure

Extend the relational infrastructure with production operational capabilities for geospatial workloads.

Support:

* read replicas where justified
* controlled maintenance
* vacuum/analyze strategy
* index maintenance
* partition-management automation where used
* connection-pool protections
* long-running query monitoring
* lock monitoring
* storage growth monitoring
* replication monitoring
* geospatial index health monitoring

Provide operational safeguards for workloads performing:

* spatial intersection
* proximity search
* bounding-box queries
* geometry retrieval
* geocoding
* place lookup
* geographic feature processing

Do not redesign application schema or business logic.

---

## 6. Large-Scale Database Import/Export Infrastructure

Provide controlled infrastructure for:

* bulk imports
* bulk exports
* dataset snapshots
* large data migrations
* partition movement
* index rebuilds
* backfills

Support:

* temporary worker capacity
* isolated processing
* progress reporting
* resumability where practical
* checksums
* validation
* throttling
* failure recovery

Bulk operations must not unnecessarily destabilize production transactional workloads.

---

## 7. Search Index Infrastructure

Provide production infrastructure for large-scale search-index operations.

Support:

* index creation
* bulk ingestion
* parallel indexing
* index versioning
* alias management
* blue/green index replacement
* controlled reindexing
* partial rebuild
* full rebuild
* failed-batch retry
* stale-index detection
* index health monitoring

Provide infrastructure suitable for place search, autocomplete, address discovery, category discovery, and geographically relevant search.

Do not implement ranking logic here.

---

## 8. Search Rebuild and Recovery Infrastructure

Implement isolated worker capacity for:

* full index rebuilds
* incremental rebuilds
* replay from canonical event streams
* reprocessing after schema changes
* recovery from corrupted indexes

A rebuild must be capable of occurring without taking the public search API offline where the architecture supports blue/green cutover.

Implement controlled promotion of rebuilt indexes.

Do not permit incomplete indexes to become production-active.

---

## 9. Vector-Tile Generation Infrastructure

Implement the infrastructure required to create vector-tile datasets from published geographic data.

Support:

* tile-generation workers
* XYZ/tile-coordinate processing
* zoom-level partitioning
* spatial tiling
* geometry simplification
* clipping
* MVT generation
* tile validation
* tile packaging
* compression
* publication to object storage

Design workloads to scale by geographic region and/or zoom range.

Do not use application API servers to perform heavy tile-generation jobs.

---

## 10. Tile Publication and Promotion

Implement infrastructure supporting atomic publication of new tile datasets.

Support:

* tile dataset versioning
* generated-artifact checksums
* completeness validation
* metadata publication
* release manifests
* staged publication
* active-version pointer
* rollback
* cache invalidation integration
* CDN propagation

Prevent a partially generated tile dataset from becoming the active production dataset.

---

## 11. Routing Graph Build Infrastructure

Provision specialized infrastructure for creating routing-engine graph artifacts.

Support:

* road-network extraction
* graph construction
* preprocessing
* contraction/hierarchical preprocessing where the selected engine requires it
* profile-specific graph generation
* regional partitioning
* validation
* artifact packaging
* graph versioning
* checksums
* publication
* rollback

The routing engine must consume immutable graph artifacts.

Do not replace the selected routing engine with a homegrown algorithm.

---

## 12. Routing-Engine Runtime Infrastructure

Provision production runtime capacity for routing engines.

Support:

* geographic partitioning where appropriate
* dedicated routing node pools
* CPU/memory sizing
* local cache/storage where required
* warm startup behavior
* graph artifact loading
* readiness checks
* autoscaling
* concurrency controls
* request timeouts
* graceful replacement
* rolling upgrades

Separate routing workloads from ordinary API workloads where resource characteristics require it.

---

## 13. Map-Matching Runtime Infrastructure

Provision specialized infrastructure for high-volume map-matching workloads.

Support:

* dedicated worker/runtime pools
* low-latency request processing
* graph-version affinity
* autoscaling
* request concurrency controls
* health checks
* observability
* failure isolation

Ensure the map-matching service consumes compatible road-network versions.

Do not permit mismatched graph versions to produce silently inconsistent results.

---

## 14. Realtime Navigation Infrastructure

Extend the platform runtime for large numbers of concurrent navigation connections.

Support:

* WebSocket/realtime gateways
* connection-aware load balancing
* connection draining
* horizontal scaling
* sticky-session strategy only where truly required
* heartbeat configuration
* connection limits
* per-node capacity tracking
* graceful failover
* rolling deployment behavior

Design for high connection counts without making ordinary HTTP APIs dependent on the same resource pool.

---

## 15. Realtime Session Distribution

Provide infrastructure for distributing ephemeral navigation state.

Support:

* shared Redis/state infrastructure
* distributed coordination
* event propagation
* session ownership where applicable
* shard-aware distribution
* bounded session state
* session expiration
* failover

Avoid making one service instance the only authoritative holder of active navigation session state.

---

## 16. High-Volume Location Processing

Provision worker infrastructure for location-event processing.

Support:

* partitioned stream consumption
* parallel consumers
* backpressure
* batch processing
* lag monitoring
* autoscaling
* replay
* dead-letter/quarantine handling
* retention-aware processing

Workloads may include:

* map matching
* route-progress enrichment
* telemetry aggregation
* navigation analytics
* traffic-data derivation

Do not persist raw high-volume location telemetry indefinitely without a documented retention requirement.

---

## 17. Traffic Data Infrastructure

Provision infrastructure for traffic-data ingestion and publication.

Support sources such as:

* partner traffic feeds
* road-speed observations
* incident feeds
* road closures
* manually curated traffic events
* navigation-derived aggregate traffic signals where authorized

Provide:

* ingestion workers
* stream processing
* validation
* freshness monitoring
* deduplication support
* publication
* regional partitioning
* replay
* quarantine

Traffic infrastructure must distinguish between current, stale, and unavailable data.

---

## 18. Traffic Publication Infrastructure

Support publishing traffic state to services such as:

* routing
* navigation
* map overlays
* incident APIs

Implement:

* versioned traffic snapshots
* incremental updates where supported
* publication checkpoints
* freshness metadata
* rollback
* regional failure isolation

A failed traffic update must not destroy the last-known-good dataset unless explicitly required.

---

## 19. Transit Ingestion Infrastructure

Provision infrastructure for static and realtime transit-feed processing.

Support:

* GTFS ingestion
* GTFS-Realtime ingestion
* feed validation
* decompression
* normalization
* deduplication
* schedule transformation
* stop/station processing
* route/trip/calendar processing
* transfer processing
* accessibility metadata
* fare data
* shape data

Process transit feeds in isolated worker environments so malformed external feeds cannot destabilize core services.

---

## 20. Transit Publication Infrastructure

Support publication of validated transit datasets.

Provide:

* versioned feeds
* active-version pointers
* rollback
* freshness tracking
* feed health monitoring
* realtime-update publication
* partial-feed failure isolation

Do not publish an incomplete transit dataset as authoritative without an explicit degraded-data policy.

---

## 21. Batch Scheduling Infrastructure

Implement production scheduling infrastructure for recurring workloads.

Support jobs such as:

* dataset imports
* index maintenance
* tile generation
* routing-graph builds
* backup verification
* cleanup
* retention enforcement
* stale-resource cleanup
* report generation
* reconciliation
* periodic data-quality checks

Scheduled jobs must support:

* retry
* concurrency limits
* timeout
* cancellation
* failure notification
* execution history
* ownership

Prevent overlapping executions where jobs are not concurrency-safe.

---

## 22. Controlled Backfill Infrastructure

Provide infrastructure for large historical reprocessing tasks.

Support:

* scoped backfills
* partition/range selection
* throttling
* progress tracking
* resumability
* dry-run validation where appropriate
* checkpointing
* cancellation
* partial failure handling

Backfills must not automatically consume all production resources.

Provide explicit capacity controls.

---

## 23. Event Replay Infrastructure

Implement controlled replay capability for event-driven workloads.

Support:

* topic/partition selection
* time/range selection
* consumer-group isolation
* replay environment
* throttling
* replay checkpoints
* duplicate-safe processing
* monitoring

Replays must never accidentally publish test/replayed data to production consumers without an explicit controlled path.

---

## 24. Dead-Letter and Quarantine Operations

Create operational infrastructure for failed messages/data.

Support:

* dead-letter queues
* quarantined objects
* failure metadata
* retry count
* source identifier
* first-failure timestamp
* last-failure timestamp
* replay capability
* retention policy

Avoid silently discarding failed data.

Provide sufficient metadata to diagnose and recover the failure.

---

## 25. Media Processing Infrastructure

Provision specialized workers for user-media processing.

Support workloads such as:

* image normalization
* thumbnail generation
* metadata extraction
* format conversion
* safety-scan integration
* derivative generation
* lifecycle cleanup

Use isolated worker pools and bounded temporary storage.

Do not perform expensive processing synchronously on API instances.

---

## 26. Notification Worker Infrastructure

Provision scalable infrastructure for notification delivery.

Support:

* queue-based worker processing
* provider-specific worker pools where necessary
* retry
* exponential backoff
* dead-letter handling
* delivery-state recording
* provider timeout handling
* rate-limit handling
* concurrency controls

Separate provider failures from unrelated platform workloads.

---

## 27. External Provider Isolation

Where the platform integrates with:

* geocoding providers
* map-data providers
* routing providers
* notification providers
* media scanning providers
* external transit/traffic sources

provide infrastructure isolation for those dependencies.

Support:

* dedicated connection pools
* quotas
* circuit-breaking integration points
* timeout configuration
* usage monitoring
* credential isolation
* provider-specific rate limits
* fallback boundaries where contractually supported

Do not create automatic fallback behavior that changes semantics without an explicit architecture contract.

---

## 28. Workload Priority Classes

Implement infrastructure-level workload prioritization.

Differentiate between workloads such as:

* user-facing APIs
* active-navigation/realtime
* routing
* search
* tile delivery
* batch ingestion
* bulk indexing
* tile generation
* graph builds
* media processing
* notification processing
* analytics/background jobs

Latency-sensitive workloads must remain protected during large batch operations.

Implement priority and resource-isolation mechanisms appropriate to the selected runtime.

---

## 29. Capacity Management

Implement capacity planning and operational safeguards.

Monitor:

* CPU
* memory
* disk
* network
* database connections
* queue depth
* stream lag
* routing throughput
* map-matching throughput
* realtime connections
* object-storage growth
* search cluster capacity
* tile-generation capacity

Create explicit capacity thresholds.

Where the system approaches a hard platform limit, generate actionable alerts before service degradation occurs.

---

## 30. Autoscaling for Specialized Workloads

Implement workload-specific autoscaling.

Scale based on appropriate signals such as:

* API request rate
* realtime connection count
* queue depth
* stream lag
* routing request rate
* tile-generation backlog
* indexing backlog
* CPU/memory
* database saturation
* worker processing time

Avoid scaling from noisy metrics without stabilization.

Define sensible:

* minimum replicas
* maximum replicas
* scale-up behavior
* scale-down behavior
* cooldown/stabilization
* dependency protection

---

## 31. Pod and Node Isolation

Where Kubernetes is used, create workload-specific node pools and scheduling controls where justified.

Support:

* node selectors
* taints/tolerations
* affinity
* anti-affinity
* topology spread
* dedicated pools
* spot/preemptible capacity for interruptible workloads where appropriate
* on-demand capacity for latency-sensitive workloads

Do not schedule critical realtime workloads exclusively on interruptible capacity.

---

## 32. Storage Performance Classes

Define storage strategies for workload-specific requirements.

Support distinct storage profiles for:

* PostgreSQL
* search
* routing graph artifacts
* tile-generation temporary data
* media processing
* object-storage-backed artifacts
* observability data

Ensure high-I/O workloads do not unintentionally share undersized storage.

---

## 33. Disaster-Recovery Implementation

Move from the DR foundation established in Volume 1 to executable recovery infrastructure for critical platform services.

Support, according to the architecture:

* cross-zone recovery
* backup replication
* object-storage replication
* infrastructure recreation
* database restore automation
* search-index rebuild
* event-stream recovery strategy
* routing-artifact restoration
* tile-dataset restoration
* transit-dataset restoration
* DNS failover mechanisms

Define recovery priorities for:

* identity
* APIs
* geospatial services
* search
* routing
* navigation/realtime
* tiles
* transit
* user-generated content
* media
* notifications

Do not claim zero-data-loss or zero-downtime recovery unless the implemented architecture actually supports it.

---

## 34. Recovery Automation

Implement scripts/automation for operational recovery tasks such as:

* restoring databases
* recreating worker pools
* restoring object metadata
* rebuilding search indexes
* republishing tile datasets
* restoring routing graph artifacts
* replaying required event streams
* restarting failed processing pipelines

Recovery procedures must be deterministic and version-controlled.

Avoid runbooks that depend entirely on undocumented operator knowledge.

---

## 35. Backup-Restore Testing

Implement recurring infrastructure for restore verification.

Test:

* database restoration
* object retrieval
* search reconstruction
* configuration recovery
* critical artifact recovery

Record:

* restore duration
* restored version
* validation outcome
* failures
* remediation status

A backup that cannot be restored successfully must be treated as an operational defect.

---

## 36. Security Hardening

Harden the specialized infrastructure against:

* compromised workloads
* malicious data
* supply-chain attacks
* unauthorized dataset publication
* credential misuse
* lateral movement
* container compromise
* privilege escalation
* malicious upload processing

Implement:

* workload isolation
* restricted service identities
* network policies
* admission/policy checks
* signed/verified artifacts where supported
* image scanning
* dependency scanning
* secret rotation
* audit logs
* protected publication paths

---

## 37. Data-Pipeline Security

Protect external-data ingestion.

Treat every external dataset as untrusted input.

Implement controls for:

* checksum verification
* schema enforcement
* malformed-data isolation
* archive-bomb protection
* resource limits
* decompression limits
* parser isolation
* malware scanning where applicable
* provenance tracking

Do not allow external files to execute code as part of ingestion.

---

## 38. Supply-Chain Security

Harden the infrastructure delivery chain.

Support:

* signed container images where available
* provenance metadata
* dependency vulnerability scanning
* infrastructure-code scanning
* artifact verification
* branch/release protection
* controlled deployment identities

Ensure production deployment references traceable artifacts.

---

## 39. Observability for Geospatial Workloads

Expand observability for specialized systems.

Measure:

### Geospatial pipelines

* records processed
* processing rate
* validation failures
* spatial errors
* dataset duration
* publication latency

### Routing

* request rate
* latency
* timeout rate
* graph-load time
* graph version
* CPU/memory
* queueing

### Tiles

* generation rate
* failed tiles
* publication duration
* completeness
* CDN hit/miss

### Realtime

* active connections
* connection failures
* reconnect rate
* heartbeat failures
* event lag

### Traffic/transit

* feed freshness
* update rate
* stale feeds
* rejected records
* processing latency

---

## 40. SLO and Error-Budget Instrumentation

Implement infrastructure support for service-level objectives.

Track relevant SLO signals for:

* public APIs
* search
* routing
* navigation/realtime
* map tiles
* geocoding
* transit
* notification processing
* critical data pipelines

Provide alerting for:

* SLO exhaustion risk
* sustained error-budget burn
* dependency failures
* capacity exhaustion

Do not create arbitrary SLO numbers without aligning them to the platform's documented reliability targets.

---

## 41. Operational Dashboards

Create dashboards for specialized infrastructure.

Dashboards should cover:

* geospatial ingestion
* dataset publication
* search indexing
* tile generation
* routing
* map matching
* realtime navigation
* traffic
* transit
* media processing
* notifications
* queues
* event streams
* database health
* infrastructure capacity

Prefer actionable dashboards over metric collections without interpretation.

---

## 42. Incident Automation

Implement operational automation for common infrastructure failures where safe.

Examples include:

* restarting unhealthy stateless workers
* quarantining malformed datasets
* pausing a failed batch pipeline
* limiting a runaway consumer
* shifting traffic away from unhealthy instances
* stopping runaway backfills
* paging appropriate operators
* triggering rebuild workflows

Automation must fail safely.

Do not automatically delete or destroy production data as an incident response.

---

## 43. Deployment Safety

Implement specialized deployment safeguards.

Support:

* canary deployment where appropriate
* rolling deployment
* controlled graph-version rollout
* controlled tile-version rollout
* staged dataset publication
* search-index cutover
* realtime-service connection draining
* rollback

Do not replace large shared datasets atomically without validating the replacement.

---

## 44. Schema and Artifact Compatibility

Infrastructure deployments must validate compatibility between:

* service version
* database version
* event-schema version
* search-index version
* tile-data version
* routing-graph version
* traffic-data version
* transit-data version

Prevent deployment of a service that expects an incompatible artifact version when compatibility can be validated automatically.

---

## 45. Operational Cost Controls

Extend cost management to specialized workloads.

Track costs for:

* routing
* map generation
* geospatial ingestion
* search indexing
* data storage
* egress
* CDN
* realtime infrastructure
* streaming
* worker compute
* observability

Support workload tagging and cost attribution.

Use interruptible/spot capacity for suitable batch workloads where it does not compromise correctness.

Do not use spot capacity for stateful or latency-critical workloads without a resilient architecture.

---

## 46. Infrastructure Test Environments

Provide isolated environments for testing infrastructure changes involving:

* routing
* search
* tiles
* ingestion
* streaming
* realtime
* transit
* traffic

Where full-scale data is impractical, use sanitized, representative datasets rather than silently bypassing the real pipeline architecture.

Do not place test workloads on production data paths.

---

## 47. Operational Runbooks

Create detailed runbooks for:

* failed dataset ingestion
* corrupted dataset
* failed publication
* index rebuild
* tile rebuild
* routing-graph rollout
* routing-engine outage
* map-matching degradation
* realtime connection saturation
* stream lag
* traffic feed failure
* transit feed failure
* queue backlog
* failed media processing
* notification provider outage
* failed restore
* database replication failure
* CDN failure
* certificate failure
* capacity exhaustion
* emergency rollback

Runbooks must correspond to actual infrastructure.

---

## 48. Documentation

Document:

* specialized workload topology
* geospatial data lifecycle
* dataset publication
* tile generation
* routing graph lifecycle
* routing runtime
* map matching
* realtime infrastructure
* traffic pipeline
* transit pipeline
* media workers
* notification workers
* batch scheduling
* event replay
* backfill process
* DR procedures
* security controls
* SLOs
* dashboards
* alerting
* cost allocation
* operational runbooks
* compatibility requirements

Documentation must describe implemented behavior, not planned functionality.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement:

* frontend changes
* mobile changes
* backend business logic
* routing algorithms
* map-matching algorithms
* search-ranking logic
* traffic-prediction ML
* transit journey-planning logic
* recommendation algorithms
* review/moderation logic
* user-account logic
* application schema redesign
* application API redesign
* event-schema redesign
* cloud-provider account creation outside the platform infrastructure itself
* unrelated corporate infrastructure
* fabricated external data
* fake production providers
* arbitrary service-mesh adoption without architectural justification
* full active-active multi-region operation unless explicitly defined and actually implementable within the selected architecture

Do not create placeholder infrastructure for out-of-scope systems.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect the infrastructure created by the existing platform foundation.
2. Inspect Kubernetes topology and node pools.
3. Inspect existing Terraform/modules.
4. Inspect deployment manifests.
5. Inspect database provisioning.
6. Inspect Redis and event-streaming infrastructure.
7. Inspect object storage and CDN configuration.
8. Inspect search infrastructure.
9. Inspect queue infrastructure.
10. Inspect existing CI/CD.
11. Inspect routing-service deployment configuration.
12. Inspect map/tile publication configuration.
13. Inspect traffic and transit pipeline definitions.
14. Inspect worker/scheduler infrastructure.
15. Inspect observability configuration.
16. Inspect backup/DR automation.
17. Inspect security and policy tooling.
18. Inspect existing operational runbooks.
19. Inspect architecture and contract artifacts defining dataset, tile, routing, traffic, transit, event, storage, deployment, and recovery semantics.

Reuse compatible infrastructure.

Do not assume previous AI conversations or hidden implementation history exists.

Do not replace a working infrastructure foundation unnecessarily.

The repository and explicit portable architecture/contract artifacts are the implementation sources of truth.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real infrastructure-as-code.
* Do not use pseudo-Terraform.
* Do not use fake processing pipelines.
* Do not simulate production routing or tile generation.
* Do not fabricate geographic datasets.
* Do not hardcode credentials.
* Do not commit secrets.
* Treat external datasets as untrusted input.
* Keep batch workloads isolated from latency-sensitive services.
* Use immutable dataset and artifact versions.
* Make publication atomic or safely staged.
* Keep rollback possible for critical data artifacts.
* Make processing resumable where practical.
* Prevent unbounded queues and retries.
* Prevent stale artifacts from becoming active accidentally.
* Make graph/tile/index version compatibility explicit.
* Protect realtime workloads from batch capacity exhaustion.
* Do not automatically destroy production data during recovery.
* Use least privilege.
* Enforce network isolation.
* Scan artifacts and infrastructure.
* Make backup restoration testable.
* Make SLO and capacity signals actionable.
* Keep cost ownership explicit.
* Clean up temporary processing storage.
* Protect external-data parsers and decompression workflows.
* Do not silently discard failed records.
* Keep operational actions auditable.
* Keep documentation synchronized with actual infrastructure.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Validate infrastructure-as-code.
* Run static analysis and security checks.
* Validate specialized Kubernetes workloads.
* Validate worker scheduling and isolation.
* Validate dataset ingestion configuration.
* Validate data-quality/quarantine pipelines.
* Validate dataset versioning.
* Validate PostGIS operational configuration.
* Validate bulk import/export controls.
* Validate search-index rebuild infrastructure.
* Validate tile-generation infrastructure.
* Validate tile publication/rollback.
* Validate routing-graph build infrastructure.
* Validate routing runtime configuration.
* Validate map-matching runtime configuration.
* Validate realtime navigation scaling.
* Validate location-processing workers.
* Validate traffic pipeline infrastructure.
* Validate transit pipeline infrastructure.
* Validate media-processing workers.
* Validate notification workers.
* Validate scheduling.
* Validate backfill/replay controls.
* Validate autoscaling.
* Validate workload isolation.
* Validate storage performance configuration.
* Validate observability dashboards and alerts.
* Validate SLO/error-budget instrumentation.
* Validate backup/restore automation where execution is possible.
* Validate disaster-recovery workflows where execution is possible.
* Validate artifact compatibility checks.
* Validate cost controls.
* Validate no production secrets are committed.
* Validate no critical specialized workflow depends on undocumented manual infrastructure setup.

Resolve in-scope infrastructure defects discovered during validation.

Do not claim successful execution of cloud operations that were not actually performed.

---

# EXPECTED DELIVERABLES

Produce the actual infrastructure implementation and supporting artifacts.

Expected deliverables include, as applicable:

* geospatial ingestion infrastructure
* validation/quarantine infrastructure
* dataset-version infrastructure
* geospatial processing workers
* PostGIS operational automation
* bulk import/export infrastructure
* search-index rebuild infrastructure
* vector-tile generation infrastructure
* tile publication infrastructure
* routing-graph build infrastructure
* routing-engine runtime infrastructure
* map-matching runtime infrastructure
* realtime navigation infrastructure
* high-volume location-processing infrastructure
* traffic ingestion/publication infrastructure
* transit ingestion/publication infrastructure
* batch schedulers
* controlled backfill infrastructure
* event-replay infrastructure
* dead-letter/quarantine operations
* media-processing workers
* notification workers
* provider-isolation infrastructure
* workload-priority controls
* specialized autoscaling
* node/storage isolation
* disaster-recovery automation
* restore testing
* security hardening
* supply-chain controls
* specialized observability
* SLO dashboards/alerts
* incident automation
* deployment-safety mechanisms
* artifact compatibility validation
* cost controls
* infrastructure test environments
* operational runbooks
* documentation

Keep the implementation cohesive.

Do not artificially split infrastructure into meaningless modules.

---

# INTEGRATION REQUIREMENTS

The specialized infrastructure must integrate with the shared platform foundation while preserving clear boundaries.

Provide stable infrastructure interfaces for:

* data ingestion
* dataset publication
* PostGIS
* search indexing
* tile datasets
* routing graphs
* routing runtime
* map matching
* realtime navigation
* traffic
* transit
* media processing
* notifications
* queues
* event streams
* object storage
* CDN
* observability

Maintain stable identifiers and versions for:

* dataset versions
* tile versions
* graph versions
* index versions
* traffic snapshots
* transit feed versions
* processing jobs
* publication releases

Infrastructure must expose enough metadata for services to determine what version they are consuming.

Do not force application services to discover infrastructure state through undocumented implementation details.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Geospatial ingestion infrastructure implemented.
2. Data-quality/quarantine infrastructure implemented.
3. Dataset-versioning/publication infrastructure implemented.
4. Geospatial processing workers implemented.
5. PostGIS operational infrastructure implemented.
6. Bulk import/export infrastructure implemented.
7. Search-index rebuild infrastructure implemented.
8. Vector-tile generation infrastructure implemented.
9. Tile publication/rollback implemented.
10. Routing-graph build infrastructure implemented.
11. Routing-engine runtime implemented.
12. Map-matching runtime implemented.
13. Realtime navigation infrastructure implemented.
14. High-volume location processing implemented.
15. Traffic infrastructure implemented.
16. Transit infrastructure implemented.
17. Batch scheduling implemented.
18. Backfill/replay infrastructure implemented.
19. Dead-letter/quarantine operations implemented.
20. Media-processing infrastructure implemented.
21. Notification workers implemented.
22. External-provider isolation implemented.
23. Workload-priority and capacity controls implemented.
24. Specialized autoscaling implemented.
25. Disaster-recovery automation implemented.
26. Restore testing implemented where executable.
27. Security/supply-chain hardening implemented.
28. Specialized observability and SLO instrumentation implemented.
29. Incident/deployment automation implemented.
30. Cost controls implemented.
31. Infrastructure test environments implemented where applicable.
32. Operational runbooks created or updated.
33. Documentation created or updated.
34. Validation commands and actual outcomes.
35. Important implementation decisions or deviations.
36. Environment/provider limitations encountered.
37. Exact files/modules/artifacts changed or created.

Do not claim execution of infrastructure operations that were not actually performed.

---

# DEFINITION OF DONE

This prompt is complete only when:

* Geographic datasets can be ingested through controlled infrastructure.
* Invalid or suspicious data is quarantined rather than silently published.
* Dataset versions are immutable and traceable.
* Geospatial processing runs on scalable isolated workers.
* PostGIS operational safeguards are implemented.
* Large database operations have controlled execution paths.
* Search indexes can be rebuilt and promoted without unsafe partial activation.
* Vector tiles can be generated and published through versioned artifacts.
* Tile publication supports validation and rollback.
* Routing graphs can be built, validated, versioned, and promoted.
* Routing-engine workloads have dedicated production-capable runtime infrastructure.
* Map-matching workloads are isolated and scalable.
* Realtime navigation can support high concurrent connection counts.
* Location-processing infrastructure supports partitioning, backpressure, replay, and monitoring.
* Traffic ingestion and publication have freshness and rollback safeguards.
* Transit ingestion and publication have validation and freshness safeguards.
* Scheduled jobs have retry, timeout, concurrency, and failure controls.
* Backfills and event replays are bounded and operationally controlled.
* Failed data/messages are quarantined or dead-lettered with recoverable metadata.
* Media and notification workers are isolated from latency-sensitive workloads.
* External providers have explicit infrastructure boundaries and credential isolation.
* Workload priority and resource isolation protect critical services during batch processing.
* Specialized workloads have appropriate autoscaling.
* Disaster-recovery automation exists for critical artifacts and services.
* Restore verification is implemented where the environment allows actual execution.
* Security and supply-chain controls protect infrastructure and data pipelines.
* Specialized SLOs, dashboards, and alerts provide actionable operational visibility.
* Deployment and artifact publication are controlled and rollback-capable.
* Artifact-version compatibility is enforced where practical.
* Cost attribution and lifecycle controls are present.
* Operational runbooks match the implemented infrastructure.
* Documentation reflects actual infrastructure behavior.
* No hardcoded credentials, fake production resources, pseudo-infrastructure, TODO/FIXME gaps, or undocumented critical manual setup remains within scope.

**Implement only the current prompt's scope.**
