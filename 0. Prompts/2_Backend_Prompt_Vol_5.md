# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 5

# ROLE

You are the senior backend engineering agent responsible for implementing the **production routing, route planning, traffic-aware routing, route alternatives, ETA computation, and routing-engine integration layer** for a **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Routing Architect
* Geospatial Engineer
* Graph/Pathfinding Engineer
* Distributed Systems Engineer
* Backend API Engineer
* Data Engineer
* Traffic Systems Engineer
* Performance Engineer
* Security Engineer
* Reliability Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement the real routing platform that converts validated route requests into stable, production-grade route responses while isolating public APIs from the internal routing engine.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive maps;
* geographic features;
* places;
* search;
* geocoding;
* route planning;
* route alternatives;
* multi-modal directions;
* ETA calculation;
* traffic-aware routing;
* turn-by-turn navigation;
* real-time location;
* trips;
* saved places;
* contributions;
* reviews;
* media;
* notifications;
* moderation;
* administration;
* analytics;
* observability.

This milestone implements the routing backend and its integration with routing data, traffic inputs, and clients.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* routing-domain backend structure;
* route request validation;
* route calculation API;
* routing-engine adapter abstraction;
* routing-engine integration;
* travel modes;
* route alternatives;
* waypoints;
* route constraints;
* vehicle constraints where applicable;
* route geometry;
* route legs;
* route steps;
* maneuver metadata;
* distance calculations;
* duration calculations;
* ETA calculation;
* traffic-aware route inputs;
* traffic-aware ETA;
* route warnings;
* route restrictions;
* toll metadata where available;
* route-request idempotency;
* route result caching where justified;
* route calculation deduplication where justified;
* routing timeouts;
* routing retries;
* circuit-breaking/degraded behavior;
* route result normalization;
* routing-engine versioning;
* road-network graph versioning;
* route-data freshness metadata;
* routing observability;
* routing security;
* rate limiting;
* routing performance controls;
* asynchronous/precomputation hooks where appropriate;
* API contracts;
* machine-readable route schemas;
* unit tests;
* integration tests;
* routing-engine contract tests;
* geospatial correctness tests;
* performance tests;
* failure tests;
* documentation.

This milestone implements route calculation and its backend contract.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* full turn-by-turn navigation session management;
* navigation WebSocket protocol implementation;
* continuous location telemetry;
* mobile background location;
* client-side navigation UI;
* complete web directions UI;
* complete mobile navigation UI;
* traffic telemetry ingestion pipeline;
* user-generated traffic data collection;
* reviews;
* ratings;
* contributions;
* media processing;
* notifications;
* moderation;
* full search implementation;
* autocomplete implementation;
* map-tile generation;
* production CDN deployment;
* production Kubernetes provisioning;
* complete transit journey planning if the chosen routing engine/data source is not available;
* fabrication of live traffic data;
* fabrication of external routing-provider access.

This milestone may consume already available traffic/geographic contracts and establish interfaces for later traffic and navigation milestones.

Do not build fake navigation sessions merely to demonstrate route calculation.

---

# REPOSITORY INSPECTION

Inspect the repository first.

Determine:

* current backend architecture;
* geographic-domain implementation;
* PostGIS models;
* dataset-version model;
* road/road-segment model;
* routing contracts;
* existing routing engine;
* routing libraries;
* container definitions for routing engines;
* event/queue infrastructure;
* Redis;
* OpenAPI;
* configuration;
* observability;
* rate limiting;
* existing route implementations;
* tests;
* architecture documents;
* map-data publication artifacts.

Treat the actual repository state as authoritative.

Do not assume a routing engine exists merely because the architecture supports one.

Do not assume external routing data exists.

Preserve compatible implementations.

Do not duplicate the canonical route contract.

---

# ROUTING TECHNOLOGY CONTEXT

Use the project's established backend stack:

* TypeScript/NestJS-compatible application services;
* PostgreSQL/PostGIS for authoritative geographic data;
* a specialized routing engine such as Valhalla, OSRM, GraphHopper, or another compatible engine selected by repository architecture;
* Redis where justified;
* event/queue infrastructure where available;
* OpenTelemetry-compatible observability.

The public routing contract must remain independent from the internal routing-engine implementation.

Changing from one compatible routing engine to another should not require redesigning web/mobile contracts.

---

# ROUTING ARCHITECTURE

Implement the backend flow conceptually equivalent to:

```text
Client
  ↓
Route Request API
  ↓
Validation + Authorization
  ↓
Routing Policy / Request Normalization
  ↓
Routing Engine Adapter
  ↓
Routing Engine
  ↓
Route Normalization
  ↓
Traffic / ETA Enrichment
  ↓
Stable Route Response
```

Separate:

* public API;
* routing policy;
* engine adapter;
* engine-specific request;
* engine-specific response;
* normalization;
* traffic enrichment.

Do not allow engine-specific objects to leak through every application layer.

---

# ROUTING REQUEST MODEL

Implement the canonical RouteRequest representation.

Support, where applicable:

* request ID;
* origin;
* destination;
* waypoints;
* travel mode;
* departure time;
* arrival time;
* avoidances;
* vehicle properties;
* route alternatives;
* language;
* units;
* traffic preference;
* accessibility options where supported;
* route preferences.

Validate all inputs.

---

# TRAVEL MODES

Implement the travel-mode contract.

At minimum support, where the routing engine and geographic data make them feasible:

* driving;
* walking;
* cycling.

Provide architecture-compatible extension points for:

* motorcycle;
* truck;
* transit.

Do not expose a travel mode as operationally supported merely because an enum exists.

Unsupported modes must return an explicit unsupported-mode response.

---

# ORIGIN AND DESTINATION VALIDATION

Validate:

* latitude;
* longitude;
* precision;
* required values.

Where place IDs are supported:

* resolve them through the authoritative place/geographic system;
* verify that the resolved geometry is usable for routing;
* avoid trusting client-supplied internal database identifiers.

Do not perform unbounded place lookups.

---

# WAYPOINTS

Support bounded waypoints.

Define:

* maximum number;
* ordering;
* stop versus pass-through behavior where supported;
* per-waypoint validation;
* waypoint resolution;
* duplicate behavior.

Reject requests that exceed limits.

Do not allow arbitrary waypoint counts that can create denial-of-service conditions.

---

# ROUTE AVOIDANCES

Where supported, implement explicit route-avoidance options such as:

* tolls;
* ferries;
* highways;
* unpaved roads;
* restricted roads.

Avoidance behavior must be passed to the routing engine through typed adapter methods.

Do not emulate unavailable restrictions using undocumented heuristics.

---

# VEHICLE CONSTRAINTS

For supported driving profiles, define vehicle constraints where the selected engine can use them.

Potential fields include:

* vehicle type;
* weight;
* height;
* width;
* length;
* hazardous-material restrictions where legally/operationally appropriate.

Do not expose truck routing options unless the underlying routing graph contains the necessary restriction data.

---

# ROUTE ALTERNATIVES

Implement support for multiple route alternatives where the routing engine can reliably provide them.

Define:

* maximum number of alternatives;
* ranking;
* deterministic ordering;
* duplicate-route suppression;
* route equivalence criteria.

Do not return multiple nearly identical routes simply to satisfy an alternatives parameter.

---

# ROUTE REPRESENTATION

Normalize engine output into the canonical project route model.

A Route must support:

* route ID;
* request ID;
* travel mode;
* geometry;
* distance;
* duration;
* ETA;
* traffic-aware ETA;
* legs;
* steps;
* warnings;
* restrictions;
* toll information;
* routing-engine/data version metadata where appropriate;
* generated-at;
* freshness metadata.

Do not expose raw engine-specific JSON to clients.

---

# ROUTE LEG

Each route leg should contain:

* leg ID;
* origin;
* destination;
* distance;
* duration;
* ETA;
* geometry where required;
* steps;
* waypoint association.

Leg ordering must be deterministic.

---

# ROUTE STEP

Implement normalized steps containing, where supported:

* step ID;
* geometry;
* maneuver type;
* maneuver modifier;
* instruction;
* distance;
* duration;
* road name;
* road reference;
* lane guidance;
* exit number;
* roundabout information;
* warning metadata.

The backend contract must remain renderer-independent.

Do not encode arbitrary UI-specific text structures.

---

# MANEUVER MODEL

Define stable maneuver types such as:

* depart;
* arrive;
* continue;
* turn;
* merge;
* fork;
* roundabout;
* ramp;
* u-turn;
* ferry;
* destination-side arrival.

Each maneuver must have clear semantics.

Avoid free-form strings as the only representation of navigation-relevant maneuver state.

---

# ROUTE GEOMETRY

Return stable route geometry suitable for:

* map visualization;
* distance measurement;
* navigation clients.

Define:

* encoding;
* precision;
* coordinate order;
* simplification policy;
* maximum payload size.

Do not reuse map-tile-generalized geometry when routing precision is required.

Routing geometry must remain independent from display-only tile geometry.

---

# DISTANCE MODEL

Define a project-wide distance representation.

Support:

* meters internally;
* integer or precise numeric representation according to contract;
* localized display units at clients or API boundary as appropriate.

Do not mix miles and kilometers internally.

Avoid floating-point accumulation errors where exact values are possible.

---

# DURATION MODEL

Define duration semantics.

Represent:

* nominal duration;
* traffic-adjusted duration;
* duration timestamp basis.

Do not confuse:

* engine travel time;
* traffic delay;
* ETA clock time.

These must remain distinguishable.

---

# ETA CALCULATION

Implement ETA using:

* route duration;
* request departure/current time;
* traffic adjustments;
* explicit timestamp conventions.

A route response must indicate the freshness of any traffic-aware ETA.

Do not return a traffic-aware ETA when traffic information is stale or unavailable without indicating the degraded state.

---

# TRAFFIC ENRICHMENT BOUNDARY

Routing must consume normalized traffic state through an explicit interface.

Traffic input should be capable of representing:

* road/segment;
* effective interval;
* congestion;
* speed;
* free-flow speed;
* confidence;
* freshness;
* source.

Do not hardcode traffic behavior into the routing API itself.

The routing engine adapter should accept traffic inputs only through defined interfaces.

---

# STATIC VS TRAFFIC-AWARE ROUTING

Clearly distinguish:

* base/static route;
* traffic-aware route;
* traffic-adjusted ETA.

If live traffic is unavailable:

* produce a static route where supported;
* identify traffic data as unavailable/stale;
* avoid fabricating traffic conditions.

Do not represent a static ETA as live traffic-aware ETA.

---

# TRAFFIC FRESHNESS

Define acceptable traffic freshness thresholds.

Traffic input must carry:

* observed-at;
* effective-at;
* expires-at or freshness policy;
* source.

If traffic data exceeds its freshness threshold:

* discard it;
* degrade to static routing;
* or apply the architecture-defined fallback.

Do not use stale traffic indefinitely.

---

# ROUTING ENGINE ADAPTER

Implement an adapter abstraction that isolates engine-specific behavior.

The adapter must define operations such as:

* calculate route;
* calculate alternatives;
* supported travel modes;
* engine health;
* graph/data version;
* capabilities.

The adapter must translate:

* canonical request → engine request;
* engine response → canonical route;
* engine error → project error.

Do not permit engine-specific types to escape the adapter boundary.

---

# ROUTING ENGINE HEALTH

Implement engine health checks.

Health checks should verify:

* process availability;
* routing endpoint availability;
* supported data version where practical;
* readiness for traffic.

Do not expose internal engine credentials or topology.

If the engine is unavailable:

* fail route requests safely;
* do not fabricate routes.

---

# ROUTING TIMEOUTS

Implement strict bounded routing timeouts.

Timeouts must account for:

* API request;
* engine request;
* traffic enrichment;
* serialization.

Do not allow a slow route calculation to hold HTTP resources indefinitely.

---

# RETRIES

Do not blindly retry every route request.

Retry only when:

* the operation is safe to retry;
* the error is transient;
* retry count is bounded;
* backoff/jitter is appropriate.

Avoid retrying expensive requests aggressively during engine overload.

---

# CIRCUIT BREAKING

Implement circuit-breaking or equivalent overload protection for routing-engine dependency failures where appropriate.

The circuit must:

* open after defined failure conditions;
* prevent cascading overload;
* transition to half-open safely;
* recover when the engine becomes healthy.

Do not hide persistent engine failures behind endless retries.

---

# ROUTING REQUEST DEDUPLICATION

Where justified, deduplicate simultaneous identical route calculations.

The deduplication key should incorporate all materially route-affecting inputs.

Do not deduplicate two requests that differ in:

* origin;
* destination;
* waypoint;
* travel mode;
* departure time;
* traffic policy;
* vehicle constraints;
* avoidances.

---

# ROUTE RESULT CACHING

Cache only route results that remain semantically safe to cache.

For static route calculations, a short-lived cache may be useful.

For traffic-aware routes, cache TTL must be constrained by traffic freshness.

Cache keys must include all material inputs.

Do not cache private user data in globally shared caches.

Do not cache dynamic routes indefinitely.

---

# ROUTE IDEMPOTENCY

Use request-level idempotency where the API semantics require repeat-safe behavior.

A route lookup that is inherently read-like may not need a persisted idempotency record, but route-session creation semantics in future navigation flows must remain distinct.

Do not create database state merely to force idempotency into a pure calculation endpoint.

---

# RATE LIMITING

Implement routing-specific rate limits.

Differentiate:

* route calculations;
* alternatives-heavy calculations;
* expensive vehicle profiles;
* internal bulk/precomputation.

Rate limits must consider:

* user;
* IP;
* client/application;
* request cost.

Do not permit anonymous clients to execute unlimited expensive route calculations.

---

# ABUSE PROTECTION

Protect routing from:

* request floods;
* enormous waypoint lists;
* repeated expensive alternatives requests;
* impossible coordinates;
* oversized payloads;
* malicious query patterns;
* engine-directed denial of service.

Use bounded:

* waypoint count;
* request size;
* route alternatives;
* routing timeout;
* query frequency.

Do not expose raw engine query syntax.

---

# AUTHORIZATION

Routing may be publicly accessible according to the product contract.

Any authenticated-only features must use server-side authorization.

Do not permit clients to impersonate another user when invoking:

* saved-route behavior;
* private trip references;
* future navigation sessions.

Do not implement private navigation session resources in this milestone.

---

# SECURITY

Protect routing APIs against:

* injection;
* malformed geospatial input;
* resource exhaustion;
* unauthorized access;
* provider abuse;
* internal topology leakage;
* sensitive logging.

Never expose:

* routing-engine connection strings;
* internal hostnames;
* provider API keys;
* raw internal error messages.

Use least-privileged service credentials.

---

# PRIVACY

Route requests can reveal sensitive location information.

Do not persist route-history records in this milestone.

Do not log complete origin/destination coordinates by default.

Where operational logs need geographic context:

* reduce precision;
* use safe aggregation;
* apply environment-specific redaction.

Do not associate exact route requests with user identity in telemetry unless operationally justified.

---

# ROUTING DATA VERSIONING

Every route result should be associated internally with:

* routing graph/data version;
* geographic dataset version where relevant;
* routing-engine version;
* traffic data version where applicable.

Do not mix incompatible graph versions during a single calculation.

Expose only the metadata appropriate for the public contract.

---

# GRAPH/DATA COMPATIBILITY

Before accepting a routing request, verify the routing graph is compatible with:

* requested travel mode;
* current dataset version;
* required restriction data;
* geographic publication state.

Do not calculate routes against an unpublished or invalid routing graph.

---

# ROUTING GRAPH PUBLICATION

Implement repository-side compatibility with versioned routing graphs.

Support states such as:

* building;
* validating;
* ready;
* active;
* superseded;
* rolled back.

The active routing graph must be explicit.

A failed graph build must not replace the active graph.

---

# MULTI-REGION ROUTING

Where global scale requires geographically partitioned routing:

* identify region;
* select appropriate routing graph;
* route within the correct coverage area;
* support cross-region requests through a defined strategy where implemented.

Do not create a global in-memory road graph.

Do not load the full worldwide graph into every application process.

---

# CROSS-BORDER ROUTING

Where routes cross administrative or geographic boundaries:

* preserve one stable route contract;
* maintain appropriate regional graph selection;
* preserve timezone/locale semantics;
* represent country/region transitions where useful.

Do not assume route calculations occur entirely within one country.

---

# ROUTING WARNINGS

Implement structured warnings for conditions such as:

* toll roads;
* ferries;
* restricted roads;
* unpaved roads;
* traffic degradation;
* unavailable live traffic;
* route data limitations.

Warnings must be machine-readable.

Do not rely solely on free-form warning text.

---

# ACCESSIBILITY AND TRAVEL CONSTRAINTS

Where supported by the routing engine, provide contract extension points for:

* wheelchair accessibility;
* pedestrian restrictions;
* bicycle restrictions;
* vehicle restrictions.

Do not expose unsupported accessibility guarantees.

---

# TRANSIT BOUNDARY

The architecture must permit public transit routing through an explicit adapter.

The current implementation may leave full transit routing outside scope when authoritative transit data and engine support are unavailable.

Do not fabricate transit schedules.

If transit capabilities are implemented within the repository, use real schedule/data sources and document their freshness.

---

# API IMPLEMENTATION

Implement the route-calculation API according to the project's canonical API contract.

Support:

* origin;
* destination;
* waypoints;
* travel mode;
* options;
* traffic preference;
* alternatives;
* language;
* units.

Return:

* request ID;
* route(s);
* legs;
* steps;
* geometry;
* distance;
* duration;
* ETA;
* traffic metadata;
* warnings.

Do not expose raw routing-engine responses.

---

# API VALIDATION

Reject:

* invalid coordinates;
* impossible latitude/longitude;
* excessive waypoints;
* invalid travel mode;
* invalid avoidances;
* unsupported vehicle constraints;
* invalid departure/arrival combinations;
* excessive alternatives;
* oversized requests.

Use stable validation errors.

---

# REQUEST COST CONTROL

Classify routing requests by computational cost.

Potential cost factors include:

* waypoint count;
* alternatives;
* route mode;
* vehicle profile;
* time-dependent traffic;
* cross-region routing.

Use these classifications to:

* rate-limit;
* timeout;
* prioritize;
* monitor.

Do not use one undifferentiated cost model if it allows expensive requests to overwhelm cheaper workloads.

---

# ROUTING OBSERVABILITY

Instrument:

* route-request volume;
* route latency;
* engine latency;
* timeout rate;
* engine errors;
* route failures;
* alternatives requested;
* cache hits;
* cache misses;
* deduplication;
* traffic freshness;
* traffic fallback;
* graph version;
* engine version;
* route distance;
* route duration.

Track:

* p50;
* p95;
* p99;
* error rate;
* timeout rate;
* engine saturation.

Do not log complete private origin/destination data by default.

---

# ROUTING QUALITY TELEMETRY

Where safe, measure:

* route calculation success;
* empty-route rate;
* invalid-route rate;
* fallback rate;
* traffic-data fallback;
* reroute-support readiness.

Do not create user-identifying route analytics merely for convenience.

---

# PERFORMANCE

Optimize for route-calculation latency while maintaining correctness.

Evaluate:

* engine call latency;
* serialization;
* PostGIS lookups;
* traffic enrichment;
* route normalization;
* caching;
* duplicate suppression.

Avoid unnecessary database calls during route calculation.

The routing engine should own graph traversal rather than the API layer.

---

# ENGINE RESPONSE VALIDATION

Treat routing-engine output as untrusted dependency output.

Validate:

* route geometry;
* coordinates;
* distance;
* duration;
* step ordering;
* leg ordering;
* maneuver values;
* size limits.

Reject malformed engine output.

Do not blindly pass engine output to clients.

---

# ROUTE CONSISTENCY

Verify:

* route distance is nonnegative;
* duration is nonnegative;
* steps form a coherent sequence;
* leg boundaries align;
* geometry is valid;
* alternative routes are distinguishable;
* ETA is consistent with duration and request time.

Do not attempt to silently repair materially corrupt routing-engine output.

Return controlled dependency/data errors.

---

# ERROR MODEL

Map engine-specific failures to canonical errors such as:

* invalid route request;
* unsupported travel mode;
* no route found;
* routing engine unavailable;
* routing engine timeout;
* route-data unavailable;
* traffic unavailable;
* routing graph unavailable;
* route calculation overloaded.

Do not expose provider-specific failure codes as the only API contract.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                    | Required Behavior                                                           |
| -------------------------- | --------------------------------------------------------------------------- |
| Routing engine unavailable | Return controlled service-unavailable error; never fabricate a route        |
| Routing engine timeout     | Return bounded timeout error; record telemetry                              |
| Routing graph unavailable  | Return route-data-unavailable error                                         |
| Traffic unavailable        | Use static routing only when supported and clearly mark traffic degradation |
| Traffic stale              | Ignore/degrade according to freshness policy                                |
| Malformed engine response  | Reject result and report dependency/data error                              |
| Redis unavailable          | Bypass route cache where safe                                               |
| Database unavailable       | Fail only operations requiring database access; do not fabricate routes     |
| Excessive request cost     | Reject or rate-limit before expensive engine work                           |
| Duplicate requests         | Apply safe deduplication only where request semantics match                 |

---

# TESTING — UNIT

Create meaningful unit tests covering:

* coordinate validation;
* waypoint validation;
* route-option normalization;
* travel-mode support;
* vehicle constraints;
* request-cost classification;
* engine request translation;
* engine response normalization;
* maneuver normalization;
* distance/duration validation;
* ETA calculation;
* traffic freshness;
* cache-key construction;
* routing error mapping;
* stale graph rejection.

---

# TESTING — ROUTING ENGINE CONTRACT

Test the adapter against a real routing-engine test environment where available.

Validate:

* driving route;
* walking route;
* cycling route;
* waypoints;
* alternatives;
* avoidances;
* invalid request;
* no-route case;
* engine timeout;
* engine-unavailable behavior;
* malformed response handling.

Do not rely entirely on mocked engine responses for adapter correctness.

Where an external routing engine cannot be run in the available environment, implement deterministic adapter contract tests and accurately report the environmental limitation.

---

# TESTING — GEOSPATIAL CORRECTNESS

Validate:

* route start/end proximity;
* geometry coordinate order;
* leg ordering;
* waypoint ordering;
* route distance;
* route duration;
* route geometry size;
* cross-boundary routes where fixtures permit.

Do not use fake route geometries as proof of routing correctness.

---

# TESTING — TRAFFIC

Test:

* fresh traffic;
* stale traffic;
* missing traffic;
* traffic fallback;
* traffic-adjusted ETA;
* static route fallback.

Verify that stale traffic is not reported as live traffic.

---

# TESTING — FAILURE AND RESILIENCE

Test:

* engine timeout;
* engine connection failure;
* repeated engine failures;
* circuit opening;
* recovery;
* Redis failure;
* cache corruption;
* malformed engine output;
* invalid graph version;
* rate limiting.

Do not allow failure tests to make the system report successful route calculations when no route was actually produced.

---

# TESTING — PERFORMANCE

Use representative route requests to measure:

* API overhead;
* routing-engine latency;
* alternatives cost;
* waypoint cost;
* traffic enrichment cost;
* cache performance;
* concurrency behavior.

Do not claim global routing capacity from small local fixtures.

Document meaningful bottlenecks and scaling assumptions.

---

# ROUTING CONTRACT ARTIFACTS

Create or update portable artifacts for:

* route request schema;
* route response schema;
* route leg schema;
* route step schema;
* maneuver enum;
* travel-mode enum;
* route warnings;
* routing errors;
* traffic input contract;
* routing-engine adapter contract;
* graph-version contract;
* route cache contract.

Document authoritative locations.

Do not create conflicting route definitions.

---

# DOCUMENTATION

Create or update documentation covering:

* routing architecture;
* supported travel modes;
* request limits;
* routing-engine adapter;
* routing graph versions;
* route response semantics;
* geometry encoding;
* ETA behavior;
* traffic freshness;
* fallback behavior;
* caching;
* rate limits;
* security;
* observability;
* failure handling;
* local routing-engine setup;
* performance considerations.

Document actual implementation behavior.

Do not claim transit, traffic, or vehicle-routing support unless the required data and implementation actually exist.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* geographic/place services;
* search/geocoding;
* navigation;
* traffic;
* event/queue infrastructure;
* saved trips or places where later implemented.

## Web

The web client must be able to consume:

* route alternatives;
* route geometry;
* legs;
* steps;
* ETA;
* warnings;
* traffic metadata.

## Mobile

The mobile client must consume the same route contract and use route geometry suitable for navigation.

## Infrastructure

Infrastructure must support:

* routing-engine workloads;
* scalable API capacity;
* graph/data deployment;
* observability;
* health checks;
* resource limits.

## QA

QA must be able to validate:

* route contracts;
* routing quality;
* traffic fallback;
* engine failure;
* performance;
* security.

Do not create separate incompatible route contracts for web and mobile.

---

# API CONTRACT VALIDATION

Ensure the implemented endpoint matches the authoritative contract.

Validate:

* request schema;
* response schema;
* errors;
* enum values;
* coordinate format;
* geometry format;
* units;
* warnings;
* metadata.

The implementation and contract must not drift.

---

# SECURITY REVIEW

Before completion, inspect for:

* route-query injection;
* resource-exhaustion paths;
* unbounded waypoint processing;
* excessive alternative generation;
* unauthorized private-route access;
* sensitive location logging;
* raw engine error leakage;
* provider credential exposure;
* cache poisoning.

Use typed request builders.

Do not accept raw routing-engine request syntax from clients.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* inspect routing adapters;
* inspect API contracts;
* inspect route normalization;
* inspect traffic integration;
* inspect cache behavior;
* inspect rate limits;
* inspect graph-version handling;
* inspect tests;
* run type checking;
* run linting;
* run formatting;
* inspect performance output;
* inspect documentation;
* remove debug code;
* remove unused dependencies;
* verify no navigation-session or telemetry implementation was accidentally added;
* verify no fake routes exist.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* routing-domain changes;
* route API changes;
* routing-engine adapter;
* routing-engine configuration;
* supported travel modes;
* route alternatives;
* waypoints;
* route constraints;
* vehicle constraints;
* route normalization;
* route geometry;
* route legs;
* route steps;
* maneuver model;
* distance/duration model;
* ETA calculation;
* traffic integration;
* traffic freshness handling;
* routing graph/version support;
* caching;
* request deduplication;
* rate limiting;
* reliability controls;
* circuit breaking;
* observability;
* security changes;
* API contract changes;
* tests created;
* tests executed;
* geospatial validation;
* routing-engine validation;
* performance validation;
* documentation changes;
* compatibility considerations;
* known limitations;
* unresolved external routing/traffic dependencies.

The report must accurately describe actual repository changes.

Do not claim that live traffic telemetry, navigation sessions, mobile navigation, or complete routing coverage exists unless those capabilities were actually implemented and validated.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* the routing domain is clearly separated from other domains;
* route requests are validated;
* travel modes are defined and enforced;
* origin/destination validation exists;
* waypoint limits are enforced;
* route avoidances are implemented where supported;
* vehicle constraints are validated where supported;
* route alternatives are implemented where supported;
* route responses use the canonical project model;
* route legs are normalized;
* route steps are normalized;
* maneuver types are stable and machine-readable;
* route geometry follows project coordinate conventions;
* distance semantics are consistent;
* duration semantics are consistent;
* ETA calculation is implemented;
* traffic-aware ETA is distinguishable from static ETA;
* traffic freshness is enforced;
* traffic fallback is implemented;
* routing-engine integration is isolated behind an adapter;
* engine-specific types do not leak through public APIs;
* engine health is monitored;
* routing timeouts are enforced;
* retries are bounded and safe;
* circuit breaking or equivalent overload protection is implemented where appropriate;
* safe request deduplication exists where justified;
* route caching is bounded and correctly keyed where used;
* routing-specific rate limits are implemented;
* routing abuse protections are implemented;
* routing graph versions are explicit;
* incompatible graph data is rejected;
* multi-region routing boundaries are defined where applicable;
* route warnings are structured;
* accessibility/travel-constraint extensions are handled accurately;
* unsupported transit or vehicle modes are not falsely advertised;
* routing observability is implemented;
* private location data is not unnecessarily logged;
* routing API contracts are implemented;
* unit tests exist;
* routing-engine contract tests exist;
* geospatial correctness tests exist;
* traffic tests exist;
* resilience/failure tests exist;
* performance validation exists;
* portable routing contracts exist;
* documentation is current;
* the final diff was inspected;
* there are no fake route calculations;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no credentials or external routing access were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement navigation sessions, continuous location tracking, mobile navigation, reviews, media, or the complete traffic-ingestion platform during this routing backend milestone.
