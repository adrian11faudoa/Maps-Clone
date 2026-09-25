# Google Maps-Style Mapping & Navigation Platform — Architecture Prompt — Volume 1

# ROLE

You are the senior architecture engineering agent responsible for producing the **foundational architecture and portable engineering-contract package** for a production-grade **Google Maps-style mapping, place discovery, geocoding, routing, and navigation platform**.

Operate as a multidisciplinary architecture organization consisting of:

* Principal Architect
* Distributed Systems Architect
* Geospatial Architect
* Backend Architect
* Database Architect
* Search Architect
* Routing/Navigation Architect
* Data Platform Architect
* Security Architect
* Privacy Architect
* Infrastructure Architect
* SRE Architect
* Web Architect
* Mobile Architect
* QA Architect
* Technical Writer

The objective of this prompt is to create concrete architecture artifacts that independently generated backend, frontend, mobile, infrastructure, and QA implementations can consume later.

This is an **architecture and contract task**, not an instruction to implement the complete application.

Implement only the current prompt's scope.

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed system is intended to provide:

* interactive maps;
* map tile delivery;
* geographic feature rendering;
* address and place search;
* autocomplete;
* forward geocoding;
* reverse geocoding;
* place details;
* nearby discovery;
* user location;
* route planning;
* route alternatives;
* turn-by-turn navigation;
* ETA calculation;
* traffic-aware routing where supported;
* transit capabilities where supported;
* saved places;
* user contributions;
* ratings and reviews where included;
* place photos and media;
* reports and moderation;
* notifications;
* administration;
* analytics;
* operational observability.

The platform is intended for large-scale international use.

The architecture must support independent project-part generation and later assembly by a final integration environment.

---

# CURRENT ARCHITECTURE SCOPE

This prompt is responsible for establishing the **foundational architecture and portable cross-part contracts** for the platform.

The current scope includes:

* system context;
* architectural principles;
* logical component boundaries;
* domain boundaries;
* service/module boundaries;
* authoritative data ownership;
* foundational identifier and timestamp conventions;
* API design standards;
* core error conventions;
* authentication/session architecture;
* authorization model;
* geospatial data architecture;
* database ownership and foundational schema boundaries;
* search architecture boundaries;
* map-tile architecture boundaries;
* routing and navigation architecture boundaries;
* event and asynchronous-processing boundaries;
* storage and media boundaries;
* observability architecture;
* security and privacy boundaries;
* deployment and environment architecture;
* scalability and reliability principles;
* external integration boundaries;
* architecture decision records;
* implementation handoff documentation;
* portable contract artifacts.

Do not implement the application features themselves.

Do not build the complete backend.

Do not build the web application.

Do not build the mobile applications.

Do not provision production cloud infrastructure.

Do not create a full QA implementation.

Those responsibilities belong to separately bounded implementation prompts.

---

# EXPLICIT OUT-OF-SCOPE

Do not turn this architecture task into an application implementation milestone.

The following are explicitly outside the current scope unless a tiny executable example is absolutely necessary to validate an architectural artifact:

* full backend feature implementation;
* complete REST controllers;
* production frontend screens;
* production mobile screens;
* full route-calculation implementation;
* production navigation engine implementation;
* production traffic engine implementation;
* complete search implementation;
* complete map-tile generation;
* production cloud provisioning;
* complete Kubernetes deployment;
* full CI/CD implementation;
* complete end-to-end test suite;
* production operational execution;
* real production dataset acquisition;
* live third-party provider activation;
* generation of credentials;
* generation of secrets;
* claiming that external services are provisioned.

Architecture documentation, schemas, machine-readable contracts, and configuration specifications are in scope.

---

# REPOSITORY INSPECTION

Inspect the repository before creating architecture artifacts.

Determine:

* current repository structure;
* existing applications;
* existing packages/modules;
* existing backend services;
* existing frontend applications;
* existing mobile applications;
* existing infrastructure directories;
* existing database schemas;
* existing migrations;
* existing OpenAPI or API specifications;
* existing event schemas;
* existing configuration;
* existing tests;
* existing documentation;
* package managers;
* dependency versions;
* build tooling;
* linting;
* formatting;
* CI configuration.

Treat the repository's actual state as authoritative for what already exists.

Do not assume that a prior AI conversation generated anything.

Do not claim that architecture already exists merely because a project description implies it should.

If architecture artifacts already exist in the repository, inspect them and preserve compatible decisions unless they conflict with explicit requirements in this prompt.

Do not perform a destructive architecture rewrite merely to impose a preferred structure.

---

# ARCHITECTURAL OBJECTIVE

Produce a sufficiently concrete architecture that an independent engineering agent can implement the system without relying on undocumented architectural decisions.

The architecture must answer:

* What are the major system components?
* What responsibilities belong to each component?
* Which data is authoritative?
* Which data is derived?
* How do components communicate?
* Which operations are synchronous?
* Which operations are asynchronous?
* Which operations require real-time delivery?
* What are the major API boundaries?
* What are the major domain boundaries?
* What are the database ownership boundaries?
* Which systems own geospatial source data?
* Which systems own search indexes?
* Which systems own map-tile artifacts?
* Which systems own route computations?
* How are navigation sessions represented?
* How is location telemetry handled?
* How are user-generated place contributions handled?
* How do media flows operate?
* How are events versioned?
* What failures are expected?
* How does the system degrade?
* How is security enforced?
* How is privacy enforced?
* How will the architecture scale?
* What is deployed where?
* How can independently generated project parts integrate later?

Do not leave these decisions as vague future work.

---

# ARCHITECTURAL PRINCIPLES

The architecture must follow these principles.

## Authoritative Source Separation

Clearly distinguish:

* authoritative transactional data;
* source geospatial data;
* derived search documents;
* cached data;
* generated map tiles;
* routing graph data;
* traffic aggregates;
* analytics data;
* operational telemetry.

Do not allow derived indexes or caches to become accidental sources of truth.

## Explicit Ownership

Every major domain must have one clear authoritative owner.

Document:

* data owner;
* write authority;
* read interfaces;
* consumers;
* synchronization mechanism;
* deletion behavior;
* lifecycle.

## Contract-First Integration

Cross-part contracts must be explicit and portable.

Contracts must not exist only in prose when a machine-readable representation is practical.

## Separation of Control Plane and Data Plane

Where appropriate, distinguish high-volume operational data paths from administrative/configuration operations.

## Failure Isolation

A search outage should not unnecessarily destroy authenticated account functionality.

A recommendation or analytics outage should not unnecessarily block route calculation.

A noncritical enrichment provider outage should have bounded impact.

## Deterministic Core Behavior

Important domain behavior must have explicit inputs, outputs, status values, and error semantics.

## Versionability

APIs, events, schemas, map data, and derived indexes must be evolvable without hidden compatibility assumptions.

## Operational Visibility

Every major component must expose meaningful health, metrics, logs, and tracing boundaries.

---

# SYSTEM CONTEXT

Create a system context artifact describing the relationship among:

* web clients;
* mobile clients;
* public APIs;
* authentication;
* map delivery;
* geocoding;
* place/search;
* routing;
* navigation;
* traffic processing;
* location telemetry;
* place contributions;
* media;
* notifications;
* administration;
* analytics;
* event streaming;
* background jobs;
* databases;
* caches;
* search indexes;
* object storage;
* external geographic providers;
* traffic providers;
* transit providers where used;
* map-data sources;
* observability systems.

Represent external dependencies explicitly.

Do not depict external systems as though they are internally controlled services.

---

# COMPONENT ARCHITECTURE

Define the major logical components and their responsibilities.

At minimum evaluate the following logical areas:

* API gateway/edge;
* identity and session management;
* user/profile domain;
* place domain;
* geocoding;
* search;
* map data/tile services;
* routing;
* navigation;
* traffic;
* location ingestion;
* trip/session management;
* saved places;
* user contributions;
* reviews/ratings;
* media;
* notifications;
* moderation;
* administration;
* analytics;
* event streaming;
* background processing;
* configuration;
* observability.

Do not create a separate microservice merely because a domain exists.

Document whether each boundary should initially be:

* a standalone service;
* a modular backend domain;
* a specialized computational service;
* a data pipeline;
* an external dependency.

Explain the boundary using operational and scaling requirements.

The architecture must allow future decomposition without requiring unnecessary distributed complexity in the first implementation.

---

# DOMAIN BOUNDARIES

Define canonical domains.

For every major domain document:

* purpose;
* owned entities;
* authoritative data;
* read responsibilities;
* write responsibilities;
* API boundary;
* event boundary;
* data dependencies;
* security boundary;
* operational characteristics.

At minimum establish boundaries for:

* identity;
* users;
* places;
* geographic/address data;
* search;
* maps/tiles;
* routing;
* navigation;
* traffic;
* trips;
* location telemetry;
* saved places;
* contributions;
* reviews;
* media;
* notifications;
* moderation;
* administration;
* analytics.

If two concepts belong in the same bounded context, explicitly justify that decision.

Do not create ambiguous ownership.

---

# DATA OWNERSHIP MODEL

Create a portable data-ownership matrix.

For each important entity or dataset define:

* canonical owner;
* storage system;
* primary key/identifier strategy;
* mutable fields;
* derived fields;
* consumers;
* publication mechanism;
* deletion behavior;
* retention;
* consistency expectations.

At minimum consider:

* User;
* Device/Session;
* Place;
* Address;
* GeographicFeature;
* RoadSegment;
* MapDataVersion;
* SearchDocument;
* RouteRequest;
* Route;
* RouteLeg;
* RouteStep;
* NavigationSession;
* LocationEvent;
* TrafficSnapshot;
* Incident;
* SavedPlace;
* Review;
* Rating;
* PlacePhoto;
* Contribution;
* ModerationCase;
* Notification;
* AuditRecord.

The final artifact must distinguish canonical entities from projections and materialized representations.

---

# IDENTIFIER AND TIME MODEL

Establish one project-wide identity convention.

Define:

* identifiers;
* public identifiers;
* internal identifiers;
* UUID/ULID or selected strategy;
* route/request IDs;
* navigation session IDs;
* event IDs;
* idempotency keys;
* correlation IDs;
* trace IDs;
* external provider IDs.

Define timestamp conventions:

* UTC;
* serialization format;
* precision;
* server-generated versus client-provided times;
* ordering semantics;
* clock-skew handling;
* event-time versus processing-time semantics.

Define coordinate conventions:

* latitude/longitude order;
* coordinate reference systems;
* precision expectations;
* geometry encoding;
* distance units;
* speed units;
* bearing conventions.

Do not allow different project parts to invent incompatible identifier, timestamp, or coordinate conventions.

---

# API ARCHITECTURE

Create the foundational API contract.

Define:

* API style;
* resource naming;
* URL conventions;
* versioning;
* request/response envelopes;
* authentication requirements;
* authorization behavior;
* error structure;
* pagination;
* filtering;
* sorting;
* idempotency;
* rate limiting;
* correlation identifiers;
* content negotiation;
* localization;
* unit handling.

At minimum define the contract families for:

* authentication;
* user profile;
* place lookup;
* place search;
* autocomplete;
* geocoding;
* reverse geocoding;
* nearby search;
* route calculation;
* navigation session management;
* saved places;
* contributions;
* reviews;
* media;
* notifications.

The architecture artifact must be precise enough for later implementation prompts to turn it into actual APIs.

Do not implement controllers during this task.

---

# ERROR CONTRACT

Define a project-wide error model.

At minimum establish:

* machine-readable error code;
* human-readable message;
* HTTP status;
* request/correlation ID;
* field-level validation details where applicable;
* retryability;
* documentation/reference field where useful.

Define categories for:

* authentication;
* authorization;
* validation;
* not found;
* conflict;
* rate limiting;
* dependency failure;
* service unavailable;
* timeout;
* geospatial input errors;
* routing failures;
* navigation-state conflicts.

Do not leak sensitive internal implementation details through public errors.

---

# AUTHENTICATION AND SESSION ARCHITECTURE

Define:

* supported authentication mechanisms;
* access-token model;
* refresh-token model;
* session lifecycle;
* device/session tracking;
* logout;
* revocation;
* account recovery;
* credential reset;
* MFA extension points where appropriate;
* token storage responsibilities by web and mobile;
* service-to-service authentication;
* administrative authentication.

Define which claims are authoritative.

Define what happens when sessions expire or are revoked.

The web and mobile clients must never be treated as authoritative for identity or permission decisions.

---

# AUTHORIZATION ARCHITECTURE

Define the authorization model.

At minimum distinguish:

* anonymous access;
* authenticated user access;
* user-owned resources;
* contributor permissions;
* moderator permissions;
* support permissions;
* administrator permissions;
* service-to-service permissions.

Define resource-level authorization for:

* user data;
* saved places;
* location history;
* navigation sessions;
* contributions;
* reviews;
* media;
* administrative data.

Define protection against IDOR and privilege escalation.

---

# GEOSPATIAL DATA ARCHITECTURE

Define the geospatial data pipeline at an architectural level.

Document:

* raw source ingestion;
* source normalization;
* canonical geographic model;
* geometry processing;
* validation;
* versioning;
* updates;
* derived datasets;
* indexing;
* publication;
* rollback;
* provenance.

Establish how source data can flow into:

```text
External Geographic Sources
        ↓
Raw/Immutable Source Data
        ↓
Normalization + Validation
        ↓
Canonical Geospatial Dataset
        ↓
Derived Products
 ┌──────┼──────────┬────────────┐
 ↓      ↓          ↓            ↓
Search  Tiles   Routing Graph  Analytics
```

Define which representations are authoritative and which are derived.

Document the lifecycle of geographic-data versions.

---

# POSTGRESQL / POSTGIS ARCHITECTURE

Define the authoritative relational data boundary.

Specify:

* database ownership;
* schema namespaces where useful;
* transactional domains;
* PostGIS usage;
* geometry versus geography usage;
* spatial reference system;
* spatial indexes;
* normal indexes;
* partitioning candidates;
* transaction boundaries;
* consistency requirements;
* migration strategy;
* read replicas;
* backup strategy;
* archival considerations.

Do not attempt to produce the full production schema in this architecture volume unless needed for an architectural contract.

Produce enough canonical entity definitions and relationships to prevent later prompts from inventing incompatible models.

---

# SEARCH ARCHITECTURE

Define the search pipeline and ownership.

At minimum establish:

* source-of-truth records;
* normalization;
* indexing;
* search document structure;
* text fields;
* aliases;
* categories;
* geographic fields;
* ranking inputs;
* freshness;
* indexing events;
* deletion;
* reindexing;
* alias/index migration;
* fallback behavior;
* caching.

Define the role of OpenSearch or an equivalent search engine.

Search must remain a derived representation of authoritative records unless explicitly documented otherwise.

---

# AUTOCOMPLETE AND GEOCODING ARCHITECTURE

Define distinct responsibilities for:

* autocomplete;
* forward geocoding;
* reverse geocoding;
* place search;
* nearby search.

Define:

* latency expectations;
* candidate generation;
* ranking;
* confidence;
* ambiguity;
* localization;
* geographic bias;
* source provenance;
* result normalization;
* caching;
* error behavior.

Do not make autocomplete an undocumented variation of general search.

---

# MAP-TILE ARCHITECTURE

Define:

* source geographic data;
* vector-tile generation;
* tile schemas;
* zoom levels;
* layer concepts;
* style configuration;
* tile versioning;
* CDN;
* cache-control;
* invalidation;
* regional publication;
* freshness;
* rollback.

Identify what belongs in:

* offline/precomputed pipelines;
* online delivery;
* client rendering.

Map tiles must never directly expose internal database access.

---

# ROUTING ARCHITECTURE

Define the routing system boundary.

Specify:

* route-request API;
* supported travel modes;
* routing-engine boundary;
* road-network graph;
* restrictions;
* waypoints;
* alternatives;
* traffic influence;
* route scoring;
* route geometry;
* route steps;
* warnings;
* calculation timeout;
* caching;
* route-request deduplication;
* failure behavior.

Establish how a routing engine such as Valhalla, OSRM, GraphHopper, or another selected engine integrates with the platform without coupling public APIs to engine-specific internal representations.

The public routing contract must be stable even if the internal routing engine changes.

---

# NAVIGATION ARCHITECTURE

Define the navigation session model.

Specify:

* navigation-session creation;
* route association;
* current-state model;
* location updates;
* map matching;
* maneuver progression;
* off-route detection;
* rerouting;
* ETA updates;
* session heartbeat;
* disconnect/reconnect;
* stale location handling;
* termination;
* background operation.

Define the authoritative server state versus client-derived transient state.

Do not assume that every GPS update is reliable.

---

# TRAFFIC ARCHITECTURE

Define a traffic-data architecture capable of consuming applicable sources such as:

* aggregated user telemetry;
* public traffic feeds;
* commercial traffic providers;
* road incidents;
* planned closures.

Distinguish:

* raw traffic observations;
* validated observations;
* aggregated traffic state;
* routing inputs;
* public map visualization.

Define:

* privacy boundaries;
* aggregation;
* retention;
* freshness;
* stale data behavior;
* source provenance;
* confidence;
* update frequency.

Do not claim that a live traffic capability exists without identifying its data source.

---

# LOCATION TELEMETRY ARCHITECTURE

Define a privacy-conscious location ingestion model.

Specify:

* event payload;
* source;
* device/session identity;
* timestamp;
* location precision;
* speed;
* heading;
* accuracy;
* validation;
* rate limiting;
* aggregation;
* retention;
* access control.

Define how the system protects against:

* impossible jumps;
* stale events;
* duplicate events;
* spoofed timestamps;
* excessive update rates.

Do not retain raw location data indefinitely without a documented requirement.

---

# EVENT ARCHITECTURE

Define the event model.

Every event should support, where applicable:

* event ID;
* event type;
* event version;
* entity/aggregate ID;
* producer;
* occurred-at timestamp;
* published-at timestamp;
* correlation ID;
* trace context;
* schema version.

Define the initial domain-event families, such as:

* UserRegistered;
* SessionRevoked;
* PlaceCreated;
* PlaceUpdated;
* PlaceModerated;
* SearchDocumentRefreshRequested;
* PlaceMediaAdded;
* PlaceMediaRemoved;
* ContributionSubmitted;
* ReviewCreated;
* ReviewModerated;
* RouteRequested;
* NavigationStarted;
* NavigationEnded;
* LocationTelemetryReceived;
* TrafficSnapshotUpdated;
* NotificationRequested.

These names are architectural contracts and must remain consistent across future prompts unless explicitly changed.

Use stable naming and versioning conventions.

---

# EVENT DELIVERY SEMANTICS

Define:

* delivery expectation;
* ordering requirements;
* idempotency;
* retries;
* dead-letter handling;
* replay;
* consumer offsets;
* schema compatibility;
* publication reliability;
* outbox requirements;
* monitoring.

Default to at-least-once delivery unless a stronger guarantee is genuinely justified.

Do not claim exactly-once semantics without a technical basis.

---

# QUEUE AND BACKGROUND PROCESSING ARCHITECTURE

Define job categories for workloads such as:

* geographic data ingestion;
* data normalization;
* tile generation;
* search indexing;
* media processing;
* notification delivery;
* moderation workflows;
* analytics processing;
* traffic aggregation;
* route precomputation where needed;
* cleanup.

For every class define:

* purpose;
* producer;
* consumer;
* payload ownership;
* retry;
* backoff;
* timeout;
* concurrency;
* idempotency;
* priority;
* dead-letter behavior.

---

# REDIS ARCHITECTURE

Define explicit Redis responsibilities.

Evaluate uses including:

* response caching;
* autocomplete caching;
* nearby-result caching;
* rate limiting;
* session coordination;
* ephemeral navigation state where appropriate;
* distributed locks where genuinely necessary;
* temporary workflow state.

For each use define:

* key namespace;
* serialization;
* TTL;
* invalidation;
* ownership;
* failure behavior.

Redis must not become an undocumented authoritative database.

---

# OBJECT STORAGE AND MEDIA ARCHITECTURE

Define the media lifecycle:

```text
Client
  ↓
Authenticated Upload Request
  ↓
Object Storage
  ↓
Validation / Scanning
  ↓
Processing
  ↓
Derivative Generation
  ↓
Metadata Persistence
  ↓
CDN Delivery
```

Define:

* media ownership;
* upload authorization;
* file validation;
* size limits;
* processing;
* derivative variants;
* signed access;
* CDN;
* deletion;
* retention;
* lifecycle cleanup.

Object storage access must remain protected.

---

# NOTIFICATION ARCHITECTURE

Define notification domains for:

* navigation/trip events;
* user account events;
* moderation outcomes;
* contributions;
* operationally relevant product events.

Separate:

* notification intent;
* delivery provider;
* delivery status;
* retry behavior;
* user preferences.

Support applicable channels such as:

* push;
* email;
* in-app.

Do not tightly couple core domain transactions to unreliable third-party notification providers.

---

# MODERATION AND ADMINISTRATION ARCHITECTURE

Define boundaries for:

* user reports;
* place corrections;
* review moderation;
* media moderation;
* account restrictions;
* administrator actions;
* audit records.

Administrative actions must include:

* authorization;
* actor identity;
* action type;
* target;
* timestamp;
* reason where required;
* auditability.

Do not allow moderation tooling to bypass normal authorization controls.

---

# SECURITY ARCHITECTURE

Create a threat-oriented security architecture covering at least:

* API edge;
* identity;
* authorization;
* geospatial APIs;
* routing APIs;
* location ingestion;
* media uploads;
* search;
* administrative APIs;
* internal service communication;
* event streams;
* queues;
* data storage.

Evaluate threats including:

* authentication bypass;
* IDOR;
* privilege escalation;
* injection;
* SSRF;
* malicious uploads;
* credential stuffing;
* scraping;
* route-query abuse;
* telemetry abuse;
* location-data exposure;
* secret leakage;
* denial of service.

Define security boundaries and trust zones.

---

# PRIVACY ARCHITECTURE

Define data classes for:

* account information;
* approximate/public location;
* precise private location;
* navigation history;
* saved places;
* reviews;
* media;
* administrative data;
* telemetry;
* analytics.

For each relevant class document:

* purpose;
* minimum collection;
* retention;
* access control;
* deletion;
* auditability;
* aggregation/anonymization requirements.

Precise user location must receive stronger controls than ordinary public place data.

---

# OBSERVABILITY ARCHITECTURE

Define the observability boundaries for:

* API edge;
* application services;
* databases;
* PostGIS;
* Redis;
* search;
* routing;
* navigation;
* location ingestion;
* queues;
* event streams;
* media processing;
* external providers;
* map-tile delivery.

Define the required:

* logs;
* metrics;
* traces;
* health checks;
* readiness;
* liveness;
* correlation IDs;
* dashboards;
* alerts.

Specify what sensitive information must not be logged.

---

# RELIABILITY ARCHITECTURE

For each major component, document:

* timeout policy;
* retry behavior;
* idempotency;
* failure isolation;
* fallback;
* degraded behavior;
* queue buffering;
* reconciliation;
* recovery.

Explicitly address failures involving:

* PostgreSQL;
* Redis;
* search;
* routing engine;
* traffic source;
* geographic-data pipeline;
* object storage;
* CDN;
* event broker;
* queue workers;
* notification providers.

Define which capabilities remain available during partial dependency failure.

---

# SCALABILITY ARCHITECTURE

Map the expected scaling characteristics of:

* API requests;
* search;
* autocomplete;
* tile delivery;
* geocoding;
* routing;
* navigation sessions;
* location telemetry;
* traffic processing;
* media;
* events;
* background jobs.

Document likely scaling dimensions such as:

* horizontal service scaling;
* read replicas;
* geographic partitioning;
* sharding candidates;
* precomputed artifacts;
* CDN;
* cache;
* queue partitioning;
* regional deployment;
* data partitioning.

Do not prematurely introduce distributed infrastructure with no demonstrated architectural purpose.

---

# DEPLOYMENT AND ENVIRONMENT ARCHITECTURE

Define the logical environment model:

* local development;
* CI;
* test;
* development;
* staging;
* production;
* disaster recovery.

Define deployment boundaries for:

* application services;
* routing engines;
* search;
* Redis;
* event streaming;
* job workers;
* databases;
* tile pipelines;
* media processing.

Define where secrets, certificates, configuration, and feature flags belong.

Do not claim real cloud resources exist.

---

# EXTERNAL INTEGRATION BOUNDARIES

Define adapter boundaries for:

* geographic-data providers;
* routing providers or engines;
* traffic providers;
* transit providers;
* notification providers;
* map-data sources;
* identity providers where applicable.

Each integration contract must define:

* provider boundary;
* authentication mechanism;
* request/response abstraction;
* timeout;
* retry;
* rate limit;
* quota;
* error mapping;
* fallback;
* observability;
* provider-specific configuration.

Do not allow provider-specific assumptions to leak through every application layer.

---

# VERSIONING AND DATA EVOLUTION

Define compatibility rules for:

* APIs;
* events;
* database schemas;
* map datasets;
* search indexes;
* routing graph versions;
* configuration.

Address:

* rolling deployment;
* backward compatibility;
* schema migration;
* index rebuild;
* dual-read/dual-write only where justified;
* event versioning;
* rollback;
* dataset rollback.

---

# ARCHITECTURE ARTIFACT PACKAGE

Create a portable architecture package in the repository.

Use a clear documentation structure and machine-readable formats where appropriate.

At minimum, produce artifacts covering:

1. Project architecture overview.
2. System context.
3. Logical component architecture.
4. Domain and bounded-context model.
5. Data ownership matrix.
6. Identifier/time/coordinate model.
7. API architecture and foundational API contract.
8. Error contract.
9. Authentication/session/authorization architecture.
10. Geospatial data architecture.
11. Database/PostGIS architecture and foundational entity model.
12. Search/geocoding/autocomplete architecture.
13. Map-tile architecture.
14. Routing/navigation/traffic architecture.
15. Event/queue architecture.
16. Storage/media architecture.
17. Notifications/moderation/administration architecture.
18. Security and privacy architecture.
19. Observability/reliability architecture.
20. Deployment/scalability/external-integration architecture.
21. Architecture decision records for material technology and boundary decisions.
22. Cross-part integration contract matrix.

Do not force an arbitrary one-file-per-topic structure if the repository's documentation architecture clearly supports a better organization.

However, every listed architectural responsibility must be represented explicitly and discoverably.

---

# MACHINE-READABLE CONTRACTS

Where practical, create machine-readable artifacts that later implementation agents can consume.

Examples include:

* OpenAPI;
* JSON Schema;
* event schemas;
* configuration schemas;
* shared TypeScript contract packages where appropriate;
* SQL/entity specifications;
* formal enum definitions.

Use the repository's technology and tooling when already established.

Do not create duplicate competing sources of truth.

For each machine-readable artifact, document:

* authoritative location;
* version;
* consumers;
* update procedure.

---

# CROSS-PART INTEGRATION CONTRACT MATRIX

Create a dedicated matrix showing how architecture connects later implementation areas.

At minimum map:

| Contract      | Authoritative Artifact | Backend Consumer | Web Consumer         | Mobile Consumer      | Infrastructure Consumer | QA Consumer          |
| ------------- | ---------------------- | ---------------- | -------------------- | -------------------- | ----------------------- | -------------------- |
| API           | Explicit contract      | Yes              | Yes                  | Yes                  | Gateway/deployment      | Contract tests       |
| Auth/session  | Auth contract          | Yes              | Yes                  | Yes                  | IAM/secret boundaries   | Security tests       |
| Data model    | Schema/domain artifact | Yes              | Indirect             | Indirect             | DB deployment           | DB/integration tests |
| Events        | Event schemas          | Yes              | Indirect             | Indirect             | Broker                  | Event tests          |
| Queues        | Queue contract         | Yes              | No                   | No                   | Worker infrastructure   | Job tests            |
| Realtime      | Realtime contract      | Yes              | Yes                  | Yes                  | Gateway/networking      | Realtime tests       |
| Media         | Media contract         | Yes              | Yes                  | Yes                  | Storage/CDN             | Media tests          |
| Search        | Search contract        | Yes              | Yes                  | Yes                  | Search infrastructure   | Search tests         |
| Routing       | Routing contract       | Yes              | Yes                  | Yes                  | Routing deployment      | Routing tests        |
| Observability | Telemetry contract     | Yes              | Yes where applicable | Yes where applicable | Yes                     | Validation           |

Expand the matrix to cover the project's actual domains.

This matrix is mandatory because project parts may be generated independently.

---

# ARCHITECTURE DECISION RECORDS

Create ADRs for material decisions such as:

* modular monolith versus independently deployed services;
* PostgreSQL/PostGIS as authoritative geospatial store;
* search engine choice;
* routing-engine abstraction;
* event-streaming choice;
* Redis responsibilities;
* tile strategy;
* storage/CDN architecture;
* identifier strategy;
* API versioning;
* location-telemetry privacy model;
* deployment topology.

Each ADR should contain:

* context;
* decision;
* alternatives considered;
* rationale;
* consequences;
* operational implications.

Do not create ADRs for trivial implementation details.

---

# QUALITY REQUIREMENTS

Architecture artifacts must be:

* internally consistent;
* technically concrete;
* implementable;
* versionable;
* portable;
* discoverable;
* compatible with independent Claude conversations;
* compatible with final Codex integration.

Do not create contradictory service boundaries.

Do not create conflicting ownership models.

Do not define two incompatible identifier schemes.

Do not define two incompatible event envelopes.

Do not define APIs that cannot represent the architectural domain model.

Do not define infrastructure without application ownership.

Do not design every domain as an independent microservice merely to appear scalable.

---

# VALIDATION

Before declaring this architecture prompt complete, validate the artifacts against one another.

Perform at least the following checks:

## Contract Consistency

Verify that:

* entity names match;
* identifiers match;
* timestamp conventions match;
* coordinate conventions match;
* API resource names match;
* event names match;
* event versions match;
* status values match;
* error codes match;
* authentication terminology matches;
* authorization terminology matches.

## Ownership Consistency

Verify that each major entity and dataset has one authoritative owner.

## Dependency Consistency

Verify that every dependency has:

* purpose;
* interface;
* failure behavior;
* ownership;
* observability.

## Scale Consistency

Verify that high-volume workloads have plausible scaling mechanisms.

## Security Consistency

Verify that protected data has explicit authorization boundaries.

## Privacy Consistency

Verify that location data has appropriate retention and access controls.

## Deployment Consistency

Verify that application components map to deployable infrastructure boundaries.

## Integration Consistency

Verify that later backend, web, mobile, infrastructure, and QA prompts can consume the architecture without requiring hidden knowledge from another AI conversation.

---

# TESTING OF ARCHITECTURAL ARTIFACTS

This architecture prompt does not require implementation of the full application test suite.

It does require validation of the architecture package itself.

Where tooling supports it:

* validate OpenAPI;
* validate JSON Schemas;
* validate event schemas;
* validate machine-readable configuration schemas;
* validate diagrams;
* validate generated documentation links;
* validate consistency of referenced artifact paths;
* validate examples against formal schemas.

Any executable validation created specifically for architecture contracts must be real and must actually run.

Do not create fake validation scripts.

---

# DOCUMENTATION REQUIREMENTS

The architecture package must include a top-level navigation or index document explaining:

* architecture package contents;
* authoritative artifacts;
* artifact ownership;
* contract locations;
* versioning;
* how implementation agents should consume the artifacts;
* how Codex should use the package during final integration;
* how architectural changes should be recorded.

Documentation must describe the actual files generated during this execution.

Do not document nonexistent implementation.

---

# CODEX INTEGRATION REQUIREMENTS

The architecture package must be designed for later assembly by Codex or another final integration environment.

Codex must be able to determine from the generated artifacts:

* canonical domains;
* canonical entities;
* API contracts;
* event contracts;
* queue contracts;
* database ownership;
* service boundaries;
* storage boundaries;
* infrastructure dependencies;
* observability requirements;
* security boundaries;
* privacy boundaries;
* external integrations;
* versioning rules.

Do not rely on this prompt having been read by Codex later.

The artifacts themselves must carry the necessary architectural information.

---

# IMPLEMENTATION CONSTRAINT

Do not implement unrelated application functionality during this architecture task.

The objective is to create the architecture and portable contract foundation required for subsequent implementation work.

Where the repository already contains implementation, do not rewrite working code merely to demonstrate architecture.

Modify application code only when required to establish or validate architecture artifacts within this scope.

---

# COMPLETION REPORT

After completing the architecture work, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* architecture domains established;
* service/module boundaries established;
* data ownership decisions;
* API contracts created;
* event contracts created;
* queue contracts created;
* database/PostGIS decisions;
* search decisions;
* routing/navigation decisions;
* map-tile decisions;
* media/storage decisions;
* authentication and authorization decisions;
* security/privacy decisions;
* observability decisions;
* reliability decisions;
* deployment decisions;
* ADRs created;
* machine-readable contracts created;
* validation performed;
* documentation created or updated;
* integration considerations for later project parts;
* unresolved architectural issues, if any.

The report must accurately describe the repository changes.

Do not claim that the application has been implemented.

Do not claim that external infrastructure has been provisioned.

Do not claim that external providers have been activated.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* the foundational architecture is documented;
* major domains are explicitly bounded;
* major component/service boundaries are explicit;
* authoritative data ownership is explicit;
* identifier, timestamp, and coordinate conventions are explicit;
* API conventions are defined;
* error conventions are defined;
* authentication/session architecture is defined;
* authorization is defined;
* geospatial data flow is defined;
* PostgreSQL/PostGIS responsibilities are defined;
* search architecture is defined;
* autocomplete/geocoding architecture is defined;
* map-tile architecture is defined;
* routing architecture is defined;
* navigation architecture is defined;
* traffic architecture is defined;
* location telemetry architecture is defined;
* events are defined as portable contracts;
* queues/background jobs are defined;
* media/storage boundaries are defined;
* notifications/moderation/administration boundaries are defined;
* security boundaries are defined;
* privacy requirements are defined;
* observability boundaries are defined;
* reliability requirements are defined;
* scalability decisions are documented;
* deployment boundaries are documented;
* external integration boundaries are documented;
* versioning rules are documented;
* machine-readable contracts are validated where applicable;
* cross-part integration matrix exists;
* material architecture decisions are documented;
* the architecture package is portable and independently consumable;
* no critical architectural decision remains implicit;
* no pseudo-code or fake implementation is being presented as architecture execution;
* documentation accurately reflects generated artifacts;
* the final diff was inspected;
* the completion report accurately reflects the work.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement the complete mapping and navigation platform during this architecture milestone.
