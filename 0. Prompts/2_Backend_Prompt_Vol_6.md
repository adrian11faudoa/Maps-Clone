# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 6

# ROLE

You are the senior backend engineering agent responsible for implementing the **production real-time navigation, navigation-session management, location telemetry, map matching, off-route detection, rerouting coordination, ETA updates, traffic-ingestion foundation, and live navigation backend** for a **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Realtime Systems Architect
* Navigation Engineer
* Geospatial Engineer
* Location/Telemetry Engineer
* Routing Engineer
* Distributed Systems Engineer
* Stream-Processing Engineer
* Backend API Engineer
* Database Engineer
* Security Engineer
* Privacy Engineer
* Reliability Engineer
* Performance Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement a real, production-grade backend capable of maintaining active navigation sessions, processing location updates safely, detecting navigation state transitions, coordinating reroutes, and providing fresh navigation information to authorized clients.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive maps;
* place discovery;
* search;
* geocoding;
* route planning;
* route alternatives;
* traffic-aware routing;
* turn-by-turn navigation;
* real-time location;
* active trips;
* saved places;
* user contributions;
* reviews and ratings;
* media;
* notifications;
* moderation;
* administration;
* analytics;
* operational observability.

This milestone implements the backend systems required for active navigation and real-time trip execution.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* navigation-session domain;
* active trip state;
* navigation-session lifecycle;
* route association;
* navigation-state persistence;
* navigation-state versioning;
* realtime navigation protocol;
* WebSocket or repository-selected realtime transport;
* authenticated realtime connections;
* session-bound authorization;
* location-update ingestion;
* location-event validation;
* location-event deduplication;
* out-of-order location handling;
* location timestamp validation;
* GPS anomaly detection;
* stale-location handling;
* map-matching integration boundary;
* current navigation position;
* maneuver progression;
* current route-step determination;
* off-route detection;
* rerouting requests;
* reroute throttling;
* dynamic ETA updates;
* traffic-aware navigation updates;
* navigation heartbeat;
* reconnect handling;
* missed-update recovery;
* session expiration;
* session termination;
* background/disconnected session handling;
* privacy-preserving location storage;
* short-lived location retention;
* telemetry aggregation hooks;
* live traffic-observation ingestion boundary;
* traffic-segment-state normalization foundation;
* traffic freshness handling;
* navigation-specific rate limiting;
* realtime abuse protection;
* observability;
* reliability;
* performance controls;
* API and realtime contracts;
* event and queue integration;
* unit tests;
* integration tests;
* realtime protocol tests;
* location validation tests;
* navigation-state tests;
* resilience tests;
* performance tests;
* documentation.

The routing service remains responsible for route calculation.

This prompt consumes the routing contract and turns a calculated route into an active navigation session.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* complete web navigation UI;
* complete mobile navigation UI;
* native iOS/Android background-service implementation;
* complete map-tile generation;
* search ranking;
* autocomplete ranking;
* reviews;
* ratings;
* place contributions;
* media processing;
* notification provider implementation;
* moderation tooling;
* complete analytics warehouse;
* production Kubernetes provisioning;
* production cloud provisioning;
* fabrication of live traffic feeds;
* fabrication of GPS/device data;
* proprietary Google navigation algorithms;
* custom cryptography.

This prompt may implement backend abstractions required by later web/mobile implementations.

Do not create fake live location or traffic behavior merely to simulate a complete product.

---

# REPOSITORY INSPECTION

Inspect the repository first.

Determine:

* current backend structure;
* authentication/session implementation;
* route API;
* route-response schema;
* routing-engine integration;
* geographic models;
* PostGIS;
* Redis;
* event broker;
* queue workers;
* WebSocket infrastructure;
* OpenTelemetry;
* configuration;
* rate limiting;
* existing navigation code;
* existing trip/session code;
* existing location models;
* existing traffic models;
* tests;
* API contracts;
* realtime contracts;
* architecture artifacts.

Treat the repository's actual state as authoritative.

Do not assume previous prompts were executed merely because they were generated.

Preserve compatible behavior.

Do not duplicate route or authentication contracts.

---

# NAVIGATION TECHNOLOGY CONTEXT

Use the project's existing backend direction:

* TypeScript;
* NestJS or compatible modular backend framework;
* PostgreSQL/PostGIS;
* Redis where justified;
* WebSocket or equivalent realtime transport;
* event streaming where available;
* queue infrastructure where appropriate;
* OpenTelemetry-compatible observability.

Use a specialized map-matching or navigation library where an established compatible implementation exists.

Do not implement custom map-matching mathematics merely for the sake of creating more code.

---

# NAVIGATION ARCHITECTURE

Implement the backend flow conceptually equivalent to:

```text
Mobile/Web Client
      ↓
Authenticated Realtime Connection
      ↓
Navigation Session
      ↓
Location Update
      ↓
Validation / Filtering
      ↓
Map Matching
      ↓
Navigation State Evaluation
   ┌──┼───────────────┐
   ↓  ↓               ↓
Step  ETA         Off-Route
      ↓               ↓
      └── Reroute Request
               ↓
          Routing Service
               ↓
        Updated Navigation State
               ↓
        Realtime Client Update
```

Keep the responsibilities of:

* route calculation;
* navigation execution;
* traffic ingestion;

separate.

---

# NAVIGATION SESSION MODEL

Implement the canonical navigation-session entity.

It should support:

* navigation session ID;
* user ID;
* device ID;
* route ID;
* travel mode;
* status;
* created-at;
* started-at;
* last-location-at;
* last-state-update-at;
* ended-at;
* expiration time;
* current step ID;
* current step index;
* state version;
* latest map-matched location;
* latest ETA;
* traffic freshness indicator.

Do not embed full location history in the navigation-session row.

Keep high-volume telemetry separate.

---

# NAVIGATION SESSION STATES

Implement explicit lifecycle states.

At minimum support:

* `CREATED`
* `ACTIVE`
* `RECALCULATING`
* `ARRIVED`
* `ENDED`
* `CANCELLED`
* `EXPIRED`
* `FAILED`

Define legal transitions.

Prevent invalid state transitions such as:

* ended → active;
* expired → active;
* cancelled → recalculating.

State transitions must be idempotent where repeated requests are possible.

---

# NAVIGATION SESSION CREATION

Implement the navigation-session creation endpoint.

It must accept:

* route ID;
* client/device metadata where necessary;
* optional navigation preferences where supported.

Validate:

* authenticated user;
* route existence;
* route ownership/access where applicable;
* route freshness;
* route-data compatibility;
* travel mode.

Do not create a navigation session for a nonexistent or invalid route.

---

# ROUTE ASSOCIATION

A navigation session must reference a specific route representation.

Store enough metadata to detect whether the route is stale.

Where route recalculation occurs:

* create a new route representation or route revision;
* update session association;
* preserve session continuity.

Do not overwrite the original route in place without a defined revision strategy.

---

# NAVIGATION STATE MODEL

Implement a navigation-state representation containing, as applicable:

* state version;
* route ID;
* active step;
* next maneuver;
* distance to maneuver;
* remaining distance;
* remaining duration;
* current ETA;
* map-matched location;
* route progress;
* traffic freshness;
* off-route status;
* last-update timestamp.

State versions must increase monotonically.

Do not allow out-of-order state updates to overwrite newer state.

---

# CLIENT STATE VS SERVER STATE

Define clearly which state is authoritative.

The server should own authoritative:

* session lifecycle;
* route association;
* authorization;
* server-observed location timestamps;
* accepted location events;
* current server navigation state;
* route revision;
* reroute state.

The client may maintain:

* rendering state;
* audio/UI state;
* local transient state;
* offline state.

Do not make the client authoritative for session security or route ownership.

---

# LOCATION EVENT MODEL

Implement a separate location-event representation.

Support:

* event ID;
* session ID;
* device ID;
* user ID reference where required internally;
* client sequence number;
* client timestamp;
* server-received timestamp;
* latitude;
* longitude;
* horizontal accuracy;
* altitude where available;
* speed;
* heading;
* source/provider;
* optional activity information where legitimately available.

Do not store unnecessary device metadata.

---

# LOCATION VALIDATION

Validate every location event.

Reject or quarantine events with:

* invalid latitude;
* invalid longitude;
* impossible coordinate values;
* invalid speed;
* invalid heading;
* impossible timestamp;
* excessive payload size;
* unsupported provider values;
* malformed session IDs.

Do not assume GPS input is trustworthy.

---

# LOCATION ACCURACY

Use the reported horizontal accuracy when available.

Navigation state should account for uncertainty.

Do not treat a point with very poor accuracy as a precise route position.

Where accuracy is too poor for reliable navigation:

* degrade map matching confidence;
* delay step transitions;
* avoid false off-route events;
* communicate degraded state where appropriate.

---

# IMPOSSIBLE-JUMP DETECTION

Protect against physically implausible location jumps.

Compare:

* previous accepted location;
* current location;
* elapsed time;
* speed;
* travel mode.

Reject or flag impossible transitions.

Do not hardcode a universal speed threshold that incorrectly rejects legitimate high-speed transport modes.

Use travel-mode-aware bounds.

---

# OUT-OF-ORDER LOCATION EVENTS

Location events may arrive out of order.

Use:

* client sequence;
* client timestamp;
* server receive time;

to determine ordering.

Older events must not overwrite newer navigation state.

Late telemetry may still be retained or processed for analytics only when justified and authorized.

---

# DUPLICATE LOCATION EVENTS

Repeated location events may occur due to reconnects or client retries.

Implement idempotency using:

* event ID;
* session;
* sequence number.

Duplicate events must not:

* advance navigation twice;
* trigger duplicate reroutes;
* inflate traffic observations;
* create duplicate notifications.

---

# LOCATION RATE LIMITING

Apply navigation-specific rate limiting.

Navigation location updates may legitimately arrive frequently.

Use:

* per-session rate limits;
* per-user limits;
* per-device limits;
* burst allowance;
* payload-size limits.

Reject abusive high-frequency traffic without breaking normal navigation.

Do not use the same rate limit as route calculations.

---

# LOCATION RETENTION

Treat raw precise location as sensitive.

Store only the minimum amount required for active navigation and explicitly planned derived workloads.

Define:

* active-session retention;
* short-term recovery retention;
* aggregated traffic retention;
* deletion.

Do not persist raw precise location history indefinitely.

Do not add a permanent location-history product in this milestone.

---

# LOCATION PRIVACY

Do not expose:

* one user's active location;
* one user's navigation route;
* exact location telemetry;

to another user without an explicit authorized product capability.

Do not log exact coordinates unnecessarily.

Where diagnostic telemetry requires geographic context:

* reduce precision where possible;
* minimize retention;
* restrict access.

---

# MAP MATCHING

Implement the map-matching integration boundary.

The map matcher must accept, as appropriate:

* recent location sequence;
* accuracy;
* speed;
* heading;
* travel mode;
* route geometry;
* map data version.

It should return:

* matched road/segment;
* matched coordinate;
* route position;
* confidence;
* matched timestamp.

Do not expose map-matcher internals through public APIs.

---

# MAP-MATCHING CONFIDENCE

Track confidence.

If confidence is low:

* avoid immediate off-route decisions;
* do not aggressively advance maneuvers;
* avoid unnecessary rerouting.

Define configurable thresholds.

Do not hide map-matching uncertainty behind false certainty.

---

# ROUTE PROGRESS

Determine navigation progress using:

* matched position;
* route geometry;
* current route step;
* direction of travel;
* route sequence.

Protect against GPS jitter causing repeated step transitions.

Progress should move monotonically unless a reroute creates a new route revision.

---

# MANEUVER PROGRESSION

Advance the current step only when appropriate.

Consider:

* proximity to maneuver;
* heading;
* map-matched road;
* route progression;
* GPS confidence.

Do not advance to the next maneuver merely because a point is geographically close if the user is traveling on a different road.

---

# OFF-ROUTE DETECTION

Implement bounded off-route detection.

Use evidence such as:

* lateral distance from route;
* route position;
* matched road;
* heading mismatch;
* persistence over multiple updates.

Avoid declaring off-route from one noisy GPS point.

Define hysteresis to prevent rapid:

```text
ON ROUTE → OFF ROUTE → ON ROUTE
```

oscillation.

---

# REROUTING

When off-route conditions are sufficiently strong:

* mark navigation state accordingly;
* transition to `RECALCULATING`;
* request a new route through the routing service;
* preserve the active navigation session;
* apply reroute throttling;
* publish the new route revision.

Do not allow every noisy point to trigger a routing calculation.

---

# REROUTE THROTTLING

Implement controls such as:

* minimum time between reroutes;
* minimum route-deviation evidence;
* maximum concurrent reroutes;
* backoff after routing-engine failures.

The exact threshold must be configurable.

Rerouting must not create a self-amplifying routing load.

---

# REROUTE IDEMPOTENCY

A navigation session may receive repeated reroute triggers.

Implement deduplication using:

* session;
* navigation state version;
* route revision;
* relevant position state.

Two identical reroute requests should not create multiple conflicting route revisions.

---

# REROUTE FAILURE

If rerouting fails:

* preserve the previous valid route where possible;
* remain in a controlled navigation state;
* retry only according to bounded retry policy;
* surface degraded routing status;
* do not fabricate a new route.

If the user reconnects, the client must be able to recover the authoritative navigation state.

---

# ETA UPDATES

Update ETA using:

* current matched position;
* remaining route;
* current traffic data;
* route duration;
* current time.

Avoid recalculating full routing more frequently than needed.

Use existing route information and localized traffic updates where possible.

---

# ETA FRESHNESS

Every traffic-aware ETA must have a freshness basis.

Track:

* traffic observation timestamp;
* traffic effective timestamp;
* route calculation timestamp;
* ETA calculation timestamp.

Do not report stale traffic as current.

---

# TRAFFIC INPUT

Consume normalized traffic information through the project's traffic contract.

Traffic state must support:

* road/segment ID;
* observation timestamp;
* effective interval;
* congestion;
* speed;
* free-flow speed;
* confidence;
* source;
* freshness.

The navigation service must not parse arbitrary provider-specific traffic payloads directly.

---

# TRAFFIC-SEGMENT ASSOCIATION

Map traffic state to route segments.

Only apply traffic to a route when:

* segment identity matches;
* traffic state is valid;
* traffic is within freshness bounds.

Do not apply nearby but unrelated traffic observations to a route.

---

# TRAFFIC INGESTION FOUNDATION

Implement the backend boundary required to ingest normalized live traffic observations.

Support, as appropriate:

* source adapter;
* validation;
* normalization;
* deduplication;
* segment association;
* freshness;
* expiration;
* publication.

The current prompt does not require implementation of every external traffic provider.

Do not fabricate provider data.

---

# TRAFFIC OBSERVATION ENTITY

Where persistence is required, define a traffic-observation representation containing:

* observation ID;
* road/segment ID;
* source;
* observed-at;
* effective-at;
* expires-at/freshness;
* speed;
* free-flow speed;
* congestion level;
* confidence;
* source version.

High-volume raw telemetry should not be stored indefinitely in the transactional navigation database.

---

# TRAFFIC AGGREGATION

Where traffic observations are aggregated:

* use bounded windows;
* distinguish raw from aggregate data;
* retain source and freshness;
* avoid exposing raw telemetry.

Aggregated traffic is used by:

* route calculation;
* navigation;
* map visualization.

Do not make the navigation service the authoritative traffic-data owner.

---

# TRAFFIC FAILURE BEHAVIOR

If live traffic is unavailable:

* continue navigation using the existing route where possible;
* fall back to static ETA calculation where appropriate;
* mark traffic state as degraded;
* avoid fabricating traffic conditions.

A temporary traffic-source outage must not terminate an otherwise valid navigation session.

---

# REALTIME TRANSPORT

Implement the project's realtime transport.

Where WebSockets are selected:

* authenticated handshake;
* secure connection;
* session-bound subscription;
* server-to-client navigation updates;
* client-to-server location updates;
* acknowledgements where required;
* heartbeat;
* disconnect reasons;
* reconnect support.

Do not expose arbitrary topic subscription.

---

# REALTIME AUTHENTICATION

Authenticate the realtime connection before allowing access to navigation channels.

Verify:

* identity;
* session ownership;
* token validity;
* token expiration;
* device/session binding where applicable.

Do not trust a client-supplied navigation session ID as proof of authorization.

---

# REALTIME SESSION BINDING

A connection may subscribe only to navigation sessions explicitly authorized for that authenticated principal.

If authorization fails:

* reject the subscription;
* record security telemetry;
* avoid leaking session existence.

---

# REALTIME MESSAGE ENVELOPE

Define a stable message envelope containing, where appropriate:

* message ID;
* message type;
* protocol version;
* sequence number;
* navigation session ID;
* server timestamp;
* payload.

Do not send undocumented ad hoc messages.

---

# SERVER-TO-CLIENT NAVIGATION MESSAGES

Support messages for events such as:

* navigation-session state;
* route updated;
* maneuver advanced;
* ETA updated;
* off-route detected;
* rerouting started;
* rerouting completed;
* navigation warning;
* traffic-degraded;
* session ended;
* session expired.

Every message must have stable semantics.

---

# CLIENT-TO-SERVER MESSAGES

Support appropriate:

* location update;
* heartbeat/presence if required;
* navigation acknowledgement where needed;
* reconnect/recovery request.

Do not permit clients to directly mutate authoritative navigation state.

---

# SEQUENCE NUMBERS

Use monotonic sequence numbers for realtime navigation updates.

Clients must be able to detect:

* missing messages;
* duplicates;
* out-of-order delivery.

Server state must remain authoritative.

Do not assume WebSocket delivery guarantees ordering across reconnects.

---

# RECONNECT RECOVERY

When a client reconnects:

* re-authenticate;
* re-authorize the session;
* determine last acknowledged sequence;
* send current authoritative navigation state;
* send missed durable state transitions where supported.

Do not replay an unbounded realtime message history.

Prefer snapshot-plus-bounded-replay semantics.

---

# HEARTBEAT

Implement bounded heartbeat behavior.

Track:

* connection activity;
* last client heartbeat;
* last server response;
* session freshness.

Disconnect stale connections.

Do not confuse transport liveness with navigation-session activity.

---

# NAVIGATION SESSION EXPIRATION

Sessions that become inactive must expire safely.

Consider:

* last accepted location;
* connection state;
* last client interaction;
* explicit session end.

Expiration must:

* transition state;
* release ephemeral resources;
* stop unnecessary processing;
* preserve required audit/operational information.

---

# NAVIGATION SESSION TERMINATION

Implement explicit termination.

Termination may result from:

* user cancellation;
* arrival;
* user logout where policy requires;
* session expiration;
* account suspension;
* application termination/recovery policy.

Termination must be idempotent.

---

# CONCURRENCY

Protect against concurrent operations such as:

* two route updates;
* two reroute requests;
* two session termination requests;
* simultaneous location events;
* reconnect while an old connection remains active.

Use navigation-state versions or equivalent concurrency control.

Do not let an old connection overwrite newer state.

---

# REDIS

Use Redis where it provides real value for:

* ephemeral navigation state;
* connection/session coordination;
* distributed locks;
* rate limiting;
* short-lived location buffers;
* deduplication windows.

For each key define:

* namespace;
* serialization;
* TTL;
* maximum size;
* owner;
* failure behavior.

Do not make Redis the sole durable navigation-session source.

---

# DISTRIBUTED LOCKING

Use distributed locks only for operations that truly require cross-instance coordination, such as:

* session ownership transitions;
* reroute de-duplication;
* publication of a single navigation-state revision.

Locks must have:

* bounded TTL;
* unique owner token;
* safe release;
* failure handling.

Do not hold locks across slow routing calls.

---

# EVENTS

Emit or consume navigation events according to the project's canonical event model.

Applicable events may include:

* `NavigationStarted`;
* `NavigationStateUpdated`;
* `NavigationStepAdvanced`;
* `NavigationOffRouteDetected`;
* `NavigationRerouteRequested`;
* `NavigationRerouted`;
* `NavigationEnded`;
* `LocationTelemetryReceived`;
* `TrafficSnapshotUpdated`.

Preserve the project's event envelope and versioning.

Do not create duplicate event taxonomies.

---

# QUEUES

Where background work is appropriate, use queues for tasks such as:

* traffic aggregation;
* telemetry aggregation;
* delayed cleanup;
* navigation-session expiration;
* noncritical analytics processing.

Do not place latency-sensitive navigation updates behind long-running background queues.

Critical interactive navigation state must use the realtime path.

---

# LOCATION TELEMETRY PIPELINE

Where location telemetry must feed traffic analytics:

```text
Navigation Location Events
        ↓
Validation
        ↓
Privacy Filtering
        ↓
Map/Segment Matching
        ↓
Aggregation
        ↓
Traffic Observation
```

Separate:

* user-private navigation state;
* privacy-filtered aggregate traffic computation.

Do not expose private route or identity data through traffic outputs.

---

# TELEMETRY ANONYMIZATION / AGGREGATION

When deriving traffic from user telemetry:

* aggregate across sufficient observations;
* strip direct user identifiers from derived traffic;
* avoid producing single-user road-speed insights where privacy would be compromised;
* retain only necessary derived data.

Do not claim a specific anonymization guarantee unless the implemented method genuinely supports it.

---

# SECURITY

Protect the navigation system against:

* session hijacking;
* unauthorized session subscription;
* location spoofing;
* location flooding;
* replayed location events;
* malformed realtime messages;
* WebSocket abuse;
* reroute abuse;
* session-ID enumeration;
* resource exhaustion;
* cross-user location disclosure.

Use:

* authentication;
* authorization;
* sequence validation;
* rate limiting;
* request-size limits;
* bounded state;
* safe error handling.

---

# LOCATION SPOOFING

Treat client location as untrusted.

Use plausibility checks involving:

* timestamp;
* speed;
* heading;
* route proximity;
* sequence continuity;
* reported accuracy.

Do not claim that server-side heuristics can perfectly detect GPS spoofing.

Flag suspicious behavior rather than silently asserting certainty.

---

# REPLAY PROTECTION

Prevent old location events from being replayed to alter current navigation state.

Use:

* event IDs;
* sequence numbers;
* timestamp windows;
* session state.

An old event must not move the navigation session backward.

---

# PRIVACY AND DATA MINIMIZATION

Navigation and location data require strong privacy controls.

Do not:

* expose precise location to unrelated users;
* log exact routes routinely;
* persist unlimited raw location history;
* include exact user locations in public events;
* put private location payloads into generic analytics systems without an explicit privacy design.

Use the minimum information necessary for active navigation.

---

# OBSERVABILITY

Instrument:

* navigation-session creation;
* active-session count;
* location-event rate;
* location-event rejection;
* map-matching latency;
* map-matching confidence;
* off-route detection;
* reroute count;
* reroute latency;
* route-update count;
* ETA-update latency;
* realtime connection count;
* reconnect rate;
* dropped connections;
* heartbeat failures;
* traffic freshness;
* traffic fallback;
* session expiration;
* session termination.

Track:

* p50;
* p95;
* p99;
* error rate;
* connection stability;
* processing lag.

Do not log exact private coordinates by default.

---

# PERFORMANCE

Optimize the realtime navigation path for:

* low update latency;
* bounded CPU per location event;
* bounded memory;
* minimal database writes;
* efficient spatial operations;
* efficient state storage;
* efficient WebSocket fan-out.

Avoid:

* synchronous expensive database writes for every location update;
* routing on every GPS event;
* unbounded Redis state;
* unbounded realtime replay;
* repeated serialization of large route objects.

Use incremental state updates where appropriate.

---

# NAVIGATION STATE PERSISTENCE

Persist durable navigation-session state at a frequency appropriate to recovery and consistency needs.

Do not persist every location event synchronously to PostgreSQL.

Maintain a separation between:

* durable session state;
* ephemeral current state;
* high-volume telemetry.

This distinction is mandatory for scale.

---

# RECOVERY

After a backend instance restart:

* active sessions must remain recoverable according to durability requirements;
* ephemeral state must be reconstructed or safely degraded;
* clients must be able to reconnect;
* session authorization must remain correct.

Do not rely on process memory as the only source of active navigation state.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                        | Required Behavior                                                                             |
| ------------------------------ | --------------------------------------------------------------------------------------------- |
| Realtime server instance fails | Client reconnects to another instance and recovers authoritative session state                |
| Redis unavailable              | Use durable session state and safe degraded behavior; do not silently corrupt navigation      |
| PostgreSQL unavailable         | Preserve ephemeral navigation operation where safe; avoid losing critical durable transitions |
| Routing service unavailable    | Keep last valid route when possible; enter bounded degraded/rerouting state                   |
| Traffic service unavailable    | Continue navigation with static ETA or prior route assumptions                                |
| Map matcher unavailable        | Retain last trusted state and avoid false step/off-route transitions                          |
| Location event duplicated      | Ignore duplicate safely                                                                       |
| Location event arrives late    | Do not overwrite newer navigation state                                                       |
| WebSocket disconnects          | Preserve session and permit reconnect recovery                                                |
| Excessive location rate        | Apply bounded rate limiting                                                                   |
| Suspicious location jump       | Reject or flag without corrupting navigation state                                            |
| Concurrent reroute             | Deduplicate and preserve one authoritative route revision                                     |
| Session already ended          | Reject further state mutations safely                                                         |

Never fabricate navigation state to conceal an infrastructure failure.

---

# API CONTRACTS

Implement or update the project's authoritative contracts for:

* navigation-session creation;
* navigation-session retrieval;
* navigation-session termination;
* current navigation state;
* location updates where HTTP fallback is supported;
* route revision;
* navigation errors.

Define:

* authentication;
* authorization;
* request;
* response;
* versioning;
* status values;
* error behavior.

---

# REALTIME CONTRACT ARTIFACTS

Create or update machine-readable documentation for:

* realtime message envelope;
* server-to-client message types;
* client-to-server message types;
* sequence numbers;
* acknowledgement behavior;
* heartbeat;
* reconnect;
* recovery;
* authorization.

Document protocol versioning.

Do not let client implementations infer the protocol from source code.

---

# TESTING — UNIT

Create meaningful unit tests for:

* navigation-state transitions;
* location validation;
* timestamp validation;
* speed plausibility;
* heading validation;
* duplicate detection;
* out-of-order detection;
* route-progress logic;
* maneuver advancement;
* off-route hysteresis;
* reroute throttling;
* ETA updates;
* traffic freshness;
* session expiration;
* concurrency/version checks;
* realtime message serialization.

---

# TESTING — NAVIGATION INTEGRATION

Use a real PostgreSQL/Redis/realtime test environment where available.

Validate:

* session creation;
* session persistence;
* session authorization;
* session termination;
* state updates;
* concurrent updates;
* reconnect recovery;
* location-event processing;
* rerouting integration;
* degraded routing;
* traffic fallback.

Do not replace the entire navigation subsystem with mocks.

---

# TESTING — REALTIME PROTOCOL

Test:

* authenticated connection;
* unauthorized session subscription;
* location messages;
* state messages;
* sequence numbers;
* duplicate messages;
* missed messages;
* reconnect;
* heartbeat;
* expired token;
* expired session;
* malformed message;
* connection closure.

Ensure private sessions cannot be accessed cross-user.

---

# TESTING — LOCATION PROCESSING

Test:

* valid GPS updates;
* invalid coordinates;
* poor accuracy;
* impossible jumps;
* stale timestamps;
* out-of-order events;
* duplicates;
* replayed events;
* excessive rates;
* wrong-session events.

Verify that invalid data cannot corrupt current navigation state.

---

# TESTING — NAVIGATION PROGRESSION

Use deterministic route fixtures to test:

* step entry;
* step completion;
* route progress;
* maneuver sequencing;
* GPS jitter;
* near-maneuver ambiguity;
* off-route detection;
* on-route recovery;
* rerouting.

Do not validate navigation progression using fabricated assertions detached from route geometry.

---

# TESTING — TRAFFIC

Test:

* fresh traffic;
* stale traffic;
* traffic expiration;
* traffic fallback;
* traffic-adjusted ETA;
* unavailable traffic;
* malformed traffic observation;
* duplicate observation.

Verify that stale traffic cannot appear as current.

---

# TESTING — FAILURE AND RESILIENCE

Test:

* Redis outage;
* PostgreSQL outage;
* routing-service outage;
* realtime disconnect;
* instance restart;
* concurrent reroute;
* message duplication;
* message reordering;
* malformed location events;
* excessive traffic.

Ensure recovery is deterministic and secure.

---

# TESTING — PERFORMANCE

Measure practical:

* location-processing latency;
* concurrent navigation sessions;
* WebSocket connection stability;
* state-update latency;
* reroute latency;
* CPU/memory per location update;
* Redis operations;
* PostgreSQL write behavior.

Use representative but bounded test loads.

Do not claim global-scale navigation capacity from a small local benchmark.

---

# DOCUMENTATION

Create or update documentation covering:

* navigation-session architecture;
* session lifecycle;
* durable versus ephemeral state;
* location-event contract;
* map matching;
* maneuver progression;
* off-route detection;
* rerouting;
* ETA;
* traffic freshness;
* realtime protocol;
* reconnect recovery;
* privacy;
* rate limits;
* security;
* observability;
* failure behavior;
* operational recovery;
* local development and testing.

Document actual implementation behavior only.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* routing;
* geographic/place data;
* traffic;
* event streams;
* queues;
* authentication;
* user/session platform.

## Web

The web client must be able to:

* create navigation sessions where supported;
* consume navigation state;
* receive realtime updates;
* reconnect;
* render route revisions;
* respond to session termination.

## Mobile

The mobile client must be able to:

* maintain authenticated realtime connections;
* send location updates;
* receive navigation state;
* recover after network loss;
* receive reroutes;
* handle session expiration.

## Infrastructure

Infrastructure must support:

* horizontally scaled realtime servers;
* sticky sessions only if actually required;
* shared state where needed;
* WebSocket load balancing;
* Redis where used;
* durable database state;
* observability.

## QA

QA must be able to validate:

* realtime protocol;
* navigation state;
* location processing;
* rerouting;
* traffic degradation;
* security;
* resilience;
* load behavior.

Do not introduce different navigation contracts for web and mobile.

---

# PORTABLE NAVIGATION CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* navigation-session schema;
* navigation-state schema;
* location-event schema;
* route-revision schema;
* realtime protocol;
* message envelope;
* session state machine;
* maneuver state model;
* off-route rules;
* reroute policy;
* traffic input contract;
* privacy rules;
* recovery behavior.

Document the authoritative location of each artifact.

---

# EXTERNAL TRAFFIC INTEGRATION

Where live traffic is consumed from an external provider:

* implement a typed adapter;
* normalize provider data;
* validate freshness;
* map provider segment identifiers to canonical road/segment identifiers;
* handle provider errors;
* enforce timeouts;
* apply bounded retries;
* record source metadata.

Do not fabricate provider responses.

If external traffic access is unavailable in the execution environment:

* implement the adapter boundary;
* create deterministic test fixtures;
* test normalization and failure behavior;
* report the external validation limitation.

---

# SECURITY REVIEW

Before completion, inspect for:

* WebSocket authentication bypass;
* cross-user session access;
* session-ID enumeration;
* location replay;
* location flooding;
* route hijacking;
* stale-state overwrite;
* malformed realtime messages;
* cache poisoning;
* Redis-state corruption;
* sensitive coordinate logging;
* provider credential leakage.

Server-side authorization must remain authoritative.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* inspect navigation state transitions;
* inspect realtime protocol;
* inspect location schema;
* inspect Redis keys;
* inspect database writes;
* inspect concurrency mechanisms;
* inspect rate limits;
* inspect security;
* inspect observability;
* inspect API contracts;
* inspect event contracts;
* run type checking;
* run linting;
* run formatting;
* run automated tests;
* inspect performance output;
* remove debug code;
* remove unused dependencies;
* verify no fake traffic or GPS data is being presented as production functionality;
* verify no unrelated product domain was implemented.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* navigation-session implementation;
* navigation-state implementation;
* route association;
* realtime transport;
* realtime authentication;
* realtime session binding;
* realtime message protocol;
* heartbeat/reconnect behavior;
* location-event ingestion;
* validation;
* deduplication;
* out-of-order handling;
* anomaly detection;
* privacy controls;
* map-matching integration;
* route-progress logic;
* maneuver progression;
* off-route detection;
* rerouting;
* reroute throttling;
* ETA updates;
* traffic integration;
* traffic freshness;
* traffic-ingestion foundation;
* Redis changes;
* database changes;
* events;
* queues;
* rate limits;
* security changes;
* observability changes;
* API contract changes;
* realtime contract changes;
* tests created;
* tests executed;
* resilience validation;
* performance validation;
* documentation changes;
* compatibility considerations;
* known limitations;
* unresolved external traffic/data dependencies.

The report must describe actual repository changes.

Do not claim that a mobile background-location implementation exists unless it was actually implemented.

Do not claim that live external traffic feeds are operational unless they were genuinely verified.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* navigation sessions are implemented as explicit domain resources;
* navigation lifecycle states are implemented;
* invalid lifecycle transitions are prevented;
* navigation sessions are authorized server-side;
* routes are associated with navigation sessions;
* navigation state is versioned;
* durable and ephemeral state are separated;
* realtime transport is implemented;
* realtime authentication is implemented;
* realtime session binding is enforced;
* realtime messages use a stable envelope;
* sequence numbers are implemented;
* heartbeat is implemented;
* reconnect recovery is implemented;
* location events are validated;
* location event IDs/sequence values prevent duplicates;
* out-of-order events cannot overwrite newer state;
* stale events cannot move navigation backward;
* impossible location jumps are detected;
* location rate limiting is implemented;
* location payloads are bounded;
* exact location data is protected;
* raw location retention is bounded;
* map matching is integrated through an explicit boundary;
* map-matching confidence is handled;
* route progress is computed;
* maneuver progression is implemented;
* GPS jitter does not cause unstable step changes;
* off-route detection uses bounded evidence;
* off-route hysteresis exists;
* rerouting is integrated with the routing service;
* rerouting is throttled;
* duplicate reroutes are controlled;
* reroute failures preserve the last valid route where possible;
* route revisions are explicit;
* ETA updates are implemented;
* traffic freshness is enforced;
* stale traffic cannot be represented as current;
* traffic fallback is implemented;
* traffic ingestion boundaries are implemented;
* traffic observations are normalized;
* private telemetry is separated from derived traffic data;
* Redis state is bounded;
* distributed coordination is safe where required;
* navigation events are versioned;
* background work is appropriately queued;
* critical realtime operations are not hidden behind long-running queues;
* failure behavior is deterministic;
* API contracts are implemented;
* realtime contracts are documented;
* unit tests exist;
* navigation integration tests exist;
* realtime protocol tests exist;
* location processing tests exist;
* progression tests exist;
* traffic tests exist;
* resilience tests exist;
* performance validation exists;
* security review is complete;
* privacy requirements are satisfied;
* operational documentation is current;
* portable navigation contracts exist;
* the final diff was inspected;
* there are no fake GPS or traffic implementations;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no credentials or external infrastructure were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement the complete web/mobile navigation experience, reviews, media, moderation, or production cloud infrastructure during this realtime navigation backend milestone.
