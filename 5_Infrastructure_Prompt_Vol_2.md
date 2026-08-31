You are operating in Senior Engineering Team Mode.

Complete the production-grade infrastructure and DevOps implementation for an enterprise-scale global mapping, search, routing, navigation, traffic, location, places, offline-map, and geospatial platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

Use the approved architecture and previously generated infrastructure foundation as the single source of truth.

Do not redesign the application architecture.

Do not implement backend business logic.

Do not implement frontend business logic.

Do not implement mobile business logic.

Infrastructure implementation is allowed.

────────────────────────────────────────

MISSION

Complete the infrastructure required for:

• Production Kubernetes workloads
• Geospatial services
• Routing services
• Traffic services
• Location services
• Navigation services
• Search services
• Map-data pipelines
• Road-graph pipelines
• Tile generation
• Offline package generation
• WebSocket infrastructure
• Multi-region deployment
• Global traffic management
• CI/CD
• Release automation
• Autoscaling
• Observability
• Security operations
• Backup
• Disaster recovery
• Chaos/resilience testing
• Incident response
• Capacity planning
• Cost optimization
• Production certification

Support:

• Consumer web
• Business web
• Admin web
• Consumer mobile
• Navigation mobile
• API gateway
• Places
• Businesses
• Geocoding
• Search
• Routing
• ETA
• Traffic
• Navigation
• Location
• Geofencing
• Offline maps
• Reviews
• Contributions
• Notifications
• Analytics
• Administration
• Privacy workers

────────────────────────────────────────

PRIMARY TECHNOLOGY STACK

Cloud:

• AWS

Infrastructure as Code:

• Terraform

Containers:

• Docker
• Amazon ECR

Orchestration:

• Kubernetes
• Amazon EKS

Packaging:

• Helm

CI/CD:

• GitHub Actions

Database:

• Aurora PostgreSQL or managed RDS PostgreSQL
• PostGIS

Cache:

• ElastiCache Redis

Streaming:

• Managed Kafka/Redpanda

Search:

• Amazon OpenSearch

Object storage:

• Amazon S3

CDN:

• CloudFront

DNS:

• Route 53

TLS:

• ACM

Secrets:

• Secrets Manager

Encryption:

• KMS

Security:

• IAM
• WAF
• Security Groups
• NetworkPolicies
• Kubernetes RBAC
• Pod Security Standards

Observability:

• OpenTelemetry
• Prometheus
• Grafana
• Loki
• Tempo

────────────────────────────────────────

IMPLEMENTATION RULES

Never generate pseudo-configuration.

Never generate placeholders.

Never generate TODO infrastructure.

Never omit required resources.

Every Terraform file must be valid.

Every Helm template must be complete.

Every Dockerfile must build.

Every workflow must be complete.

Never hard-code secrets.

Never commit:

• AWS credentials
• Database passwords
• API secrets
• Private keys
• Certificates
• Provider credentials

Prefer:

• OIDC
• Short-lived credentials
• Workload identity
• Immutable artifacts
• Least privilege

Never regenerate unchanged files.

Only modify existing files when required.

────────────────────────────────────────

KUBERNETES PRODUCTION ARCHITECTURE

Create complete Helm deployments for the approved services.

APPLICATION WORKLOADS:

• API Gateway
• Identity
• Accounts
• Profiles
• Devices
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
• Location
• Location History
• Saved Places
• Collections
• Location Sharing
• Trip Sharing
• Geofencing
• Offline Maps
• Reviews
• Ratings
• Photos
• Contributions
• Notifications
• Moderation
• Analytics
• Administration
• Privacy

WORKERS:

• Search indexing
• Geocoding
• Map-data ingestion
• Geometry validation
• Road graph
• Tile generation
• Traffic aggregation
• Geofencing
• Offline packages
• Notifications
• Moderation
• Analytics
• Privacy
• Cleanup
• Reconciliation

────────────────────────────────────────

WORKLOAD TYPES

Define appropriate Kubernetes objects for:

• Deployment
• Service
• ServiceAccount
• ConfigMap
• Secret reference
• HPA
• PDB
• NetworkPolicy
• PriorityClass
• Job
• CronJob
• HorizontalPodAutoscaler
• PodDisruptionBudget

Use Jobs/CronJobs only when workload semantics justify them.

────────────────────────────────────────

KUBERNETES RESOURCE POLICY

Every workload must define:

• CPU requests
• Memory requests
• CPU limits
• Memory limits
• Ephemeral storage where needed
• Priority
• Graceful termination

Critical services must have multiple replicas.

────────────────────────────────────────

TOPLOGY

Use:

• TopologySpreadConstraints
• Pod anti-affinity
• Node affinity
• Taints
• Tolerations

Prevent all replicas of critical services from landing on the same failure domain.

────────────────────────────────────────

SERVICE CLASSES

Define workload classes:

CRITICAL:

• API
• Search
• Routing
• Location
• Navigation

HIGH:

• Geocoding
• ETA
• Traffic
• Places

BACKGROUND:

• Map ingestion
• Tile generation
• Offline packages
• Analytics
• Reconciliation

BATCH:

• Full reindex
• Graph builds
• Dataset processing

Scheduling must prevent background workloads from starving critical services.

────────────────────────────────────────

MEDIA / MAP-DATA COMPUTE

Create dedicated node pools for:

• Geometry processing
• Map-data transformation
• Tile generation
• Road graph generation
• Routing graph builds
• Offline package generation
• Search reindexing

Support:

• CPU-optimized instances
• Memory-optimized instances where useful
• Spot where safe
• On-demand capacity for critical workloads

────────────────────────────────────────

ROUTING NODE POOLS

Provide specialized capacity for:

• Interactive route requests
• Matrix requests
• ETA
• Navigation calculations

Prevent batch matrix requests from exhausting interactive routing capacity.

────────────────────────────────────────

LOCATION NODE POOLS

Support high-frequency:

• Location ingestion
• Map matching
• Navigation state
• WebSocket workloads

Use:

• Horizontal scaling
• Connection-aware routing
• Resource limits

────────────────────────────────────────

WEB SOCKET INFRASTRUCTURE

Support:

• High connection counts
• Horizontal replicas
• Connection draining
• Redis coordination
• Health checks
• Graceful shutdown
• Idle timeout tuning

Prepare for:

• Location sharing
• Trip sharing
• Navigation state
• Notifications

────────────────────────────────────────

INGRESS

Configure ingress for:

• Public API
• Search
• Routing
• Geocoding
• Web
• Business portal
• Admin portal
• WebSockets

Apply:

• TLS
• WAF integration
• Request limits
• Timeouts
• Health checks
• Connection draining

────────────────────────────────────────

GLOBAL TRAFFIC MANAGEMENT

Use Route 53 and CloudFront to support:

• Primary region
• Secondary region
• Health checks
• Failover
• Weighted rollout
• Latency-based routing
• Controlled failback

Support region draining before planned maintenance.

────────────────────────────────────────

MULTI-REGION

Create regional deployment architecture for:

• EKS
• PostgreSQL
• Redis
• Kafka where regionalized
• OpenSearch
• Routing
• Traffic
• Location
• Search
• Map-data processing

Global services:

• CloudFront
• Route 53
• Artifact replication
• Global configuration where appropriate

────────────────────────────────────────

REGIONAL DATA CONTROL

Define explicit configuration for:

• Region
• Geography ownership
• Routing graph
• Map dataset version
• Search index version
• Traffic state
• Offline package region

Do not permit accidental cross-region data ownership.

────────────────────────────────────────

MAP DATA PIPELINE INFRASTRUCTURE

Deploy worker infrastructure for:

• Source download
• Parsing
• Normalization
• Geometry validation
• Deduplication
• Enrichment
• Tile generation
• Search indexing
• Road graph generation
• QA

Support large temporary storage requirements.

────────────────────────────────────────

MAP DATA ARTIFACT STORAGE

Use S3 for:

• Raw source
• Normalized source
• Intermediate artifacts
• Tile artifacts
• Graph artifacts
• Offline packages
• Validation reports

Use versioned object naming.

────────────────────────────────────────

ROAD GRAPH BUILD INFRASTRUCTURE

Support:

• Graph build jobs
• Topology validation
• Connectivity testing
• Performance benchmarking
• Version publication
• Rollback

Store graph artifacts in S3.

Deploy active graph versions to routing infrastructure without overwriting previous versions until validated.

────────────────────────────────────────

TILE GENERATION INFRASTRUCTURE

Support:

• Vector tile generation
• Raster tile generation
• Compression
• Dataset version
• Style version
• Regional build

Scale by:

• Zoom range
• Region
• Tile volume
• Queue depth

────────────────────────────────────────

OFFLINE PACKAGE INFRASTRUCTURE

Support package generation for:

• Vector tiles
• Raster fallback
• POI data
• Search data
• Routing graph
• Style

Use:

• S3
• CloudFront
• Queue-based generation

────────────────────────────────────────

SEARCH REINDEX INFRASTRUCTURE

Create isolated infrastructure for large reindexes.

Support:

• Bulk indexing
• Throttling
• Alias switching
• Temporary compute
• Validation

Reindexing must not degrade production search availability.

────────────────────────────────────────

GEOCODING INFRASTRUCTURE

Support:

• Primary provider
• Secondary provider
• Internal data fallback

Use:

• Timeout
• Retry
• Circuit breaker
• Rate limit
• Provider health monitoring

────────────────────────────────────────

ROUTING PROVIDER INFRASTRUCTURE

Support provider adapters with:

• Connection management
• Timeout
• Retry
• Circuit breaker
• Rate limits
• Health monitoring

Provider-specific credentials must come from Secrets Manager.

────────────────────────────────────────

TRAFFIC PROVIDER INFRASTRUCTURE

Support:

• Streaming ingestion
• Polling where required
• Provider failover
• Data freshness monitoring
• Rate limits

Do not allow stale traffic to appear as current.

────────────────────────────────────────

DATABASE PRODUCTION HARDENING

Complete PostgreSQL/PostGIS operations.

Configure:

• Multi-AZ
• Backup
• PITR
• Encryption
• TLS
• Parameter groups
• Performance monitoring
• Read replicas
• Connection pooling
• Maintenance windows

Monitor:

• Connections
• CPU
• Memory
• Storage
• IOPS
• Query latency
• Lock contention
• Deadlocks
• Replica lag

────────────────────────────────────────

DATABASE MIGRATION INFRASTRUCTURE

Create safe migration jobs/pipeline.

Sequence:

1. Expand schema
2. Deploy compatible application
3. Backfill
4. Validate
5. Activate new behavior
6. Contract old schema later

Migration deployment must support rollback of application versions without requiring destructive database reversal.

────────────────────────────────────────

REDIS PRODUCTION

Configure:

• Multi-AZ
• Replication
• Auto-failover
• TLS
• Encryption
• Authentication
• Monitoring

Monitor:

• Memory
• Evictions
• CPU
• Connections
• Latency
• Replication
• Hot keys

────────────────────────────────────────

KAFKA / REDPANDA

Configure:

• Multi-broker
• Multi-AZ
• Replication
• TLS
• Authentication
• Persistent storage
• Monitoring

Monitor:

• Consumer lag
• Broker health
• Disk
• Throughput
• Under-replicated partitions
• Partition skew

────────────────────────────────────────

OPENSEARCH

Configure:

• Multi-AZ
• Multi-node
• Encryption
• Access policies
• Snapshots
• Monitoring

Prevent reindex operations from exhausting the cluster.

────────────────────────────────────────

S3

Configure:

• Block Public Access
• Encryption
• Versioning where justified
• Lifecycle rules
• Access logging where useful
• Replication where required
• Bucket policies
• Least privilege

────────────────────────────────────────

CLOUDFRONT

Configure distributions for:

• Vector tiles
• Raster tiles
• Map styles
• Offline packages
• Public place photos
• Web assets

Use:

• Origin Access Control
• Cache policies
• Compression
• TLS
• WAF

────────────────────────────────────────

CERTIFICATE MANAGEMENT

Configure ACM for:

• Main domain
• API
• Admin
• Business portal
• CDN
• WebSockets

Use automated renewal.

────────────────────────────────────────

WAF

Protect:

• Web
• API
• Admin
• Upload
• Search
• Routing
• Geocoding
• Webhooks

Use:

• Managed rules
• Rate limits
• Request-size restrictions
• IP rules
• Bot controls where appropriate

Admin endpoints require stronger protection.

────────────────────────────────────────

CI/CD

Create complete GitHub Actions workflows for:

• Pull requests
• Build
• Unit tests
• Integration tests
• Contract tests
• Security scans
• Docker builds
• SBOM
• Image scanning
• Image signing
• Terraform validation
• Helm lint
• Kubernetes validation
• Staging deployment
• Production deployment
• Smoke tests
• Rollback

────────────────────────────────────────

CI/CD SECURITY

Use:

• GitHub OIDC
• Environment protection
• Minimal permissions
• Protected branches
• Required approvals
• Short-lived cloud credentials

Never use long-lived AWS access keys in GitHub secrets.

────────────────────────────────────────

ARTIFACT PROMOTION

Use:

Development
→ Test
→ Staging
→ Production

Promote immutable image digests.

Validate:

• Digest
• SBOM
• Vulnerabilities
• Tests
• Signature
• Approval

────────────────────────────────────────

DEPLOYMENT STRATEGIES

Support:

• Rolling
• Canary
• Blue-green where useful

Apply progressive delivery especially to:

• Routing
• Search
• Traffic
• Geocoding
• Recommendation-related discovery
• Map styles
• Map-data services

────────────────────────────────────────

DEPLOYMENT HEALTH

After deployment verify:

• Pods
• Services
• Readiness
• Error rate
• Latency
• Queue depth
• Kafka lag
• Search health
• Database health
• Redis health
• WebSocket health

Stop promotion on failure.

────────────────────────────────────────

ROLLBACK

Provide:

• Helm rollback
• Traffic rollback
• Region rollback
• Image-digest rollback
• Configuration rollback
• Feature-flag kill switch

Database changes must remain backward-compatible.

────────────────────────────────────────

AUTOSCALING

Implement:

• HPA
• Karpenter or Cluster Autoscaler
• Queue-based scaling
• Kafka-lag scaling

For each workload define:

• Minimum replicas
• Maximum replicas
• CPU threshold
• Memory threshold
• Custom metric
• Scale-up behavior
• Scale-down behavior

────────────────────────────────────────

ROUTING AUTOSCALING

Use:

• Request rate
• CPU
• Memory
• Route latency
• Matrix queue depth

Protect interactive routes from batch workloads.

────────────────────────────────────────

LOCATION AUTOSCALING

Use:

• Location events/sec
• Active connections
• WebSocket count
• CPU
• Memory
• Kafka lag

────────────────────────────────────────

TRAFFIC AUTOSCALING

Use:

• Input event rate
• Aggregation lag
• Queue depth
• CPU
• Memory

────────────────────────────────────────

SEARCH AUTOSCALING

Use:

• Query rate
• Indexing rate
• Search latency
• CPU
• JVM memory
• Disk utilization

────────────────────────────────────────

MAP-DATA AUTOSCALING

Use:

• Queue depth
• Dataset size
• Processing latency
• CPU
• Memory
• Ephemeral storage

────────────────────────────────────────

OBSERVABILITY

Deploy and configure:

• OpenTelemetry Collector
• Prometheus
• Grafana
• Loki
• Tempo

Create dashboards:

PLATFORM

• Requests
• Latency
• Errors
• Saturation

MAP

• Tile request rate
• Cache hit
• Tile latency
• Dataset freshness

SEARCH

• Query rate
• Latency
• Indexing
• Freshness
• Cluster health

GEOCODING

• Request rate
• Latency
• Provider health
• Fallback rate

ROUTING

• Requests
• Latency
• Failures
• Alternatives
• Matrix load

TRAFFIC

• Event rate
• Freshness
• Aggregation lag

LOCATION

• Events/sec
• Connections
• Processing latency
• Kafka lag

NAVIGATION

• Sessions
• Updates
• Reroutes
• Off-route
• WebSocket health

OFFLINE

• Package jobs
• Build duration
• Failure rate
• Storage

────────────────────────────────────────

ALERTS

Create alerts for:

• API availability
• High API error rate
• High latency
• Search degradation
• Routing degradation
• Geocoding provider outage
• Traffic staleness
• Location backlog
• Kafka lag
• Queue backlog
• PostgreSQL saturation
• Redis memory pressure
• OpenSearch degradation
• WebSocket connection loss
• Tile failure
• Offline-package failure
• Backup failure
• Certificate expiration
• Region degradation
• Security findings

────────────────────────────────────────

SLO / SLI

Define measurable SLOs for:

• Tiles
• Search
• Autocomplete
• Geocoding
• Routing
• ETA
• Navigation
• Location updates
• Traffic freshness
• Offline packages
• Business APIs
• Administration APIs

For each specify:

• SLI
• Measurement
• Target
• Error budget
• Alert threshold

────────────────────────────────────────

BACKUP

Configure:

• PostgreSQL backup
• PITR
• S3 versioning
• S3 replication where required
• OpenSearch snapshots
• Terraform state protection
• Critical configuration backup

Encrypt all backups.

────────────────────────────────────────

RESTORE TESTING

Actually test restoration of:

• PostgreSQL
• PostGIS
• S3 artifacts
• OpenSearch
• Terraform state
• Critical configuration

Record:

• Restore duration
• RPO
• RTO
• Integrity validation
• Result

────────────────────────────────────────

DISASTER RECOVERY

Create runbooks for:

• AZ failure
• EKS failure
• PostgreSQL failure
• Redis failure
• Kafka failure
• OpenSearch failure
• S3 disruption
• Routing provider outage
• Geocoding provider outage
• Traffic provider outage
• Region outage

Every scenario requires:

• Detection
• Containment
• Recovery
• Validation
• Reconciliation
• Failback

────────────────────────────────────────

CHAOS TESTING

Prepare controlled tests for:

• Pod termination
• Node termination
• Routing worker failure
• Search worker failure
• Location gateway failure
• Kafka broker failure
• Redis failover
• PostgreSQL failover
• OpenSearch node failure
• WebSocket gateway failure
• Map-data worker failure
• Region failure

Run in test/staging before production.

────────────────────────────────────────

INCIDENT RESPONSE

Create operational procedures for:

• Map outage
• Tile outage
• Search outage
• Routing outage
• Traffic outage
• Location outage
• Navigation outage
• Database outage
• Redis outage
• Kafka outage
• Search outage
• Region outage
• Security incident

Each includes:

• Severity
• Detection
• Owner
• Mitigation
• Recovery
• Communications
• Postmortem
• Corrective action

────────────────────────────────────────

RUNBOOKS

Create runbooks for:

• Deployment rollback
• Database restore
• Redis failover
• Kafka recovery
• OpenSearch recovery
• Routing degradation
• Search degradation
• Traffic staleness
• Location backlog
• Map-data backlog
• Tile-generation backlog
• Offline-package backlog
• Secret rotation
• Certificate rotation
• Region failover
• Region failback
• Backup failure

────────────────────────────────────────

SECURITY OPERATIONS

Implement processes for:

• IAM review
• Service-account review
• Secrets rotation
• KMS rotation
• Container scanning
• Dependency scanning
• Network-policy validation
• WAF review
• Security-group review
• CloudTrail monitoring
• Vulnerability remediation

────────────────────────────────────────

COST OPTIMIZATION

Evaluate:

• EKS right-sizing
• Karpenter
• Spot workers
• Database sizing
• Redis sizing
• OpenSearch sizing
• S3 lifecycle
• CloudFront caching
• Cross-region transfer
• NAT Gateway usage
• Log retention
• Routing compute
• Map-data processing compute
• Tile-generation compute

Do not reduce cost by violating:

• Security
• Privacy
• Availability
• Disaster recovery
• Data integrity

────────────────────────────────────────

CAPACITY PLANNING

Model:

• Users
• Concurrent map sessions
• Tile requests
• Search requests
• Autocomplete requests
• Geocoding requests
• Route requests
• Matrix requests
• Navigation sessions
• Location events
• WebSocket connections
• Traffic events
• Offline downloads
• Reviews
• Contributions
• Analytics events

For each determine:

• Normal capacity
• Peak
• Burst
• Headroom
• Scaling threshold
• Failure threshold

────────────────────────────────────────

PRODUCTION SMOKE TESTS

After deployment verify:

• Map loads
• Search works
• Autocomplete works
• Place details work
• Geocoding works
• Route calculation works
• ETA works
• Traffic loads
• Navigation API is healthy
• Location ingestion is healthy
• Saved places work
• Business APIs work
• Offline metadata works
• Privacy APIs work
• Admin APIs work

Use synthetic/non-destructive test identities.

────────────────────────────────────────

INFRASTRUCTURE VALIDATION

Automate:

• Terraform fmt
• Terraform validate
• Terraform plan
• Terraform policy
• Helm lint
• Kubernetes schema
• Kubernetes security
• Docker build
• Container scan
• SBOM
• Image signing
• IAM validation
• Security-group validation
• NetworkPolicy validation
• WAF validation
• Backup validation
• Restore validation

────────────────────────────────────────

RELEASE GATES

Production deployment requires:

• Passing automated tests
• Security checks
• Image signature
• Infrastructure validation
• Staging validation
• Smoke tests
• Monitoring available
• Backup health
• Rollback procedure
• Required approvals
• Known-risk documentation

────────────────────────────────────────

DOCUMENTATION

Generate:

• Production infrastructure
• Kubernetes operations
• Helm operations
• Terraform operations
• CI/CD
• Artifact promotion
• Global routing
• Multi-region
• Geospatial compute
• Map-data pipelines
• Tile generation
• Routing infrastructure
• Traffic infrastructure
• Location infrastructure
• Navigation infrastructure
• Offline maps
• PostgreSQL/PostGIS
• Redis
• Kafka
• OpenSearch
• S3
• CloudFront
• WAF
• Secrets
• Autoscaling
• Observability
• SLO/SLI
• Backups
• Restore
• Disaster recovery
• Chaos testing
• Incident response
• Runbooks
• Capacity planning
• Cost optimization
• Security operations
• Release certification

────────────────────────────────────────

PROJECT INDEX

Update the infrastructure Project Index with:

• Kubernetes workloads
• Namespaces
• Helm charts
• Node pools
• Routing infrastructure
• Traffic infrastructure
• Location infrastructure
• Navigation infrastructure
• Search infrastructure
• Geocoding infrastructure
• Map-data pipelines
• Tile generation
• Road graph builds
• Offline packages
• WebSockets
• Autoscaling
• HPA
• Karpenter/Cluster Autoscaler
• CI/CD
• GitHub Actions
• ECR
• SBOM
• Image signing
• Security scanning
• PostgreSQL
• PostGIS
• Redis
• Kafka
• OpenSearch
• S3
• CloudFront
• Route 53
• ACM
• WAF
• Observability
• Dashboards
• Alerts
• SLOs
• Backups
• Restore tests
• Disaster recovery
• Chaos tests
• Incident response
• Runbooks
• Capacity planning
• Cost optimization
• Security operations
• Release gates
• Smoke tests
• Generated files
• Modified files
• Remaining work
• Known risks
• Current milestone
• Production-readiness status
• Dependencies

────────────────────────────────────────

IMPLEMENTATION MILESTONES

INFRASTRUCTURE MILESTONE 11

Complete production Helm charts and Kubernetes deployment for API, web, places, search, geocoding, routing, ETA, traffic, location, navigation, and core workers.

INFRASTRUCTURE MILESTONE 12

Deploy geospatial processing pools for map-data ingestion, geometry validation, tile generation, road-graph generation, offline packages, and full search reindexing.

INFRASTRUCTURE MILESTONE 13

Complete WebSocket infrastructure, location ingestion, navigation processing, traffic processing, routing worker pools, specialized autoscaling, and connection draining.

INFRASTRUCTURE MILESTONE 14

Complete multi-region architecture, Route 53, CloudFront, WAF, regional failover, weighted routing, controlled rollout, region draining, and failback.

INFRASTRUCTURE MILESTONE 15

Implement GitHub Actions CI/CD, OIDC, artifact promotion, SBOM, image scanning, image signing, staged deployments, production deployment, smoke tests, and rollback.

INFRASTRUCTURE MILESTONE 16

Complete database migration automation, PostgreSQL/PostGIS production hardening, Redis operations, Kafka operations, OpenSearch operations, S3 lifecycle/backup, and operational monitoring.

INFRASTRUCTURE MILESTONE 17

Complete observability, dashboards, metrics, logs, traces, SLOs, alerts, custom autoscaling metrics, queue monitoring, and geospatial operational dashboards.

INFRASTRUCTURE MILESTONE 18

Complete security operations, secret rotation, IAM review, KMS review, WAF hardening, network security validation, container security, vulnerability management, and audit integration.

INFRASTRUCTURE MILESTONE 19

Complete backup restoration, disaster recovery, regional recovery, chaos testing, incident response, runbooks, capacity planning, and cost optimization.

INFRASTRUCTURE MILESTONE 20

Complete final production validation, smoke tests, release gates, resilience certification, security certification, operational documentation, Project Index completion, and infrastructure production-readiness certification.

Each milestone should contain approximately 20–40 files where practical.

Every milestone must pass infrastructure validation before proceeding.

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never truncate files.

Never summarize infrastructure configuration instead of generating it.

Never generate pseudo-configuration.

Never generate placeholders.

Never generate TODO implementations.

When modifying an existing file:

1. Provide the exact file path.
2. State why it must change.
3. Provide the complete updated file.

Never regenerate unchanged files.

────────────────────────────────────────

SCOPE RESTRICTION

This volume completes production infrastructure and DevOps for the mapping platform.

It covers:

• Kubernetes
• Helm
• Production workloads
• Geospatial worker pools
• Routing infrastructure
• Traffic infrastructure
• Location infrastructure
• Navigation infrastructure
• Search infrastructure
• Map-data pipelines
• Tile generation
• Road graph
• Offline packages
• WebSockets
• Autoscaling
• Multi-region
• Global routing
• CI/CD
• Artifact promotion
• Security scanning
• Observability
• SLO/SLI
• Alerts
• Backups
• Restore testing
• Disaster recovery
• Chaos
• Incident response
• Runbooks
• Capacity
• Cost
• Security operations
• Release gates
• Production smoke tests

Do not implement:

• Backend business logic
• Frontend business logic
• Mobile business logic
• Routing algorithms
• ETA algorithms
• Traffic algorithms
• Search algorithms
• Map-data domain logic
• Geofence domain logic

Those belong to application layers.

────────────────────────────────────────

QUALITY BAR

Treat this as mission-critical infrastructure supporting:

• Hundreds of millions of users
• Billions of map-tile requests
• Massive search traffic
• Millions of navigation sessions
• Massive location streams
• Large road graphs
• Large map datasets
• Massive routing traffic
• Large offline downloads
• Multiple regions
• High availability
• Disaster recovery
• Strict privacy
• Strict security

Prioritize:

• Availability
• Geospatial workload isolation
• Routing performance
• Location scalability
• CDN efficiency
• Regional resilience
• Data durability
• Security
• Observability
• Recoverability
• Automation
• Cost awareness
• Maintainability
• Production readiness
