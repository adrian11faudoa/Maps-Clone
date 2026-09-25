# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 3

# ROLE

You are the senior backend engineering agent responsible for implementing the **production search, autocomplete, place-discovery, indexing, and geographic-ranking backend** for a **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Search Architect
* Search/Relevance Engineer
* Geospatial Backend Engineer
* OpenSearch Engineer
* Data Pipeline Engineer
* API Engineer
* Database Engineer
* Distributed Systems Engineer
* Security Engineer
* Performance Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement a real, scalable search and discovery platform that consumes the project's authoritative place and geographic data without redefining those domains.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to support:

* interactive maps;
* places and points of interest;
* address search;
* autocomplete;
* place discovery;
* nearby search;
* forward and reverse geocoding;
* routing;
* navigation;
* traffic;
* user location;
* saved places;
* contributions;
* reviews and ratings;
* media;
* notifications;
* moderation;
* administration;
* analytics;
* operational observability.

This milestone implements the search and discovery layer that allows users to efficiently find places, addresses, categories, and geographic entities.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* search-domain backend structure;
* OpenSearch or the repository's selected search-engine integration;
* canonical search-document projection;
* place-to-search indexing;
* address indexing where appropriate;
* alias indexing;
* category indexing;
* localized search fields where supported;
* normalized text fields;
* autocomplete;
* prefix matching;
* typo tolerance where appropriate;
* geographic relevance;
* nearby discovery through the search layer where useful;
* result ranking;
* deterministic ranking signals;
* search filters;
* bounded search requests;
* search pagination;
* search result contracts;
* search-document versioning;
* indexing events/requests;
* index refresh workflows;
* delete propagation;
* alias/index migration support;
* index rebuild support;
* bulk indexing foundation;
* index backfill foundation;
* search caching where justified;
* search rate limiting;
* abuse controls;
* observability;
* search failure/degradation behavior;
* unit tests;
* integration tests;
* search contract tests;
* ranking tests;
* indexing tests;
* performance validation;
* search documentation.

The authoritative Place and Address records remain outside the search engine.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* routing engine implementation;
* traffic ingestion or traffic modeling;
* turn-by-turn navigation;
* live navigation sessions;
* location telemetry;
* map-tile generation;
* CDN deployment;
* place reviews;
* place ratings;
* user-contribution workflows;
* media upload or media processing;
* notification delivery;
* moderation application;
* complete web search UI;
* complete mobile search UI;
* production Kubernetes provisioning;
* production cloud provisioning;
* full analytics infrastructure.

This prompt may create event/indexing contracts and integration hooks required by those domains.

Do not create fake implementations of future functionality.

---

# REPOSITORY INSPECTION

Inspect the repository first.

Determine:

* existing backend structure;
* place/geographic domain implementation;
* Address and Place schemas;
* canonical identifiers;
* database schema;
* PostGIS implementation;
* existing search dependencies;
* OpenSearch/Elasticsearch integration;
* Redis integration;
* event infrastructure;
* queue infrastructure;
* API contracts;
* configuration;
* observability;
* existing search code;
* existing tests;
* CI tooling;
* documentation.

Treat the current repository as the source of truth for actual implementation state.

Do not assume that another AI conversation executed any previous prompt.

Preserve compatible implementations.

Do not create duplicate Place or Address models.

Do not create a second incompatible search abstraction if a compatible repository implementation already exists.

When repository implementation differs from the expected architecture, make the smallest coherent compatibility-preserving changes necessary within this scope.

---

# SEARCH TECHNOLOGY CONTEXT

The search implementation uses:

* OpenSearch or another repository-selected compatible search engine;
* PostgreSQL/PostGIS as authoritative source data;
* Redis where caching provides justified value;
* the project's event/queue infrastructure where available;
* TypeScript/NestJS or the repository's compatible backend framework.

Do not allow the search engine to become the authoritative transactional source of place data.

The search index is a derived representation.

---

# SEARCH ARCHITECTURE PRINCIPLE

The search pipeline must follow a flow conceptually equivalent to:

```text
Authoritative Place / Address Data
              ↓
         Change Event
              ↓
      Projection / Normalization
              ↓
       Search Document
              ↓
          OpenSearch
              ↓
       Search / Autocomplete
              ↓
     Ranked Search Results
```

The exact implementation may use queues, batch pipelines, outbox records, direct projection workers, or other mechanisms already established by the repository.

The key invariant is:

**Authoritative geographic data remains the source of truth.**

Search data is rebuildable.

---

# SEARCH DOCUMENT MODEL

Implement a canonical search-document model.

A search document should support, as applicable:

* document ID;
* place ID;
* feature type;
* canonical name;
* searchable names;
* aliases;
* normalized names;
* localized names;
* categories;
* address;
* administrative hierarchy;
* postal code where available;
* geographic coordinates;
* geographic geometry where justified;
* ranking signals;
* source/provider metadata where safe;
* verification state;
* quality state;
* freshness metadata;
* dataset version;
* document version;
* indexed-at timestamp.

Do not duplicate unnecessary authoritative data into the index.

Only include fields required for retrieval, filtering, ranking, or presentation.

---

# SEARCH DOCUMENT OWNERSHIP

Define clear ownership:

* Place domain owns Place truth.
* Address/geographic domain owns address/geographic truth.
* Search domain owns the search-document projection.
* OpenSearch owns indexed search representation.
* Redis owns only explicitly temporary cached results.

A search document must be rebuildable from authoritative source data.

Do not store irreversible business state only inside OpenSearch.

---

# INDEX NAMING AND VERSIONING

Implement explicit index versioning.

Use a structure that can support:

* environment isolation;
* schema version;
* deployment version;
* dataset version;
* zero/minimal-downtime reindexing.

Avoid hardcoding one permanent production index name deep inside application code.

Use index aliases or an equivalent version-switching strategy where appropriate.

Document:

* active index;
* candidate index;
* read alias;
* write behavior;
* rebuild process;
* cutover;
* rollback.

---

# SEARCH-SCHEMA VERSIONING

Search-document schema evolution must be explicit.

When the document schema changes:

* create a new schema version;
* update projection logic;
* build the new index;
* validate the new index;
* backfill;
* switch the read alias;
* monitor;
* retain rollback capability where operationally appropriate.

Do not mutate a production index schema in a way that makes rollback impossible without documented justification.

---

# TEXT NORMALIZATION

Implement deterministic search text normalization.

Normalize, as appropriate:

* Unicode;
* casing;
* diacritics;
* whitespace;
* punctuation;
* common separators;
* locale-specific normalization.

Do not apply transformations that destroy the original display representation.

Maintain:

* display value;
* normalized search value.

Do not use normalization as a substitute for proper linguistic analyzers.

---

# LANGUAGE AND LOCALIZATION

Where the repository supports localization, implement language-aware search fields.

Support, as applicable:

* language-specific names;
* aliases;
* transliterations;
* locale preference;
* fallback languages.

Search behavior must not silently discard localized names.

Define fallback order.

Do not hardcode one language as globally authoritative for every geographic entity.

---

# ANALYZERS AND SEARCH FIELDS

Configure analyzers appropriate to the selected search engine.

Evaluate:

* exact-match fields;
* prefix fields;
* full-text fields;
* keyword fields;
* normalized fields;
* language-specific fields;
* n-gram/search-as-you-type structures where useful.

Use analyzers purposefully.

Do not add analyzers merely because the engine supports them.

Document why each important indexed field exists.

---

# SEARCH QUERY MODEL

Implement the search API according to the project's canonical API contract.

Support, as applicable:

* query text;
* geographic bias;
* viewport/bounding box;
* category;
* feature type;
* country/region filters;
* language;
* open-now filters where source data supports it;
* result limit;
* cursor;
* session context where applicable.

Requests must remain bounded.

Reject or constrain:

* excessively long query strings;
* huge result limits;
* unbounded geographic areas;
* arbitrarily complex filters.

---

# SEARCH RESULT CONTRACT

Implement a stable search-result representation.

Each result should include, as applicable:

* place ID;
* feature type;
* display name;
* highlighted matched text where appropriate;
* formatted address;
* coordinates;
* distance when a geographic origin is supplied;
* category;
* short metadata required by clients;
* relevance metadata only when safe and useful.

Do not expose internal OpenSearch scoring values as if they were universal product-quality scores.

If a rank/debug score is returned internally, keep it internal.

---

# SEARCH RANKING

Implement a deterministic ranking pipeline.

Ranking may consider:

* lexical relevance;
* exact-name matches;
* prefix matches;
* alias matches;
* geographic distance;
* category match;
* popularity signals where available;
* verification;
* source quality;
* freshness;
* data completeness.

Define explicit weighting.

Avoid a ranking model that depends on undocumented database behavior.

Do not create arbitrary user-specific ranking behavior without a clear data source.

---

# RANKING TIERS

Where useful, establish a deterministic precedence model such as:

1. strong exact match;
2. strong normalized/prefix match;
3. alias/localized match;
4. category/geographic relevance;
5. distance/popularity quality adjustments.

The exact implementation must be documented and testable.

Do not implement ranking as an opaque collection of magic constants without explanation.

---

# GEOGRAPHIC RELEVANCE

Search must support geographic context.

When the client supplies:

* current location;
* map viewport;
* bounding box;
* search center;

use it to influence candidate ranking or filtering.

Do not treat latitude/longitude merely as opaque numbers.

Use OpenSearch geo fields or PostGIS-assisted candidate generation where appropriate.

Avoid expensive global-distance sorting across the full index.

---

# NEARBY SEARCH

Where OpenSearch provides an efficient geospatial search path, implement compatible nearby discovery behavior.

Support:

* center point;
* radius;
* category;
* maximum results;
* bounded result window.

The authoritative place data remains in PostgreSQL/PostGIS.

Use OpenSearch for low-latency search/discovery workloads where appropriate.

Do not allow the search index to drift silently from authoritative place data.

---

# SEARCH AND POSTGIS RESPONSIBILITIES

Define clear boundaries:

Use PostgreSQL/PostGIS for authoritative:

* place storage;
* address storage;
* transactional updates;
* exact ownership;
* spatial integrity.

Use OpenSearch for:

* free-text search;
* autocomplete;
* ranking;
* search-time geographic relevance;
* large-scale discovery.

Use the system best suited to each workload.

Do not force every geospatial query through OpenSearch if PostGIS is materially more appropriate.

---

# AUTOCOMPLETE

Implement dedicated autocomplete functionality.

Autocomplete must optimize for:

* low latency;
* compact responses;
* prefix matching;
* partial names;
* address suggestions;
* local geographic relevance;
* category relevance where useful.

Support:

* query;
* geographic context;
* language;
* result limit;
* session token or request-grouping mechanism if defined by the project's contract.

Do not return complete place-detail payloads from autocomplete.

---

# AUTOCOMPLETE SESSION CONTEXT

Where a client session token is used for grouping autocomplete requests:

* validate format;
* bound token lifetime;
* avoid using raw client-controlled tokens as unrestricted cache keys;
* prevent abuse;
* document semantics.

A session token must not become an authentication mechanism.

---

# TYPO TOLERANCE

Implement controlled typo tolerance using the search engine's established capabilities.

The system should tolerate reasonable:

* character omissions;
* substitutions;
* transpositions;
* spacing errors.

Do not make fuzzy matching so broad that unrelated places dominate results.

Test false-positive behavior.

---

# EXACT MATCH PRIORITY

Exact canonical-name matches should receive deterministic treatment.

Where appropriate, distinguish:

* exact normalized name;
* exact alias;
* exact address component;
* prefix match;
* fuzzy match.

Do not allow a distant fuzzy result to routinely outrank a strong exact local result without a documented reason.

---

# ADDRESS SEARCH

Search must support address-oriented retrieval where the available data supports it.

Use separate indexed fields for components such as:

* house number;
* street;
* locality;
* city;
* region;
* postal code;
* country.

Do not collapse the entire address exclusively into one uncontrolled text string.

The search result may still expose a formatted address.

---

# CATEGORY SEARCH

Support category discovery using canonical category identifiers.

Category filtering must use stable codes rather than user-generated free-text strings.

Where category hierarchy exists, define whether queries match:

* exact category;
* descendants;
* ancestors.

Do not let category behavior vary between endpoints.

---

# PLACE SEARCH CONTEXT

Search results should return enough context for clients to distinguish similarly named places.

Where available include:

* city/locality;
* region;
* country;
* neighborhood;
* address;
* distance.

Do not expose unnecessary internal data.

---

# SEARCH FRESHNESS

Search projections must have explicit freshness behavior.

Track:

* source dataset version;
* source update timestamp;
* projection timestamp;
* indexing timestamp.

Monitor projection lag.

Do not claim real-time search freshness if indexing is asynchronous.

---

# INDEXING PIPELINE

Implement the indexing pipeline foundation.

Support:

* create/update projection;
* delete projection;
* batch indexing;
* retries;
* idempotency;
* version validation;
* partial failure handling;
* observability.

Use the project's event/queue infrastructure where available.

If the event infrastructure is not yet implemented in the repository, create a clean adapter boundary without fabricating a production broker.

---

# INDEXING EVENTS

Consume or prepare for canonical events such as:

* `PlaceCreated`;
* `PlaceUpdated`;
* `PlaceDeleted`;
* `PlaceMerged`;
* `AddressUpdated`;
* `DatasetPublished`.

If the project's currently implemented event infrastructure uses different names, preserve the authoritative repository contracts and document compatibility.

For each event ensure:

* event version;
* place/entity ID;
* source/dataset version where relevant;
* event timestamp;
* idempotent projection behavior.

---

# IDEMPOTENT PROJECTION

Indexing must be idempotent.

Repeated processing of the same event must result in the same effective search document.

Use:

* document version;
* source version;
* event sequence where appropriate;
* deterministic document identifiers.

Prevent stale events from overwriting newer search data.

---

# OUT-OF-ORDER EVENTS

The projection system must account for events arriving out of order.

Where event ordering is not guaranteed:

* compare source/entity versions where available;
* reject stale projections;
* make updates monotonic where appropriate.

Do not let an older event silently overwrite a newer document.

---

# DELETE PROPAGATION

When an authoritative place/address record is deleted or superseded:

* remove or invalidate its search document;
* preserve redirect behavior for merged identifiers where required;
* avoid returning stale deleted records.

Delete handling must be idempotent.

Do not rely solely on periodic full reindexing to remove deleted records.

---

# PLACE MERGE PROPAGATION

Where a place is merged:

* old identifier;
* surviving identifier;
* search-document state;
* aliases;
* source identifiers;

must remain consistent.

The search index must not continue presenting the superseded record as an independent active result.

---

# BULK INDEXING

Implement a reusable bulk indexing mechanism.

It must support:

* batching;
* bounded memory;
* partial failures;
* retry;
* idempotency;
* progress tracking;
* resumability;
* rate control.

Do not load the entire geographic database into process memory.

---

# INDEX REBUILD

Implement the repository-side capability to rebuild a search index from authoritative data.

The rebuild must support:

* selecting a dataset/source version;
* creating a new versioned index;
* bulk population;
* validation;
* progress reporting;
* cutover;
* rollback where appropriate.

A failed rebuild must not destroy the currently active search index.

---

# REINDEX SAFETY

Before switching a rebuilt index into production use:

* validate document counts;
* validate required mappings;
* validate representative search cases;
* validate delete behavior;
* validate category behavior;
* validate geospatial fields;
* validate autocomplete;
* validate ranking invariants.

Do not switch aliases merely because an indexing job completed.

---

# SEARCH CACHING

Use Redis caching where measurable value exists.

Potential cache targets include:

* autocomplete;
* frequently repeated search requests;
* popular place lookup combinations.

Cache keys must include all request parameters that materially affect results, such as:

* query;
* language;
* geographic context;
* category filters;
* dataset/search version.

Set bounded TTLs.

Do not cache indefinitely.

Do not cache private or unauthorized data into shared public cache keys.

---

# CACHE FAILURE

Search correctness must not depend on Redis availability.

When Redis is unavailable:

* search remains functionally correct through OpenSearch where feasible;
* cache misses are acceptable;
* the API must not fabricate results;
* rate limiting must follow its documented security policy.

Do not make Redis the sole store of search results.

---

# RATE LIMITING

Apply search-specific rate limits.

Differentiate at least:

* autocomplete;
* full search;
* nearby discovery;
* bulk/admin indexing.

Autocomplete generally requires high request frequency but small query cost.

Full search and geographic queries require stronger cost controls.

Bulk indexing must not share public-user rate limits.

---

# ABUSE PREVENTION

Protect search from:

* scraping;
* query floods;
* wildcard abuse;
* fuzzy-query abuse;
* oversized geographic queries;
* excessive pagination;
* indexing abuse;
* alias explosion.

Reject pathological queries before they become expensive search-engine operations.

Do not permit raw OpenSearch query DSL from untrusted clients.

---

# SEARCH ENGINE SAFETY

Never pass arbitrary client-controlled OpenSearch query structures directly to the search engine.

Build typed application-level search queries.

Validate:

* query text;
* filters;
* geo inputs;
* pagination;
* result limits.

Do not permit clients to choose:

* index names;
* analyzers;
* scripts;
* arbitrary sort expressions;
* raw query JSON.

---

# SECURITY

Inspect the search system for:

* index privilege escalation;
* arbitrary query injection;
* OpenSearch scripting abuse;
* excessive result extraction;
* cache poisoning;
* unauthorized unpublished-place exposure;
* deleted-record leakage;
* provider/source data exposure.

The backend must use least-privileged search-engine credentials.

Do not expose OpenSearch directly to browsers or mobile applications.

---

# PRIVACY

Search requests may contain location context.

Treat client-supplied exact location as potentially sensitive.

Do not unnecessarily log:

* exact coordinates;
* persistent user search history;
* raw search queries tied to user IDs.

Where operational diagnostics require location data:

* minimize precision;
* restrict access;
* use environment-appropriate redaction;
* avoid indefinite retention.

Do not create a persistent user-search-history system in this milestone.

---

# OBSERVABILITY

Instrument:

* search latency;
* autocomplete latency;
* result count;
* zero-result rate;
* search errors;
* index lag;
* indexing throughput;
* indexing failures;
* OpenSearch availability;
* OpenSearch query latency;
* cache hit/miss;
* rate-limit rejection;
* projection lag;
* stale-event rejection.

Use:

* request ID;
* correlation ID;
* trace ID;
* index version;
* dataset version where useful;
* operation type.

Do not log full sensitive search context unnecessarily.

---

# PERFORMANCE

Validate:

* autocomplete latency;
* search latency;
* nearby search latency;
* ranking overhead;
* OpenSearch query cost;
* indexing throughput;
* bulk indexing memory usage;
* rebuild behavior;
* cache efficiency.

Check search plans and index mappings.

Prevent:

* unbounded fuzzy queries;
* unbounded result windows;
* expensive wildcard patterns;
* unrestricted aggregations;
* arbitrary script execution;
* enormous source payloads.

Use search-engine-native pagination such as `search_after` or equivalent for large result sets where appropriate.

---

# SEARCH PAGINATION

Implement bounded cursor-based search pagination.

Define:

* cursor representation;
* sort fields;
* deterministic tie-breaking;
* cursor invalidation behavior after index version changes;
* maximum page size;
* invalid cursor errors.

Avoid relying on unstable score-only ordering for deep pagination.

---

# SEARCH SORTING

Define supported sorts.

At minimum evaluate:

* relevance;
* distance;
* relevance-plus-distance;
* popularity/quality where available.

Clients must not specify arbitrary internal fields.

Sorting behavior must be deterministic.

---

# SEARCH CONTRACTS

Implement/update the API contract for:

* full-text search;
* autocomplete;
* nearby search through the search layer where applicable.

Define:

* request;
* response;
* filters;
* geographic context;
* pagination;
* errors;
* rate-limit behavior;
* localization;
* result semantics.

Ensure OpenAPI or the repository's authoritative contract is consistent with the implementation.

---

# TESTING — UNIT

Create meaningful unit tests for:

* text normalization;
* query construction;
* ranking rules;
* exact-match priority;
* fuzzy matching constraints;
* geographic relevance;
* filter translation;
* pagination cursors;
* index document construction;
* version checks;
* stale-event rejection;
* cache-key construction;
* autocomplete behavior.

Do not only test that methods were called.

Test actual ranking and query semantics.

---

# TESTING — SEARCH ENGINE INTEGRATION

Use a real OpenSearch-compatible test environment where available.

Validate:

* mappings;
* analyzers;
* indexing;
* updates;
* deletes;
* aliases;
* versioned indexes;
* autocomplete;
* exact matches;
* prefix matches;
* typo tolerance;
* geographic relevance;
* category filtering;
* pagination;
* zero-result behavior.

Do not replace the search engine with mocks for tests that are intended to validate search semantics.

---

# TESTING — INDEXING

Validate:

* create event;
* update event;
* delete event;
* duplicate event;
* out-of-order event;
* merge event;
* bulk indexing;
* partial failure;
* retry;
* rebuild;
* alias cutover;
* rollback behavior where implemented.

Ensure stale source versions cannot overwrite newer search documents.

---

# TESTING — API

Test:

* valid searches;
* empty queries where allowed;
* excessively long queries;
* invalid filters;
* invalid geographic parameters;
* excessive radius;
* excessive result limits;
* pagination;
* invalid cursors;
* autocomplete;
* rate limiting;
* authorization boundaries;
* safe errors.

Verify responses against the canonical API contract.

---

# TESTING — RANKING

Create deterministic test cases covering:

* exact place name;
* exact alias;
* prefix match;
* fuzzy match;
* local versus distant match;
* category match;
* geographic bias;
* similarly named places;
* duplicate-like records;
* multilingual names where supported.

Ranking tests must protect important product invariants against accidental regressions.

Do not encode tests around arbitrary internal scoring values unless those values are intentionally part of the contract.

---

# TESTING — INDEX REBUILD

Validate that:

* current index remains available while a new index is populated;
* failed rebuilds do not destroy current search;
* the new index can be validated;
* alias switching is safe;
* document count checks occur;
* stale documents do not survive deletion propagation.

---

# TESTING — PERFORMANCE

Run practical tests for:

* autocomplete;
* standard search;
* nearby search;
* indexing throughput;
* bulk indexing memory;
* deep pagination.

Use representative data volumes.

Do not claim global-scale throughput based on tiny fixtures.

Document important bottlenecks and scaling assumptions.

---

# DATA FRESHNESS MONITORING

Implement monitoring or instrumentation for search freshness.

Track, where possible:

* source update time;
* event publication time;
* projection start;
* projection completion;
* indexing completion;
* active index version.

Define a measurable projection-lag metric.

Do not claim zero-latency propagation for asynchronous processing.

---

# INDEX RECOVERY

Document how search indexes are recovered from authoritative data.

Recovery must not depend on an unrecoverable OpenSearch snapshot alone.

The authoritative Place/Address data must be sufficient to rebuild search documents.

Provide operational commands or procedures for:

* index creation;
* full rebuild;
* validation;
* alias switch;
* rollback.

---

# DOCUMENTATION

Create or update documentation covering:

* search architecture;
* search-document schema;
* index naming/versioning;
* analyzers;
* ranking;
* autocomplete;
* geographic relevance;
* filtering;
* pagination;
* indexing pipeline;
* event dependencies;
* stale-event handling;
* deletes;
* merges;
* rebuilds;
* cache behavior;
* rate limits;
* observability;
* search-engine recovery;
* operational procedures.

Document actual implementation behavior.

Do not describe advanced ranking or data sources that are not implemented.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* authoritative place/geographic data;
* geocoding;
* map services;
* routing;
* navigation;
* traffic;
* contributions;
* reviews;
* media;
* moderation;
* notifications.

## Web

The web client must be able to consume:

* autocomplete;
* search;
* nearby discovery;
* bounded result pagination;
* stable place identifiers;
* stable location representation.

## Mobile

The mobile client must be able to consume the same search/autocomplete contracts.

Autocomplete and search must remain efficient for mobile networks.

## Infrastructure

Infrastructure must be able to provide:

* OpenSearch;
* Redis where used;
* workers;
* event/queue infrastructure;
* observability;
* scalable API capacity.

## QA

QA must be able to validate:

* search contracts;
* ranking;
* index lifecycle;
* indexing events;
* failure behavior;
* performance;
* security.

Do not create incompatible parallel search contracts.

---

# PORTABLE SEARCH CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* search document schema;
* search API;
* autocomplete API;
* nearby-discovery API;
* search errors;
* search pagination;
* ranking rules;
* index versioning;
* indexing event contract;
* rebuild procedures;
* search configuration.

Document which artifact is authoritative for each contract.

Do not maintain conflicting duplicate definitions.

---

# EXTERNAL SERVICE REALISM

OpenSearch is an infrastructure dependency.

If the execution environment does not provide a live OpenSearch instance:

* implement repository configuration;
* implement integration code;
* provide deterministic local/test configuration where practical;
* create tests appropriate to the available environment;
* report the external validation limitation accurately.

Do not substitute a fake in-memory search engine and claim production search behavior has been validated.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                     | Required Behavior                                                                               |
| --------------------------- | ----------------------------------------------------------------------------------------------- |
| OpenSearch unavailable      | Return controlled search-service failure or documented fallback; never fabricate search results |
| Redis unavailable           | Bypass cache where possible; preserve search correctness                                        |
| Index missing               | Do not silently use an unintended index; return controlled operational failure                  |
| Projection event duplicated | Apply idempotent processing                                                                     |
| Projection event stale      | Reject/ignore stale update safely                                                               |
| Index rebuild fails         | Preserve currently active search index                                                          |
| Alias switch fails          | Keep previous active index                                                                      |
| Search query malformed      | Reject with validation error                                                                    |
| Search query too expensive  | Reject with bounded query-limit behavior                                                        |
| Authoritative place deleted | Remove/invalidate corresponding search document                                                 |
| Source data unavailable     | Do not fabricate search documents                                                               |

---

# SECURITY REVIEW

Before completion, inspect for:

* raw OpenSearch query injection;
* arbitrary scripts;
* index-name injection;
* analyzer abuse;
* wildcard/fuzzy denial-of-service;
* excessive result extraction;
* unauthorized unpublished-data access;
* deleted-place leakage;
* cache poisoning;
* excessive request payloads;
* sensitive logging.

Ensure OpenSearch access is least-privileged and server-side only.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* verify index mappings;
* verify query builders;
* verify OpenAPI;
* verify ranking rules;
* verify cache keys;
* verify index lifecycle;
* verify migrations if any;
* verify workers;
* verify event/queue handling;
* verify tests;
* verify type checking;
* verify linting;
* verify formatting;
* verify documentation;
* remove debug code;
* remove unused dependencies;
* ensure no fake search engine behavior remains;
* ensure no unrelated future-domain implementation was introduced.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* search architecture changes;
* search-document model;
* index mappings;
* index versioning;
* OpenSearch integration;
* query implementation;
* ranking implementation;
* geographic relevance;
* autocomplete;
* address search;
* category filtering;
* pagination;
* search caching;
* rate limiting;
* indexing pipeline;
* indexing events;
* idempotent projection;
* stale-event handling;
* delete propagation;
* merge propagation;
* bulk indexing;
* index rebuild;
* alias cutover;
* observability;
* security changes;
* API contract changes;
* tests created;
* tests executed;
* performance validation;
* index validation;
* documentation changes;
* compatibility considerations;
* known limitations;
* unresolved external dependencies.

The report must accurately describe actual repository changes.

Do not claim that routing, navigation, traffic, map tiles, reviews, media, or the complete web/mobile experiences have been implemented.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* the authoritative Place/Address models were identified;
* search is implemented as a derived projection;
* search documents have a stable schema;
* index ownership is explicit;
* index naming/versioning is implemented;
* analyzers are configured appropriately;
* text normalization is implemented;
* localization behavior is defined;
* full-text search is implemented;
* exact matching is implemented;
* prefix matching is implemented;
* controlled typo tolerance is implemented;
* geographic relevance is implemented;
* category filtering is implemented;
* address-oriented search is implemented;
* autocomplete is implemented;
* autocomplete context/session behavior is implemented where applicable;
* search result contracts are implemented;
* pagination is cursor-based and bounded;
* sorting is controlled and deterministic;
* search query complexity is bounded;
* raw search-engine query injection is prevented;
* search indexing events are handled;
* projections are idempotent;
* stale events cannot overwrite newer data;
* deletes propagate;
* place merges propagate;
* bulk indexing exists;
* index rebuild exists;
* failed rebuilds preserve the active index;
* alias/index cutover is controlled;
* search freshness is measurable;
* Redis caching is bounded where used;
* rate limiting is implemented;
* abuse protection is implemented;
* observability is implemented;
* sensitive search/location data is protected;
* OpenSearch integration is real;
* unit tests exist;
* search integration tests exist;
* indexing tests exist;
* ranking tests exist;
* API tests exist;
* performance validation exists;
* operational documentation exists;
* recovery procedures are documented;
* portable search contracts exist;
* the final diff was inspected;
* there are no fake search implementations;
* there are no placeholder/TODO gaps standing in for required current-scope functionality;
* no credentials or external infrastructure were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement routing, navigation, traffic, map-tile generation, reviews, media, or the complete client applications during this search and discovery backend milestone.
