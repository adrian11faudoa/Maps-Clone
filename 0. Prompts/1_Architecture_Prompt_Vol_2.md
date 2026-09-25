# Google Maps-Style Mapping & Navigation Platform — Architecture Prompt — Volume 2

# ROLE

You are the senior architecture engineering agent responsible for producing the **implementation-ready contract, schema, protocol, and operational architecture package** for a production-grade **Google Maps-style mapping, place discovery, geocoding, routing, traffic, and navigation platform**.

Operate as a multidisciplinary architecture organization consisting of:

* Principal Architect
* Distributed Systems Architect
* Geospatial Architect
* API Architect
* Backend Architect
* Database Architect
* Search Architect
* Routing Architect
* Navigation Architect
* Realtime Systems Architect
* Data Platform Architect
* Security Architect
* Privacy Architect
* Infrastructure Architect
* SRE Architect
* Web Architect
* Mobile Architect
* QA Architect
* Technical Writer

This prompt is responsible for turning the project's foundational architecture into **concrete, portable, implementation-grade contracts**.

This is an **architecture and contract-definition task**, not an instruction to implement the complete product.

Implement only the current prompt's scope.

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed system is intended to support:

* interactive maps;
* vector-map rendering;
* map tile delivery;
* address and place search;
* autocomplete;
* forward geocoding;
* reverse geocoding;
* nearby discovery;
* place details;
* geographic data ingestion;
* route planning;
* route alternatives;
* multi-modal travel;
* turn-by-turn navigation;
* ETA calculation;
* traffic-aware routing where supported;
* traffic and incident information;
* user location;
* trip and navigation sessions;
* saved places;
* user contributions;
* reviews and ratings where included;
* place photos and other media;
* moderation;
* administration;
* notifications;
* analytics;
* operational observability.

The completed platform is intended for large international usage and must remain compatible with independently generated implementation parts and later Codex integration.

---

# CURRENT ARCHITECTURE SCOPE

This prompt is responsible for the **deep contract and implementation-specification layer** of the architecture.

The current scope includes:

* canonical domain entity definitions;
* API endpoint specifications;
* request and response schemas;
* pagination and filtering contracts;
* authentication and authorization contracts;
* realtime/navigation protocols;
* geospatial data contracts;
* routing request/response contracts;
* geocoding contracts;
* search/autocomplete contracts;
* map tile contracts;
* event envelopes and event schemas;
* queue/job contracts;
* database contract details;
* cache-key conventions;
* configuration conventions;
* media contracts;
* notification contracts;
* moderation contracts;
* idempotency conventions;
* concurrency rules;
* compatibility and versioning rules;
* data lifecycle conventions;
* operational SLO/SLA-oriented contracts;
* cross-service failure behavior;
* machine-readable implementation artifacts;
* contract validation;
* integration handoff documentation.

The goal is to make the architecture sufficiently concrete that independently working backend, web, mobile, infrastructure, data, and QA agents can implement compatible systems without relying on undocumented assumptions.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement the full product.

Do not use this prompt to create:

* complete production backend services;
* complete web applications;
* complete mobile applications;
* production cloud resources;
* complete Kubernetes environments;
* production routing engine code;
* full search implementation;
* complete geospatial ingestion pipelines;
* complete tile-generation pipelines;
* production traffic-processing implementation;
* full media-processing services;
* complete moderation applications;
* full QA automation across the entire product;
* live third-party provider activation;
* real credentials or secrets.

Creating architecture files, formal schemas, API specifications, contract packages, configuration schemas, and validation tooling is in scope.

---

# REPOSITORY INSPECTION

Inspect the repository before creating or modifying architecture artifacts.

Determine:

* current repository structure;
* existing architecture documentation;
* existing API specifications;
* existing OpenAPI files;
* existing JSON Schemas;
* existing database schemas;
* migrations;
* entity models;
* event definitions;
* queue definitions;
* shared types;
* configuration schemas;
* authentication contracts;
* realtime contracts;
* search contracts;
* routing contracts;
* media contracts;
* notification contracts;
* infrastructure definitions;
* tests validating contracts.

Treat the actual repository state as authoritative.

Do not assume that another AI generated anything outside the repository.

Preserve compatible existing contracts when they do not conflict with the requirements of this prompt.

Do not create duplicate competing contract sources of truth.

---

# ARCHITECTURAL CONTEXT

The platform uses the following technology direction:

## Web

* TypeScript
* React
* Next.js
* MapLibre-compatible map rendering

## Mobile

* React Native
* TypeScript
* native location capabilities
* secure credential storage
* push notifications
* background location where required

## Backend

* TypeScript
* NestJS or equivalent modular framework
* specialized Go services where high-performance geospatial or routing workloads justify them

## Data

* PostgreSQL
* PostGIS
* Redis
* OpenSearch or equivalent
* object storage
* Kafka, Redpanda, or equivalent event streaming
* queue/job infrastructure where required

## Infrastructure

* containers;
* Kubernetes where justified;
* Terraform or equivalent infrastructure-as-code;
* CDN;
* load balancing;
* secure networking;
* secrets management;
* CI/CD;
* backups;
* disaster recovery.

## Observability

* OpenTelemetry-compatible tracing;
* structured logging;
* metrics;
* dashboards;
* alerting;
* error tracking.

The exact internal implementation may evolve, but portable contracts must remain stable.

---

# CANONICAL ENTITY CONTRACTS

Create a machine-readable and human-readable canonical domain model.

Define, at minimum, the following entities where applicable:

* User
* UserProfile
* Device
* Session
* Place
* PlaceCategory
* PlaceAlias
* Address
* GeographicFeature
* Road
* RoadSegment
* Intersection
* MapDatasetVersion
* MapTile
* SearchDocument
* RouteRequest
* Route
* RouteAlternative
* RouteLeg
* RouteStep
* NavigationSession
* NavigationState
* LocationEvent
* TrafficObservation
* TrafficSegmentState
* TrafficIncident
* TransitStop
* TransitRoute
* TransitJourney
* SavedPlace
* SavedPlaceList
* Review
* Rating
* PlacePhoto
* MediaAsset
* Contribution
* ModerationCase
* Notification
* AuditRecord
* IdempotencyRecord

For every entity define:

* identifier;
* owning domain;
* authoritative storage;
* required fields;
* optional fields;
* immutable fields;
* mutable fields;
* relationships;
* lifecycle states;
* timestamps;
* deletion semantics;
* privacy classification;
* authorization rules;
* externally visible identifiers where applicable.

Do not create conflicting representations of the same domain entity.

---

# ENUM AND STATUS CONTRACT

Create one canonical definition for important enumerations.

At minimum evaluate:

* account status;
* session status;
* place status;
* place moderation status;
* contribution status;
* review status;
* media status;
* navigation status;
* route status;
* routing mode;
* transport mode;
* traffic condition;
* incident status;
* notification status;
* job status;
* moderation status.

For each enum define:

* canonical string value;
* meaning;
* lifecycle transitions;
* terminal states;
* compatibility rules.

Do not use inconsistent status strings across APIs, database fields, events, and clients.

---

# API CONTRACT

Create an implementation-ready API specification.

Use OpenAPI or another machine-readable API contract appropriate to the repository.

The contract must define, where applicable:

## Authentication

* registration;
* login;
* refresh;
* logout;
* session listing;
* session revocation;
* recovery;
* credential management.

## Users

* current user;
* profile;
* devices;
* preferences.

## Places

* place lookup;
* place details;
* nearby places;
* category filtering;
* place corrections.

## Search

* text search;
* autocomplete;
* structured address search;
* nearby discovery.

## Geocoding

* forward geocoding;
* reverse geocoding.

## Routes

* route calculation;
* alternatives;
* route metadata;
* route refresh;
* route status where appropriate.

## Navigation

* navigation-session creation;
* state updates;
* location updates;
* rerouting;
* session termination.

## Saved Places

* save;
* update;
* delete;
* list;
* custom lists.

## Contributions

* submit;
* update;
* withdraw;
* report;
* moderation status.

## Reviews and Ratings

* create;
* update;
* delete;
* list.

## Media

* upload authorization;
* metadata;
* association;
* deletion;
* access.

## Notifications

* list;
* read;
* preferences.

## Administration

* moderation;
* reports;
* user restrictions;
* audit access.

For every endpoint define:

* method;
* path;
* authentication;
* authorization;
* request schema;
* response schema;
* errors;
* pagination where relevant;
* filtering;
* sorting where relevant;
* idempotency where relevant;
* rate limits;
* cache semantics where relevant;
* observability requirements.

Do not expose database implementation details unnecessarily.

---

# API REQUEST AND RESPONSE CONVENTIONS

Establish one consistent project-wide convention for:

* JSON casing;
* envelopes;
* resource representations;
* timestamps;
* coordinates;
* units;
* nullability;
* optional fields;
* enum serialization;
* links where useful;
* request IDs;
* correlation IDs.

Define whether API responses use:

* direct resource objects;
* collection envelopes;
* metadata;
* pagination cursors;
* error envelopes.

Use the same convention across web and mobile APIs.

Do not let independently implemented endpoints invent their own formatting.

---

# PAGINATION CONTRACT

Define pagination separately for:

* place search;
* nearby search;
* reviews;
* saved places;
* notifications;
* administrative lists;
* audit logs;
* contribution history.

Prefer cursor-based pagination for large or mutable datasets.

Define:

* cursor format;
* cursor stability;
* sort ordering;
* page size limits;
* maximum page size;
* invalid cursor behavior;
* deleted-record behavior;
* consistency expectations.

Avoid offset pagination where it would cause unacceptable large-dataset behavior.

---

# FILTERING AND SORTING CONTRACT

Define standardized query semantics for relevant APIs.

Cover:

* geographic radius;
* bounding box;
* category;
* text;
* distance;
* relevance;
* rating;
* open-now where supported;
* route mode;
* travel constraints;
* timestamp ranges;
* moderation state.

Define allowed combinations and maximum query complexity.

Do not expose arbitrary database filtering.

---

# ERROR CONTRACT

Create the canonical machine-readable error model.

Every public API error must support, where applicable:

* HTTP status;
* machine-readable code;
* stable error category;
* message;
* request/correlation ID;
* field-level errors;
* retryability;
* optional details safe for clients.

Define canonical codes for:

* authentication failure;
* session invalid;
* authorization failure;
* resource not found;
* validation failure;
* conflict;
* idempotency conflict;
* rate limited;
* service unavailable;
* dependency timeout;
* dependency failure;
* invalid coordinates;
* geocoding failure;
* routing failure;
* navigation state conflict;
* media validation failure;
* moderation restriction.

Do not expose stack traces, SQL errors, credentials, internal topology, or sensitive provider information.

---

# IDEMPOTENCY CONTRACT

Define the idempotency model.

Specify:

* header or request-field convention;
* idempotency-key length;
* allowed characters;
* retention period;
* scope;
* request fingerprinting;
* response replay;
* concurrent duplicate handling;
* mismatched request behavior;
* terminal failure handling.

Use idempotency for operations such as:

* contribution creation;
* review creation;
* media association;
* navigation-session creation;
* notification submission;
* external provider operations;
* payment-like operations if introduced later.

Do not create idempotency semantics that silently convert distinct requests into one operation.

---

# CONCURRENCY CONTRACT

Define expected concurrency behavior for:

* saved places;
* place edits;
* contributions;
* reviews;
* navigation state;
* session changes;
* moderation operations.

Where optimistic concurrency is appropriate, define:

* version field;
* ETag or equivalent;
* conflict response;
* merge behavior.

Where database locking is required, document ownership and transaction boundaries.

Do not silently overwrite concurrent user updates.

---

# AUTHENTICATION CONTRACT

Define concrete token/session behavior.

Specify:

* access-token lifetime;
* refresh-token lifetime policy;
* refresh rotation;
* revocation;
* reuse detection where supported;
* device/session identification;
* logout semantics;
* token storage expectations;
* web cookie behavior where applicable;
* mobile secure-storage behavior;
* service-to-service authentication.

Do not encode actual secrets.

Define security-sensitive token fields and logging restrictions.

---

# AUTHORIZATION CONTRACT

Define authorization requirements per major resource.

Create a matrix covering:

* anonymous;
* authenticated user;
* resource owner;
* contributor;
* moderator;
* support;
* administrator;
* service account.

At minimum cover:

* private location history;
* active navigation session;
* saved places;
* user media;
* reviews;
* contributions;
* moderation cases;
* administrative functions;
* audit logs.

Every server-side protected endpoint must have an explicit authorization rule.

---

# GEOJSON AND GEOMETRY CONTRACT

Establish canonical geometry serialization.

Define:

* GeoJSON usage where applicable;
* coordinate order;
* CRS assumptions;
* precision;
* point;
* line string;
* polygon;
* multi-geometry;
* bounding box;
* route geometry encoding.

Specify whether internal representations may use database-native geometry while public APIs use GeoJSON or encoded polyline representations.

Define safe limits on geometry size.

Do not allow unbounded geometry payloads.

---

# GEOCODING CONTRACT

Define concrete schemas for:

## Forward Geocoding

Inputs may include:

* query;
* language;
* country/region hints;
* geographic bias;
* bounding box;
* result limit.

Outputs must include, where applicable:

* place/address identifier;
* formatted label;
* components;
* coordinates;
* geometry;
* confidence;
* feature type;
* locality;
* administrative hierarchy;
* provenance;
* ambiguity indicators.

## Reverse Geocoding

Define:

* input coordinates;
* optional radius/tolerance;
* result filtering;
* confidence;
* nearest-address behavior;
* feature precedence.

Do not claim false address precision.

---

# SEARCH CONTRACT

Define the search document schema.

Include relevant fields such as:

* place ID;
* canonical name;
* aliases;
* categories;
* address components;
* normalized search fields;
* coordinates;
* bounding geometry;
* language variants;
* ranking signals;
* popularity signals where appropriate;
* quality signals;
* open/closed information where supported;
* provenance;
* dataset version;
* document version;
* indexed-at timestamp.

Define search result contracts separately from search documents.

Search APIs must not expose internal index implementation details.

---

# AUTOCOMPLETE CONTRACT

Define a dedicated autocomplete contract.

Specify:

* query length requirements;
* maximum query length;
* geographic bias;
* session token semantics where applicable;
* result limit;
* ranking;
* latency target;
* caching;
* abuse protection;
* localization.

Autocomplete must produce compact predictable responses suitable for high-frequency client interaction.

Do not return excessive payloads.

---

# PLACE CONTRACT

Define the canonical Place representation.

Cover:

* place ID;
* display name;
* categories;
* coordinates;
* address;
* contact data;
* operating hours where available;
* website;
* attributes;
* rating summary;
* photos;
* provenance;
* verification;
* moderation state.

Clearly distinguish:

* authoritative provider/source fields;
* platform-enriched fields;
* user-generated fields;
* derived ranking fields.

---

# ROUTING CONTRACT

Create a machine-readable route contract.

A route request must define, as applicable:

* origin;
* destination;
* waypoints;
* travel mode;
* departure time;
* arrival time;
* avoidances;
* vehicle constraints;
* preferences;
* language;
* units;
* alternatives;
* traffic request options.

A route response must define:

* request ID;
* route ID;
* alternatives;
* legs;
* steps;
* geometry;
* distance;
* duration;
* static ETA;
* traffic-aware ETA;
* warnings;
* toll information where available;
* road restrictions;
* data freshness;
* routing-engine metadata only where safe.

Define the separation between stable public contract and replaceable routing-engine implementation.

---

# ROUTE STEP CONTRACT

Each navigation-capable route step must define enough data for clients to render and execute navigation.

Consider:

* step ID;
* geometry;
* maneuver type;
* maneuver modifier;
* instruction;
* distance;
* duration;
* road name;
* road number where available;
* lane guidance where supported;
* exit number/name where relevant;
* roundabout information;
* warnings.

Define maneuver state transitions.

Do not encode UI-specific assumptions into backend routing contracts.

---

# NAVIGATION SESSION CONTRACT

Define the lifecycle:

```text
CREATED
  ↓
ACTIVE
  ↓
RECALCULATING
  ↓
ACTIVE
  ↓
ARRIVED / ENDED
```

Define terminal and exceptional states such as:

* cancelled;
* failed;
* expired.

Specify:

* session ID;
* route ID;
* client/device ID;
* start time;
* last server update;
* current step;
* map-matched position if available;
* ETA;
* navigation state version.

Define concurrency and update ordering.

---

# REALTIME NAVIGATION PROTOCOL

Define the protocol used for navigation-related real-time updates.

Specify:

* connection establishment;
* authentication;
* session binding;
* message names;
* message schema;
* sequence number;
* server timestamp;
* acknowledgement behavior;
* reconnect behavior;
* heartbeat;
* missed-message recovery;
* authorization failures;
* session expiration.

Where WebSockets are used, define:

* connection endpoint;
* authentication handshake;
* allowed channels;
* subscription authorization;
* message envelopes;
* close reasons.

Do not expose another user's navigation channel.

---

# LOCATION UPDATE CONTRACT

Define the client-to-server location event.

Consider:

* event ID;
* device/session ID;
* timestamp;
* latitude;
* longitude;
* accuracy;
* altitude where available;
* speed;
* heading;
* provider/source;
* sequence number;
* navigation session ID;
* battery state only where justified.

Define:

* acceptable timestamp skew;
* duplicate behavior;
* out-of-order behavior;
* impossible-location rejection;
* update-rate limits;
* privacy rules.

Do not treat client-provided data as automatically trustworthy.

---

# OFFLINE AND RECONNECTION CONTRACT

Define how clients behave when connectivity is lost.

Specify:

* locally retained navigation state;
* last known route;
* queued location updates where appropriate;
* bounded local retention;
* replay behavior;
* duplicate handling;
* server reconciliation;
* stale-session behavior;
* rerouting after reconnect.

Do not create an unbounded local telemetry queue.

---

# TRAFFIC CONTRACT

Define the normalized traffic representation.

A traffic state should be capable of representing:

* road/segment identifier;
* observed timestamp;
* effective interval;
* speed;
* reference/free-flow speed;
* congestion level;
* confidence;
* source;
* freshness;
* incident references.

Define the conversion from raw observations to routing inputs and public map representations.

Do not expose raw private telemetry through traffic APIs.

---

# INCIDENT CONTRACT

Define road incident data including:

* incident ID;
* type;
* severity;
* affected geometry;
* affected road;
* start time;
* expected end time;
* source;
* confidence;
* description;
* status;
* last updated.

Define how incidents affect:

* route calculation;
* navigation warnings;
* map visualization.

---

# MAP-TILE CONTRACT

Define the tile delivery interface.

Specify:

* tile coordinate system;
* zoom range;
* tile size;
* format;
* content encoding;
* style reference;
* version;
* cache behavior;
* expiration;
* invalidation;
* regional publication.

Where vector tiles are used, define the public layer contract at a stable conceptual level without unnecessarily coupling clients to internal database tables.

Map data versions must be distinguishable from application versions.

---

# MAP-DATA VERSION CONTRACT

Define a version model for geographic datasets.

Include:

* dataset version ID;
* source;
* source timestamp;
* ingestion timestamp;
* validation status;
* publication status;
* supersedes version;
* rollback eligibility;
* regional coverage;
* schema version.

Define the lifecycle:

```text
RECEIVED
   ↓
VALIDATING
   ↓
VALIDATED
   ↓
BUILDING
   ↓
PUBLISHED
   ↓
SUPERSEDED / ROLLED_BACK
```

---

# DATABASE CONTRACT

Create implementation-level database specifications for authoritative application data.

Define:

* table/entity ownership;
* primary keys;
* foreign keys;
* unique constraints;
* indexes;
* spatial indexes;
* status columns;
* version fields;
* created-at/updated-at fields;
* soft-delete policy where applicable;
* retention.

Identify high-volume tables likely to require partitioning, such as:

* location events;
* traffic observations;
* audit records;
* analytics events.

Define partitioning strategy at the architectural level without implementing the complete production database.

---

# DATA RETENTION CONTRACT

Define retention categories.

At minimum distinguish:

* account data;
* saved places;
* reviews;
* place contributions;
* media metadata;
* navigation sessions;
* raw location telemetry;
* aggregated traffic;
* audit logs;
* operational logs;
* search indexes;
* map datasets.

For each category define:

* purpose;
* default retention;
* deletion trigger;
* archival behavior;
* privacy implications.

Do not require indefinite retention by default.

---

# REDIS CONTRACT

Create canonical Redis key conventions.

Define:

* namespace;
* key structure;
* serializer;
* TTL;
* invalidation;
* ownership;
* maximum item size where relevant.

Cover keys for appropriate capabilities such as:

* autocomplete;
* place lookup;
* nearby search;
* rate limiting;
* navigation state;
* distributed coordination.

Do not make cache keys dependent on undocumented implementation details.

---

# EVENT ENVELOPE CONTRACT

Create the canonical event envelope.

Include:

* event ID;
* event type;
* event version;
* producer;
* aggregate/entity ID;
* occurred-at;
* published-at;
* correlation ID;
* causation ID where useful;
* trace context;
* payload version;
* payload.

Define serialization and compatibility expectations.

---

# DOMAIN EVENT CONTRACTS

Create concrete schemas for important events.

At minimum define:

* UserRegistered;
* SessionCreated;
* SessionRevoked;
* PlaceCreated;
* PlaceUpdated;
* PlaceDeleted;
* PlaceModerated;
* SearchDocumentRefreshRequested;
* ContributionSubmitted;
* ContributionModerated;
* ReviewCreated;
* ReviewUpdated;
* ReviewDeleted;
* MediaUploaded;
* MediaDeleted;
* RouteRequested;
* NavigationStarted;
* NavigationEnded;
* LocationTelemetryReceived;
* TrafficSnapshotUpdated;
* TrafficIncidentCreated;
* TrafficIncidentUpdated;
* NotificationRequested.

For every event define:

* producer;
* consumers;
* payload;
* ordering;
* idempotency;
* retryability;
* retention;
* compatibility strategy.

Do not create event names that merely restate internal method names.

---

# QUEUE CONTRACT

Define standard background-job envelopes.

Include:

* job ID;
* job type;
* job version;
* payload;
* created-at;
* available-at;
* attempt;
* correlation ID;
* causation ID where useful.

For each major job type define:

* producer;
* consumer;
* timeout;
* retry limit;
* backoff;
* concurrency;
* deduplication;
* dead-letter behavior.

---

# MEDIA CONTRACT

Define the media API and processing lifecycle.

Include:

* media ID;
* owner;
* associated entity;
* media type;
* declared type;
* verified type;
* size;
* checksum;
* storage key;
* processing state;
* moderation state;
* visibility;
* derivative references.

Define lifecycle states such as:

```text
REQUESTED
   ↓
UPLOADING
   ↓
UPLOADED
   ↓
SCANNING
   ↓
PROCESSING
   ↓
READY
   ↓
PUBLISHED / RESTRICTED / DELETED
```

Define safe access behavior for each state.

---

# NOTIFICATION CONTRACT

Define the notification intent model.

Include:

* notification ID;
* recipient;
* notification type;
* channel;
* payload;
* preference category;
* delivery status;
* provider message ID where applicable;
* retry state;
* timestamps.

Separate:

* domain event;
* notification intent;
* provider delivery.

Do not couple a core transaction to guaranteed third-party notification availability.

---

# CONTRIBUTION AND MODERATION CONTRACT

Define contribution states and transitions.

For example:

```text
DRAFT
  ↓
SUBMITTED
  ↓
UNDER_REVIEW
  ↓
APPROVED / REJECTED
  ↓
PUBLISHED
```

Define correction and withdrawal behavior.

Define moderation cases covering:

* reported place;
* review;
* photo;
* user;
* contribution.

Include:

* case ID;
* reporter;
* target;
* reason;
* evidence references;
* status;
* moderator;
* resolution;
* timestamps;
* audit information.

---

# SAVED-PLACE CONTRACT

Define:

* saved-place ID;
* user;
* place reference;
* label;
* list;
* notes;
* created-at;
* updated-at.

Define uniqueness and concurrent-update behavior.

Saved places are user-owned data and must be authorized accordingly.

---

# REVIEW AND RATING CONTRACT

Define:

* review ID;
* author;
* place;
* rating;
* text;
* language;
* moderation state;
* timestamps;
* edit history policy.

Define:

* one-review-per-policy if applicable;
* rating range;
* edit behavior;
* deletion;
* moderation;
* abuse reporting.

Do not expose private moderation data through public review APIs.

---

# CONFIGURATION CONTRACT

Create a machine-readable configuration specification.

Separate:

* nonsecret configuration;
* environment-specific configuration;
* secret references;
* feature flags;
* provider configuration;
* rate limits;
* service endpoints.

Define conventions for:

* environment variable naming;
* configuration precedence;
* validation;
* startup failure for invalid critical configuration;
* secret retrieval.

Never include actual credentials.

---

# EXTERNAL PROVIDER CONTRACT

Create an adapter contract for external providers.

Define a common abstraction for:

* geographic data;
* traffic;
* transit;
* notification;
* routing where an external routing provider is used.

Each provider adapter must map:

* provider identifiers;
* provider errors;
* rate limits;
* quotas;
* timeout;
* retries;
* provider-specific freshness;
* provenance.

Public domain contracts must remain provider-neutral.

---

# RATE-LIMIT CONTRACT

Define rate-limit categories for:

* authentication;
* search;
* autocomplete;
* geocoding;
* routing;
* navigation location updates;
* place contributions;
* reviews;
* media;
* administrative APIs.

Define:

* identity scope;
* IP scope;
* device scope where appropriate;
* burst limit;
* sustained limit;
* response behavior;
* retry-after semantics.

High-frequency navigation updates must use different controls from expensive route calculations.

---

# SECURITY CONTRACT

Produce an implementation-oriented security contract.

Cover:

* authentication;
* authorization;
* input validation;
* request size limits;
* geometry size limits;
* media validation;
* SSRF controls;
* outbound-provider restrictions;
* secrets;
* administrative APIs;
* audit logging;
* rate limits;
* anti-abuse controls;
* WebSocket authorization;
* data access.

Define trust boundaries between:

* public internet;
* edge;
* API services;
* internal services;
* data systems;
* external providers;
* administrative users.

---

# PRIVACY CONTRACT

Create an explicit data-classification and access matrix.

At minimum classify:

* public place data;
* user profile data;
* saved places;
* exact location;
* location history;
* active navigation data;
* reviews;
* media;
* administrative data;
* telemetry;
* operational data.

For each define:

* visibility;
* permitted consumers;
* retention;
* deletion;
* logging restrictions;
* aggregation requirements.

Do not allow precise private location information to become an accidental analytics or logging data source.

---

# OBSERVABILITY CONTRACT

Define standard telemetry attributes.

At minimum consider:

* service;
* environment;
* region;
* request ID;
* correlation ID;
* trace ID;
* route/request type;
* provider;
* entity ID where safe;
* error category;
* latency;
* result count;
* retry count.

Define prohibited telemetry fields including:

* passwords;
* access tokens;
* refresh tokens;
* secrets;
* payment credentials;
* private cryptographic material;
* unnecessary exact user locations;
* private message/content bodies where not operationally necessary.

---

# SLO AND OPERATIONAL CONTRACT

Define initial service-level objectives at an architectural level.

Cover important user-facing capabilities such as:

* map tile delivery;
* autocomplete;
* place search;
* geocoding;
* route calculation;
* navigation updates;
* API availability.

Define, where appropriate:

* availability target;
* latency percentile target;
* freshness expectation;
* error budget concept;
* dependency degradation behavior.

These are engineering targets, not claims that production measurements have already been achieved.

---

# FAILURE AND DEGRADATION CONTRACT

Create a dependency-failure matrix.

At minimum evaluate:

| Dependency Failure                | Expected System Behavior                                                                         |
| --------------------------------- | ------------------------------------------------------------------------------------------------ |
| PostgreSQL unavailable            | Fail writes safely; return controlled errors; protect data integrity                             |
| Redis unavailable                 | Fall back or fail only affected cached/ephemeral functionality                                   |
| Search unavailable                | Preserve authoritative place data and expose bounded fallback behavior where feasible            |
| Routing engine unavailable        | Return explicit routing-unavailable errors; do not fabricate routes                              |
| Traffic provider unavailable      | Route using non-live traffic assumptions where supported and clearly identify degraded freshness |
| Event broker unavailable          | Apply reliable buffering/outbox strategy where required                                          |
| Queue worker unavailable          | Preserve durable work until workers recover                                                      |
| Object storage unavailable        | Avoid losing metadata; expose controlled media failure                                           |
| CDN unavailable                   | Use configured origin fallback where operationally appropriate                                   |
| Notification provider unavailable | Preserve notification intent for retry where supported                                           |

Extend this matrix to all critical dependencies.

---

# COMPATIBILITY AND VERSIONING CONTRACT

Define compatibility rules for:

* REST APIs;
* event schemas;
* queue payloads;
* database schemas;
* map datasets;
* tile versions;
* search indexes;
* routing graph versions;
* configuration.

Specify:

* additive change rules;
* breaking-change rules;
* deprecation policy;
* migration ordering;
* rollout ordering;
* rollback constraints;
* version retention;
* client compatibility expectations.

Do not require simultaneous deployment of every project component merely to change one contract.

---

# DEPLOYMENT-ORDER CONTRACT

Define safe deployment sequencing for changes involving:

* database schema;
* backend;
* events;
* queues;
* search indexes;
* map datasets;
* routing graphs;
* web client;
* mobile client.

Where compatibility requires expand/contract migration, document the sequence.

Examples include:

```text
Expand
  ↓
Deploy Compatible Consumers
  ↓
Backfill / Migrate
  ↓
Switch Producers
  ↓
Remove Legacy Representation
```

Use this pattern only where appropriate.

---

# PORTABLE INTEGRATION PACKAGE

Create a clear artifact package that a later engineering agent can consume without requiring this conversation.

The package must include:

* canonical entity schemas;
* OpenAPI;
* JSON Schemas where useful;
* event schemas;
* queue schemas;
* enums;
* error codes;
* identifier conventions;
* geometry conventions;
* authentication contract;
* authorization matrix;
* realtime protocol;
* route contract;
* navigation protocol;
* media contract;
* configuration schema;
* integration matrix;
* compatibility/versioning rules.

Every authoritative artifact must have:

* a stable path;
* ownership;
* version;
* intended consumers.

Do not create duplicate authoritative definitions.

---

# MACHINE-READABLE ARTIFACT VALIDATION

Validate every machine-readable contract using the repository's available tooling.

Where appropriate:

* validate OpenAPI syntax and references;
* validate JSON Schemas;
* validate event schemas;
* validate enum consistency;
* validate referenced artifact paths;
* validate schema examples;
* validate configuration schemas;
* validate generated documentation links.

Where practical, validate that representative request/response examples conform to their schemas.

Do not create validation commands that merely print success without performing validation.

---

# CROSS-PART IMPLEMENTATION MATRIX

Create a detailed implementation handoff matrix showing how contracts are consumed.

At minimum cover:

| Contract         | Backend             | Web              | Mobile            | Infrastructure          | Data/Geo Pipeline  | QA                     |
| ---------------- | ------------------- | ---------------- | ----------------- | ----------------------- | ------------------ | ---------------------- |
| Identity/session | Auth services       | Auth client      | Auth client       | Secret/IAM              | —                 | Security tests         |
| Place            | Place domain        | Place UI         | Place UI          | Storage/DB              | Geo source         | Contract tests         |
| Search           | Search APIs         | Search client    | Search client     | Search cluster          | Index pipeline     | Search tests           |
| Geocoding        | Geocoder            | Search/map UI    | Search/map UI     | Geocoder runtime        | Geo data           | Geocoder tests         |
| Routing          | Routing API         | Directions UI    | Navigation UI     | Routing engine          | Road graph         | Route tests            |
| Navigation       | Session service     | Web navigation   | Native navigation | Realtime infrastructure | —                 | Realtime/E2E           |
| Traffic          | Traffic service     | Traffic layer    | Navigation        | Stream infrastructure   | Telemetry pipeline | Traffic tests          |
| Map tiles        | Tile API            | Map renderer     | Map renderer      | CDN/tile stack          | Tile pipeline      | Tile tests             |
| Media            | Media service       | Upload/view      | Upload/view       | Object storage/CDN      | Processing         | Media tests            |
| Events           | Producers/consumers | —               | —                | Broker                  | Pipelines          | Event tests            |
| Queues           | Workers             | —               | —                | Queue runtime           | Pipelines          | Job tests              |
| Observability    | Telemetry           | Client telemetry | Client telemetry  | Monitoring              | Pipeline metrics   | Operational validation |

Expand this to cover all actual project contracts.

---

# ARCHITECTURAL DECISION RECORDS

Create or update ADRs for material contract decisions introduced by this prompt.

Evaluate ADRs for decisions such as:

* public API representation;
* cursor pagination;
* GeoJSON/public geometry format;
* route geometry encoding;
* realtime navigation protocol;
* event envelope;
* event delivery semantics;
* idempotency;
* optimistic concurrency;
* dataset versioning;
* tile versioning;
* search projection model;
* location privacy model;
* configuration hierarchy;
* external-provider abstraction.

Every ADR must contain:

* context;
* decision;
* alternatives;
* rationale;
* consequences;
* migration or operational implications where relevant.

Do not generate ADRs for trivial field naming.

---

# DOCUMENTATION

Create or update a developer-facing architecture contract guide.

It must explain:

* authoritative contract files;
* domain ownership;
* API conventions;
* event conventions;
* queue conventions;
* realtime conventions;
* geospatial conventions;
* versioning;
* compatibility;
* security expectations;
* privacy expectations;
* how independent implementation agents should consume the contracts;
* how Codex should reconcile project parts using these artifacts.

The documentation must describe actual generated artifacts.

Do not claim that implementation exists when only contracts have been produced.

---

# INDEPENDENT EXECUTABILITY

This architecture prompt must remain executable in a fresh AI conversation.

Therefore:

* all required project context is included here;
* repository inspection is mandatory;
* existing repository artifacts may be reused;
* previous AI messages are not required;
* previous Claude conversations are not required;
* previous approval messages are not required;
* invisible architecture decisions are not allowed.

A coding agent must be able to inspect the repository and determine what currently exists.

The generated contract package must then provide authoritative specifications for future implementation.

---

# FINAL ARCHITECTURE QUALITY CHECK

Before declaring the task complete, verify:

## Entity Consistency

Every entity has:

* one canonical name;
* one identifier strategy;
* one owner;
* defined lifecycle.

## API Consistency

Every endpoint has:

* authentication rule;
* authorization rule;
* request schema;
* response schema;
* error behavior.

## Geospatial Consistency

Verify:

* coordinate order;
* CRS;
* units;
* geometry serialization;
* precision;
* spatial limits.

## Event Consistency

Verify:

* event envelope;
* event version;
* entity ID;
* timestamps;
* producer;
* consumer expectations;
* idempotency.

## Queue Consistency

Verify:

* job envelope;
* retries;
* backoff;
* timeout;
* concurrency;
* dead-letter behavior.

## Realtime Consistency

Verify:

* session binding;
* authorization;
* sequence;
* heartbeat;
* reconnect;
* recovery.

## Security Consistency

Verify:

* protected resources;
* server-side authorization;
* rate limits;
* safe logging;
* secure external calls.

## Privacy Consistency

Verify:

* exact location controls;
* retention;
* deletion;
* aggregation;
* access restrictions.

## Integration Consistency

Verify that backend, web, mobile, infrastructure, data, and QA agents can consume the contract package independently.

---

# VALIDATION REQUIREMENTS

Before completing the prompt, perform all feasible repository-level validation available in the execution environment.

At minimum:

* validate machine-readable schemas;
* validate OpenAPI;
* validate references;
* validate examples;
* validate documentation links;
* validate contract naming consistency;
* validate enum consistency;
* validate that authoritative artifacts do not contradict one another.

Inspect the final diff.

Do not claim external systems were tested unless the execution environment genuinely provided access and the tests were actually executed.

---

# COMPLETION REPORT

After completing the architecture work, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* canonical entities defined;
* enums/status values defined;
* API contracts created;
* error contracts created;
* authentication contracts created;
* authorization matrix created;
* geospatial contracts created;
* search/autocomplete contracts created;
* geocoding contracts created;
* routing contracts created;
* navigation/realtime contracts created;
* traffic contracts created;
* map-tile contracts created;
* event schemas created;
* queue schemas created;
* media contracts created;
* notification contracts created;
* moderation contracts created;
* configuration schemas created;
* rate-limit contracts created;
* security/privacy contracts created;
* observability contracts created;
* SLO/failure contracts created;
* compatibility/versioning rules created;
* machine-readable artifacts validated;
* documentation created or updated;
* ADRs created or updated;
* cross-part integration matrix created;
* unresolved issues or external dependencies.

The report must describe actual repository changes.

Do not claim that the complete application has been implemented.

Do not claim that production infrastructure has been provisioned.

Do not claim that external providers are active unless actually verified.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* canonical entities are explicitly defined;
* entity ownership is explicit;
* identifiers are explicit;
* lifecycle states are explicit;
* canonical enums are defined;
* API contracts are machine-readable where practical;
* request and response structures are explicit;
* pagination is explicit;
* filtering and sorting are bounded;
* error contracts are explicit;
* idempotency rules are explicit;
* concurrency rules are explicit;
* authentication is explicit;
* authorization is explicit;
* geometry serialization is explicit;
* geocoding contracts are explicit;
* search contracts are explicit;
* autocomplete contracts are explicit;
* place contracts are explicit;
* route contracts are explicit;
* route-step contracts are explicit;
* navigation-session contracts are explicit;
* realtime navigation protocol is explicit;
* location-update contracts are explicit;
* offline/reconnection behavior is explicit;
* traffic contracts are explicit;
* incident contracts are explicit;
* map-tile contracts are explicit;
* map-data versioning is explicit;
* database contracts are explicit;
* retention is explicit;
* Redis conventions are explicit;
* event envelopes are explicit;
* domain event schemas are explicit;
* queue envelopes are explicit;
* background-job behavior is explicit;
* media contracts are explicit;
* notification contracts are explicit;
* moderation contracts are explicit;
* configuration is explicit;
* external integrations are abstracted;
* rate limits are explicit;
* security boundaries are explicit;
* privacy boundaries are explicit;
* observability conventions are explicit;
* operational targets are documented;
* failure/degradation behavior is documented;
* compatibility/versioning is documented;
* deployment-order considerations are documented;
* portable integration artifacts exist;
* machine-readable contracts are validated;
* documentation identifies authoritative sources;
* ADRs cover material contract decisions;
* the cross-part implementation matrix exists;
* the final diff was inspected;
* the completion report accurately reflects the work;
* no fake implementation is presented as completed functionality;
* no credentials or secrets were fabricated.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement the complete mapping and navigation platform during this architecture and contract milestone.
