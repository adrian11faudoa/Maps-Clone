# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 9

# ROLE

You are the senior backend engineering agent responsible for implementing the **production public-transit, multimodal journey-planning, transit-data ingestion, transit schedule, real-time transit-status, and transit-routing integration capabilities** for a **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Public Transit Systems Engineer
* Multimodal Routing Engineer
* GIS/Data Engineer
* GTFS/GTFS-Realtime Engineer
* Geospatial Backend Engineer
* Transit Data Platform Engineer
* API Engineer
* Distributed Systems Engineer
* Database Engineer
* Search/Discovery Integration Engineer
* Security Engineer
* Reliability Engineer
* Performance Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement a real, production-grade transit and multimodal journey-planning backend that can consume authoritative transit datasets, normalize them into a canonical internal representation, integrate with routing, and expose stable transit-aware directions contracts to web and mobile clients.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive maps;
* geographic data;
* places;
* search;
* autocomplete;
* geocoding;
* driving directions;
* walking directions;
* cycling directions;
* public-transit directions;
* multimodal journey planning;
* turn-by-turn navigation;
* traffic-aware routing;
* real-time transit information where data is available;
* saved places;
* user contributions;
* reviews and ratings;
* media;
* notifications;
* moderation;
* administration;
* analytics;
* operational observability.

This milestone implements the public-transit and multimodal backend required to make transit a genuine routing capability rather than an enum without operational support.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* canonical transit domain;
* transit-agency model;
* transit-feed model;
* transit-feed versioning;
* transit stops;
* stations;
* station entrances/exits where data supports them;
* transit routes;
* route variants;
* trips;
* stop times;
* service calendars;
* exceptions;
* transfers;
* accessibility metadata;
* route shapes;
* fare metadata where available;
* transit service alerts;
* realtime vehicle positions where available;
* realtime trip updates where available;
* realtime service alerts;
* GTFS static ingestion;
* GTFS-Realtime ingestion;
* feed normalization;
* feed validation;
* feed versioning;
* idempotent ingestion;
* data freshness;
* transit-data provenance;
* transit graph/index foundation;
* transit journey-planning integration;
* multimodal route-request support;
* transit route normalization;
* transit legs;
* transfer legs;
* walking connections;
* access/egress legs;
* departure/arrival schedules;
* real-time delay propagation;
* service-alert effects;
* transit ETA;
* transit fallback behavior;
* multimodal route ranking;
* transit result pagination where applicable;
* route-data caching where justified;
* transit-specific rate limiting;
* realtime transit observability;
* data-quality validation;
* failure and recovery handling;
* API contracts;
* event contracts;
* queue contracts;
* automated tests;
* integration tests;
* schedule tests;
* realtime transit tests;
* routing integration tests;
* performance tests;
* resilience tests;
* documentation.

This milestone makes transit a first-class backend capability while preserving the existing routing contract.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* complete web transit UI;
* complete mobile transit UI;
* native mobile background services;
* full map-tile generation;
* map rendering;
* search ranking redesign;
* reviews;
* ratings;
* place contributions;
* media;
* notification-provider implementation;
* moderation UI;
* production Kubernetes provisioning;
* production cloud provisioning;
* fabrication of transit data;
* fabrication of live vehicle positions;
* proprietary transit feeds;
* proprietary Google Transit implementation details.

This prompt may implement backend notification-event hooks for transit alerts, but it must not fabricate push/email delivery.

---

# REPOSITORY INSPECTION

Inspect the repository before making changes.

Determine:

* current backend architecture;
* place/geographic models;
* routing implementation;
* route contracts;
* travel-mode enums;
* route-engine adapter;
* PostGIS;
* PostgreSQL schema;
* event infrastructure;
* queues;
* Redis;
* OpenSearch;
* map-data versioning;
* existing transit models;
* existing transit-feed integrations;
* existing routing graph infrastructure;
* API contracts;
* configuration;
* observability;
* rate limiting;
* existing tests;
* architecture artifacts.

Treat the repository as the source of truth for actual implementation state.

Do not assume any previous AI conversation was executed.

Preserve compatible existing route and geographic contracts.

Do not create a second route representation when the canonical route model can be extended safely.

---

# BACKEND TECHNOLOGY CONTEXT

Use the project's established backend technology direction:

* TypeScript;
* NestJS or the repository's compatible modular backend framework;
* PostgreSQL/PostGIS;
* Redis where justified;
* event/queue infrastructure;
* OpenTelemetry-compatible observability.

Use established transit libraries or parsers for:

* GTFS;
* GTFS-Realtime;
* transit schedule processing;

rather than implementing feed protocols manually.

Use specialized algorithms only where required.

---

# TRANSIT DATA OWNERSHIP

Establish clear ownership:

* **Transit domain** owns canonical transit schedules, agencies, routes, trips, stops, calendars, and normalized realtime state.
* **External transit providers** own source feeds.
* **Routing domain** owns public route calculation.
* **Transit journey-planning layer** translates transit data into route-compatible journey alternatives.
* **Search/place domain** remains authoritative for generic geographic place data.
* **Map-tile domain** may consume transit entities for visualization.
* **Notification domain** may consume transit-alert events.

Do not store transit schedule truth only inside a route result.

---

# TRANSIT AGENCY MODEL

Implement an Agency entity supporting, as applicable:

* agency ID;
* source/provider ID;
* name;
* URL;
* timezone;
* language;
* phone;
* fare-related metadata where available;
* active status;
* feed version;
* created-at;
* updated-at.

Preserve source provenance.

Do not assume one agency uses one feed forever.

---

# TRANSIT FEED MODEL

Implement a feed representation supporting:

* feed ID;
* agency;
* source;
* feed type;
* feed URL/reference;
* version;
* effective-at;
* imported-at;
* checksum;
* schema version;
* status;
* coverage;
* timezone;
* validation result.

Do not store provider credentials inside feed records.

---

# FEED VERSIONING

Support explicit feed versions.

States should include, where appropriate:

* discovered;
* downloading;
* validating;
* validated;
* ingesting;
* active;
* superseded;
* failed;
* rolled back.

An invalid feed version must not replace the currently active valid version.

---

# GTFS STATIC INGESTION

Implement real GTFS ingestion for supported feeds.

Support standard files where relevant, including:

* agency;
* stops;
* routes;
* trips;
* stop_times;
* calendar;
* calendar_dates;
* shapes;
* transfers;
* frequencies;
* pathways where available;
* fare-related files appropriate to the supported GTFS version.

Do not assume every feed contains every optional file.

Missing optional files must be handled explicitly.

---

# GTFS VALIDATION

Validate feeds before publication.

Check:

* required files;
* required columns;
* data types;
* foreign keys;
* duplicate IDs;
* invalid stop references;
* invalid route references;
* invalid trip references;
* invalid stop sequences;
* impossible times;
* invalid service calendars;
* malformed geometries;
* inconsistent timezones.

Do not publish a feed with critical referential-integrity errors.

---

# TRANSIT DATA NORMALIZATION

Normalize source feed structures into canonical project models.

Preserve:

* source agency;
* source feed version;
* source IDs;
* source timestamps;
* provenance.

Do not expose source-specific schemas directly through the public API.

---

# TRANSIT STOPS

Implement canonical stops.

A stop must support:

* stop ID;
* name;
* location;
* parent station where applicable;
* platform identifier where available;
* timezone;
* wheelchair accessibility where provided;
* location type;
* source reference;
* feed version;
* active status.

Use PostGIS geometry.

---

# STATIONS

Represent stations separately when the source distinguishes them.

Support:

* station ID;
* name;
* coordinates;
* parent network/agency;
* entrances/exits where available;
* accessible facilities;
* platform references;
* transfer relationships.

Do not collapse all stops into a flat list when hierarchy is available.

---

# TRANSIT ROUTES

Implement canonical transit routes.

Support:

* route ID;
* short name;
* long name;
* route type;
* agency;
* color/branding metadata where legally appropriate;
* route URL where provided;
* source identifier;
* feed version.

Do not expose provider-private data unnecessarily.

---

# ROUTE VARIANTS

Where transit feeds distinguish variants or patterns:

* represent route patterns;
* associate trips;
* preserve stop sequences;
* preserve shape references.

Do not create duplicate routes merely because two trips differ in schedule.

---

# TRANSIT TRIPS

Implement trip representations including:

* trip ID;
* route;
* service;
* direction;
* headsign;
* shape;
* accessibility attributes;
* source reference;
* feed version.

Trips must be associated with valid service calendars.

---

# STOP TIMES

Implement stop-time persistence.

Support:

* trip;
* stop;
* stop sequence;
* arrival time;
* departure time;
* pickup policy;
* drop-off policy;
* timepoint indicator.

Handle trips crossing midnight correctly.

Do not represent post-midnight times as invalid simply because they exceed `24:00:00` in GTFS semantics.

---

# SERVICE CALENDARS

Implement service schedules using:

* recurring weekly calendar;
* start date;
* end date;
* added service dates;
* removed service dates.

Correctly evaluate exceptional dates.

Do not assume every trip operates every day.

---

# TRANSIT TIME MODEL

Define canonical time semantics.

Transit scheduling must distinguish:

* local agency timezone;
* service date;
* actual timestamp;
* scheduled timestamp;
* estimated timestamp.

Do not interpret transit schedules solely using server UTC without applying agency timezone semantics.

---

# SERVICE-DATE HANDLING

Implement GTFS-style service-date semantics correctly.

Support times beyond midnight within a service day.

A service trip beginning late at night may continue into the following civil date while remaining associated with the original service date.

Do not truncate or misinterpret such trips.

---

# TRANSFERS

Implement transit transfers.

Support, where source data permits:

* transfer source stop;
* transfer destination stop;
* transfer type;
* minimum transfer time;
* station-level transfer;
* walking transfer where appropriate.

Do not create impossible transfer paths.

---

# PEDESTRIAN CONNECTIONS

Represent walking connections needed for:

* stop-to-stop transfers;
* entrance-to-platform access;
* origin-to-stop access;
* stop-to-destination egress.

Where pedestrian routing is available, delegate walking-path calculation to the canonical walking-routing capability rather than inventing independent walking geometry.

---

# ACCESSIBILITY

Consume accessibility metadata where available.

Support:

* wheelchair-accessible stops;
* accessible stations;
* accessible pathways;
* accessible vehicles where data exists.

Do not claim accessibility where the source data does not establish it.

---

# TRANSIT SHAPES

Persist or index route shapes where available.

Shapes must remain distinct from:

* road-routing geometry;
* map-tile geometry.

Do not use generalized tile geometry for journey-planning calculations.

---

# TRANSIT GRAPH

Create an efficient journey-planning representation.

The architecture may use:

* PostgreSQL;
* specialized graph structures;
* precomputed indexes;
* timetable indexes;
* routing-engine transit profiles;

according to repository capabilities.

Do not perform unbounded full-database scans for every transit request.

---

# JOURNEY-PLANNING MODEL

A transit journey may contain:

```text
WALK ACCESS
      ↓
TRANSIT RIDE
      ↓
TRANSFER
      ↓
TRANSIT RIDE
      ↓
WALK EGRESS
```

Represent journey components explicitly.

---

# MULTIMODAL ROUTE MODEL

Extend the canonical route representation to support:

* walking;
* cycling;
* driving;
* transit;
* transfers.

A multimodal route must preserve:

* route ID;
* journey duration;
* departure;
* arrival;
* legs;
* geometry;
* transit metadata;
* walking metadata;
* transfer metadata;
* warnings.

Do not create a separate incompatible route format for transit.

---

# TRANSIT LEG

A transit leg should support:

* agency;
* route;
* trip;
* boarding stop;
* alighting stop;
* departure;
* arrival;
* scheduled times;
* real-time times;
* stop sequence;
* headsign;
* intermediate stops where appropriate;
* accessibility;
* service alerts.

---

# TRANSFER LEG

A transfer leg must support:

* origin stop/station;
* destination stop/station;
* walking distance;
* estimated walking duration;
* minimum transfer requirement;
* accessibility implications where available.

Do not report transfers shorter than explicitly known minimum transfer requirements unless uncertainty is clearly represented.

---

# JOURNEY DEPARTURE/ARRIVAL

Support query parameters such as:

* depart-at;
* arrive-by.

The system must not accept both simultaneously without explicit defined semantics.

Validate timezone and timestamp inputs.

---

# TRANSIT ROUTE SEARCH

Implement transit-aware route planning.

Support:

* origin;
* destination;
* departure/arrival time;
* allowed modes;
* transfer limit;
* accessibility requirements where supported;
* maximum walking distance;
* preferred agencies where supported;
* route alternatives.

Requests must be bounded.

Do not allow unlimited transfer or walking-path exploration.

---

# TRANSIT ROUTE ALTERNATIVES

Provide meaningful alternatives where supported.

Different alternatives may vary by:

* departure time;
* transit service;
* transfer count;
* walking distance;
* total duration;
* agency;
* service reliability.

Do not return duplicated journeys with insignificant differences.

---

# ROUTE RANKING

Rank multimodal journeys using deterministic criteria such as:

* arrival time;
* total duration;
* departure time;
* transfer count;
* walking duration;
* accessibility requirements;
* service alerts;
* reliability/freshness where available.

The exact ranking rules must be documented.

Do not expose internal ranking coefficients as public product scores.

---

# TRANSIT FARES

Where fare data is available, support a canonical fare representation.

It may include:

* fare amount;
* currency;
* zone;
* product;
* transfer validity;
* source.

Do not fabricate fares when feed data does not contain sufficient information.

Do not treat estimated fare as exact without an explicit confidence or source basis.

---

# REALTIME TRANSIT DATA

Implement a normalized realtime model supporting GTFS-Realtime concepts such as:

* trip updates;
* vehicle positions;
* service alerts.

Each realtime record must preserve:

* provider;
* feed version;
* update timestamp;
* entity ID;
* source timestamp;
* freshness.

---

# TRIP UPDATES

Support realtime updates to:

* estimated arrival;
* estimated departure;
* delays;
* cancelled trips;
* added trips where supported;
* stop-level changes.

Do not mutate the static timetable source.

Realtime information is a dynamic overlay.

---

# VEHICLE POSITIONS

Where available support:

* vehicle ID;
* trip ID;
* route;
* current stop;
* latitude;
* longitude;
* bearing;
* speed;
* timestamp.

Treat vehicle positions as realtime data, not authoritative road geometry.

Do not fabricate vehicle positions when a provider does not supply them.

---

# REALTIME SERVICE ALERTS

Support alerts for:

* delay;
* cancellation;
* detour;
* station closure;
* service disruption;
* modified service.

Normalize alert severity and affected entities.

---

# REALTIME FRESHNESS

Every realtime transit record must have explicit freshness semantics.

When stale:

* stop applying the dynamic update;
* fall back to scheduled data;
* identify degraded freshness;
* avoid presenting old predictions as current.

---

# REALTIME OVERRIDES

Dynamic transit information should override static schedules only when:

* entity IDs match;
* update is valid;
* timestamp is sufficiently fresh;
* update semantics are understood.

Do not allow malformed realtime data to overwrite a valid static schedule.

---

# TRANSIT CANCELLATION

Support cancellation semantics.

When a trip is cancelled:

* remove it from eligible live departures;
* preserve historical schedule data;
* communicate cancellation through route warnings where applicable.

Do not delete the static trip.

---

# TRANSIT DELAYS

Apply delay information to relevant trip/stop-time instances.

Do not permanently mutate the base timetable because of a temporary realtime delay.

---

# SERVICE ALERT EFFECTS ON ROUTING

Service alerts may affect journey planning.

Where supported:

* exclude cancelled services;
* penalize disrupted services;
* surface warnings;
* alter route alternatives.

Do not silently route users through known service closures.

---

# REALTIME VEHICLE ETA

Where vehicle positions and trip schedules permit:

* calculate predicted arrival at future stops;
* respect realtime trip updates;
* avoid false precision;
* identify whether an ETA is scheduled or real-time.

Do not calculate a realtime ETA from stale vehicle positions without marking degradation.

---

# TRANSIT DATA INGESTION JOBS

Implement background jobs for:

* static-feed ingestion;
* feed validation;
* feed publication;
* realtime-feed polling/streaming;
* normalization;
* index refresh;
* stale-data cleanup.

Jobs must support:

* retries;
* backoff;
* idempotency;
* timeout;
* concurrency;
* metrics;
* dead-letter handling.

---

# FEED POLLING

For realtime feeds that require polling:

* enforce bounded polling intervals;
* use provider-supported intervals;
* avoid unnecessary requests;
* apply timeout;
* honor provider rate limits.

Do not create a runaway polling loop.

---

# FEED FAILURE

If a realtime feed is unavailable:

* retain the last known valid static schedule;
* retain last valid realtime data only within its freshness window;
* mark the source degraded;
* stop applying stale updates;
* continue service using scheduled information where appropriate.

Do not fabricate realtime status.

---

# TRANSIT INDEXING

Create efficient indexes for:

* stop location;
* station hierarchy;
* route;
* trip;
* service date;
* stop sequence;
* departure time;
* arrival time;
* agency;
* accessibility;
* realtime entity references.

Avoid loading an entire transit network into an API request.

---

# DEPARTURE SEARCH

Implement efficient departure lookup.

Support queries such as:

* departures from stop;
* next departures;
* arrivals to stop where data permits.

Results should distinguish:

* scheduled time;
* estimated time;
* delay;
* cancellation;
* realtime freshness.

---

# STOP SEARCH INTEGRATION

Transit stops may be discoverable through the existing search system.

Publish approved transit entities through the existing search-projection contract.

Do not create a separate public search API solely for transit stops.

---

# MAP INTEGRATION

Expose sufficient transit data for map rendering and future tile integration.

Do not generate tiles in this milestone.

Provide stable:

* stop IDs;
* station IDs;
* route IDs;
* route-color metadata where appropriate;
* route geometry references.

---

# ROUTING-ENGINE INTEGRATION

Integrate transit capabilities through the existing routing abstraction.

The public API must remain independent of whether journey planning is provided by:

* a dedicated transit planner;
* a routing engine;
* a multimodal graph;
* a combination.

Do not leak engine-specific transit representations.

---

# ROUTING FALLBACK

When realtime transit is unavailable but scheduled transit remains valid:

* calculate using scheduled data;
* identify freshness limitations.

When static transit data is unavailable:

* return an explicit transit-data-unavailable error;
* do not fabricate schedules.

---

# TRANSIT DATA VERSIONING

Every journey-planning operation must be associated internally with:

* static feed version;
* realtime feed timestamp/version where applicable;
* routing graph version;
* geographic dataset version where relevant.

Do not combine incompatible transit snapshots silently.

---

# CACHE

Use Redis only for justified short-lived data such as:

* next-departure queries;
* static stop metadata;
* frequent timetable lookups;
* bounded journey-result caching.

Realtime journey results must have TTLs tied to data freshness.

Do not cache stale live-departure data indefinitely.

---

# CACHE KEY DESIGN

Cache keys must incorporate:

* stop/place identifier;
* query time;
* timezone/service date;
* allowed modes;
* accessibility;
* walking limit;
* agency filter;
* relevant feed version.

Do not allow semantically different journey requests to collide.

---

# RATE LIMITING

Apply transit-specific rate limits for:

* journey planning;
* departures;
* stop information;
* realtime vehicle queries.

Journey planning is more computationally expensive than static stop lookup.

Use differentiated request limits.

---

# ABUSE PROTECTION

Protect against:

* huge transfer limits;
* excessive walking radius;
* excessive alternatives;
* deep timetable exploration;
* massive departure queries;
* feed-ingestion abuse.

Reject computationally pathological requests before graph exploration becomes expensive.

---

# SECURITY

Protect:

* internal feed URLs/configuration;
* provider credentials;
* unpublished feed data;
* administrative feed controls;
* internal transit metrics;
* private user route context.

Do not expose:

* provider API keys;
* internal data-source credentials;
* internal graph topology;
* raw provider authentication material.

---

# PRIVACY

Transit journey requests can reveal:

* origin;
* destination;
* travel time;
* mobility patterns.

Do not persist user journey history in this milestone unless explicitly required by an existing feature.

Do not log exact origin/destination coordinates routinely.

Where operational telemetry needs geographic information:

* minimize precision;
* minimize retention;
* restrict access.

---

# OBSERVABILITY

Instrument:

* feed ingestion;
* feed validation;
* feed freshness;
* feed publication;
* realtime update latency;
* stale-data rate;
* trip-update processing;
* vehicle-position processing;
* service-alert processing;
* journey-planning latency;
* journey failure rate;
* transfer count;
* cache hit/miss;
* data-version usage.

Track:

* p50;
* p95;
* p99;
* realtime freshness;
* ingestion lag;
* journey-planner CPU/memory;
* provider failure rate.

Do not log private route coordinates unnecessarily.

---

# DATA QUALITY

Implement measurable transit-data-quality checks.

Validate:

* referential integrity;
* stop-coordinate validity;
* route/trip consistency;
* service-calendar consistency;
* stop-time ordering;
* duplicate entities;
* broken transfer references;
* malformed shapes;
* stale feeds.

Track feed quality metrics before publication.

---

# TRANSIT DATA PUBLICATION

A static feed must not become active until:

* validation succeeds;
* required indexes are built;
* required projections are ready;
* data-quality thresholds are satisfied.

Publication should be atomic at the feed/version level.

Failed publication must preserve the currently active feed.

---

# TRANSIT FEED ROLLBACK

Implement version rollback.

If a feed causes:

* severe data corruption;
* missing service;
* invalid schedules;
* broken references;

restore the previous known-good feed version.

Preserve rollback metadata.

---

# TESTING — UNIT

Create meaningful unit tests for:

* GTFS parsing;
* time normalization;
* service-date calculation;
* timezone handling;
* calendar exceptions;
* transfer validation;
* trip normalization;
* route normalization;
* realtime update normalization;
* delay application;
* cancellation behavior;
* freshness evaluation;
* journey-ranking rules;
* fare parsing;
* cache-key construction.

---

# TESTING — GTFS STATIC

Use real representative GTFS fixtures where available.

Validate:

* agency;
* stops;
* routes;
* trips;
* stop times;
* calendars;
* exceptions;
* shapes;
* transfers;
* optional files.

Include fixtures with:

* midnight-crossing services;
* multiple agencies;
* station hierarchies;
* duplicate source identifiers;
* missing optional data;
* invalid references.

Do not use fabricated fixtures as evidence of global transit coverage.

---

# TESTING — GTFS REALTIME

Use real-format GTFS-Realtime fixtures where possible.

Test:

* trip updates;
* delays;
* cancellations;
* vehicle positions;
* service alerts;
* stale updates;
* duplicate updates;
* malformed updates.

Verify that realtime data overlays static schedules rather than mutating the base timetable.

---

# TESTING — JOURNEY PLANNING

Test:

* direct transit journey;
* walk + transit;
* transit + transfer + transit;
* transit + walk;
* arrive-by;
* depart-at;
* accessibility constraints;
* maximum walking distance;
* transfer limits;
* route alternatives;
* cancelled trip;
* delayed trip;
* service alert;
* stale realtime data;
* missing realtime data.

Verify journey ordering and leg semantics.

---

# TESTING — TIMEZONE AND SERVICE-DATE

Explicitly test:

* local agency timezone;
* daylight-saving transitions where relevant;
* trips after midnight;
* service-date boundaries;
* calendar exceptions.

Do not assume server timezone.

---

# TESTING — DATA QUALITY

Verify that invalid feeds are rejected for:

* broken references;
* invalid times;
* invalid coordinates;
* duplicate identifiers;
* inconsistent calendars.

Verify that valid feeds can become active.

---

# TESTING — FAILURE AND RESILIENCE

Test:

* static-feed download failure;
* malformed feed;
* realtime-feed outage;
* stale realtime data;
* routing-engine outage;
* cache outage;
* database outage;
* indexing failure;
* feed publication failure;
* rollback.

The previous active valid transit dataset must remain usable after an unsuccessful feed update.

---

# TESTING — PERFORMANCE

Measure:

* feed-ingestion throughput;
* timetable indexing;
* departure lookup;
* journey-planning latency;
* realtime-update processing;
* cache effectiveness;
* concurrent journey requests.

Use representative network fixtures.

Do not claim metropolitan or global transit-scale performance from tiny datasets.

---

# API CONTRACTS

Implement or update authoritative contracts for:

* transit stop lookup;
* transit station details;
* departures;
* transit journey planning;
* multimodal directions;
* transit alerts;
* transit accessibility metadata;
* transit fare metadata where supported.

The contracts must define:

* request;
* response;
* travel mode;
* departure/arrival semantics;
* route legs;
* scheduled versus realtime times;
* freshness;
* warnings;
* errors;
* pagination/limits where applicable.

Do not create a second incompatible directions API.

---

# EVENT CONTRACTS

Create/update applicable events such as:

* `TransitFeedValidated`;
* `TransitFeedPublished`;
* `TransitFeedRolledBack`;
* `TransitTripUpdated`;
* `TransitVehiclePositionUpdated`;
* `TransitServiceAlertUpdated`;
* `TransitDataDegraded`.

Use the project's standard event envelope.

Events must be versioned and idempotent.

---

# QUEUE CONTRACTS

Define jobs for:

* static feed ingestion;
* feed validation;
* feed publication;
* realtime feed processing;
* stale-data cleanup;
* transit-index rebuild.

Every job must support:

* version;
* payload;
* retry;
* backoff;
* timeout;
* idempotency;
* dead-letter handling.

---

# DOCUMENTATION

Create or update documentation covering:

* transit domain;
* feed sources;
* GTFS ingestion;
* GTFS validation;
* feed versioning;
* timezone/service-date semantics;
* stop/station model;
* routes/trips;
* transfer model;
* journey-planning model;
* realtime transit;
* freshness;
* fares;
* accessibility;
* routing integration;
* caching;
* rate limits;
* data-quality controls;
* publication;
* rollback;
* monitoring;
* external provider dependencies.

Document actual implementation behavior.

Do not claim transit coverage that has not been ingested and validated.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* geographic/place data;
* search;
* routing;
* navigation;
* traffic;
* notifications;
* map tiles;
* administration;
* analytics.

## Web

The web client must be able to consume:

* transit stops;
* transit routes;
* departures;
* transit journey alternatives;
* scheduled and realtime arrival/departure times;
* transfers;
* accessibility;
* alerts.

## Mobile

The mobile client must be able to consume the same contracts efficiently for:

* journey planning;
* departures;
* realtime transit status;
* active trip information.

## Infrastructure

Infrastructure must support:

* transit feed workers;
* realtime feed processing;
* database/indexing;
* journey-planning compute;
* queues;
* observability.

## QA

QA must be able to validate:

* transit data quality;
* schedule semantics;
* route planning;
* realtime behavior;
* accessibility;
* freshness;
* failure recovery;
* security;
* performance.

Do not create separate transit contracts for web and mobile.

---

# PORTABLE TRANSIT CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* agency schema;
* feed schema;
* feed-version lifecycle;
* stop schema;
* station schema;
* route schema;
* trip schema;
* stop-time schema;
* service-calendar schema;
* transfer schema;
* transit-leg schema;
* journey schema;
* departure schema;
* realtime trip-update schema;
* vehicle-position schema;
* service-alert schema;
* fare schema;
* accessibility schema;
* transit errors;
* data-freshness rules;
* journey-planning configuration.

Document which files are authoritative.

Do not maintain duplicate incompatible schemas.

---

# EXTERNAL DATA REALISM

Transit data depends on external providers.

For each integration:

* implement a typed adapter;
* validate feed format;
* preserve source provenance;
* enforce timeouts;
* enforce rate limits;
* support retries;
* record source freshness;
* do not fabricate provider credentials;
* do not fabricate provider data.

When a provider is unavailable:

* test with deterministic fixtures;
* validate the ingestion and normalization pipeline;
* report the external validation limitation accurately.

---

# SECURITY REVIEW

Before completion, inspect for:

* malicious feed payloads;
* oversized feed files;
* decompression attacks;
* malformed realtime messages;
* unauthorized feed administration;
* provider credential leakage;
* unsafe external URLs;
* SSRF through configurable feed sources;
* arbitrary file writes;
* query-resource exhaustion;
* unauthorized transit-data mutation.

External feed URLs must be restricted and validated according to the security model.

Do not allow arbitrary internal-network fetches from user-controlled URLs.

---

# PERFORMANCE AND RESOURCE CONTROLS

Apply limits to:

* feed-file size;
* uncompressed feed size;
* number of records;
* number of realtime entities;
* journey alternatives;
* transfer count;
* walking distance;
* departure-query range.

Processing must use bounded memory.

Do not load a complete large feed into process memory when streaming or batched processing is available.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* inspect feed parsers;
* inspect schema migrations;
* inspect indexes;
* inspect timezone handling;
* inspect realtime overlay logic;
* inspect stale-data handling;
* inspect routing integration;
* inspect cache behavior;
* inspect job configuration;
* inspect API contracts;
* inspect event contracts;
* inspect security controls;
* inspect tests;
* run type checking;
* run linting;
* run formatting;
* inspect performance output;
* inspect documentation;
* remove debug code;
* remove unused dependencies;
* verify no fabricated transit data exists;
* verify no unrelated future-domain implementation was introduced.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* transit domain changes;
* agency implementation;
* feed implementation;
* feed versioning;
* GTFS ingestion;
* GTFS validation;
* normalization;
* stop/station models;
* route/trip implementation;
* stop times;
* service calendars;
* transfers;
* accessibility;
* route shapes;
* fares where supported;
* transit graph/index;
* journey planning;
* multimodal routing;
* transit legs;
* transfer legs;
* departures;
* realtime trip updates;
* vehicle positions;
* service alerts;
* realtime freshness;
* feed publication;
* rollback;
* Redis/cache changes;
* queues;
* events;
* API changes;
* rate limits;
* security changes;
* privacy changes;
* observability;
* data-quality controls;
* tests created;
* tests executed;
* timezone validation;
* journey-planning validation;
* realtime validation;
* resilience testing;
* performance validation;
* documentation updates;
* compatibility considerations;
* known limitations;
* unresolved external transit-data dependencies.

The report must accurately describe actual repository changes.

Do not claim that live transit coverage, external feeds, or provider integrations are operational unless they were actually verified.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* transit ownership is explicit;
* agency entities are implemented;
* feed entities are implemented;
* feed versions are explicit;
* feed lifecycle is implemented;
* static GTFS ingestion is real;
* GTFS validation is real;
* source provenance is preserved;
* source versions are preserved;
* stops are implemented;
* stations are implemented where applicable;
* stop hierarchy is represented;
* transit routes are implemented;
* route variants are represented where applicable;
* trips are implemented;
* stop times are implemented;
* service calendars are implemented;
* calendar exceptions are implemented;
* timezone semantics are correct;
* midnight-crossing trips are handled;
* transfers are implemented;
* pedestrian transfer connections are supported;
* accessibility metadata is preserved;
* transit shapes are represented;
* transit indexing is implemented;
* journey planning is implemented;
* multimodal journeys use the canonical route model;
* transit legs are explicit;
* transfer legs are explicit;
* departure/arrival semantics are implemented;
* route alternatives are meaningful;
* deterministic journey ranking is implemented;
* fare data is represented where legitimately available;
* realtime trip updates are implemented;
* realtime vehicle positions are implemented where feeds provide them;
* realtime service alerts are implemented;
* realtime freshness is enforced;
* stale realtime data cannot appear current;
* cancellations are handled;
* delays overlay schedules without corrupting static data;
* service alerts influence journey planning where applicable;
* realtime ETAs are distinguished from scheduled times;
* static feed ingestion jobs are implemented;
* realtime processing jobs are implemented;
* retries are bounded;
* ingestion is idempotent;
* feed publication is version-safe;
* feed rollback is implemented;
* the previous active dataset remains protected during failed updates;
* search integration hooks exist;
* map integration hooks exist;
* routing-engine integration is isolated;
* transit caching is bounded;
* rate limiting is implemented;
* abuse protection exists;
* external feed security is enforced;
* SSRF protections exist for configurable provider URLs;
* memory/resource limits are enforced;
* observability is implemented;
* data-quality metrics are implemented;
* privacy requirements are respected;
* API contracts are implemented;
* event contracts are implemented;
* queue contracts are implemented;
* GTFS tests exist;
* GTFS-Realtime tests exist;
* journey-planning tests exist;
* timezone/service-date tests exist;
* data-quality tests exist;
* failure/resilience tests exist;
* performance validation exists;
* documentation is current;
* portable transit contracts exist;
* the final diff was inspected;
* there are no fabricated transit schedules or vehicle positions;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no credentials or external infrastructure were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement the complete web/mobile transit experience, map-tile generation, notifications, reviews, media, or production cloud infrastructure during this public-transit and multimodal backend milestone.
