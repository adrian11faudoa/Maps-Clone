# Google Maps-Style Mapping & Navigation Platform — Mobile Prompt — Volume 2

# ROLE

Act as a senior mobile engineering team responsible for implementing the active-navigation, realtime-location, traffic-aware, and transit-capable mobile experience for a production-grade Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal Mobile Architect
* Senior React Native Engineers
* Senior TypeScript Engineers
* Mobile Geolocation Engineers
* Realtime/Distributed Systems Engineers
* Navigation UX Engineers
* Accessibility Engineers
* Mobile Security/Privacy Engineers
* Performance Engineers
* QA Engineers
* Reliability Engineers
* Technical Writers

You are implementing production software.

Do not produce pseudo-code, toy implementations, mock navigation systems, fake realtime servers, fake traffic data, placeholder navigation screens, hardcoded secrets, TODO/FIXME implementation gaps, or knowingly incomplete production paths.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Extend the mobile application into a production-grade active-navigation and realtime mobility experience.

The mobile application must support:

* active turn-by-turn navigation
* navigation-session lifecycle
* foreground location streaming
* route progress
* map matching integration
* maneuver presentation
* off-route detection
* rerouting
* realtime ETA
* traffic-aware route state
* navigation WebSocket/realtime integration
* reconnect and recovery
* voice guidance foundation
* navigation-safe background/locked-screen behavior where platform permissions and capabilities permit
* public-transit and multimodal route presentation using the canonical backend contracts
* degraded-network behavior
* strong privacy and battery controls

The implementation must integrate with the existing mobile foundation, canonical routing/navigation APIs, realtime contracts, transit contracts, location models, and map infrastructure.

Do not create parallel mobile-only semantics for routing, navigation, traffic, transit, location, or session state.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the production-grade active-navigation and realtime mobility layer.

## 1. Active Navigation Architecture

Create the mobile navigation subsystem required to transition from route results into an active navigation session.

Implement:

* navigation state machine
* navigation session creation
* navigation session attachment to a selected route
* navigation session identity
* navigation session lifecycle
* starting navigation
* pausing navigation where supported
* resuming navigation
* ending navigation
* navigation cancellation
* session recovery
* session expiration handling
* route version/state tracking
* synchronization between navigation UI and navigation backend state

Clearly distinguish:

* planned route
* active route
* current route progress
* current maneuver
* route state version
* current location
* navigation session state
* realtime connection state

Do not represent these as one mutable undifferentiated object.

---

## 2. Foreground Location Streaming

Extend the existing location foundation into controlled high-frequency foreground tracking for active navigation.

Implement:

* navigation-mode location updates
* platform-appropriate foreground location APIs
* configurable update intervals
* configurable distance filters
* accuracy-aware behavior
* timestamp validation
* stale-location rejection
* impossible-jump detection
* speed plausibility checks
* heading handling
* altitude handling where available
* location quality metadata
* temporary location unavailability
* recovery after provider interruption

The implementation must avoid unnecessarily high-frequency updates when navigation does not require them.

Location collection must be explicitly tied to navigation state.

When active navigation ends, stop navigation-specific high-frequency collection.

Do not create unrestricted continuous location collection outside the scope of an active navigation session.

---

## 3. Background and Screen-Locked Navigation Behavior

Implement the platform behavior required to continue essential navigation functionality when the application is backgrounded or the device screen is locked, subject to platform rules and user permissions.

Handle:

* background location authorization where legally and technically appropriate
* foreground-service requirements on Android where required
* iOS location background mode configuration where required
* screen locking
* app background transitions
* application suspension
* application restoration
* system termination and recovery behavior where platform capabilities permit

Do not silently request background permissions without explaining the navigation-related purpose to the user.

Do not collect background location before the user has explicitly entered an appropriate navigation flow and permission state.

Respect platform-specific privacy and battery policies.

---

## 4. Location Ingestion and Realtime Upload

Integrate mobile location updates with the canonical navigation realtime contract.

Implement:

* sequence numbers
* client timestamps
* server timestamps where supplied
* location payload validation
* request correlation
* batching where contractually appropriate
* upload acknowledgement
* duplicate prevention
* out-of-order handling
* retry behavior
* backpressure
* transient queueing
* connectivity-aware transmission
* safe recovery after process interruption

Do not upload indefinitely during complete network loss without bounds.

Define explicit limits for locally buffered navigation telemetry.

Protect against sending stale buffered locations after the navigation session has materially advanced.

---

## 5. Navigation WebSocket / Realtime Connection

Implement the mobile client for the canonical navigation realtime protocol.

Support:

* authenticated connection establishment
* protocol/version negotiation where defined
* navigation-session binding
* heartbeat
* ping/pong if required
* sequence tracking
* server acknowledgements
* server events
* client events
* connection state
* reconnect
* exponential backoff
* jitter
* connection timeout
* idle timeout
* graceful close
* authentication expiration
* session rebinding
* recovery after application lifecycle transitions

Prevent duplicate subscriptions.

Prevent simultaneous reconnect loops from multiple mobile components.

The realtime transport must be owned by an explicit navigation/realtime boundary rather than by individual screens.

---

## 6. Realtime State Synchronization

Integrate server-driven navigation state into mobile application state.

Support server updates for, where present in the canonical contract:

* route changes
* reroute commands/results
* maneuver changes
* traffic changes
* ETA changes
* incident information
* navigation warnings
* session state
* route-version updates

Implement conflict-safe handling when mobile and server state arrive out of order.

Do not allow an old realtime event to overwrite a newer route or session state.

Use explicit versioning or sequence semantics from the backend contract.

---

## 7. Map Matching Integration

Integrate the navigation client with the canonical map-matching/navigation service.

Support:

* raw location submission
* matched position response
* confidence/quality metadata
* snapped coordinate
* matched road/segment information where provided
* heading/direction alignment
* location uncertainty
* temporary map-match failures

Use the backend's canonical map-matching model.

Do not implement a full routing-engine-grade map matcher inside React Native.

Client-side interpolation may be used only for smooth rendering and must never replace authoritative server state.

---

## 8. Route Progress

Implement real-time progress along the active route.

Track:

* current route position
* completed route segments
* active leg
* current step
* current maneuver
* next maneuver
* remaining distance
* remaining duration
* current ETA
* route completion
* destination arrival state

Update route progress from validated navigation location data.

Prevent route progress from moving backward due to delayed or inaccurate location samples.

Handle tunnels, GPS gaps, and low-confidence positioning without visually jumping the user to an impossible position.

---

## 9. Maneuver Guidance

Implement the mobile turn-by-turn guidance surface.

Display, as supported by the canonical route-step contract:

* current maneuver
* maneuver icon
* maneuver instruction
* distance to maneuver
* estimated time to maneuver
* street/road name
* upcoming maneuver
* lane guidance where available
* roundabout guidance where available
* destination arrival guidance

Support appropriate formatting for:

* metric units
* imperial units
* localized road names
* localized instruction text
* right-to-left languages where supported by the application's localization architecture

Do not recreate routing instructions independently on the client.

Use the canonical maneuver semantics and localized data delivered by the routing/navigation system.

---

## 10. Camera Following and Navigation Map

Extend the map component into a navigation-specific map experience.

Support:

* user-position camera following
* automatic camera framing
* heading-aware camera
* route overview mode
* user-panned mode
* automatic recentering
* pitch adjustments
* navigation-focused zoom levels
* smooth camera transitions
* route rendering
* current-position marker
* upcoming route emphasis
* completed route de-emphasis
* navigation overlays
* traffic overlays when available through the current contract

Handle transitions cleanly between:

* free map exploration
* route overview
* active following
* user interaction
* recentering

Do not force camera-following while the user is intentionally inspecting the map.

---

## 11. Off-Route Detection

Implement production-grade off-route behavior using the canonical navigation state and location/matching information.

Handle:

* lateral deviation
* wrong-road detection
* direction reversal
* route deviation thresholds
* temporary GPS drift
* tunnels and dead zones
* false positive suppression
* confidence-aware off-route decisions

Do not trigger rerouting from one noisy sample.

Require appropriate evidence according to the available location and navigation quality metadata.

Expose a clear navigation state transition when the client determines that the user is likely off route.

---

## 12. Rerouting

Implement the client experience for dynamic rerouting.

Support:

* reroute request
* reroute loading
* route replacement
* alternative route handling
* reroute success
* reroute failure
* fallback to existing route state
* stale reroute response rejection
* user-visible route changes

Rerouting must remain compatible with the canonical routing backend.

Prevent multiple concurrent reroute requests from racing.

Use request/session/version identifiers to ensure an obsolete reroute result cannot replace a newer route.

Do not invent a local routing algorithm as a fallback.

---

## 13. ETA and Dynamic Traffic

Integrate navigation ETA and traffic state from the canonical backend.

Support:

* live ETA
* remaining duration
* traffic delay
* traffic state changes
* traffic freshness
* incident warnings where provided
* stale traffic indicators where necessary

Do not treat stale traffic data as current.

Clearly separate:

* route baseline duration
* traffic-adjusted duration
* current ETA
* traffic data freshness

Update UI only when state changes materially enough to avoid unnecessary rendering.

---

## 14. Navigation Alerts and Incidents

Display navigation-relevant alerts supported by the backend contract.

Possible alert classes include:

* traffic incidents
* closures
* hazards
* route restrictions
* navigation warnings
* road-condition alerts
* service disruptions affecting the route

Implement:

* severity presentation
* alert timing
* dismissal behavior where allowed
* expiration
* duplicate suppression
* accessibility announcements
* localization

Do not invent unsupported incident types or claim authoritative road information that is not present in the platform contracts.

---

## 15. Voice Guidance Foundation

Implement the production mobile architecture for spoken navigation instructions.

Support:

* text-to-speech integration
* maneuver announcements
* distance-based announcement timing
* repeated critical instructions
* announcement suppression
* audio focus
* volume/ducking behavior
* interruption handling
* resumption after interruption
* user preference state
* localization

Respect existing media/audio sessions.

Handle interruptions from:

* phone calls
* other media
* system notifications
* navigation lifecycle changes

Do not embed prerecorded route-specific audio files.

Use platform speech capabilities or an explicitly supported speech provider according to the platform architecture.

---

## 16. Navigation Audio Settings

Implement settings needed for the in-scope voice experience.

Support where applicable:

* voice guidance enabled/disabled
* guidance volume
* announcement behavior
* language/locale selection according to application localization capabilities
* muted-state indication
* test/preview behavior when supported

Persist settings through the established mobile preference system.

Do not store authentication secrets or sensitive location data in ordinary preferences.

---

## 17. Battery and Thermal Efficiency

Active navigation must be designed for long-running mobile sessions.

Optimize:

* location update rate
* GPS usage
* map rendering
* camera animation
* WebSocket activity
* network requests
* route progress calculations
* speech generation
* rendering frequency
* memory usage

Use adaptive behavior when GPS accuracy is poor or when navigation state changes.

Do not sacrifice navigation correctness merely to minimize battery use.

Where platform controls restrict behavior, expose the limitations in documentation.

---

## 18. Navigation Lifecycle and Device Lifecycle

Handle lifecycle transitions including:

* app foreground
* app background
* screen lock
* app restoration
* temporary process interruption
* permission changes
* connectivity changes
* audio interruption
* location-provider interruption

Navigation must recover gracefully from transient lifecycle events.

Do not assume that a mounted React component remains alive for the entire navigation journey.

Navigation state must live in a durable application-level boundary rather than only inside one screen component.

---

## 19. Public Transit Experience

Integrate the mobile application with the canonical public-transit APIs.

Support:

* transit route options
* transit journey summary
* transit legs
* walking segments
* transfers
* stations/stops
* departure times
* arrival times
* route/service identifiers
* accessibility information where available
* realtime service updates
* cancellations
* delays
* service alerts
* freshness state

Display transit journeys as structured multimodal paths.

Do not implement GTFS ingestion or transit data processing in the mobile application.

The mobile app consumes published backend results.

---

## 20. Multimodal Routing Experience

Support route presentation for combinations of supported travel modes, such as:

* walking
* driving
* cycling
* public transit

Where supported by the backend contract, render journeys containing multiple leg types.

Display:

* mode
* leg duration
* distance
* transfer/wait information
* station/stop information
* connection warnings
* accessibility metadata
* total journey duration
* estimated arrival

Do not locally calculate multimodal routing.

Do not silently convert one backend mode into another.

---

## 21. Realtime Transit Updates

Integrate realtime transit updates where supplied by the backend.

Handle:

* updated departure
* delay
* cancellation
* vehicle/status update where supported
* service alert
* stale feed state

Ensure stale realtime data cannot overwrite a newer journey state.

Make freshness visible when it materially affects decision-making.

---

## 22. Connectivity Degradation During Navigation

Navigation must remain as useful as reasonably possible under degraded connectivity.

Implement:

* cached active-route representation
* local retention of essential current route data
* bounded buffering of unsent navigation updates
* reconnect handling
* stale-data detection
* degraded-state UI
* recovery after reconnect
* preservation of active navigation state

The mobile application must not falsely claim live traffic or realtime synchronization while disconnected.

The current route should remain renderable from locally retained data as long as the available platform/runtime permits.

Do not implement full downloaded-map offline navigation in this prompt.

---

## 23. Security and Privacy During Navigation

Strengthen privacy protection for high-frequency location usage.

Implement:

* authenticated realtime sessions
* secure WebSocket connection
* session-bound location submission
* location-payload validation
* log redaction
* crash-report filtering
* analytics filtering
* secure local route/session state handling
* bounded telemetry retention
* secure background behavior
* permission state enforcement

Do not expose raw location traces through:

* debug logs
* analytics events
* exception metadata
* UI telemetry
* crash reports
* user-visible error messages

Do not retain navigation history locally beyond documented product requirements.

Ensure users can understand when navigation is actively using location.

---

## 24. Accessibility

Ensure active navigation is usable with accessibility technologies.

Support:

* screen-reader-safe maneuver announcements
* accessible route progress
* accessible ETA
* accessible alert presentation
* accessible controls
* semantic map controls
* logical focus
* dynamic text
* nonvisual status communication
* meaningful spoken instructions

Critical navigation information must not exist only as visual map overlays.

Where maps cannot provide equivalent semantics, expose an accessible textual/navigation representation.

---

## 25. Internationalization

Ensure this prompt's mobile features work with the existing localization infrastructure.

Support:

* localized navigation instructions
* unit formatting
* distance formatting
* duration formatting
* time formatting
* transit labels
* traffic labels
* RTL layout
* localized accessibility labels
* locale-aware speech guidance where supported

Do not hardcode language-specific routing semantics into the client.

---

## 26. State and Rendering Performance

Prevent navigation performance degradation over long sessions.

Pay particular attention to:

* continuous location updates
* route progress updates
* map camera changes
* WebSocket events
* traffic updates
* transit updates
* speech events
* React rendering frequency
* memory growth
* listener cleanup
* timer cleanup

Use selectors, memoization, throttling, batching, or equivalent techniques where justified.

Do not cause the entire application tree to rerender for every GPS sample.

---

## 27. Testing

Create comprehensive automated tests for active navigation and realtime behavior.

### Unit Tests

Cover:

* navigation state machine
* session lifecycle
* sequence validation
* location validation
* stale location handling
* impossible-jump detection
* route progress
* maneuver calculation/presentation logic
* off-route decision logic
* reroute coordination
* ETA state transitions
* connection state
* reconnect backoff
* event ordering
* traffic freshness
* transit freshness
* preference handling
* deep lifecycle transitions
* voice announcement scheduling

### Component Tests

Cover:

* active navigation screen
* maneuver card
* route-progress UI
* ETA display
* traffic indicators
* incident alerts
* voice settings
* reroute state
* reconnect state
* degraded-network state
* transit journey presentation
* multimodal journey presentation
* accessible navigation surfaces

### Integration Tests

Cover:

* route → start navigation
* navigation session creation
* location streaming
* realtime connection
* server route update
* route progress
* off-route detection
* reroute
* navigation completion
* authentication expiration
* temporary connectivity loss
* reconnect/recovery
* transit journey display
* realtime transit update
* app background/foreground transition
* audio interruption
* navigation restoration

### Long-Running Tests

Where the environment supports them, include scenarios simulating extended navigation sessions to detect:

* memory leaks
* duplicate listeners
* excessive battery-related polling
* runaway network requests
* unbounded local buffering
* stale subscriptions

---

## 28. Contract Validation

Validate the mobile navigation implementation against the canonical platform contracts.

Verify:

* navigation-session contract
* route-state/version contract
* location-event contract
* realtime WebSocket protocol
* sequence/acknowledgement semantics
* route progress model
* maneuver model
* reroute contract
* traffic model
* incident model
* transit journey model
* realtime transit model
* authentication/session contract
* error contract
* coordinate conventions
* timestamp semantics

Do not silently reinterpret backend events.

Any transformation performed for mobile presentation must be explicit and tested.

---

## 29. Documentation

Create or update documentation for:

* active-navigation architecture
* navigation state machine
* location streaming policy
* background location behavior
* WebSocket/realtime lifecycle
* reconnection strategy
* route progress
* off-route detection
* rerouting
* ETA/traffic handling
* voice guidance
* transit presentation
* multimodal journeys
* degraded connectivity
* battery/performance considerations
* privacy safeguards
* platform-specific behavior
* permissions
* testing strategy
* operational troubleshooting

Document actual behavior and limitations.

Do not document unsupported offline navigation as complete.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement the following:

* full downloaded offline-map system
* offline routing-engine execution
* offline map package management
* server-side routing engine
* routing graph generation
* server-side map matching
* traffic ingestion pipelines
* traffic prediction/ML
* transit feed ingestion
* GTFS/GTFS-Realtime processing
* backend navigation session service
* backend WebSocket service
* user reviews
* place contributions
* saved places/lists
* media uploads
* notification center
* moderation
* administration
* analytics dashboards
* cloud infrastructure
* Kubernetes changes unless required solely to consume an already-defined contract
* backend database changes unrelated to a blocking contract integration
* client-side route ranking algorithms
* autonomous route optimization independent of backend routing
* unsupported background tracking outside active-navigation requirements

Do not create fake functionality for any out-of-scope system.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect the existing mobile application structure.
2. Inspect the navigation architecture.
3. Inspect the existing map integration.
4. Inspect the location-permission and location service implementation.
5. Inspect the API client.
6. Inspect route and directions models.
7. Inspect existing authentication/session handling.
8. Inspect state-management infrastructure.
9. Inspect configuration and platform capabilities.
10. Inspect iOS location/background configuration.
11. Inspect Android location/foreground-service configuration.
12. Inspect available realtime client infrastructure.
13. Inspect backend navigation contracts.
14. Inspect backend route/reroute contracts.
15. Inspect traffic and incident contracts.
16. Inspect transit and multimodal contracts.
17. Inspect existing accessibility implementation.
18. Inspect testing infrastructure.
19. Inspect documentation relevant to the mobile navigation stack.

Reuse compatible infrastructure.

Do not assume previous AI conversations or hidden implementation history exist.

Resolve implementation conflicts using the repository and explicit portable contracts as sources of truth.

Do not replace working foundations unnecessarily.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real production code.
* Do not use pseudo-code.
* Do not use fake realtime servers in production code.
* Do not fabricate navigation events.
* Do not fabricate traffic or transit data.
* Do not hardcode secrets.
* Do not leave TODO/FIXME implementation gaps.
* Do not silently swallow realtime or navigation errors.
* Do not log raw location traces.
* Do not collect navigation location outside the justified lifecycle.
* Do not create duplicate WebSocket owners.
* Do not permit concurrent uncontrolled reconnect loops.
* Do not permit stale events to overwrite newer state.
* Do not permit obsolete reroute responses to replace current routes.
* Do not let noisy GPS samples cause immediate false reroutes.
* Do not perform unrestricted high-frequency network transmission.
* Do not leak location data into telemetry.
* Do not duplicate backend routing semantics.
* Keep navigation state independent from individual screen lifecycle.
* Clean up every native subscription, timer, listener, watcher, socket, and event handler.
* Respect platform permission requirements.
* Keep accessibility active throughout the navigation flow.
* Keep battery usage reasonable without sacrificing correctness.
* Test failure and recovery paths, not only successful navigation.
* Keep contracts explicit and typed.
* Keep platform-specific behavior documented.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Build the mobile application for supported targets.
* Run type checks.
* Run linting.
* Run all relevant unit tests.
* Run component tests.
* Run integration tests available in the environment.
* Validate navigation-session lifecycle.
* Validate foreground location streaming.
* Validate background/screen-lock behavior where the environment permits.
* Validate realtime connection establishment.
* Validate reconnect behavior.
* Validate route progress.
* Validate off-route detection.
* Validate rerouting.
* Validate ETA updates.
* Validate traffic/incident presentation.
* Validate voice guidance.
* Validate transit presentation.
* Validate multimodal presentation.
* Validate degraded-connectivity behavior.
* Validate lifecycle transitions.
* Validate accessibility.
* Validate memory/listener cleanup.
* Validate privacy-safe logs and telemetry.
* Validate no secrets are committed.
* Validate no fake production integrations remain.
* Validate that out-of-scope systems were not implemented as placeholders or simulations.

Resolve in-scope defects discovered during validation.

Do not claim platform verification that was not actually possible in the available environment.

---

# EXPECTED DELIVERABLES

Produce the actual implementation and supporting artifacts.

Expected deliverables include, as applicable:

* active-navigation state machine
* navigation-session client
* foreground location streaming implementation
* background/screen-lock navigation support
* realtime WebSocket client
* navigation event synchronization
* map-matching integration
* route-progress engine
* maneuver-guidance UI
* navigation map behavior
* off-route detection
* rerouting workflow
* traffic/incident integration
* ETA updates
* voice-guidance subsystem
* navigation audio settings
* transit journey presentation
* multimodal journey presentation
* realtime transit updates
* degraded-connectivity behavior
* security/privacy protections
* automated tests
* platform configuration
* documentation
* contract-validation artifacts where appropriate

Do not artificially split functionality into meaningless files.

---

# INTEGRATION REQUIREMENTS

The implementation must expose stable boundaries for future mobile features.

Future mobile work must be able to build on:

* navigation-session state
* location streaming
* realtime transport
* map navigation presentation
* voice-guidance infrastructure
* route-progress state
* transit journey models
* mobile lifecycle handling
* accessibility infrastructure
* privacy controls

Stable contracts must be maintained for:

* navigation-session identifiers
* route identifiers
* route versions
* location sequence numbers
* timestamps
* coordinates
* maneuver identifiers
* realtime event types
* acknowledgement semantics
* traffic freshness
* transit journey identity
* error semantics

Do not require future prompts to reverse-engineer these semantics from implementation details.

Document integration boundaries explicitly.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Active-navigation architecture implemented.
2. Navigation-session lifecycle implemented.
3. Foreground location streaming implemented.
4. Background/screen-lock navigation behavior implemented where supported.
5. Realtime WebSocket integration implemented.
6. Navigation state synchronization implemented.
7. Map-matching integration implemented.
8. Route progress implemented.
9. Maneuver guidance implemented.
10. Navigation camera behavior implemented.
11. Off-route detection implemented.
12. Rerouting implemented.
13. ETA/traffic/incident integration implemented.
14. Voice guidance implemented.
15. Transit journey presentation implemented.
16. Multimodal journey presentation implemented.
17. Realtime transit behavior implemented.
18. Degraded-connectivity behavior implemented.
19. Security/privacy protections completed.
20. Accessibility work completed.
21. Tests created and executed.
22. Validation commands executed and outcomes.
23. Documentation created or updated.
24. Important implementation decisions or deviations.
25. Environment/platform limitations encountered.
26. Exact files/modules/artifacts changed or created.

Do not claim work was completed unless it was actually implemented and validated.

---

# DEFINITION OF DONE

This prompt is complete only when:

* Active navigation can be started from a valid route.
* Navigation sessions have explicit lifecycle state.
* Foreground navigation location updates are collected and validated correctly.
* Background/screen-lock navigation behavior is implemented where supported by the target platforms and permissions.
* Location updates integrate with the canonical navigation backend.
* The realtime connection is authenticated, reconnectable, and lifecycle-safe.
* Stale or out-of-order realtime events cannot corrupt current navigation state.
* Route progress updates correctly.
* Maneuver guidance reflects the canonical route-step model.
* The navigation map follows the user appropriately while respecting manual map interaction.
* Off-route conditions are detected with false-positive protection.
* Rerouting uses the canonical routing service and is race-safe.
* ETA and traffic information are updated from authoritative backend state.
* Navigation incidents are presented appropriately.
* Voice guidance works through the supported mobile speech/audio architecture.
* Transit and multimodal journeys render from the canonical backend models.
* Realtime transit changes are handled safely.
* Degraded connectivity does not falsely represent unavailable realtime state.
* Battery, memory, and rendering behavior are appropriate for long-running sessions.
* Accessibility requirements are implemented across active navigation.
* Location privacy protections are enforced.
* Meaningful unit, component, integration, and long-running tests exist where supported.
* Static analysis and applicable builds pass.
* Documentation reflects the actual navigation implementation.
* No hardcoded secrets, fake production systems, placeholder implementations, TODO/FIXME gaps, or pseudo-code remain in scope.
* The resulting mobile navigation architecture is ready for the next mobile implementation volume without requiring replacement of the foundation.

**Implement only the current prompt's scope.**
