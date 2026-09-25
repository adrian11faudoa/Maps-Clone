# Google Maps-Style Mapping & Navigation Platform — Mobile Prompt — Volume 1

# ROLE

Act as a senior mobile engineering team responsible for implementing the mobile application foundation and core map-discovery experience for a production-grade Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal Mobile Architect
* Senior React Native Engineers
* Senior TypeScript Engineers
* Mobile UI/UX Engineers
* Mobile Geospatial/Mapping Engineers
* Mobile Security Engineers
* Mobile QA Engineers
* Accessibility Engineers
* Performance and Reliability Engineers
* Technical Writers

You are implementing software, not merely proposing architecture.

The resulting mobile application must be production-grade and suitable for a funded startup operating at significant scale.

Do not produce pseudo-code, toy implementations, mock backends, fake APIs, fake authentication, placeholder screens, hardcoded secrets, TODO/FIXME implementation gaps, or knowingly incomplete production paths.

Implement only functionality that belongs to this prompt's bounded scope.

---

# PROJECT

Build the mobile client foundation for a large-scale Google Maps-style mapping and navigation platform.

The mobile application must provide a coherent foundation for future navigation, realtime location, transit, saved places, user-generated content, notifications, and other platform capabilities.

The mobile client must communicate with real backend contracts rather than inventing parallel mobile-only semantics.

The implementation must be compatible with a production architecture using:

* React Native
* TypeScript
* A maintained mobile navigation/routing solution appropriate for React Native
* MapLibre-compatible native map rendering
* Secure device storage appropriate to the platform
* Native iOS and Android location and permission APIs
* The platform's established HTTP/JSON APIs
* WebSocket/realtime infrastructure where explicitly required by this prompt
* Shared backend contract semantics
* Production observability and error handling

Use native platform capabilities where they materially improve correctness, performance, permissions, location handling, accessibility, or reliability.

Do not substitute web-oriented assumptions for native mobile behavior.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the production-grade mobile application foundation and the first complete user-facing mapping/discovery workflow.

The implementation must cover the following areas.

## 1. Mobile Application Foundation

Create the React Native application structure required for a maintainable production mobile product.

Implement:

* iOS and Android application configuration
* TypeScript configuration
* environment/configuration loading
* development/staging/production configuration separation
* application bootstrap
* root providers
* dependency boundaries
* navigation architecture
* screen registration
* feature/module boundaries
* common hooks
* common utilities
* shared type definitions
* API infrastructure
* application-wide error handling
* logging abstraction
* analytics/telemetry abstraction
* accessibility foundations
* test infrastructure
* platform-specific extension points

Keep feature code organized so future prompts can add navigation, realtime, transit, notifications, account features, and user-generated content without requiring structural rewrites.

Do not duplicate backend domain rules unnecessarily in the mobile client.

Client-side validation may improve user experience, but backend validation remains authoritative.

---

## 2. Mobile Design System and UI Foundation

Build the foundational mobile design system needed by all current and future screens.

Implement reusable primitives for:

* typography
* spacing
* layout
* buttons
* icon buttons
* inputs
* search fields
* chips
* cards
* list rows
* bottom sheets
* modal surfaces
* loading states
* empty states
* inline errors
* banners
* snackbars/toasts
* separators
* badges
* tabs where required
* pull-to-refresh
* skeleton/loading placeholders
* confirmation dialogs

Support:

* light and dark appearance where the project configuration enables it
* safe-area handling
* platform conventions
* dynamic text sizing
* high text contrast
* touch-target sizing
* reduced-motion considerations
* screen-reader semantics
* keyboard behavior
* orientation changes where applicable

Do not introduce arbitrary styling conventions in individual screens when the shared design system can express the requirement.

---

## 3. Mobile Navigation Shell

Implement the application's primary navigation shell.

Provide a coherent structure for the initial product experience, including the major destinations needed by this prompt such as:

* map/home
* search/discovery
* directions
* account entry where appropriate

The navigation shell must support deep-link entry to map/place/directions experiences.

Implement:

* stack navigation
* tab or equivalent primary navigation where appropriate
* nested navigation boundaries
* route parameter validation
* back behavior
* state restoration where practical
* navigation-safe handling of authentication state
* deep-link parsing
* invalid/degraded deep-link behavior

Do not create screens for future functionality merely to fill navigation slots.

Navigation destinations outside this prompt's scope must not be represented as fake or nonfunctional features.

---

## 4. Authentication and Session Client Foundation

Implement the mobile client-side foundation for authenticated sessions.

Support the backend contract for:

* authentication initiation
* session establishment
* access-token usage
* refresh-token/session renewal where applicable
* logout
* session expiration
* unauthorized response handling
* protected request retry behavior
* device/session state
* account-aware application state

Use secure platform storage for sensitive credentials/tokens.

Never store credentials or long-lived authentication secrets in:

* source code
* plain application preferences when secure storage is required
* logs
* analytics payloads
* URLs
* crash reports
* debugging output

Implement robust behavior for:

* expired sessions
* revoked sessions
* refresh failures
* network interruption during refresh
* concurrent requests during token renewal
* logout while requests are in flight

Avoid multiple independent refresh operations racing against one another.

The backend remains authoritative for authentication and authorization.

---

## 5. API Client and Contract Integration

Create a production-grade mobile API client layer.

Implement:

* base API configuration
* request construction
* headers
* authentication integration
* request IDs/correlation metadata when supported
* timeout handling
* retry policy only for safe/retryable operations
* structured error parsing
* transport-error classification
* cancellation
* request deduplication where useful
* typed responses
* typed request models
* pagination handling where applicable
* API-version handling according to the available contract

The mobile client must consume the backend's canonical:

* identifiers
* timestamps
* coordinates
* distance units
* geometry formats
* error model
* pagination semantics
* authentication semantics

Do not create a second competing API contract.

Where a server-generated identifier is required, never fabricate an identifier format that conflicts with the platform contract.

Handle malformed or partially unexpected server responses safely.

---

## 6. Device Location Foundation

Implement the mobile location foundation required for map-centric workflows.

Support:

* permission state detection
* foreground location permission
* platform-appropriate permission requests
* permission-denied behavior
* permission-revoked behavior
* unavailable-location behavior
* current-location retrieval
* location accuracy metadata where provided
* location age/staleness handling
* user-controlled location display
* graceful behavior when device location services are disabled

Use platform-specific permission messaging and application configuration.

Do not request background location permissions in this prompt.

Do not continuously stream background location in this prompt.

The user must always receive an understandable explanation of why a foreground location permission is needed.

Do not expose precise location through analytics, logs, or crash telemetry unless explicitly required by a documented contract.

---

## 7. Native Map Experience

Implement the initial native interactive map experience using a MapLibre-compatible mobile renderer.

The map must support:

* map initialization
* configured map style
* vector tile rendering
* zoom
* pan
* rotation
* pitch where supported and appropriate
* current-location indicator
* location centering
* camera animation
* bounded camera behavior
* map loading state
* map rendering failure state
* map retry/recovery behavior

Integrate the application's canonical:

* tile service
* style configuration
* map coordinate conventions
* attribution requirements
* environment configuration

Do not embed undocumented external map infrastructure merely to make the screen appear functional.

Support map events needed by the current features without creating an excessive stream of client-side work.

Avoid unnecessary rerendering of the map component.

Keep map lifecycle management explicit so future prompts can add realtime navigation and traffic overlays without replacing the map architecture.

---

## 8. Search and Autocomplete Experience

Implement the mobile search experience against the production backend search contract.

Support:

* search entry
* autocomplete
* debounced requests
* cancellation of stale requests
* empty queries
* partial queries
* search results
* recent-result presentation only where supported by the current scope
* result selection
* loading state
* no-results state
* error state
* retry
* keyboard-aware UI
* result-to-map interaction

Results must support relevant canonical information such as:

* place identifier
* display name
* category/type
* formatted address
* coordinates
* optional distance
* relevant localization fields

Respect backend ranking and search semantics rather than attempting to recreate the server's ranking algorithm locally.

Prevent stale autocomplete responses from replacing newer query results.

Handle rapid typing and intermittent connectivity correctly.

---

## 9. Place Discovery and Place Details

Implement the mobile place discovery flow.

A user must be able to:

1. Search for a place.
2. Select a result.
3. View the selected place on the map.
4. Open a place details surface.
5. Inspect the canonical place information available from the backend.
6. Start a directions workflow from that place.

Support relevant fields defined by the backend contract, such as:

* place name
* category
* formatted address
* coordinates
* locality/region/country
* contact information where contractually available
* operating-hours information where available
* metadata needed by the client
* source/provenance information only where intended for the public client

Do not fabricate missing place fields.

Represent unavailable information explicitly rather than substituting misleading values.

---

## 10. Map Tapping and Coordinate Discovery

Implement the basic interaction required to inspect a map location.

Support:

* map tap handling
* selected coordinate state
* camera/map selection state
* coordinate display where appropriate
* reverse-geocoding initiation
* reverse-geocoding result presentation

Prevent accidental repeated requests caused by rapid taps or camera interactions.

Do not persist arbitrary user-selected coordinates as saved places in this prompt.

---

## 11. Geocoding and Reverse Geocoding Client Integration

Integrate the mobile application with canonical geocoding APIs.

Support:

* forward geocoding when required by the search/directions workflow
* reverse geocoding
* structured address presentation
* ambiguous-location handling
* no-result handling
* server-side validation/error handling
* request cancellation
* request deduplication where appropriate

Use canonical coordinates and address representations supplied by the backend.

Do not implement a client-side geocoder as a replacement for the backend service.

---

## 12. Directions Entry Workflow

Implement the mobile user experience for entering a directions request.

Support:

* origin
* destination
* selecting current device location
* selecting a searched place
* selecting a map coordinate
* origin/destination swapping
* travel-mode selection
* route request submission
* validation
* missing-origin/destination behavior
* loading state
* error state
* retry

The supported travel modes must correspond exactly to modes available through the backend routing contract.

Where the backend supports constraints or options relevant to the initial mobile workflow, represent them only when they belong to the agreed client contract.

Do not implement advanced active navigation in this prompt.

---

## 13. Basic Route Results

Implement the non-navigating route-results experience.

Display the backend's route response using its canonical route model.

Support:

* primary route
* alternative routes where provided
* route geometry rendering
* route selection
* total distance
* total duration
* ETA when provided
* route legs
* route steps
* maneuver summaries
* warnings
* traffic information where already included by the backend contract

Render route geometry accurately on the map.

Provide a route-result state that can later transition into active navigation without requiring a replacement of the directions architecture.

Do not implement turn-by-turn active navigation in this prompt.

Do not continuously track location for route progress in this prompt.

Do not implement automatic rerouting in this prompt.

---

## 14. Mobile State Management

Implement a maintainable state architecture for:

* authentication/session state
* app configuration
* location permission/device state
* map state
* search state
* place selection state
* directions input
* route result state
* UI state
* loading/error states

Clearly separate:

* server state
* persistent client state
* ephemeral screen state
* platform/device state

Avoid storing large server datasets redundantly in global state.

Avoid unnecessary synchronization between duplicated state representations.

Implement invalidation/refetch behavior where server state changes.

---

## 15. Connectivity and Degraded-State Handling

Implement baseline resilience for unreliable mobile networks.

Support:

* offline detection
* request failure classification
* retryable network failures
* user-visible degraded states
* reconnect behavior for appropriate requests
* preservation of unsent local UI input
* graceful map/search failure states
* cancellation when navigating away from requests

Do not claim that maps, routing, or navigation are fully offline-capable in this prompt.

Create the client architecture so a future offline/navigation prompt can add offline packages, cached routes, downloaded map regions, and synchronization without redesigning the entire application.

---

## 16. Deep Links and Shareable Locations

Implement deep-link support for production-safe navigation into relevant current features.

At minimum, support deep links representing:

* a place
* a coordinate/map location
* a directions request where contractually supported

Validate all incoming parameters.

Handle:

* malformed links
* missing identifiers
* unavailable places
* unsupported routes
* unauthorized destinations
* expired/invalid parameters

Never trust deep-link parameters as authenticated or authorized data.

Use canonical backend lookups after parsing.

---

## 17. Accessibility

All mobile screens delivered in this prompt must be accessible.

Implement:

* semantic labels
* accessible role information
* screen-reader ordering
* meaningful focus behavior
* accessible map controls
* accessible search controls
* accessible loading/error announcements where appropriate
* sufficient touch target dimensions
* dynamic text support
* contrast-safe UI
* non-color-only status indicators
* accessible alternatives for critical map-driven interactions

For inherently visual map interactions, provide usable non-map UI alternatives for critical information where appropriate.

Do not mark decorative elements as interactive.

---

## 18. Security and Privacy

Apply mobile security and privacy practices throughout this implementation.

Protect:

* authentication tokens
* user session data
* device identifiers
* precise location data
* API credentials
* diagnostic information

Implement:

* secure storage
* transport security
* certificate/transport configuration consistent with the environment
* log redaction
* crash-report redaction
* analytics filtering
* privacy-safe request metadata
* no secrets committed to source control
* no sensitive data embedded in static configuration
* safe handling of screenshots/backgrounding for sensitive surfaces where appropriate

Never log:

* access tokens
* refresh tokens
* passwords
* authorization headers
* private user content
* precise location unless explicitly required and protected by contract

Document any platform-specific security assumptions.

---

## 19. Performance

Optimize for real mobile hardware rather than desktop-class development environments.

Pay particular attention to:

* map initialization
* map frame performance
* excessive React renders
* list rendering
* autocomplete frequency
* large route geometries
* image/icon loading
* state update frequency
* location update handling
* navigation transitions
* memory retention
* startup time

Use profiling-compatible instrumentation where appropriate.

Avoid premature complexity while ensuring the architecture remains scalable.

---

## 20. Error and Empty-State UX

Every currently implemented user workflow must have intentional states for:

* initial
* loading
* success
* empty
* validation failure
* permission denied
* unauthorized
* not found
* unavailable
* network failure
* timeout
* server failure
* retry

Do not leave screens blank when an error occurs.

Use messages appropriate to the user's action and avoid exposing internal stack traces or infrastructure details.

---

## 21. Testing

Create a meaningful automated test suite for the functionality implemented in this prompt.

Include appropriate coverage for:

### Unit Tests

Test:

* API client behavior
* error normalization
* authentication/session logic
* token refresh coordination
* deep-link parsing
* location state handling
* search debouncing/cancellation
* route input validation
* state transformations
* coordinate-related client utilities
* formatting utilities

### Component Tests

Test:

* search UI
* autocomplete results
* place details surfaces
* permission states
* directions entry
* route result presentation
* error and empty states
* accessibility semantics
* navigation transitions where practical

### Integration Tests

Test key flows such as:

* application startup
* authentication/session restoration
* location permission flow
* search → place details
* place → directions
* map selection → reverse geocoding
* directions → route results
* expired authentication behavior
* transient network failure/retry

Use real contract-shaped fixtures or contract-generated representations.

Do not use fake implementations of the production architecture merely to make tests pass.

Where external services must be isolated during tests, use explicit deterministic test doubles whose interface matches the real contract.

---

## 22. Contract Validation

Validate the mobile implementation against the canonical backend interfaces available to the project.

Verify:

* endpoint paths
* request schemas
* response schemas
* enums
* identifiers
* timestamp formats
* coordinate conventions
* geometry conventions
* error codes
* pagination semantics
* authentication behavior
* route models
* place models
* search models

Detect mismatches early.

Do not silently coerce incompatible contracts unless the transformation is explicit, documented, tested, and required for native presentation.

---

## 23. Documentation

Document the mobile implementation sufficiently for another senior engineer to operate and extend it.

Create or update appropriate documentation covering:

* mobile application structure
* feature/module boundaries
* environment configuration
* iOS configuration
* Android configuration
* secure storage choices
* permission behavior
* navigation architecture
* map integration
* API client architecture
* state-management conventions
* deep-link behavior
* testing strategy
* accessibility conventions
* privacy/security behavior
* local development
* build/run instructions
* troubleshooting
* known platform limitations within this prompt's scope

Documentation must describe actual implemented behavior.

Do not document hypothetical functionality as completed.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement the following in this prompt:

* active turn-by-turn navigation
* continuous navigation-session location streaming
* background location tracking
* off-route detection
* automatic rerouting
* navigation voice guidance
* navigation-specific WebSocket sessions
* advanced realtime navigation synchronization
* downloadable offline maps
* offline route calculation
* offline navigation
* traffic ingestion
* traffic prediction
* live traffic overlays requiring future realtime infrastructure
* public-transit backend or mobile transit implementation beyond what is strictly required for a placeholder-free architectural handoff
* advanced multimodal journey planning
* saved places/lists implementation
* user reviews
* ratings
* user contributions
* photo/media uploads
* notification center
* push-notification infrastructure
* moderation interfaces
* administrative interfaces
* analytics dashboards
* backend implementation
* routing-engine implementation
* geospatial database implementation
* search-index implementation
* vector-tile generation pipeline
* cloud infrastructure
* Kubernetes deployment
* production CI/CD infrastructure
* advanced ML or ranking models

Do not create fake screens or pretend implementations for out-of-scope functionality.

Only establish clean extension points where required by the current architecture.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect the repository structure.
2. Identify whether a React Native application already exists.
3. Identify the existing TypeScript configuration.
4. Inspect package management and build tooling.
5. Inspect iOS and Android project configuration.
6. Inspect existing navigation and state-management code.
7. Inspect existing API clients and generated types.
8. Inspect existing configuration and environment handling.
9. Inspect available design-system/shared UI components.
10. Inspect tests and test infrastructure.
11. Inspect existing map-related implementation.
12. Inspect existing documentation.
13. Inspect relevant backend-facing contracts already present in the repository.

Reuse compatible existing infrastructure rather than unnecessarily replacing it.

Where the repository contains conflicting implementations, resolve the conflict according to the project's canonical contract and production requirements.

Do not delete working functionality merely to impose a preferred structure.

Do not assume any previous AI conversation, prior prompt, hidden context, or unshared artifact exists.

The repository and explicit contract artifacts available in the current working environment are the sources of implementation truth.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real production code.
* Do not use pseudo-code.
* Do not use fake APIs.
* Do not use fake authentication.
* Do not use fake persistence as a substitute for the real contract.
* Do not introduce hardcoded secrets.
* Do not leave TODO/FIXME implementation gaps.
* Do not silently disable failing security behavior.
* Do not bypass type safety without a documented, justified boundary.
* Do not duplicate domain logic unnecessarily.
* Do not create undocumented client-only contracts.
* Do not implement future-scope features merely because they are adjacent.
* Preserve clean module boundaries.
* Prefer explicit error handling.
* Prefer deterministic behavior.
* Make platform-specific behavior explicit.
* Keep accessibility enabled by default.
* Treat privacy as a functional requirement.
* Keep telemetry privacy-safe.
* Keep sensitive data out of logs.
* Ensure all network calls are cancellable where practical.
* Prevent stale asynchronous responses from corrupting current UI state.
* Ensure authentication refresh is race-safe.
* Ensure location permission handling is platform-correct.
* Avoid memory leaks from subscriptions/listeners.
* Clean up timers, watchers, map listeners, navigation listeners, and asynchronous resources.
* Ensure tests cover meaningful failure paths, not only happy paths.
* Keep dependencies current and justified according to the repository's dependency policy.
* Do not introduce a large third-party dependency for functionality reasonably provided by the existing stack without documenting the reason.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Build the mobile application for the supported development targets.
* Run static type checks.
* Run linting.
* Run unit tests.
* Run component tests.
* Run integration tests that can execute in the available environment.
* Validate iOS configuration where the environment supports it.
* Validate Android configuration where the environment supports it.
* Validate deep-link configuration.
* Validate secure-storage behavior.
* Validate location permission behavior.
* Validate map rendering.
* Validate API error handling.
* Validate search cancellation/debouncing.
* Validate directions and route rendering.
* Validate accessibility semantics.
* Validate error and empty states.
* Validate that no secret material has been committed.
* Validate that no sensitive data is emitted through ordinary logging or telemetry.
* Validate that the implementation does not silently depend on undocumented external services.
* Validate that out-of-scope functionality has not been implemented as fake behavior.

Resolve implementation defects discovered during validation when they fall within this prompt's scope.

---

# EXPECTED DELIVERABLES

Produce the actual implementation and all necessary supporting artifacts.

Expected deliverables include, as applicable to the existing repository:

* React Native mobile application structure
* mobile navigation system
* shared mobile UI/design-system primitives
* authentication/session client infrastructure
* secure token/session storage
* API client and typed contract integration
* location-permission and foreground-location foundation
* MapLibre-compatible native map integration
* search/autocomplete screens and state
* place details experience
* coordinate/reverse-geocoding workflow
* directions-entry experience
* route-result experience
* deep-link handling
* accessibility implementation
* mobile telemetry/error-handling foundations
* automated tests
* build/test configuration
* platform configuration
* documentation
* contract validation artifacts where appropriate

Keep the implementation cohesive and avoid artificial file fragmentation.

---

# INTEGRATION REQUIREMENTS

The implementation must provide clean integration points for future mobile work.

Future functionality must be able to consume the current mobile foundation without replacing:

* authentication/session infrastructure
* navigation infrastructure
* map infrastructure
* API client
* location permission model
* design system
* state-management boundaries
* deep-link architecture
* observability foundation

Use stable contracts for:

* identifiers
* coordinate order
* timestamps
* API errors
* route data
* place data
* search results
* session state
* location state

Where a boundary is likely to be consumed by another implementation area, document it clearly.

Do not rely on knowledge held only in code comments or developer memory.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Mobile foundation implemented.
2. Navigation architecture implemented.
3. Authentication/session client implemented.
4. API/client contract integration implemented.
5. Location permission and foreground-location foundation implemented.
6. Native map experience implemented.
7. Search/autocomplete implemented.
8. Place details implemented.
9. Geocoding/reverse-geocoding integration implemented.
10. Directions entry implemented.
11. Route-results experience implemented.
12. Deep-link behavior implemented.
13. Accessibility work completed.
14. Security/privacy protections completed.
15. Tests created and executed.
16. Validation commands executed and their outcomes.
17. Documentation created or updated.
18. Important implementation decisions or deviations.
19. Any environment limitations encountered.
20. Exact files/modules/artifacts changed or created.

Do not claim a test, build, validation step, or platform verification was completed unless it was actually executed.

---

# DEFINITION OF DONE

This prompt is complete only when:

* The mobile application foundation is implemented with production-quality structure.
* The current mobile navigation shell is functional.
* Authentication/session behavior is real and secure.
* API communication uses typed, contract-aligned interfaces.
* Foreground device-location permissions and location acquisition work correctly.
* The native map is functional with the canonical map/tile configuration.
* Search/autocomplete is functional and resilient to rapid input and stale responses.
* Place discovery and place details are functional.
* Forward/reverse geocoding integration is functional where required by the implemented workflows.
* Directions entry is functional.
* Route results are rendered from the real route contract.
* Deep links are validated and functional for the supported flows.
* Accessibility requirements are implemented across all in-scope screens.
* Privacy and security protections are present.
* Meaningful unit, component, and integration tests exist.
* Static analysis and applicable builds pass.
* Error, empty, permission, and degraded-network states are intentionally handled.
* Documentation reflects the actual implementation.
* No hardcoded secrets exist.
* No fake APIs, fake authentication, placeholder production paths, TODO/FIXME gaps, or pseudo-code remain in the in-scope implementation.
* The resulting structure is ready for subsequent mobile implementation work without requiring architectural replacement.

**Implement only the current prompt's scope.**
