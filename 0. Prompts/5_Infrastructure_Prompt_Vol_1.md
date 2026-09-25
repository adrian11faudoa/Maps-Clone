# Google Maps-Style Mapping & Navigation Platform — Infrastructure Prompt — Volume 1

# ROLE

Act as a senior platform engineering organization responsible for implementing the production infrastructure foundation for a large-scale Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal Infrastructure Architect
* Senior Cloud Engineers
* Senior DevOps Engineers
* Kubernetes Engineers
* Platform Engineers
* Database Reliability Engineers
* Network Engineers
* Security Engineers
* Site Reliability Engineers
* Observability Engineers
* CI/CD Engineers
* FinOps Engineers
* Disaster Recovery Engineers
* Technical Writers

You are implementing production infrastructure.

Do not produce pseudo-infrastructure, placeholder Terraform, fake cloud resources, undocumented manual deployment requirements, hardcoded credentials, TODO/FIXME infrastructure gaps, insecure defaults, or knowingly incomplete critical infrastructure paths.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Build the foundational cloud, networking, infrastructure-as-code, platform-runtime, data-services, secrets, observability, and deployment-environment capabilities required to operate the Google Maps-style mapping and navigation platform at production scale.

The infrastructure must support the platform's major workloads, including:

* public APIs
* geospatial services
* search
* vector tiles
* routing
* navigation/realtime
* transit
* user-generated content
* media
* notifications
* asynchronous workers
* event streaming
* administrative services
* observability

The implementation must establish repeatable infrastructure for:

* local development where appropriate
* development
* staging
* production

Use cloud-agnostic design where practical, while implementing one concrete production deployment target supported by the project technology direction.

Infrastructure must be reproducible through version-controlled infrastructure-as-code.

Do not require undocumented manual cloud configuration for critical runtime behavior.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the core production infrastructure foundation and shared platform services.

## 1. Infrastructure-as-Code Foundation

Establish the infrastructure-as-code repository structure.

Implement:

* environment organization
* shared modules
* environment-specific configuration
* provider configuration
* remote state strategy
* state locking
* variable validation
* outputs
* dependency boundaries
* resource naming conventions
* tagging/labeling conventions
* lifecycle policies
* secret references
* region/zone configuration
* reusable infrastructure modules

Maintain clear separation between:

* reusable infrastructure modules
* environment composition
* environment secrets
* deployment configuration

Do not embed credentials in Terraform or equivalent infrastructure-as-code.

---

## 2. Cloud Account and Environment Structure

Implement the foundational environment structure for:

* development
* staging
* production

Where supported by the target cloud, establish appropriate separation for:

* networks
* IAM boundaries
* resource groups/projects/accounts
* data services
* observability
* security tooling

Production resources must not accidentally reference development resources.

Avoid cross-environment data sharing unless explicitly required by a documented architecture contract.

---

## 3. Networking Foundation

Implement production-grade cloud networking.

Provide:

* virtual network/VPC
* public/private subnet strategy
* multiple availability zones where supported
* routing tables
* internet egress controls
* NAT/egress architecture
* security groups/firewall rules
* private service access
* internal DNS
* ingress boundaries
* load-balancer integration
* network segmentation

Separate:

* public ingress
* application workloads
* databases
* caches
* search
* streaming
* internal workers
* management/operations paths

Do not expose databases, Redis, streaming brokers, or internal services directly to the public internet.

---

## 4. DNS and TLS

Implement infrastructure for:

* managed DNS
* service domains
* API domains
* operational domains where required
* TLS certificates
* certificate renewal
* HTTP-to-HTTPS redirection
* secure TLS configuration

Support:

* internal service discovery
* external DNS records
* health-checked routing where appropriate

Do not embed certificates or private keys in source control.

---

## 5. Edge and Ingress

Implement the production ingress boundary.

Support:

* HTTPS termination
* load balancing
* request routing
* host/path routing
* health checks
* connection timeouts
* request limits
* rate-limit integration points
* WAF integration where available
* DDoS protection through the selected cloud/provider capabilities
* API ingress
* WebSocket upgrade support for navigation/realtime services
* secure header handling

Do not expose internal services directly when an explicit ingress boundary is required.

---

## 6. Kubernetes Platform

Where Kubernetes is the selected runtime, implement the core production Kubernetes platform.

Provide:

* managed Kubernetes cluster where supported
* node pools/node groups
* workload identity
* namespaces
* resource quotas
* limit ranges
* pod security configuration
* network policies
* service accounts
* ingress/controller integration
* autoscaling primitives
* storage integration
* cluster logging hooks
* cluster metrics hooks

Separate workloads logically by function and operational boundary.

Support workloads for:

* APIs
* workers
* realtime services
* ingestion
* routing adapters
* tile services
* transit processing
* search/indexing
* notification workers

Do not install arbitrary infrastructure components without documenting their operational purpose.

---

## 7. Container Runtime and Registry

Implement production container infrastructure.

Provide:

* container registry
* repository naming
* image lifecycle policy
* image retention
* immutable version tagging
* vulnerability-scanning integration
* image provenance metadata where supported
* build artifact traceability
* pull permissions
* workload-specific access control

Production workloads must not deploy mutable `latest`-style tags as authoritative release identifiers.

Use immutable release references.

---

## 8. PostgreSQL / PostGIS Infrastructure

Provision the production relational data platform.

Support:

* managed PostgreSQL where available
* PostGIS
* high availability
* backups
* point-in-time recovery
* storage scaling
* connection limits
* parameter configuration
* encryption at rest
* encryption in transit
* monitoring
* maintenance configuration
* replica capability where required by the architecture

Support the logical domains already defined by the platform, including:

* users
* places
* addresses
* geographic features
* saved content
* contributions
* reviews
* moderation-related data
* navigation/session state where appropriate
* transit metadata

Do not redesign application schemas in this prompt.

Provision infrastructure that can host the existing canonical schema.

---

## 9. Database Connectivity

Implement the infrastructure required for safe application-to-database connectivity.

Support:

* private networking
* credential/secret injection
* connection-pool configuration hooks
* TLS
* connection monitoring
* maximum connection protection
* application-side service identities
* least-privilege database credentials
* rotation support

Avoid exposing database credentials as ordinary environment values when the selected platform provides secure secret injection mechanisms.

---

## 10. Redis Infrastructure

Provision production Redis/cache infrastructure.

Support:

* high availability
* private networking
* encryption in transit
* encryption at rest where supported
* authentication
* failover
* monitoring
* capacity/scaling model
* eviction policy consistent with workload
* connection limits

Provide infrastructure suitable for workloads such as:

* API caching
* geospatial lookup caching
* rate limiting
* idempotency
* distributed coordination
* navigation/realtime state
* session support

Do not assume Redis is a durable system of record.

---

## 11. Event Streaming Platform

Provision the event-streaming infrastructure required by the platform.

Use Kafka, Redpanda, or the selected equivalent according to the architecture.

Implement:

* broker/cluster resources
* authentication
* TLS
* topic-management strategy
* retention configuration
* partitioning foundation
* producer/consumer access control
* monitoring
* capacity/scaling configuration
* disaster-recovery considerations

Provide the platform needed for event domains such as:

* place changes
* search indexing
* route/navigation events
* location processing
* traffic
* transit
* contributions
* reviews
* media
* notifications
* audit events

Do not redesign event payloads in this prompt.

Infrastructure must consume the canonical topic/event definitions.

---

## 12. Queueing and Background Work Infrastructure

Provision managed queue infrastructure where the architecture uses dedicated queues in addition to the event stream.

Support:

* queue creation
* dead-letter queues
* retry configuration
* visibility timeout
* retention
* encryption
* consumer identity
* monitoring
* alerting hooks

Provide the infrastructure for workloads such as:

* media processing
* notification delivery
* moderation operations
* bulk indexing
* tile generation
* data ingestion
* scheduled processing

Prevent infinite retry loops through explicit retry and dead-letter policy.

---

## 13. Object Storage

Provision secure object storage for platform-managed media and large artifacts.

Support:

* private buckets/containers
* encryption
* lifecycle rules
* versioning where justified
* retention policy
* object-lock/immutability where required by the architecture
* service-account access
* signed-access integration
* deletion controls
* audit logging

Storage must support use cases such as:

* user media
* processed media derivatives
* map/tile artifacts
* imported geographic datasets
* transit datasets
* backup/export artifacts where appropriate

Do not expose buckets publicly unless explicitly required and reviewed.

---

## 14. CDN and Asset Delivery

Provision the infrastructure required for globally distributed delivery of:

* map tiles
* styles
* media derivatives
* static application assets
* publicly cacheable API responses where safe

Support:

* HTTPS
* caching policies
* cache-control
* compression
* origin protection
* invalidation
* signed/private delivery where needed
* geographic distribution

Do not cache private or authorization-sensitive responses publicly.

---

## 15. Secrets and Configuration Management

Implement centralized secret/configuration infrastructure.

Manage:

* database credentials
* Redis credentials
* streaming credentials
* service credentials
* signing keys
* external API credentials
* notification provider credentials
* media storage credentials
* other sensitive configuration

Support:

* secret versioning
* access policies
* rotation
* workload identity
* audit logging
* environment separation

Distinguish clearly between:

* non-secret configuration
* sensitive configuration
* cryptographic secrets

No secret should be committed into source control, Terraform state in plaintext where avoidable, container images, mobile bundles, or CI logs.

---

## 16. IAM and Workload Identity

Implement least-privilege infrastructure access.

Define identities for:

* application services
* workers
* database access
* object storage
* streaming
* queues
* observability
* CI/CD
* operators

Avoid shared administrator credentials.

Use workload identity or equivalent cloud-native identity mechanisms.

Separate:

* deployment permissions
* runtime permissions
* human operator permissions
* emergency break-glass permissions

Document all elevated-access paths.

---

## 17. CI/CD Foundation

Implement the base CI/CD infrastructure required to build and deploy the platform.

Support:

* source validation
* dependency installation
* linting
* type checking
* unit tests
* integration tests where feasible
* container builds
* security scanning
* image publication
* infrastructure validation
* environment promotion
* deployment artifact versioning

Implement separate deployment paths for:

* development
* staging
* production

Production deployment must require explicit promotion/authorization according to the project's release model.

Do not place production credentials directly in repository workflows.

---

## 18. Deployment Configuration

Implement the deployment manifests/configuration required for the current service ecosystem.

Where Kubernetes is used, provide appropriate configuration for:

* deployments
* services
* ingress
* config maps
* secret references
* service accounts
* autoscaling
* probes
* disruption budgets
* resource requests/limits
* topology constraints
* network policies

Ensure each workload has:

* liveness behavior
* readiness behavior
* startup behavior where required
* graceful termination

Do not deploy applications with unlimited CPU/memory consumption.

---

## 19. Autoscaling Foundation

Implement baseline autoscaling infrastructure.

Support scaling based on relevant signals such as:

* CPU
* memory
* request rate
* queue depth
* event lag
* realtime connection load
* worker utilization

Do not use CPU-only scaling for workloads where a more meaningful application signal is required.

Ensure scaling behavior respects:

* database limits
* cache capacity
* broker capacity
* external provider limits

---

## 20. Observability Infrastructure

Establish the production observability platform.

Support:

* centralized logs
* metrics
* traces
* dashboards
* alerting
* service health
* infrastructure health
* dependency health
* SLO monitoring

Use OpenTelemetry-compatible instrumentation boundaries.

Collect:

* request latency
* error rates
* saturation
* availability
* queue depth
* stream lag
* database health
* Redis health
* routing service health
* tile delivery metrics
* navigation/realtime health

Do not collect raw sensitive location data as ordinary telemetry.

---

## 21. Monitoring and Alerting

Implement actionable monitoring for critical infrastructure.

Create alerts for issues such as:

* API error-rate spikes
* latency degradation
* database saturation
* replica lag
* Redis failures
* broker lag
* queue buildup
* failed deployments
* certificate expiration
* storage capacity
* node failures
* pod crash loops
* unavailable ingress
* excessive realtime connection failures

Alerts must be tied to operational actions or runbooks.

Avoid excessive alert noise.

---

## 22. Health and Service Discovery

Provide infrastructure support for:

* service discovery
* health checks
* readiness
* liveness
* startup checks
* load balancer health
* dependency health reporting

Ensure an instance is not considered ready before required dependencies are available.

Do not make every dependency failure equivalent to application startup failure when the application can legitimately operate in degraded mode.

---

## 23. Resource Governance

Implement baseline resource governance.

Define:

* CPU/memory requests
* CPU/memory limits
* pod quotas
* storage limits
* naming conventions
* tagging
* ownership metadata
* environment metadata
* cost-center metadata where appropriate

Prevent one workload from consuming unbounded shared infrastructure resources.

---

## 24. Cost Controls

Implement foundational FinOps controls.

Support:

* environment cost allocation
* resource tagging
* budgets
* cost alerts
* idle-resource detection hooks
* storage lifecycle controls
* log-retention controls
* autoscaling
* environment shutdown policies where appropriate

Do not optimize for cost by weakening availability, security, or data durability without an explicit architecture decision.

---

## 25. Security Baseline

Implement platform-level security controls including:

* encryption in transit
* encryption at rest
* least-privilege IAM
* private networking
* firewall rules
* secure secret management
* vulnerability scanning
* audit logging
* image scanning
* infrastructure validation
* dependency scanning hooks
* restricted administrative access

Where the cloud provides managed security services, integrate the relevant controls.

---

## 26. Backup Infrastructure

Implement the backup foundation for:

* PostgreSQL
* configuration where appropriate
* critical object storage
* infrastructure state
* event/stream state where applicable

Support:

* automated backups
* retention policy
* encryption
* backup monitoring
* restore verification hooks

Do not consider a backup system complete merely because backups are scheduled.

Provide a mechanism for restore validation.

---

## 27. Disaster-Recovery Foundation

Establish the foundational infrastructure required for future disaster recovery.

Define and implement, where applicable:

* recovery regions/zones
* backup replication
* infrastructure recreation
* critical dependency inventory
* data recovery boundaries
* DNS failover capability
* recovery automation hooks

Do not claim full multi-region active-active operation unless actually implemented.

The platform must have explicit documented recovery boundaries.

---

## 28. Environment Promotion and Drift Control

Implement infrastructure controls that reduce environment drift.

Support:

* version-pinned modules/providers
* reproducible deployments
* plan review
* controlled applies
* configuration validation
* deployment provenance
* drift detection hooks

Avoid manually modifying production resources outside the infrastructure-as-code lifecycle unless an emergency process explicitly permits it.

Document exceptions.

---

## 29. Operational Runbooks

Create initial operational runbooks for:

* failed deployment
* database failure
* Redis failure
* broker failure
* queue backlog
* ingress outage
* certificate issue
* secret rotation
* unhealthy Kubernetes nodes
* excessive API errors
* scaling incidents
* backup failure
* restore procedure

Runbooks must contain actual operational actions for the implemented infrastructure.

Do not create generic instructions such as “contact the administrator.”

---

## 30. Infrastructure Testing

Create automated validation for the infrastructure.

Include, as appropriate:

* Terraform formatting
* Terraform validation
* static analysis
* security scanning
* policy checks
* Kubernetes manifest validation
* deployment-schema validation
* configuration validation
* secret-detection checks
* container-image scanning hooks

Where practical, test infrastructure modules independently.

---

## 31. Documentation

Document:

* infrastructure architecture
* environment structure
* network topology
* cluster structure
* service dependencies
* data-service provisioning
* secrets management
* IAM model
* CI/CD
* deployment process
* autoscaling
* observability
* backups
* disaster-recovery boundaries
* cost controls
* operational runbooks
* infrastructure development workflow
* emergency-change process

Documentation must match actual infrastructure.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement:

* application business logic
* backend feature implementation
* frontend implementation
* mobile implementation
* routing algorithms
* map rendering logic
* search ranking algorithms
* GTFS ingestion logic
* traffic prediction
* ML recommendation systems
* media processing application logic
* notification application logic
* review/moderation workflows
* application database schema redesign
* application API redesign
* application event-schema redesign
* full multi-region active-active deployment unless already explicitly required and implementable within this infrastructure scope
* advanced service-mesh architecture unless required by an existing application contract
* organization-wide IAM unrelated to the platform
* unrelated corporate infrastructure

Do not create placeholder resources for systems outside this prompt.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect the repository structure.
2. Identify existing Terraform or equivalent infrastructure-as-code.
3. Inspect cloud-provider configuration.
4. Inspect Kubernetes manifests/charts.
5. Inspect container definitions.
6. Inspect CI/CD workflows.
7. Inspect environment/configuration files.
8. Inspect backend deployment configuration.
9. Inspect database configuration and migration tooling.
10. Inspect Redis configuration.
11. Inspect search infrastructure configuration.
12. Inspect object-storage configuration.
13. Inspect Kafka/Redpanda/queue configuration.
14. Inspect observability configuration.
15. Inspect secret-management configuration.
16. Inspect DNS/domain configuration.
17. Inspect security policies and scanning tools.
18. Inspect existing infrastructure documentation.
19. Inspect architecture artifacts defining deployment topology, service boundaries, dependencies, SLOs, backup expectations, and external integrations.

Reuse compatible existing infrastructure.

Do not assume previous AI conversations or hidden context exist.

Do not replace an existing production-capable infrastructure foundation without a documented reason.

The repository and explicit portable architecture/contract artifacts are the implementation sources of truth.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real infrastructure-as-code.
* Do not use pseudo-Terraform or pseudo-Kubernetes.
* Do not hardcode credentials.
* Do not commit secrets.
* Do not disable security controls merely to simplify deployment.
* Do not expose private data services publicly.
* Do not use mutable production image tags as release identity.
* Pin important dependency/provider versions according to project policy.
* Use least privilege.
* Encrypt sensitive data in transit and at rest.
* Keep environments isolated.
* Make resource ownership explicit.
* Define resource limits.
* Configure health checks.
* Configure graceful termination.
* Make backups observable.
* Test restoration paths where practical.
* Make alerting actionable.
* Avoid noisy alerts.
* Use infrastructure-as-code as the authoritative provisioning mechanism.
* Do not require undocumented manual steps for critical resources.
* Do not create circular infrastructure dependencies.
* Avoid unnecessary vendor lock-in while preserving operational realism.
* Document provider-specific assumptions.
* Keep cost implications explicit.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Validate infrastructure-as-code syntax.
* Validate infrastructure modules.
* Run static analysis.
* Run security scans.
* Run policy checks.
* Validate Kubernetes manifests/charts.
* Build container images where applicable.
* Validate image scanning.
* Validate CI/CD workflows.
* Validate network configuration.
* Validate IAM policies.
* Validate secret references.
* Validate PostgreSQL/PostGIS provisioning configuration.
* Validate Redis configuration.
* Validate streaming/queue configuration.
* Validate object-storage configuration.
* Validate CDN/edge configuration.
* Validate DNS/TLS configuration.
* Validate observability resources.
* Validate backup configuration.
* Validate restore procedures where execution is possible.
* Validate autoscaling configuration.
* Validate health checks and probes.
* Validate resource limits.
* Validate environment isolation.
* Validate cost-allocation metadata.
* Validate that no secrets are committed.
* Validate that no critical resource depends on an undocumented manual setup.
* Validate infrastructure documentation against actual configuration.

Resolve in-scope infrastructure defects discovered during validation.

Do not claim cloud resources were successfully deployed or restored unless the applicable operations were actually executed.

---

# EXPECTED DELIVERABLES

Produce the actual infrastructure implementation and supporting artifacts.

Expected deliverables include, as applicable:

* infrastructure-as-code modules
* development/staging/production environment definitions
* network infrastructure
* DNS/TLS configuration
* edge/ingress infrastructure
* Kubernetes platform
* container registry
* PostgreSQL/PostGIS infrastructure
* Redis infrastructure
* event-streaming infrastructure
* queue/dead-letter infrastructure
* object storage
* CDN configuration
* secret-management integration
* IAM/workload identities
* CI/CD foundation
* deployment manifests
* autoscaling
* observability infrastructure
* alerting
* resource governance
* cost controls
* backup infrastructure
* disaster-recovery foundation
* drift-control mechanisms
* security controls
* automated infrastructure validation
* operational runbooks
* infrastructure documentation

Do not artificially fragment infrastructure into meaningless modules.

---

# INTEGRATION REQUIREMENTS

The infrastructure must provide stable runtime boundaries for the existing application services.

Support deployment and operation of:

* public APIs
* geospatial services
* search services
* tile services
* routing services
* navigation/realtime services
* transit services
* content services
* media workers
* notification workers
* event consumers
* background jobs

Maintain stable integration points for:

* databases
* caches
* event streams
* queues
* object storage
* CDN
* DNS
* secrets
* observability
* workload identity

Infrastructure resource names and endpoints must be deterministic and environment-aware.

Do not require application teams to hardcode infrastructure-specific secrets.

Expose only the configuration necessary for applications to connect safely.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Infrastructure-as-code foundation implemented.
2. Environment structure implemented.
3. Networking implemented.
4. DNS/TLS implemented.
5. Edge/ingress implemented.
6. Kubernetes platform implemented where applicable.
7. Container registry implemented.
8. PostgreSQL/PostGIS infrastructure implemented.
9. Redis infrastructure implemented.
10. Event-streaming infrastructure implemented.
11. Queue/dead-letter infrastructure implemented.
12. Object storage implemented.
13. CDN/asset-delivery infrastructure implemented.
14. Secrets/configuration management implemented.
15. IAM/workload identity implemented.
16. CI/CD foundation implemented.
17. Deployment configuration implemented.
18. Autoscaling implemented.
19. Observability implemented.
20. Monitoring/alerting implemented.
21. Backup infrastructure implemented.
22. Disaster-recovery foundation implemented.
23. Security baseline implemented.
24. Cost controls implemented.
25. Drift-control mechanisms implemented.
26. Operational runbooks created.
27. Infrastructure tests and validation executed.
28. Documentation created or updated.
29. Important implementation decisions or deviations.
30. Environment/provider limitations encountered.
31. Exact infrastructure files/modules/artifacts changed or created.

Do not claim successful provisioning or execution where the environment did not permit it.

---

# DEFINITION OF DONE

This prompt is complete only when:

* Development, staging, and production infrastructure boundaries are explicitly represented.
* Infrastructure is reproducible through version-controlled infrastructure-as-code.
* Network boundaries prevent unintended public access to internal data services.
* DNS and TLS are configured according to the production architecture.
* The application runtime platform is provisioned and governed.
* Container images have a secure registry and immutable release strategy.
* PostgreSQL/PostGIS is provisioned with appropriate availability, encryption, backup, and monitoring.
* Redis is provisioned for highly available non-authoritative state and caching workloads.
* Event streaming and queue infrastructure are provisioned with authentication, retention, retry, and monitoring controls.
* Object storage is private and lifecycle-managed.
* CDN/edge delivery is configured for globally distributable assets.
* Secrets are centrally managed and not embedded in source control or application images.
* Workload identities use least privilege.
* CI/CD provides controlled environment promotion.
* Applications have production-safe deployment configuration.
* Autoscaling and resource governance are configured.
* Logs, metrics, traces, dashboards, and alerts have a production foundation.
* Backups are automated, monitored, and restorable where validation is possible.
* Disaster-recovery boundaries are explicitly documented and supported by infrastructure.
* Infrastructure security controls are active.
* Cost ownership and lifecycle controls are present.
* Drift-control and infrastructure validation exist.
* Operational runbooks reflect the implemented platform.
* Documentation matches the actual infrastructure.
* No hardcoded credentials, pseudo-infrastructure, placeholder resources, TODO/FIXME gaps, or undocumented critical manual setup remains within scope.

**Implement only the current prompt's scope.**
