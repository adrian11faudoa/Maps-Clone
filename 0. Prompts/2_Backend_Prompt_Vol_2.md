# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 2

# ROLE

You are the senior backend engineering agent responsible for implementing the **core geospatial data, geographic entities, places, addresses, geocoding, reverse geocoding, and nearby-location capabilities** for a production-grade **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary backend engineering organization consisting of:

* Principal Backend Engineer
* Geospatial Backend Engineer
* GIS/Data Engineer
* PostGIS Database Engineer
* Search/Data Integration Engineer
* API Engineer
* Security Engineer
* Reliability Engineer
* Performance Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement the real backend functionality for authoritative geographic and place data while preserving the project's existing platform contracts, security model, observability standards, and future compatibility.

This prompt defines a bounded backend implementation milestone.

Implement only the current prompt's scope.

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive maps;
* geographic feature rendering;
* places and points of interest;
* addresses;
* address search;
* autocomplete;
* forward geocoding;
* reverse geocoding;
* nearby discovery;
* route planning;
* navigation;
* traffic;
* saved places;
* user contributions;
* reviews and ratings;
* media;
* notifications;
* moderation;
* administration;
* analytics;
* operational observability.

This milestone establishes the authoritative backend geographic and place foundation required by search, map rendering, routing, navigation, and client applications.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* canonical geographic entity persistence;
* PostGIS-backed spatial data structures;
* geographic-feature representation;
* address representation;
* place representation;
* place categories;
* place aliases;
* canonical place identifiers;
* source-provider identifiers;
* geographic provenance;
* geographic dataset version references;
* place/address CRUD where appropriate to the authoritative backend boundary;
* public place lookup;
* place-detail API;
* nearby-place query API;
* forward geocoding API;
* reverse geocoding API;
* geographic query validation;
* spatial indexes;
* spatial query boundaries;
* geographic-data ingestion foundation;
* source-data normalization boundaries;
* source provenance;
* idempotent geographic ingestion primitives;
* place deduplication primitives;
* geographic record lifecycle;
* geospatial API contracts;
* geospatial caching foundations where appropriate;
* geospatial observability;
* security and privacy controls for location-related APIs;
* unit, integration, contract, and spatial-query testing;
* documentation of implemented geographic behavior.

This milestone establishes authoritative location/place capabilities.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* full-text search ranking;
* production OpenSearch indexing pipelines;
* full autocomplete ranking;
* vector-tile generation;
* CDN map-tile infrastructure;
* routing-engine integration;
* route calculation;
* traffic ingestion and modeling;
* navigation sessions;
* continuous location telemetry;
* reviews;
* ratings;
* user-contribution moderation workflows;
* place-photo/media processing;
* notifications;
* production Kubernetes deployment;
* production cloud provisioning;
* complete web map UI;
* complete mobile map UI;
* complete end-to-end QA across the whole platform.

This prompt may create integration hooks and canonical contracts required by those future domains.

Do not create fake search, routing, navigation, traffic, or map-tile implementations merely to simulate future functionality.

---

# REPOSITORY INSPECTION

Inspect the repository before making changes.

Determine:

* current backend structure;
* existing identity and authorization implementation;
* current database tooling;
* ORM/query layer if any;
* PostgreSQL version;
* PostGIS availability;
* existing migrations;
* existing entity/model definitions;
* existing API contracts;
* existing shared types;
* existing configuration;
* existing cache implementation;
* existing observability;
* existing audit mechanisms;
* existing test infrastructure;
* existing architecture documentation;
* existing geographic artifacts, if any.

Treat the repository as authoritative for actual implementation state.

Do not assume that a previous AI conversation implemented the foundation.

Preserve compatible functionality already present.

Do not duplicate entities or schemas if the repository already contains an authoritative compatible representation.

When an existing implementation conflicts with the geographic contracts required by this prompt, make the smallest compatibility-preserving change needed within the current scope and document it.

---

# BACKEND TECHNOLOGY CONTEXT

Use the project's existing backend technology direction:

* TypeScript;
* NestJS or the repository's established compatible modular backend framework;
* PostgreSQL;
* PostGIS;
* Redis where justified;
* OpenTelemetry-compatible instrumentation;
* structured logging;
* automated testing.

Use a specialized geospatial library or service only when justified by an actual requirement.

Do not introduce a second persistence framework solely to avoid using the existing repository architecture.

---

# GEOSPATIAL DATA OWNERSHIP

Establish authoritative ownership for the geographic domain.

The authoritative backend must distinguish between:

* raw source data;
* normalized source data;
* canonical geographic records;
* derived search documents;
* derived map tiles;
* derived routing graphs;
* cached API responses.

The canonical place/geographic database introduced here must be the authoritative transactional source for the implemented place/address entities.

Derived systems must consume canonical data rather than independently redefining the domain.

---

# CORE GEOGRAPHIC DATA MODEL

Implement canonical entities appropriate to this milestone.

At minimum support:

* `GeographicFeature`
* `Address`
* `Place`
* `PlaceCategory`
* `PlaceAlias`
* `MapDatasetVersion`
* `SourceReference`

Where appropriate also support:

* `AdministrativeRegion`
* `Road`
* `RoadSegment`
* `Intersection`

Do not introduce road-network entities that cannot be used meaningfully yet.

Every entity must have a clear owner and lifecycle.

---

# GEOGRAPHIC FEATURE

Implement a canonical geographic-feature model.

Support, where appropriate:

* feature ID;
* feature type;
* geometry;
* display name;
* source reference;
* dataset version;
* parent geographic entity;
* properties required by the product;
* status;
* created-at;
* updated-at;
* version.

Geometry must use an explicit PostGIS geometry representation.

Define the spatial reference system explicitly.

Do not mix coordinate systems.

---

# COORDINATE CONVENTION

Use one project-wide coordinate convention:

* public latitude/longitude values use `latitude, longitude` semantic ordering;
* GeoJSON coordinate arrays follow the GeoJSON specification's coordinate ordering;
* the database geometry uses one explicitly defined spatial reference system;
* conversion between API and database representations must be explicit.

Do not rely on developers remembering implicit coordinate-order differences.

Centralize conversion and validation where appropriate.

---

# GEOMETRY VALIDATION

Implement safe validation for geographic inputs.

Validate:

* latitude range;
* longitude range;
* bounding boxes;
* radius;
* geometry type;
* geometry size;
* coordinate count;
* malformed geometries.

Reject:

* NaN;
* infinite values;
* malformed coordinate arrays;
* excessive geometry payloads;
* unsupported coordinate reference systems;
* obviously invalid geographic requests.

Where polygon or line geometries are accepted, validate topology as appropriate.

Do not permit arbitrary unbounded geometry payloads through public APIs.

---

# POSTGIS MODEL

Implement real PostGIS-backed persistence.

Use appropriate:

* geometry/geography types;
* spatial indexes;
* GiST/SP-GiST indexes where justified;
* bounding-box operations;
* nearest-neighbor operators where appropriate;
* spatial containment;
* intersection;
* distance filtering.

Do not use application-side loops over large geographic datasets when PostGIS can execute the operation efficiently.

Do not retrieve an entire table into application memory to perform proximity filtering.

---

# SPATIAL INDEXING

Create the spatial indexes required for common operations.

At minimum evaluate indexing for:

* place point geometry;
* geographic-feature geometry;
* address location;
* road/road-segment geometry where implemented.

Test important query patterns with realistic index use.

Do not create indexes without understanding the corresponding access patterns.

---

# PLACE MODEL

Implement the authoritative Place entity.

Support appropriate fields including:

* place ID;
* canonical name;
* display name;
* place type;
* categories;
* coordinates;
* geometry where appropriate;
* address ID/reference;
* parent geographic area;
* contact information where available;
* website;
* operating-hours representation where the source/product supports it;
* source/provenance;
* source identifiers;
* verification state;
* lifecycle status;
* dataset version;
* created-at;
* updated-at;
* version.

Separate authoritative source fields from future user-generated fields.

Do not add reviews or ratings directly into this authoritative table as though they were place attributes.

---

# PLACE CATEGORIES

Implement a normalized place-category model.

Categories must support:

* stable category ID;
* canonical code;
* display name;
* parent category;
* hierarchy depth;
* localized labels where architecture permits;
* active/inactive state.

Avoid embedding category names as uncontrolled free-text values throughout place records.

Do not allow clients to create arbitrary system categories through public APIs.

---

# PLACE ALIASES

Implement aliases for:

* alternate names;
* local spellings;
* transliterations;
* abbreviations;
* provider names;
* legacy names where valid.

Each alias should define:

* alias ID;
* place ID;
* text;
* normalized text;
* language;
* alias type;
* source;
* status.

Do not duplicate the entire place record merely to represent an alternate name.

---

# ADDRESS MODEL

Implement a normalized address model.

Where applicable represent:

* address ID;
* formatted address;
* house/building number;
* street;
* street suffix;
* neighborhood;
* locality;
* city;
* district;
* region/state;
* country;
* postal code;
* coordinates;
* precision;
* source;
* source reference;
* dataset version.

Do not assume that every country has the same administrative hierarchy.

Represent geographic hierarchy flexibly while preserving a canonical API representation.

---

# ADDRESS PRECISION

Implement explicit precision levels.

Examples may include:

* rooftop;
* building;
* parcel;
* street;
* locality;
* district;
* city;
* region;
* approximate.

Do not return false rooftop-level precision when only street-level information exists.

Precision must remain machine-readable.

---

# ADMINISTRATIVE GEOGRAPHY

Where administrative geography is included in this milestone, support hierarchical relationships such as:

* country;
* region/state;
* district/county;
* city/locality;
* neighborhood.

Do not hardcode one country's hierarchy into the database schema.

Use generic hierarchical geographic relationships with explicit classification.

---

# SOURCE PROVENANCE

Every imported geographic or place record must be traceable to its source.

Implement source references supporting:

* source provider;
* external identifier;
* source dataset;
* source version;
* source timestamp where available;
* ingestion timestamp;
* attribution metadata where required.

Do not discard provenance during normalization.

Do not assume that two providers' identifiers are globally interchangeable.

---

# MAP DATASET VERSION

Implement a dataset-version reference suitable for geographic records.

Support:

* dataset version ID;
* source;
* source version;
* imported-at;
* effective-at where applicable;
* schema version;
* validation state;
* publication state;
* supersedes reference.

Use explicit relationships so later tile and routing pipelines can consume a known geographic dataset version.

---

# GEOGRAPHIC DATA INGESTION FOUNDATION

Implement the repository-side foundation required to ingest external geographic datasets.

Provide a clear pipeline boundary:

```text
External Source
      ↓
Raw Import
      ↓
Parsing
      ↓
Normalization
      ↓
Validation
      ↓
Canonical Geographic Data
```

The current milestone must implement the reusable ingestion primitives, data structures, validation, and persistence mechanisms necessary for the pipeline.

Do not attempt to ingest every global geographic dataset.

Do not fabricate external source access.

Where a sample or test dataset is required, use a clearly identified test fixture rather than presenting it as production geographic coverage.

---

# INGESTION IDEMPOTENCY

Geographic ingestion must be repeatable.

Implement deterministic handling for duplicate imports using appropriate combinations of:

* provider;
* dataset;
* source identifier;
* source version;
* content hash.

Repeated ingestion of the same source record must not create uncontrolled duplicate canonical records.

Do not rely solely on application-level duplicate checks when a database constraint can enforce the invariant.

---

# SOURCE RECORD NORMALIZATION

Implement normalization boundaries for imported data.

Normalize, as appropriate:

* names;
* address components;
* categories;
* coordinates;
* language;
* postal codes;
* phone numbers where retained;
* provider identifiers.

Normalization must not destroy source provenance.

Do not apply country-specific transformations globally without an explicit geographic rule.

---

# PLACE DEDUPLICATION FOUNDATION

Implement safe deduplication primitives.

Use deterministic identifiers and conservative candidate matching.

Where fuzzy matching is appropriate, separate:

* candidate generation;
* similarity scoring;
* human/admin review;
* final merge decision.

Do not automatically merge places solely because their names are similar.

Potential duplicate handling must preserve provenance and auditability.

Do not implement a complete moderation UI.

---

# PLACE MERGE MODEL

Where place merging is supported, define a safe backend mechanism.

A merge must preserve:

* canonical surviving place;
* merged source identifiers;
* provenance;
* audit record;
* redirect/reference behavior where applicable.

Avoid destructive hard deletes when consumers may still possess the old place ID.

The resulting model must permit APIs and future search indexes to resolve superseded identifiers safely.

---

# PLACE LIFECYCLE

Implement lifecycle states appropriate to authoritative geographic data, such as:

* active;
* pending;
* deprecated;
* merged;
* deleted.

Define legal state transitions.

Do not use a boolean `deleted` flag when more meaningful lifecycle states are required.

---

# PUBLIC PLACE LOOKUP

Implement a secure place lookup endpoint.

The endpoint must support:

* canonical place ID;
* validated public identifier;
* safe not-found behavior;
* localized display fields where implemented;
* address;
* coordinates;
* categories;
* available authoritative metadata;
* provenance-derived fields only when safe for public exposure.

Do not expose:

* internal provider credentials;
* internal database IDs when not intended to be public;
* moderation internals;
* private administrative notes;
* raw source payloads containing sensitive information.

---

# PLACE DETAILS

Implement a place-detail API aligned with the project-wide API contract.

The response should represent:

* place identity;
* display information;
* location;
* address;
* categories;
* available contact information;
* operating hours where available;
* provenance/verification state where appropriate;
* dataset freshness/version metadata where the public contract allows it.

Do not include future review, rating, recommendation, or user-photo functionality merely to make the response appear complete.

Those fields may be defined as later extension points in the contract.

---

# NEARBY SEARCH

Implement an authoritative nearby-place endpoint.

Support:

* center coordinate;
* radius;
* category filters;
* maximum results;
* bounded sorting;
* geographic filtering.

Use PostGIS spatial operations.

Define maximum request radius and result limits.

Prevent:

* unbounded radius queries;
* unlimited result counts;
* expensive arbitrary geometry scans.

Where sorting by distance is used, return the distance explicitly when appropriate.

---

# BOUNDING-BOX QUERIES

Provide reusable backend capabilities for map clients and future tile services to query data by bounding box.

Support:

* southwest/northeast coordinates;
* bounded area;
* feature-type filters;
* result limits.

The API must enforce safe maximum bounding-box dimensions.

Do not allow a public request to retrieve the entire global geographic database.

---

# FORWARD GEOCODING

Implement forward geocoding against the currently available authoritative geographic/address data.

Accept, as appropriate:

* free-form address/query text;
* language;
* country/region hint;
* bounding box;
* geographic bias;
* result limit.

Return structured candidates containing:

* result ID;
* display label;
* address;
* coordinates;
* feature type;
* precision;
* confidence;
* geographic hierarchy;
* provenance;
* dataset version where appropriate.

Do not implement a sophisticated full-text relevance engine in this milestone.

The geocoder should use deterministic and bounded matching against the currently implemented data.

Future search infrastructure may replace or augment the candidate/ranking mechanism through explicit contracts.

---

# REVERSE GEOCODING

Implement reverse geocoding.

Accept:

* latitude;
* longitude;
* optional radius/tolerance;
* optional result-type filters.

Return nearest or containing geographic/address candidates according to a documented precedence model.

The precedence must distinguish, where applicable:

* exact building/address match;
* street-level match;
* locality;
* administrative region;
* country.

Do not return arbitrary nearest records without documenting selection behavior.

---

# GEOCODING CONFIDENCE

Implement explicit confidence/precision behavior.

Candidates should communicate when:

* an exact match exists;
* a nearby match was used;
* a broader locality match was used;
* the result is approximate.

Do not produce a numeric confidence score that has no defined meaning.

If a numeric confidence exists, document its semantics and expected range.

---

# GEOGRAPHIC LOCALIZATION

Where multiple languages are supported by existing repository architecture, allow geographic names and addresses to expose localized representations.

Do not make localization a reason to duplicate geographic records.

Represent language-specific labels as data associated with the canonical entity.

---

# GEOSPATIAL CACHING

Where caching provides measurable value, implement bounded Redis caching for appropriate read operations such as:

* place lookup;
* nearby queries;
* reverse-geocode queries.

Cache keys must encode all request dimensions that materially affect the result.

Define:

* namespace;
* serialization;
* TTL;
* invalidation;
* maximum payload size;
* stale behavior;
* failure behavior.

Do not cache responses indefinitely.

Do not use Redis as the authoritative geographic database.

---

# CACHE INVALIDATION

When canonical place/address data changes, ensure relevant cache invalidation or versioning.

For high-volume immutable or versioned geographic data, prefer versioned cache keys where appropriate.

Do not perform broad uncontrolled cache flushes for ordinary single-record updates.

---

# API RATE LIMITING

Apply the existing backend rate-limiting framework to:

* place lookup;
* nearby search;
* forward geocoding;
* reverse geocoding;
* bounding-box queries.

Geocoding and nearby operations must use bounded request complexity.

Do not use the same rate limit as login or other unrelated operations without evaluating cost characteristics.

---

# AUTHORIZATION

Public geographic data may be accessible without authentication according to the project contract.

However, distinguish carefully between:

* public place data;
* private account data;
* internal source data;
* administrative geographic records.

Any administrative mutation must use server-side authorization.

Do not expose raw unpublished source records through public endpoints.

---

# SECURITY

Geospatial endpoints must be protected against:

* denial-of-service via expensive queries;
* massive result extraction;
* malformed geometry;
* SQL injection;
* provider-injection attacks;
* unauthorized administrative mutation;
* scraping abuse;
* oversized requests.

Use:

* strict validation;
* bounded query complexity;
* parameterized database operations;
* rate limiting;
* authorization;
* safe error handling.

Do not accept arbitrary SQL-like filter expressions from clients.

---

# PRIVACY

The canonical public place domain must remain separate from future private user-location data.

Do not add fields for:

* user location history;
* continuous GPS telemetry;
* navigation history;

to Place or Address merely because future domains may need geographic context.

Exact user location is not public place data.

Maintain the architectural boundary required for future privacy-preserving telemetry systems.

---

# OBSERVABILITY

Instrument:

* place lookup;
* nearby search;
* bounding-box queries;
* geocoding;
* reverse geocoding;
* ingestion jobs;
* spatial queries;
* cache hits/misses;
* database latency;
* result counts;
* validation failures;
* rate-limit rejections.

Include safe:

* request ID;
* correlation ID;
* trace ID;
* operation;
* dataset version;
* source where relevant.

Do not log complete untrusted user queries or precise coordinates unnecessarily when they could create privacy or security problems.

Where diagnostic logging requires coordinates, use aggregation or redaction appropriate to the environment.

---

# PERFORMANCE

Validate important spatial query paths.

Pay particular attention to:

* spatial index use;
* query bounding;
* result limits;
* distance calculations;
* join cardinality;
* geocoding lookup paths;
* cache behavior;
* ingestion throughput.

Avoid:

* full-table scans;
* application-side geographic filtering;
* unbounded `ORDER BY distance`;
* excessive geometry serialization;
* repeated identical spatial calculations.

Use `EXPLAIN` or equivalent query-plan inspection where practical.

Do not present local benchmarks as proof of global production capacity.

---

# DATABASE MIGRATIONS

Create real migrations for all schema changes introduced by this prompt.

Include:

* tables;
* primary keys;
* foreign keys;
* unique constraints;
* spatial indexes;
* ordinary indexes;
* status constraints;
* source identifiers;
* dataset-version relationships;
* version fields;
* timestamps.

Migrations must be deterministic and reviewable.

Do not modify historical migrations unnecessarily.

---

# DATA INTEGRITY

Database constraints must enforce important invariants such as:

* unique source references where appropriate;
* valid entity relationships;
* valid lifecycle states;
* non-null required coordinates;
* valid foreign keys;
* valid dataset-version references.

Do not rely entirely on application-level validation for invariants that the database can safely enforce.

---

# TRANSACTIONS

Use transactions for multi-record operations that require atomicity, including where appropriate:

* source-record ingestion;
* canonical-place creation;
* place merge;
* dataset-version state changes;
* source-reference updates.

Do not hold database transactions open during slow external provider operations.

---

# CONCURRENCY

Protect against concurrent:

* place updates;
* source ingestions;
* dataset-version publication;
* place merge operations.

Use optimistic concurrency or locking where appropriate.

Do not allow two concurrent ingestion processes to create contradictory canonical mappings.

Do not silently overwrite a concurrently changed authoritative place.

---

# DATASET PUBLICATION

Implement the repository-side primitives required to identify whether a geographic dataset version is:

* received;
* validating;
* validated;
* processing;
* published;
* superseded;
* rolled back.

Do not implement a complete global dataset pipeline.

The current milestone must establish enough state management for later geographic processing infrastructure to publish a known canonical dataset version.

---

# API CONTRACT IMPLEMENTATION

Implement and update the project's authoritative API specification for:

* place lookup;
* place details;
* nearby search;
* bounding-box geographic query;
* forward geocoding;
* reverse geocoding.

Ensure the contract defines:

* authentication;
* authorization;
* request schema;
* response schema;
* limits;
* errors;
* coordinate format;
* precision;
* pagination or bounded result semantics;
* rate limits;
* caching behavior where externally relevant.

Documentation and implementation must remain consistent.

---

# ERROR BEHAVIOR

Use the canonical project error contract.

Geospatial-specific errors must include stable machine-readable categories for:

* invalid coordinates;
* invalid radius;
* invalid bounding box;
* malformed geometry;
* unsupported geometry;
* geocoding failure;
* no result;
* geographic data unavailable;
* dataset version unavailable;
* spatial query limit exceeded.

Do not expose database/PostGIS error text directly.

---

# TESTING — UNIT

Create meaningful unit tests for:

* coordinate validation;
* bounding-box validation;
* radius limits;
* geometry normalization;
* address normalization;
* place normalization;
* category validation;
* source-reference handling;
* lifecycle transitions;
* geocoding candidate selection;
* reverse-geocoding precedence;
* cache-key construction.

Do not write tests that only verify trivial getters/setters.

---

# TESTING — DATABASE AND SPATIAL INTEGRATION

Create integration tests using a real PostgreSQL/PostGIS test environment where available.

Validate:

* migrations;
* spatial indexes;
* nearest-neighbor queries;
* radius filtering;
* bounding-box queries;
* geometry persistence;
* coordinate conversions;
* foreign-key relationships;
* unique source-reference constraints;
* transaction behavior;
* concurrent ingestion behavior where practical.

Do not replace all spatial operations with mocks.

---

# TESTING — API

Test:

* valid coordinates;
* invalid coordinates;
* excessive radius;
* oversized bounding boxes;
* result limits;
* not-found place IDs;
* successful place lookup;
* nearby search;
* forward geocoding;
* reverse geocoding;
* rate limiting;
* malformed requests;
* authorization for protected mutation endpoints;
* safe error responses.

Verify response schemas against the API contract.

---

# TESTING — INGESTION

Use representative deterministic fixtures to test:

* duplicate source records;
* repeated source versions;
* malformed records;
* invalid coordinates;
* normalization;
* provenance;
* dataset-version linkage;
* canonical-record creation;
* merge candidates.

Fixtures must be clearly labeled test data.

Do not imply that test fixtures represent complete real-world geographic coverage.

---

# TESTING — PERFORMANCE

Run practical query-plan checks for:

* radius search;
* nearby category search;
* bounding-box search;
* reverse geocoding;
* place lookup.

Verify that intended spatial indexes are actually considered by the database.

Identify any query that becomes unacceptably expensive as data volume grows.

---

# DOCUMENTATION

Create or update backend documentation covering:

* geographic entity model;
* PostGIS usage;
* coordinate conventions;
* address model;
* place model;
* source provenance;
* dataset versions;
* ingestion flow;
* deduplication behavior;
* place lifecycle;
* place APIs;
* geocoding APIs;
* nearby search;
* geographic query limits;
* caching;
* testing;
* data licensing/provenance assumptions where known.

Document actual behavior only.

Do not claim global geographic coverage unless the repository contains the corresponding data.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* search;
* autocomplete;
* map tiles;
* routing;
* traffic;
* navigation;
* saved places;
* contributions;
* reviews;
* media;
* moderation;
* notifications.

## Web

The web client must be able to consume:

* place details;
* nearby results;
* geocoding;
* reverse geocoding;
* coordinate/geometry conventions.

## Mobile

The mobile client must be able to consume the same geographic contracts without separate incompatible representations.

## Infrastructure

Infrastructure must be able to support:

* PostgreSQL/PostGIS;
* Redis where used;
* ingestion workers later;
* API scaling;
* observability.

## QA

QA must be able to test:

* spatial queries;
* geocoding;
* place contracts;
* data ingestion;
* rate limiting;
* security boundaries.

Do not redesign project-wide contracts merely for local convenience.

---

# PORTABLE GEOSPATIAL CONTRACT ARTIFACTS

Create or update portable artifacts for:

* geographic entity schemas;
* place schema;
* address schema;
* category schema;
* alias schema;
* source-reference schema;
* dataset-version schema;
* geometry conventions;
* place API;
* nearby-search API;
* geocoding API;
* reverse-geocoding API;
* geographic error codes;
* ingestion contract.

Store the artifacts in stable repository locations.

Document which artifact is authoritative.

Do not maintain duplicate conflicting schemas.

---

# VERSIONING AND COMPATIBILITY

Geographic records and derived representations must support version evolution.

API contracts must remain compatible where possible.

Dataset versions must be explicit.

Place IDs must remain stable across source-data refreshes when the canonical entity remains the same.

When a record is superseded or merged, preserve an explicit redirect/reference relationship rather than silently recycling the old identifier.

---

# EXTERNAL DATA REALISM

If the repository requires external geographic datasets:

* identify the provider/source;
* identify the expected format;
* implement the adapter or ingestion interface;
* validate licensing metadata where available;
* do not fabricate credentials;
* do not fabricate network responses;
* do not claim production ingestion has succeeded unless it actually has.

Where external data is unavailable, use deterministic test fixtures for validation and report the external dependency accurately.

---

# FAILURE BEHAVIOR

Define and implement controlled behavior for:

| Failure                       | Required Behavior                                                                  |
| ----------------------------- | ---------------------------------------------------------------------------------- |
| PostgreSQL unavailable        | Return controlled service-unavailable behavior; never fabricate place results      |
| PostGIS spatial query failure | Return safe dependency error and emit telemetry                                    |
| Redis unavailable             | Fall back according to cache policy; authoritative geographic reads remain correct |
| Invalid geometry              | Reject before persistence or processing                                            |
| Duplicate source record       | Apply idempotent handling                                                          |
| Conflicting source update     | Preserve provenance and apply documented reconciliation behavior                   |
| Unknown dataset version       | Reject safely rather than silently mixing versions                                 |
| Ingestion interruption        | Preserve already committed records and allow safe retry                            |
| Geocoding no-match            | Return an explicit empty result rather than fabricated candidates                  |
| Excessive spatial query       | Reject with a bounded query-limit error                                            |

Do not fabricate geographic data to mask dependency failure.

---

# SECURITY REVIEW

Before completion, inspect the implementation for:

* SQL injection;
* unsafe dynamic spatial queries;
* unbounded result extraction;
* coordinate abuse;
* geometry payload abuse;
* unauthorized place mutation;
* source-data leakage;
* internal-provider information leakage;
* cache poisoning;
* sensitive logging;
* rate-limit bypass.

Use parameterized queries and established PostGIS mechanisms.

---

# FINAL DIFF REVIEW

Before declaring completion:

* inspect every changed file;
* verify migrations;
* inspect generated SQL;
* verify spatial indexes;
* verify API schemas;
* verify coordinate conversions;
* verify source-provenance handling;
* verify cache behavior;
* verify logging;
* verify rate limits;
* remove debug code;
* remove unused dependencies;
* verify tests;
* verify type checking;
* verify linting;
* verify formatting;
* verify documentation;
* verify no unrelated future-domain implementation was introduced.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* geographic entities implemented;
* PostGIS changes;
* migrations;
* place implementation;
* address implementation;
* category implementation;
* alias implementation;
* provenance implementation;
* dataset-version implementation;
* ingestion primitives;
* deduplication primitives;
* place lifecycle;
* place lookup API;
* nearby-search API;
* bounding-box API;
* forward-geocoding API;
* reverse-geocoding API;
* Redis/cache changes;
* API-contract changes;
* security changes;
* observability changes;
* tests added;
* tests executed;
* spatial validation performed;
* query-plan validation performed;
* documentation updates;
* compatibility considerations;
* known limitations;
* unresolved external-data dependencies.

The report must accurately describe actual repository changes.

Do not claim that full search, routing, traffic, navigation, map tiles, or global geographic coverage have been implemented.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* authoritative geographic ownership is explicit;
* canonical geographic entities are implemented;
* PostGIS persistence is real;
* coordinate conventions are enforced;
* geometry validation is implemented;
* spatial indexes are implemented;
* place persistence is implemented;
* place categories are implemented;
* place aliases are implemented;
* address persistence is implemented;
* geographic hierarchy is represented appropriately;
* source provenance is preserved;
* dataset versions are represented;
* ingestion primitives are implemented;
* ingestion is idempotent;
* normalization is implemented;
* duplicate-source handling is implemented;
* place deduplication primitives exist;
* safe place merge behavior exists where implemented;
* place lifecycle states are enforced;
* place lookup is implemented;
* place details are implemented;
* nearby search is implemented;
* bounded bounding-box queries are implemented;
* forward geocoding is implemented;
* reverse geocoding is implemented;
* confidence/precision semantics are explicit;
* localization is compatible with the project model;
* caching is bounded and correctly keyed where used;
* cache invalidation/versioning is handled;
* geographic APIs are rate-limited;
* authorization protects administrative mutation;
* privacy boundaries are preserved;
* observability is implemented;
* spatial query performance was validated;
* unit tests exist;
* PostGIS integration tests exist;
* API tests exist;
* ingestion tests exist;
* contract validation exists;
* migrations are validated;
* documentation is current;
* portable geospatial contract artifacts exist;
* external-data dependencies are accurately reported;
* the final diff was inspected;
* there are no fake geographic results;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required functionality;
* no credentials or external infrastructure were fabricated;
* no unrelated future project domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement the full search, map-tile, routing, traffic, navigation, or user-contribution systems during this geospatial backend milestone.
