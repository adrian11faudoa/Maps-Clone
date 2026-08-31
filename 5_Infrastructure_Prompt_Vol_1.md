You are operating in Senior Engineering Team Mode.

Build the production-ready cloud infrastructure foundation for an enterprise-scale global mapping, geospatial search, routing, navigation, traffic, location, places, and offline-map platform comparable in architectural scope to Google Maps.

The platform is an original implementation.

Do not copy proprietary source code, internal architecture, branding, confidential implementation details, proprietary algorithms, proprietary datasets, or private implementation details from Google or any other company.

This prompt is completely independent and may be executed in a separate conversation.

This is an INFRASTRUCTURE PHASE.

Use the approved mapping architecture, backend architecture, frontend architecture, mobile architecture, geospatial data strategy, routing strategy, privacy model, security model, and Project Index as the source of truth.

Do not redesign the application architecture.

Do not implement backend business logic.

Do not implement frontend business logic.

Do not implement mobile business logic.

Infrastructure implementation is allowed.

────────────────────────────────────────

MISSION

Build the foundational AWS, Terraform, Docker, Kubernetes, networking, data, geospatial, map-tile, routing, search, real-time, observability, security, backup, and disaster-recovery infrastructure required by the platform.

Support:

• Consumer web
• Business web
• Admin web
• Consumer mobile
• Navigation mobile
• API Gateway
• Identity
• Places
• Businesses
• Addresses
• Geocoding
• Reverse geocoding
• Autocomplete
• Search
• Map data
• Map tiles
• Map styles
• Roads
• Routing
• ETA
• Traffic
• Incidents
• Closures
• Navigation
• Location
• Location history
• Location sharing
• Trip sharing
• Geofencing
• Offline maps
• Reviews
• Contributions
• Moderation
• Notifications
• Analytics
• Administration
• Privacy workers
• Background workers

Environments:

• Local
• Development
• Test
• Staging
• Production
• Disaster Recovery

────────────────────────────────────────

PRIMARY TECHNOLOGY STACK

Cloud:

• AWS

Infrastructure as Code:

• Terraform

Containers:

• Docker

Orchestration:

• Kubernetes
• Amazon EKS

Packaging:

• Helm

Container registry:

• Amazon ECR

Database:

• Amazon Aurora PostgreSQL or managed RDS PostgreSQL
• PostGIS

Cache:

• Amazon ElastiCache for Redis

Event streaming:

• Managed Kafka/Redpanda or approved compatible architecture

Search:

• Amazon OpenSearch

Object storage:

• Amazon S3

CDN:

• Amazon CloudFront

DNS:

• Amazon Route 53

TLS:

• AWS Certificate Manager

Secrets:

• AWS Secrets Manager

Encryption:

• AWS KMS

Security:

• IAM
• WAF
• Security Groups
• Network ACLs
• Kubernetes RBAC
• NetworkPolicies
• Pod Security Standards

Observability:

• OpenTelemetry
• Prometheus
• Grafana
• Loki
• Tempo

CI/CD foundation:

• GitHub Actions

────────────────────────────────────────

IMPLEMENTATION RULES

Never generate pseudo-configuration.

Never generate placeholders.

Never generate TODO infrastructure.

Never omit required resources.

Every Terraform file must be valid.

Every Helm template must be complete.

Every Dockerfile must build.

Never hard-code:

• AWS credentials
• Database credentials
• Redis passwords
• Kafka passwords
• OpenSearch credentials
• API keys
• Provider secrets
• Certificates
• Private keys

Prefer:

• OIDC
• Short-lived credentials
• Workload identity
• Managed services
• Immutable artifacts
• Least privilege

Never regenerate unchanged files.

Only modify existing files when required.

────────────────────────────────────────

AWS ACCOUNT STRATEGY

Prepare infrastructure that can support separate AWS accounts for:

• Management
• Security
• Audit/log archive
• Shared services
• Development
• Test
• Staging
• Production
• Disaster recovery

Define:

• Account ownership
• Cross-account IAM
• Central logging
• Security boundaries
• Billing ownership

Do not force multi-account deployment for local development.

────────────────────────────────────────

REGION STRATEGY

Support:

• Primary production region
• Secondary disaster-recovery region

Prepare regional infrastructure for:

• EKS
• APIs
• WebSockets
• Geocoding
• Search
• Routing
• Traffic
• Location
• Map-data processing
• Offline-package generation
• Analytics

Use region-local latency-sensitive workloads where practical.

────────────────────────────────────────

ENVIRONMENT STRATEGY

LOCAL

Provide Docker Compose for:

• PostgreSQL + PostGIS
• Redis
• Kafka/Redpanda
• OpenSearch
• S3-compatible object storage

DEVELOPMENT

Use reduced-scale cloud resources.

TEST

Use isolated resources.

STAGING

Closely mirror production architecture.

PRODUCTION

Use:

• Multi-AZ
• Encryption
• Backups
• Monitoring
• Security controls
• High availability

DISASTER RECOVERY

Provide:

• Rebuildable infrastructure
• Restorable data
• Regional failover path

────────────────────────────────────────

TERRAFORM STRUCTURE

Create:

terraform/

modules/

environments/

global/

regional/

shared/

application/

geospatial/

routing/

traffic/

search/

media/

observability/

security/

backup/

disaster-recovery/

Separate reusable modules from environment-specific compositions.

────────────────────────────────────────

TERRAFORM MODULES

Create reusable modules for:

• AWS provider
• Naming
• Tags
• VPC
• Subnets
• Routing
• NAT
• VPC endpoints
• Security groups
• IAM
• OIDC
• EKS
• Node groups
• Autoscaling
• Aurora PostgreSQL
• ElastiCache
• Kafka
• OpenSearch
• S3
• CloudFront
• Route 53
• ACM
• WAF
• ECR
• Secrets Manager
• KMS
• Backup
• CloudTrail
• Logging
• Monitoring

────────────────────────────────────────

TERRAFORM STATE

Implement remote Terraform state using:

• S3
• Encryption
• Versioning
• Restricted access
• Environment isolation
• Safe state-locking mechanism

Avoid unnecessarily placing sensitive plaintext values into Terraform state.

────────────────────────────────────────

RESOURCE TAGGING

Standardize tags:

• Project
• Environment
• Region
• Service
• Team
• Owner
• CostCenter
• DataClassification
• ManagedBy

────────────────────────────────────────

NETWORK FOUNDATION

Create VPC architecture with:

• Public subnets
• Private application subnets
• Private data subnets
• Multi-AZ
• Internet Gateway
• NAT
• Route tables
• VPC endpoints

Separate:

• Edge
• Application
• Data
• Management

────────────────────────────────────────

NETWORK SEGMENTATION

Create network boundaries for:

• ALB/NLB
• EKS
• APIs
• Geospatial services
• Routing services
• Workers
• PostgreSQL
• Redis
• Kafka
• OpenSearch

Do not permit unrestricted east-west traffic.

────────────────────────────────────────

SECURITY GROUPS

Create dedicated security groups for:

• Load balancers
• EKS
• PostgreSQL
• Redis
• Kafka
• OpenSearch
• Management

Only allow required paths.

All data services remain private.

────────────────────────────────────────

VPC ENDPOINTS

Use private connectivity for AWS services where practical:

• S3
• ECR
• Secrets Manager
• KMS
• STS
• CloudWatch-related services
• Other required AWS services

────────────────────────────────────────

EKS FOUNDATION

Create EKS with:

• Multi-AZ
• Private worker networking
• Cluster logging
• IAM Roles for Service Accounts / workload identity
• Kubernetes RBAC
• NetworkPolicies
• Pod Security Standards

Namespaces:

• gateway
• web
• application
• geospatial
• search
• routing
• traffic
• location
• navigation
• workers
• offline
• observability
• ingress
• security
• operations

────────────────────────────────────────

NODE GROUPS

Define workload pools:

GENERAL

• API
• Web

GEOSPATIAL

• Search
• Nearby search
• Geocoding
• Spatial processing

ROUTING

• Route computation
• Matrix
• ETA

TRAFFIC

• Traffic ingestion
• Aggregation
• Map matching

LOCATION

• Location ingestion
• WebSocket workloads

DATA PROCESSING

• Map-data ingestion
• Road-graph builds
• Tile generation
• Offline packaging

ANALYTICS

• Analytics workers

Define:

• Labels
• Taints
• Tolerations
• Affinity
• Anti-affinity
• Topology spread
• Scaling bounds

────────────────────────────────────────

KUBERNETES GOVERNANCE

Configure:

• ResourceQuota
• LimitRange
• Resource requests
• Resource limits
• PodDisruptionBudget
• ServiceAccounts
• RBAC
• NetworkPolicies
• Pod Security Standards

Prevent:

• Privileged containers
• Unbounded resources
• Cross-namespace access
• Noisy-neighbor behavior

────────────────────────────────────────

INGRESS

Provide ingress for:

• Public APIs
• Web
• Business portal
• Admin portal
• WebSockets
• Upload initialization
• Route APIs
• Search APIs
• Geocoding APIs

Support:

• TLS
• Health checks
• WebSocket upgrades
• Timeouts
• Connection draining
• WAF integration

────────────────────────────────────────

LOAD BALANCING

Use:

• ALB for HTTP/HTTPS
• NLB for high-throughput or long-lived connection workloads where required

Configure:

• TLS
• Health checks
• Idle timeout
• Access logging
• Security controls

────────────────────────────────────────

POSTGRESQL + POSTGIS

Deploy managed PostgreSQL.

Support:

• Multi-AZ
• Encryption
• TLS
• Automated backups
• PITR
• Read replicas where required
• Monitoring
• Performance Insights
• Parameter groups
• Maintenance windows

Database must remain private.

────────────────────────────────────────

POSTGIS OPERATIONS

Prepare for:

• Spatial indexes
• Large geometry data
• Read replicas
• Connection pooling
• Vacuum/analyze
• Partitioning
• Spatial query monitoring

Monitor:

• Query latency
• Sequential scans
• Index usage
• Locks
• Deadlocks
• Connections
• Storage
• IOPS

────────────────────────────────────────

REDIS

Create ElastiCache/Redis infrastructure with:

• Replication
• Multi-AZ
• Automatic failover
• TLS
• Encryption at rest
• Authentication

Prepare for:

• Current location
• Geocode cache
• Reverse-geocode cache
• Autocomplete
• Search cache
• Route cache
• ETA
• Traffic
• Geofence acceleration
• Location sharing
• Trip sharing
• Rate limiting

────────────────────────────────────────

KAFKA / REDPANDA

Create production event infrastructure supporting:

• Multi-broker
• Multi-AZ
• Replication
• Persistent storage
• TLS
• Authentication
• Monitoring

Prepare topic families:

• Location
• Places
• Search
• Map data
• Routing
• Traffic
• Navigation
• Sharing
• Geofencing
• Contributions
• Reviews
• Notifications
• Analytics
• Privacy
• Administration

────────────────────────────────────────

OPENSEARCH

Create OpenSearch infrastructure supporting:

• Multi-node
• Multi-AZ
• Encryption
• Fine-grained access
• Snapshots
• Monitoring

Use indexes for:

• Places
• Businesses
• Addresses
• Roads
• Categories
• Search suggestions

Indexes must be rebuildable.

────────────────────────────────────────

S3 GEOSPATIAL STORAGE

Create secure buckets/prefixes for:

• Raw map-source data
• Normalized datasets
• Map dataset builds
• Vector tiles
• Raster tiles
• Routing graph artifacts
• Offline packages
• Place photos
• Business assets
• Privacy exports
• Reports
• Analytics artifacts
• Backups

Use:

• Encryption
• Versioning where required
• Lifecycle policies
• Block public access

────────────────────────────────────────

S3 BUCKET SEPARATION

Separate sensitive classes where appropriate:

• Map-source data
• Public map artifacts
• User-uploaded photos
• Private business documents
• Privacy exports
• Reports
• Backup data

Do not create one unrestricted bucket.

────────────────────────────────────────

CLOUDFRONT

Create CDN architecture for:

• Vector tiles
• Raster tiles
• Map styles
• Offline packages
• Public place images
• Static web assets

Configure:

• Origin Access Control
• Cache policies
• Response headers
• TLS
• WAF
• Logging where appropriate

────────────────────────────────────────

MAP TILE DELIVERY

Architecture:

Client
→ CloudFront
→ Tile origin
→ Versioned map dataset

Do not send every tile request through application pods.

Use:

• Immutable versions
• Compression
• Long cache lifetimes where safe

────────────────────────────────────────

OFFLINE PACKAGE DELIVERY

Support CDN distribution of:

• Map tiles
• Map styles
• POI data
• Search data
• Routing graph packages

Use:

• Secure downloads
• Checksums
• Version manifests
• Expiration
• Resume-compatible delivery

────────────────────────────────────────

ROUTE / NAVIGATION INFRASTRUCTURE

Provide dedicated infrastructure for:

• Routing workers
• Distance-matrix workers
• ETA workers
• Navigation processors
• Map-matching workers

Separate from general API node pools.

────────────────────────────────────────

ROUTING WORKER POOLS

Scale according to:

• Route requests
• CPU
• Memory
• Queue depth
• Latency

Support separate capacity for:

• Interactive routes
• Batch matrices
• Background graph processing

────────────────────────────────────────

TRAFFIC INFRASTRUCTURE

Deploy dedicated capacity for:

• Traffic ingestion
• Map matching
• Spatial aggregation
• Live traffic state
• Historical aggregation

Prevent traffic workloads from starving routing/API capacity.

────────────────────────────────────────

LOCATION INFRASTRUCTURE

Support:

• High-rate location ingestion
• WebSockets
• Kafka ingestion
• Redis live-location state
• Regional processing

Do not persist every raw location update into PostgreSQL synchronously.

────────────────────────────────────────

GEOSPATIAL COMPUTE

Prepare worker pools for:

• Spatial joins
• Geometry validation
• Map matching
• Geofence evaluation
• Map-data normalization
• Road graph generation
• Tile generation

Scale separately from API workloads.

────────────────────────────────────────

ROAD GRAPH BUILD INFRASTRUCTURE

Support:

• Dataset import
• Graph build
• Graph validation
• Benchmarking
• Regional publication
• Version coexistence

Use object storage for large graph artifacts.

────────────────────────────────────────

MAP-DATA BUILD INFRASTRUCTURE

Support:

• Batch ingestion
• Parsing
• Geometry validation
• Deduplication
• Normalization
• Enrichment
• Tile generation
• Search indexing
• Road graph construction

Use asynchronous workers.

────────────────────────────────────────

SEARCH INFRASTRUCTURE

Support:

• Query workloads
• Autocomplete
• Batch indexing
• Full reindex
• Alias switching
• Regional indexes

Do not overload the search cluster with unrestricted reindex traffic.

────────────────────────────────────────

GEOFENCE INFRASTRUCTURE

Prepare:

• Spatial candidate lookup
• Redis acceleration
• Geofence evaluation workers
• Event processing

Scale based on:

• Active geofences
• Location-update volume
• Spatial density

────────────────────────────────────────

WEB APPLICATION DELIVERY

Create container/image infrastructure for:

• Consumer web
• Business web
• Admin web

Use:

• Multi-stage Docker builds
• Minimal runtime
• Non-root containers
• Immutable images

Static assets may be delivered through CloudFront.

────────────────────────────────────────

DOCKER FOUNDATION

Create production Docker standards for:

• API services
• Place services
• Search services
• Routing services
• Traffic services
• Location services
• Navigation services
• Map-data workers
• Road-graph workers
• Tile workers
• Offline-package workers
• Notification workers
• Analytics workers
• Web applications

────────────────────────────────────────

CONTAINER SECURITY

Use:

• Minimal base images
• Multi-stage builds
• Non-root
• Read-only filesystem where possible
• Dropped capabilities
• Seccomp
• Dependency pinning
• Vulnerability scanning
• SBOM

────────────────────────────────────────

ECR

Create repositories for:

• API
• Web
• Geospatial
• Search
• Routing
• Traffic
• Location
• Navigation
• Map data
• Road graph
• Tile generation
• Offline maps
• Notifications
• Analytics
• Moderation

Configure:

• Scan on push
• Lifecycle rules
• Access policies
• Immutable tags where appropriate

────────────────────────────────────────

IAM

Create least-privilege identities for:

• Terraform
• GitHub Actions
• EKS
• APIs
• Search workers
• Routing workers
• Traffic workers
• Location workers
• Map-data workers
• Tile workers
• Offline workers
• Analytics workers
• Privacy workers
• Backup systems
• Observability

Prefer:

• OIDC
• Workload identity
• Short-lived credentials

────────────────────────────────────────

KMS

Create encryption keys for:

• S3
• PostgreSQL
• Redis where supported
• EBS
• Secrets
• Logs
• Backups
• Terraform state

Define:

• Key policies
• Rotation
• Environment isolation
• Access boundaries

────────────────────────────────────────

SECRETS MANAGER

Store:

• Database secrets
• Redis credentials
• Kafka credentials
• Search credentials
• Mapping-provider credentials
• Routing-provider credentials
• Traffic-provider credentials
• Notification secrets
• OAuth secrets
• Webhook secrets

Integrate securely into Kubernetes.

Never put secrets inside:

• Git
• Docker images
• Helm values
• Public Terraform variables

────────────────────────────────────────

OBSERVABILITY

Deploy:

• OpenTelemetry Collector
• Prometheus
• Grafana
• Loki
• Tempo

Collect:

• API metrics
• Search metrics
• Routing metrics
• Traffic metrics
• Location metrics
• Navigation metrics
• Database metrics
• Redis metrics
• Kafka metrics
• OpenSearch metrics
• EKS metrics
• CDN metrics
• Map-data processing metrics

────────────────────────────────────────

GEOSPATIAL OBSERVABILITY

Monitor:

• Spatial-query latency
• Geocoding latency
• Autocomplete latency
• Nearby-search latency
• Routing latency
• Map-matching latency
• Geofence latency
• Dataset-processing latency

────────────────────────────────────────

MAP DATA OBSERVABILITY

Track:

• Dataset ingestion rate
• Build duration
• Validation failures
• Geometry errors
• Tile generation duration
• Graph generation duration
• Search-indexing lag
• Publication status

────────────────────────────────────────

TRAFFIC OBSERVABILITY

Track:

• Location-ingestion rate
• Map-matching rate
• Traffic update frequency
• Segment freshness
• Aggregation lag
• Traffic confidence

────────────────────────────────────────

NAVIGATION OBSERVABILITY

Track:

• Active navigation sessions
• Location update latency
• Off-route events
• Reroutes
• Route latency
• ETA latency
• WebSocket connection count

────────────────────────────────────────

HEALTH CHECKS

Provide:

• Liveness
• Readiness
• Startup

Validate essential dependencies for readiness.

Do not make liveness depend on optional external providers.

────────────────────────────────────────

AUTOSCALING FOUNDATION

Use:

• HPA
• Karpenter or Cluster Autoscaler
• Queue-based scaling
• Kafka-lag scaling

Scale using:

• CPU
• Memory
• Request rate
• Queue depth
• Kafka lag
• WebSocket count
• Routing load
• Location load
• Map-processing load

────────────────────────────────────────

BACKUP FOUNDATION

Configure:

• PostgreSQL backups
• PITR
• S3 versioning
• S3 replication where required
• OpenSearch snapshots
• Terraform-state protection
• Critical configuration backups

Encrypt all backups.

────────────────────────────────────────

DISASTER RECOVERY

Prepare recovery for:

• AZ failure
• EKS failure
• PostgreSQL failure
• Redis failure
• Kafka failure
• OpenSearch failure
• S3 disruption
• Routing failure
• Map-data build failure
• Region failure

All major derived artifacts must be rebuildable.

────────────────────────────────────────

SECURITY BASELINE

Implement:

• Least-privilege IAM
• Private networking
• Encryption at rest
• Encryption in transit
• WAF
• Security Groups
• NetworkPolicies
• Pod security
• Secrets management
• Audit logging

────────────────────────────────────────

CLOUD AUDIT

Enable and protect:

• CloudTrail
• EKS audit logs
• AWS Config
• Security findings
• Centralized logs

Audit logs must be protected from unauthorized alteration.

────────────────────────────────────────

INFRASTRUCTURE TESTING

Validate:

• Terraform formatting
• Terraform validation
• Terraform plan
• Terraform policy
• Helm lint
• Kubernetes schema
• Kubernetes security
• Docker builds
• Container scans
• IAM policies
• Security groups
• NetworkPolicies
• WAF
• Backup configuration

────────────────────────────────────────

LOCAL DEVELOPMENT

Provide Docker Compose for:

• PostgreSQL
• PostGIS
• Redis
• Kafka/Redpanda
• OpenSearch
• MinIO or approved S3-compatible storage

Include:

• Persistent volumes
• Health checks
• Local-only credentials
• Service networks
• Startup dependencies

────────────────────────────────────────

DOCUMENTATION

Generate:

• AWS architecture
• Account strategy
• Region strategy
• Environment strategy
• Terraform structure
• Networking
• EKS
• Kubernetes
• PostgreSQL/PostGIS
• Redis
• Kafka
• OpenSearch
• S3
• CloudFront
• Route 53
• ACM
• WAF
• IAM
• KMS
• Secrets Manager
• Docker
• ECR
• Map-data infrastructure
• Tile infrastructure
• Routing infrastructure
• Traffic infrastructure
• Location infrastructure
• Geofencing infrastructure
• Offline-map infrastructure
• Observability
• Backup
• Disaster recovery
• Local development
• Security
• Infrastructure testing

────────────────────────────────────────

PROJECT INDEX

Update the infrastructure Project Index with:

• AWS accounts
• Regions
• Environments
• VPCs
• Subnets
• NAT
• VPC endpoints
• Security groups
• IAM
• OIDC
• KMS
• Secrets
• EKS
• Node groups
• Namespaces
• Terraform modules
• Helm structure
• Dockerfiles
• ECR repositories
• PostgreSQL/PostGIS
• Redis
• Kafka/Redpanda
• OpenSearch
• S3
• CloudFront
• Route 53
• ACM
• WAF
• Geospatial worker pools
• Routing worker pools
• Traffic worker pools
• Location worker pools
• Map-data workers
• Road-graph workers
• Tile workers
• Offline-map workers
• Web application deployment
• Observability
• Backups
• Disaster recovery
• Security
• Infrastructure tests
• Generated files
• Modified files
• Remaining work
• Current milestone
• Dependencies

────────────────────────────────────────

IMPLEMENTATION MILESTONES

INFRASTRUCTURE MILESTONE 1

Terraform foundation, remote state, naming, tagging, provider configuration, account/environment structure, reusable module system.

INFRASTRUCTURE MILESTONE 2

AWS networking: VPC, multi-AZ subnets, routing, NAT, VPC endpoints, security groups, network segmentation.

INFRASTRUCTURE MILESTONE 3

IAM, OIDC, workload identity, KMS, Secrets Manager, ECR, CloudTrail, AWS Config, security baseline.

INFRASTRUCTURE MILESTONE 4

EKS, node groups, namespaces, RBAC, NetworkPolicies, Pod Security Standards, quotas, resource governance, ingress, and load balancing.

INFRASTRUCTURE MILESTONE 5

PostgreSQL/PostGIS, Redis, Kafka/Redpanda, OpenSearch, encryption, monitoring, backups, and operational security.

INFRASTRUCTURE MILESTONE 6

Geospatial processing pools, map-data ingestion workers, road-graph workers, tile-generation workers, routing workers, traffic workers, location workers, and specialized autoscaling.

INFRASTRUCTURE MILESTONE 7

S3 map/media storage, CloudFront, vector/raster tiles, map styles, offline packages, secure CDN architecture, and origin protection.

INFRASTRUCTURE MILESTONE 8

Docker, ECR, web application images, API images, geospatial images, worker images, container hardening, SBOM, vulnerability scanning.

INFRASTRUCTURE MILESTONE 9

Observability platform, OpenTelemetry, Prometheus, Grafana, Loki, Tempo, dashboards, alerts, health checks, spatial/geospatial metrics.

INFRASTRUCTURE MILESTONE 10

Backup foundation, disaster recovery foundation, infrastructure validation, local development, security hardening, documentation, and Project Index completion.

Each milestone should contain approximately 20–40 files where practical.

Every milestone must pass infrastructure validation before proceeding.

────────────────────────────────────────

OUTPUT FORMAT

For every generated file provide:

1. Exact file path
2. Complete file contents

Never truncate files.

Never summarize configuration instead of generating it.

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

This volume covers infrastructure foundations:

• AWS
• Terraform
• Networking
• IAM
• OIDC
• KMS
• Secrets Manager
• EKS
• Kubernetes
• PostgreSQL/PostGIS
• Redis
• Kafka/Redpanda
• OpenSearch
• S3
• CloudFront
• Route 53
• ACM
• WAF
• Docker
• ECR
• Geospatial compute
• Map-data processing
• Road-graph infrastructure
• Routing infrastructure
• Traffic infrastructure
• Location infrastructure
• Navigation infrastructure
• Tile infrastructure
• Offline-map infrastructure
• Autoscaling foundation
• Observability foundation
• Backup foundation
• Disaster-recovery foundation
• Security baseline
• Local development
• Infrastructure testing

Do not implement:

• Backend business logic
• Frontend business logic
• Mobile business logic
• Routing algorithms
• ETA algorithms
• Traffic algorithms
• Search business logic
• Map-data business rules
• Geofence business logic

Those belong to application layers.

────────────────────────────────────────

QUALITY BAR

Treat this infrastructure as the foundation of a globally distributed mapping and navigation platform supporting:

• Hundreds of millions of users
• Billions of map-tile requests
• Massive search traffic
• Millions of navigation sessions
• Massive location streams
• Large road graphs
• Large map datasets
• Large routing workloads
• Large offline downloads
• Multiple regions
• High availability
• Disaster recovery
• Strict location privacy
• Strict security

Prioritize:

• Availability
• Geospatial workload isolation
• Routing performance
• Location ingestion scalability
• CDN efficiency
• Private networking
• Least privilege
• Regional resilience
• Data durability
• Observability
• Disaster recovery
• Cost awareness
• Maintainability
• Production readiness
