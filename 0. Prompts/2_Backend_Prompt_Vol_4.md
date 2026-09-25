# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 4

# ROLE

You are the senior backend engineering agent responsible for implementing the **production map-data publication, vector-tile generation and delivery, map-style configuration, and map-serving backend** for a **Google Maps-style global mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Geospatial Engineer
* GIS/Data Engineer
* Map-Rendering Engineer
* Tile-Pipeline Engineer
* PostGIS Engineer
* Distributed Systems Engineer
* CDN/Performance Engineer
* Security Engineer
* Reliability Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement a real, scalable map-delivery subsystem that converts authoritative geographic data into versioned map artifacts and exposes them efficiently to web and mobile clients.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive digital maps;
* geographic feature rendering;
* place discovery;
* address and geocoding capabilities;
* route planning;
* turn-by-turn navigation;
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

This milestone implements the backend map-data publication and tile-serving foundation needed by the web and mobile map clients.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* map-data publication boundaries;
* canonical map dataset version handling;
* vector-tile generation foundation;
* tile schema and layer model;
* tile-coordinate handling;
* map-tile request validation;
* vector-tile encoding;
* versioned tile generation;
* tile publication;
* tile-serving API;
* cache headers;
* CDN-compatible behavior;
* tile versioning;
* geographic feature filtering for tiles;
* zoom-dependent generalization;
* map-style configuration foundation;
* style/version metadata;
* tile invalidation/version switching;
* bounded tile-generation jobs;
* tile-generation observability;
* tile performance controls;
* abuse/rate limiting for tile endpoints;
* secure access boundaries;
* tile-generation integration contracts;
* machine-readable tile/style contracts;
* unit, spatial, integration, contract, and performance tests;
* operational documentation.

The canonical geographic entities established by the geospatial backend remain authoritative.

The tile system is a derived representation.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* route calculation;
* routing-engine integration;
* traffic processing;
* navigation sessions;
* live location telemetry;
* search ranking;
* autocomplete;
* reviews;
* ratings;
* user contributions;
* moderation workflows;
* media upload or media processing;
* notification delivery;
* complete web map UI;
* complete mobile map UI;
* production cloud provisioning;
* production Kubernetes provisioning;
* complete CDN account setup;
* global production dataset acquisition;
* proprietary Google map data;
* proprietary Google APIs;
* fabrication of third-party map assets.

This prompt may create integration hooks for routing, navigation, traffic, search, and client rendering.

Do not create fake routing or navigation behavior to make tiles appear more feature-complete.

---

# REPOSITORY INSPECTION

Inspect the repository before making changes.

Determine:

* current backend structure;
* geographic-domain implementation;
* PostGIS schema;
* geographic dataset/version model;
* existing map/tile code;
* existing tile-generation tooling;
* existing geospatial libraries;
* existing worker/job infrastructure;
* existing object-storage integration;
* existing CDN configuration;
* existing Redis caching;
* existing API contracts;
* existing configuration;
* existing observability;
* existing rate limiting;
* existing tests;
* existing documentation.

Treat the actual repository as the source of truth.

Do not assume that previous AI prompts were executed.

Preserve compatible functionality already present.

Do not duplicate existing map-data models or tile contracts.

If a compatible implementation already exists, extend it rather than replacing it unnecessarily.

---

# BACKEND TECHNOLOGY CONTEXT

Use the project's existing backend technology direction:

* TypeScript;
* NestJS or the repository's compatible modular backend framework;
* PostgreSQL/PostGIS;
* Redis where justified;
* object storage where appropriate;
* queue/job infrastructure where available;
* OpenTelemetry-compatible observability;
* vector-tile tooling compatible with the repository.

For vector tiles, use an established implementation/library such as Mapbox Vector Tile tooling rather than implementing the binary specification manually.

---

# MAP-DATA ARCHITECTURE

The system must maintain a clear separation between:

```text
Authoritative Geographic Dataset
           ↓
     Map Publication Job
           ↓
     Derived Tile Dataset
           ↓
        Versioned Tiles
           ↓
      CDN / Tile API
           ↓
       Web / Mobile
```

Authoritative geographic data remains the source of truth.

Tiles must be rebuildable from the authoritative dataset.

Do not treat generated tiles as the primary database for geographic truth.

---

# DATASET VERSIONING

Use the project's dataset-version model.

A published map dataset must identify:

* dataset version ID;
* source;
* source version;
* schema version;
* generated-at;
* publication timestamp;
* geographic coverage;
* validation state;
* publication state;
* superseded version;
* rollback eligibility.

The active map dataset must be explicit.

Do not silently mix features from incompatible geographic dataset versions.

---

# TILE VERSIONING

Implement versioned tile artifacts.

A tile identity must be deterministically derivable from:

* dataset/map version;
* style or layer version where relevant;
* zoom;
* x;
* y.

Do not overwrite immutable production tiles in a way that makes cache correctness ambiguous.

Prefer immutable/versioned tile URLs or cache keys for published datasets.

---

# TILE COORDINATE SYSTEM

Implement canonical tile-coordinate handling.

Where Web Mercator XYZ tiles are used, explicitly define:

* zoom;
* x;
* y;
* world dimension;
* valid x range;
* valid y range;
* longitude wrapping behavior;
* latitude limits.

Reject invalid tile coordinates.

Do not permit clients to request unsupported zoom levels.

---

# VECTOR TILE FORMAT

Use a standard vector-tile representation.

Define:

* tile format;
* compression;
* layer names;
* feature IDs;
* geometry encoding;
* property conventions;
* extent;
* version;
* metadata.

Do not invent a proprietary binary tile format without a compelling project requirement.

---

# TILE LAYER CONTRACT

Define stable conceptual tile layers.

Evaluate layers appropriate to the product, such as:

* road;
* road-label;
* building;
* landuse;
* water;
* boundary;
* place-label;
* transit;
* poi;
* address-related features where appropriate.

Each layer must define:

* purpose;
* geometry types;
* zoom range;
* feature properties;
* visibility;
* generalization rules.

Do not expose arbitrary database table names as public layer identifiers.

---

# FEATURE PROPERTY CONTRACT

Tile properties must be deliberately limited.

Include only properties necessary for rendering, labeling, interaction, or client behavior.

Do not include:

* internal database fields;
* source credentials;
* private administrative notes;
* unnecessary provenance;
* sensitive user data;
* unrestricted source payloads.

Keep tile payloads compact.

---

# FEATURE IDENTIFIERS

Tile features must use stable identifiers where client interaction requires them.

Define:

* identifier source;
* public versus internal identifiers;
* identifier stability;
* behavior across dataset refreshes.

A regenerated tile must not arbitrarily change a stable public feature ID when the canonical entity remains the same.

---

# ZOOM-DEPENDENT GENERALIZATION

Implement zoom-appropriate geographic representation.

At lower zoom levels:

* simplify geometry;
* reduce feature density;
* omit low-value features;
* avoid unnecessary labels;
* aggregate or generalize where appropriate.

At higher zoom levels:

* provide more detail;
* preserve important geometry;
* include more feature classes.

Use established geometry-simplification algorithms and appropriate tolerances.

Do not apply simplification that changes critical road topology in a way that would make map rendering misleading.

---

# GEOMETRY SIMPLIFICATION

For display-only tile geometry:

* simplify where appropriate;
* preserve topology where required;
* avoid self-intersections;
* enforce bounded vertex counts;
* control tile payload size.

Do not reuse display-generalized geometries as authoritative routing geometry.

Map-rendering geometry and routing geometry have different correctness requirements.

---

# TILE CLIPPING

Implement correct clipping of geometries to tile boundaries.

Account for:

* tile extent;
* buffer around tile edges;
* line continuation across adjacent tiles;
* polygon clipping;
* geometry validity.

Use a buffer where necessary to avoid visible seams and label/line discontinuities.

Do not let clipping modify authoritative geographic data.

---

# LABEL SUPPORT

Provide tile properties needed for efficient client-side labeling.

Where appropriate include:

* name;
* localized name;
* feature class;
* rank/priority;
* shield information;
* road class;
* administrative level.

Do not encode complete UI rendering logic in the backend.

---

# MAP-STYLE CONTRACT

Implement a versioned map-style configuration foundation.

A map-style configuration should define:

* style ID;
* style version;
* source references;
* layer configuration;
* visibility;
* paint properties;
* layout properties;
* sprite/icon references where applicable;
* glyph/font references where applicable.

Use a standard style representation compatible with the selected map-rendering technology where feasible.

Do not embed copyrighted proprietary Google Maps styles or assets.

---

# STYLE VERSIONING

Style updates must be versioned separately from geographic dataset versions.

Define:

* style ID;
* style version;
* compatibility with tile schema;
* publication state;
* activation timestamp.

A style change must not require regeneration of immutable geographic tiles unless the style architecture explicitly requires baked-in styling.

---

# TILE API

Implement a bounded tile endpoint consistent with the project's API/security architecture.

Support requests equivalent to:

```text
/{map-version}/{z}/{x}/{y}
```

or another repository-compatible path.

Validate:

* dataset/map version;
* zoom;
* x;
* y;
* style/layer where applicable.

Return:

* vector tile content;
* content type;
* cache-control;
* version metadata where appropriate.

Do not expose filesystem paths or internal storage keys.

---

# TILE HTTP CONTRACT

Define proper HTTP behavior for:

* successful tile;
* invalid coordinates;
* missing tile;
* unpublished version;
* expired dataset version;
* unauthorized access where a protected tile requires it;
* rate limit;
* service failure.

Use appropriate status codes.

Do not return `200` with a fake empty map tile for operational failures unless the product contract explicitly defines an empty tile as valid.

---

# TILE CACHE POLICY

Map tiles are excellent candidates for immutable caching when they are versioned.

Implement:

* long-lived cacheability for immutable published tiles;
* ETag or equivalent validators where appropriate;
* content encoding;
* CDN compatibility;
* version-aware cache keys;
* controlled invalidation.

Do not use global cache flushes for every new dataset.

Prefer version changes to preserve previous immutable tiles and allow gradual cutover.

---

# REDIS USAGE

Redis may be used for:

* tile metadata;
* hot-tile caching where origin/CDN caching alone is insufficient;
* publication state;
* generation job state;
* rate limiting.

Do not use Redis as the authoritative tile store.

Do not cache unbounded tile objects in Redis.

For every tile-related Redis key define:

* namespace;
* TTL;
* size expectations;
* invalidation;
* failure behavior.

---

# OBJECT STORAGE

Store generated tile artifacts in object storage when appropriate.

Use a deterministic storage structure based on:

* map version;
* style version if needed;
* zoom;
* x;
* y.

Do not place unversioned mutable production tiles under permanent public keys if doing so creates cache inconsistency.

Object storage access must use least privilege.

Clients should receive tiles through the controlled tile endpoint/CDN rather than unrestricted bucket credentials.

---

# TILE PUBLICATION

Implement a safe publication lifecycle:

```text
DATASET AVAILABLE
       ↓
TILE GENERATION
       ↓
VALIDATION
       ↓
PUBLICATION
       ↓
ACTIVE VERSION
       ↓
SUPERSEDED
```

A failed generation must not replace the active dataset.

A failed validation must prevent publication.

Publication must be atomic at the version level.

---

# TILE GENERATION JOBS

Implement repository-side jobs/workers for tile generation.

The job system must support:

* dataset/version selection;
* region or partition selection where applicable;
* zoom ranges;
* bounded concurrency;
* retries;
* backoff;
* progress tracking;
* idempotency;
* partial failure handling;
* resumability.

Do not generate the entire globe in a single unbounded process.

Partition work into manageable units.

---

# TILE GENERATION PARTITIONING

Where global scale requires it, partition generation by:

* geographic region;
* zoom;
* tile ranges;
* dataset partition.

The partitioning design must make it possible to resume failed regions without restarting the entire generation job.

Do not create millions of individual queue definitions.

Use batching appropriate to the execution environment.

---

# TILE GENERATION IDEMPOTENCY

Generation must be safely repeatable.

Repeated generation for the same:

* dataset version;
* style-independent tile identity;
* zoom;
* x;
* y;

must produce the same effective artifact unless source data or deterministic rendering configuration changed.

Use checksums or content hashes where useful.

---

# TILE VALIDATION

Before publication, validate generated tiles.

Check:

* valid vector-tile encoding;
* expected layer presence;
* feature counts within bounds;
* geometry validity;
* maximum tile size;
* coordinate ranges;
* required metadata;
* dataset/version metadata;
* absence of forbidden fields.

Reject corrupt or suspiciously large tiles.

Do not publish partially generated or invalid tiles.

---

# TILE SIZE CONTROL

Implement safeguards against oversized tiles.

Monitor:

* raw size;
* compressed size;
* feature count;
* geometry complexity.

Where tiles become too large:

* simplify geometry;
* reduce low-priority features;
* tune zoom visibility;
* partition data appropriately.

Do not silently truncate arbitrary feature data merely to fit a size limit.

---

# TILE INVALIDATION

For immutable versioned tiles, favor version-based publication over frequent invalidation.

For mutable metadata caches, define explicit invalidation.

Do not perform a global Redis/CDN purge merely because one place changed.

Map-data corrections should normally flow through the geographic dataset publication process.

---

# MAP DATA FRESHNESS

Track:

* source dataset timestamp;
* canonical dataset version;
* tile-generation start;
* tile-generation completion;
* publication time.

Expose operational metrics for tile freshness.

Do not claim real-time geographic freshness if the source-to-tile pipeline is asynchronous.

---

# MAP DATASET ROLLBACK

Implement version-level rollback behavior.

If a newly published dataset causes operational or data-quality problems:

* mark the new version inactive;
* restore the previous known-good active version;
* preserve immutable tile artifacts;
* record the rollback reason;
* emit an operational event where appropriate.

Do not delete the previous active dataset merely because a new version was published.

---

# MAP STYLE ACTIVATION

Style publication must be controlled independently from data publication unless the selected renderer requires combined versioning.

Support:

* draft;
* validated;
* published;
* active;
* superseded.

Do not allow an unvalidated style configuration to become the active client configuration.

---

# TILE METADATA

Provide tile metadata that clients or operational tools may need, such as:

* dataset version;
* tile version;
* generated-at;
* style compatibility;
* attribution requirements where applicable.

Do not leak internal source credentials or infrastructure metadata.

---

# ATTRIBUTION AND LICENSING

Where external geographic data requires attribution or other notice:

* preserve required attribution metadata;
* expose it through the appropriate client/map configuration;
* document the source and license;
* do not remove mandatory attribution from generated artifacts.

Do not claim licensing rights that the repository does not possess.

The system must not present proprietary Google data as its own or imply an affiliation with Google.

---

# SECURITY

Protect the tile system against:

* path traversal;
* object-key manipulation;
* arbitrary file access;
* malformed tile-coordinate requests;
* cache poisoning;
* excessive tile crawling;
* origin overload;
* request amplification;
* unpublished dataset access;
* internal storage exposure.

Never construct filesystem or object-storage access from unchecked client strings.

Validate all tile parameters before storage lookup.

---

# RATE LIMITING AND ABUSE

Map tiles may generate very high request volume.

Implement appropriate protections for:

* unauthenticated tile access;
* authenticated tile access where applicable;
* per-IP limits;
* per-client limits;
* burst behavior;
* CDN/origin protection.

Do not apply an application-level limit so low that normal map panning becomes unusable.

Prefer CDN caching and origin shielding where infrastructure supports it.

---

# OBSERVABILITY

Instrument:

* tile requests;
* tile cache hits/misses;
* origin latency;
* tile generation throughput;
* tile generation failures;
* tile size;
* feature counts;
* publication duration;
* dataset freshness;
* style publication;
* rate-limit rejections.

Track:

* p50;
* p95;
* p99 latency;
* error rate;
* origin saturation;
* generation lag.

Never log complete private request context unnecessarily.

---

# PERFORMANCE

Validate:

* tile-generation throughput;
* tile-serving latency;
* vector-tile encoding performance;
* geometry simplification cost;
* object-storage access;
* cache effectiveness;
* memory consumption;
* worker concurrency.

Prevent:

* unbounded tile generation;
* unbounded in-memory feature loading;
* full-world dataset materialization in one process;
* pathological geometry processing;
* redundant regeneration of unchanged immutable tiles.

Use streaming/batched processing where necessary.

---

# DATABASE ACCESS

Do not query the entire geographic database for every tile request.

For tile generation:

* use spatial indexes;
* use bounded tile envelopes;
* select only necessary fields;
* precompute when beneficial;
* batch by tile/region.

For tile serving:

* prefer generated artifacts from object storage/CDN;
* avoid runtime PostGIS rendering for every production request unless explicitly justified.

---

# CLIENT CONTRACT

The tile backend must remain compatible with:

## Web

MapLibre-compatible rendering must be able to request:

* styles;
* tile metadata;
* vector tiles;
* attribution information.

## Mobile

The same geographic/tile contracts must work efficiently on mobile networks and device hardware.

Support:

* bounded payloads;
* compression;
* cache-friendly versioning;
* offline-cache compatibility where the client later implements it.

## Routing

Map visualization and routing geometry must remain separate contracts.

Do not substitute display-generalized tile geometry for routing geometry.

---

# MAP STYLE API

Where the repository architecture exposes style configuration through an API, implement the bounded style retrieval capability.

A style response must identify:

* style ID;
* style version;
* tile source;
* glyph/icon references where applicable;
* layer configuration;
* attribution;
* compatibility metadata.

Do not implement a visual style editor.

Do not hardcode client-specific UI settings into backend style data.

---

# API CONTRACTS

Create or update authoritative contracts for:

* tile retrieval;
* style retrieval where applicable;
* tile metadata;
* map dataset publication state where internally exposed.

Document:

* request parameters;
* coordinate rules;
* response content type;
* caching;
* versioning;
* errors;
* rate limits.

Ensure the contract matches actual implementation.

---

# MACHINE-READABLE TILE CONTRACTS

Where practical, create machine-readable artifacts for:

* tile metadata;
* style metadata;
* layer definitions;
* feature-property conventions;
* map-version state;
* tile-generation job payload;
* publication contract.

Document which artifact is authoritative.

Do not duplicate definitions across multiple incompatible files.

---

# EVENT AND QUEUE INTEGRATION

Where event infrastructure is already available, integrate appropriately with events such as:

* `MapDatasetValidated`;
* `MapDatasetPublished`;
* `MapDatasetRolledBack`;
* `TileGenerationRequested`;
* `TileGenerationCompleted`;
* `TileGenerationFailed`;
* `MapStylePublished`;
* `MapStyleRolledBack`.

If the repository already defines compatible event names, preserve those definitions.

Events must remain versioned and idempotent.

Do not introduce a second event taxonomy.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                                          | Required Behavior                                                               |
| ------------------------------------------------ | ------------------------------------------------------------------------------- |
| PostgreSQL/PostGIS unavailable during generation | Generation fails safely; active published tiles remain available                |
| Object storage unavailable                       | Tile generation/publication fails safely; do not claim publication              |
| Redis unavailable                                | Continue without cache/metadata caching where safe                              |
| CDN unavailable                                  | Origin-serving behavior follows infrastructure contract; do not fabricate tiles |
| Tile generation worker failure                   | Retry bounded work; preserve progress and active dataset                        |
| Corrupt tile                                     | Reject publication of the affected artifact                                     |
| Invalid dataset version                          | Refuse generation                                                               |
| Style validation failure                         | Keep previous active style                                                      |
| Tile coordinate invalid                          | Return controlled client error                                                  |
| Unpublished version requested                    | Reject or return not-found according to the contract                            |
| Oversized tile                                   | Reject or regenerate according to bounded generation policy                     |

Do not return fabricated map content to conceal operational failure.

---

# TESTING — UNIT

Create unit tests for:

* tile-coordinate validation;
* XYZ calculations;
* world bounds;
* longitude wrapping;
* zoom limits;
* geometry simplification rules;
* layer filtering;
* feature-property projection;
* tile storage-key generation;
* cache-control generation;
* dataset-version validation;
* style-version validation;
* publication state transitions.

---

# TESTING — GEOSPATIAL

Use real PostGIS or an equivalent geospatial test environment where available.

Validate:

* tile envelope calculation;
* spatial filtering;
* geometry clipping;
* geometry simplification;
* feature inclusion/exclusion;
* spatial index use;
* boundary behavior at tile edges;
* antimeridian/wrapping behavior where applicable.

Do not replace all geospatial logic with mocks.

---

# TESTING — VECTOR TILES

Validate generated tiles for:

* valid binary encoding;
* expected layers;
* expected feature IDs;
* expected properties;
* valid geometry;
* bounded tile size;
* dataset metadata;
* stable output for deterministic inputs.

Test adjacent tile boundaries to detect seams or missing features.

---

# TESTING — API

Test:

* valid tile requests;
* invalid z/x/y;
* unsupported zoom;
* unpublished versions;
* missing tiles;
* style retrieval;
* rate limiting;
* cache headers;
* content type;
* safe errors.

Verify API responses against the authoritative contract.

---

# TESTING — PUBLICATION

Test:

* generation;
* validation;
* publication;
* version activation;
* supersession;
* rollback.

Verify that:

* failed generation does not replace active tiles;
* failed validation does not publish;
* rollback restores the previous version;
* immutable tile artifacts remain retrievable during transition where intended.

---

# TESTING — PERFORMANCE

Use representative geographic fixtures to measure:

* tile-generation time;
* tile size;
* tile-serving latency;
* cache behavior;
* memory use;
* worker concurrency.

Test low-, medium-, and high-zoom workloads.

Do not claim global production capacity from small fixtures.

---

# DOCUMENTATION

Create or update documentation covering:

* map-data publication;
* dataset versions;
* tile coordinate system;
* vector-tile format;
* tile layers;
* feature properties;
* generalization;
* clipping;
* tile generation;
* object storage;
* CDN behavior;
* cache strategy;
* style versions;
* publication;
* rollback;
* operational metrics;
* licensing/attribution;
* troubleshooting;
* recovery.

Document actual repository behavior only.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* authoritative geographic data;
* search;
* geocoding;
* routing;
* traffic;
* navigation;
* place contributions;
* media;
* moderation.

## Web

The web client must be able to consume:

* map styles;
* vector tiles;
* tile metadata;
* versioned tile URLs;
* attribution information.

## Mobile

The mobile client must be able to consume the same map contracts efficiently.

## Infrastructure

Infrastructure must be able to host:

* tile workers;
* object storage;
* CDN;
* API serving;
* Redis where used;
* observability.

## QA

QA must be able to validate:

* tile generation;
* vector encoding;
* geographic correctness;
* publication;
* rollback;
* performance;
* security.

---

# PORTABLE MAP CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* map dataset version;
* tile-coordinate contract;
* vector-tile metadata;
* layer contract;
* feature-property contract;
* tile API;
* style API;
* tile-generation job schema;
* publication workflow;
* rollback procedure;
* attribution/license metadata.

Document authoritative ownership for each artifact.

---

# SECURITY REVIEW

Before completion, inspect for:

* path traversal;
* object-storage key injection;
* arbitrary file access;
* unrestricted tile crawling;
* cache poisoning;
* unpublished-version leakage;
* oversized requests;
* memory exhaustion;
* malformed geometry;
* unsafe style configuration;
* sensitive metadata exposure.

Use parameterized database queries and safe object-storage abstractions.

---

# FINAL DIFF REVIEW

Before completion:

* inspect all changed files;
* inspect migrations;
* inspect tile schemas;
* inspect layer definitions;
* inspect storage paths;
* inspect style files;
* inspect worker configuration;
* inspect rate limits;
* inspect observability;
* inspect API documentation;
* inspect test coverage;
* run type checking;
* run linting;
* run formatting;
* remove debug code;
* remove unused dependencies;
* verify no future-domain implementation was introduced.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* map-data changes;
* dataset-version changes;
* tile schema;
* tile layers;
* tile-generation implementation;
* tile-generation workers;
* vector-tile encoding;
* clipping/generalization;
* tile publication;
* tile-serving API;
* style API/configuration;
* object-storage changes;
* Redis changes;
* caching behavior;
* CDN-compatible configuration;
* rate limiting;
* observability;
* security changes;
* API contract changes;
* event/queue changes;
* tests created;
* tests executed;
* spatial validation;
* tile validation;
* performance validation;
* documentation updates;
* licensing/attribution considerations;
* compatibility considerations;
* known limitations;
* unresolved external dependencies.

The report must accurately describe actual repository changes.

Do not claim that a production CDN, object-storage account, cloud environment, or global map dataset was provisioned unless it was actually verified.

Do not claim that routing or navigation has been implemented.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* authoritative geographic data remains separate from derived map artifacts;
* dataset versions are represented and validated;
* tile versions are explicit;
* tile coordinates are validated;
* vector-tile generation is real;
* standard vector-tile encoding is used;
* tile layers are defined;
* feature properties are deliberately limited;
* stable feature identifiers are preserved where required;
* zoom-dependent generalization is implemented;
* geometry simplification is safe;
* tile clipping is implemented;
* tile-edge behavior is tested;
* map styles are versioned;
* style publication is controlled;
* tile retrieval is implemented;
* tile HTTP behavior is correct;
* immutable caching/versioning is implemented;
* Redis is bounded where used;
* object storage integration is real where used;
* tile publication is version-atomic;
* failed generation cannot replace the active version;
* rollback is implemented;
* tile-generation jobs are bounded and resumable;
* tile generation is idempotent;
* generated tiles are validated;
* oversized tiles are detected;
* freshness is measurable;
* attribution/licensing metadata is preserved;
* tile endpoints are rate-limited appropriately;
* tile security controls are implemented;
* observability is implemented;
* geospatial performance was validated;
* vector-tile tests exist;
* API tests exist;
* publication/rollback tests exist;
* performance validation exists;
* portable map contracts exist;
* documentation is current;
* the final diff was inspected;
* there are no fake map tiles;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required functionality;
* no credentials or external infrastructure were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement routing, traffic, navigation, reviews, media, or the complete web/mobile map experiences during this map-data and tile backend milestone.
