# Google Maps-Style Mapping & Navigation Platform — Frontend Prompt — Volume 1

# ROLE

You are the senior frontend engineering agent responsible for implementing the **production web application foundation, application shell, authentication experience, map interface foundation, search experience foundation, place-discovery experience, and directions-entry experience** for a production-grade **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary frontend engineering organization consisting of:

* Principal Frontend Engineer
* Staff React Engineer
* Next.js Engineer
* UI Systems Engineer
* Map Rendering Engineer
* Accessibility Engineer
* Performance Engineer
* Security Engineer
* State-Management Engineer
* API Integration Engineer
* Realtime Client Engineer
* QA Engineer
* Technical Writer
* UX Engineer

The objective is to implement a real production web client foundation that consumes the platform's backend contracts and provides a coherent, accessible, responsive mapping experience.

This prompt defines a bounded frontend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed web application is intended to provide:

* interactive maps;
* current-location display;
* place search;
* autocomplete;
* place details;
* nearby discovery;
* address/geocoding workflows;
* route planning;
* route alternatives;
* turn-by-turn navigation support where the browser platform permits it;
* traffic visualization where supported;
* transit directions;
* saved places;
* user contributions;
* reviews and ratings;
* media;
* notifications;
* account management;
* moderation/admin interfaces where authorized.

This milestone establishes the production web application foundation and first major user-facing map/search experience.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* Next.js web application foundation;
* TypeScript application structure;
* route architecture;
* application shell;
* responsive layout;
* global navigation;
* design-system foundation;
* typography and spacing tokens;
* reusable UI primitives;
* accessibility foundation;
* error boundary strategy;
* loading and skeleton-state strategy;
* authentication client foundation;
* session restoration;
* logout;
* route protection;
* user-menu/account foundation;
* API client layer;
* typed API contracts;
* request/cancellation handling;
* API error normalization;
* frontend telemetry foundation;
* map rendering foundation;
* MapLibre-compatible map integration;
* map viewport state;
* zoom/pan interactions;
* current-location control;
* map controls;
* map-style loading;
* vector-tile consumption;
* tile error handling;
* search interface;
* autocomplete interface;
* search-result display;
* nearby-search experience;
* place-details panel/page;
* place selection and map synchronization;
* URL/deep-link representation of searchable locations;
* directions-entry interface;
* origin/destination selection;
* travel-mode selection foundation;
* route-request integration foundation;
* responsive mobile-web behavior;
* client-side caching where justified;
* accessibility testing;
* component tests;
* integration tests;
* API contract tests;
* map interaction tests;
* performance validation;
* security checks;
* documentation.

The backend remains authoritative for authentication, places, search, geocoding, routes, permissions, and protected data.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains during this milestone.

The following are explicitly outside the current scope:

* complete browser turn-by-turn navigation;
* continuous realtime navigation protocol implementation;
* complete traffic visualization;
* full transit experience;
* saved-place management UI;
* reviews UI;
* contribution UI;
* media upload UI;
* notification center UI;
* moderation UI;
* administration UI;
* complete mobile application;
* production infrastructure provisioning;
* backend implementation;
* routing-engine implementation;
* search-engine implementation;
* map-tile generation;
* analytics dashboards.

This milestone may create interfaces and extension points for those capabilities.

Do not fabricate backend responses to make future functionality appear implemented.

---

# REPOSITORY INSPECTION

Inspect the repository before making changes.

Determine:

* current web application structure;
* Next.js version;
* React version;
* TypeScript configuration;
* package manager;
* existing UI framework;
* existing CSS strategy;
* existing design system;
* existing route structure;
* existing authentication client;
* existing API client;
* existing OpenAPI-generated types;
* existing map integration;
* MapLibre or compatible renderer;
* state-management libraries;
* server-state/caching libraries;
* realtime client infrastructure;
* tests;
* linting;
* formatting;
* accessibility tooling;
* analytics/telemetry;
* environment configuration;
* existing documentation.

Treat the repository's actual state as authoritative.

Do not assume previous AI conversations were executed.

Preserve compatible existing code.

Do not replace an existing production-worthy design system unnecessarily.

Do not introduce a second frontend framework.

---

# FRONTEND TECHNOLOGY CONTEXT

Use the established project technology direction:

* TypeScript;
* React;
* Next.js;
* MapLibre-compatible map rendering;
* an established server-state library where appropriate;
* a predictable client-state model;
* semantic HTML;
* accessible UI primitives.

Prefer repository-established dependencies when compatible.

Do not add libraries merely because they are fashionable.

---

# APPLICATION ARCHITECTURE

Establish a maintainable frontend architecture separating:

* application shell;
* routes;
* map rendering;
* search;
* places;
* directions;
* authentication;
* user/account state;
* API integration;
* server state;
* client UI state;
* design-system components;
* telemetry;
* accessibility utilities.

Do not put business logic directly into large page components.

Use reusable domain-oriented components.

Avoid excessive abstraction that makes UI behavior difficult to trace.

---

# NEXT.JS ARCHITECTURE

Implement the repository's selected Next.js architecture consistently.

Where the project uses the App Router, establish appropriate separation between:

* server components;
* client components;
* route handlers only where a web-specific server boundary is genuinely required;
* shared UI;
* browser-only map functionality.

Map rendering must remain browser-compatible and must not cause server-rendering failures.

Do not expose secrets through client bundles.

---

# APPLICATION ROUTES

Establish routes sufficient for this milestone.

At minimum evaluate:

* home/map;
* search results;
* place details;
* directions entry;
* authenticated account state.

Routes must support stable deep links.

Do not create empty placeholder routes for future features.

---

# URL STATE

Use URL state where it materially improves:

* shareability;
* back/forward behavior;
* deep linking;
* search reproducibility.

Search-related URL state may include:

* query;
* selected place;
* map viewport where appropriate;
* origin;
* destination;
* travel mode.

Do not encode excessive transient UI state in the URL.

---

# DESIGN SYSTEM FOUNDATION

Implement reusable design primitives appropriate to the platform.

Establish:

* color tokens;
* typography;
* spacing;
* radii;
* elevation;
* focus states;
* motion conventions;
* icon sizing;
* responsive breakpoints.

The exact visual design must be original and must not reproduce Google's proprietary visual assets or branded UI.

Build accessible components for:

* buttons;
* icon buttons;
* inputs;
* text fields;
* dialogs;
* popovers;
* menus;
* tabs;
* cards;
* lists;
* badges;
* tooltips;
* drawers;
* panels.

---

# ACCESSIBILITY FOUNDATION

Implement accessibility as a core requirement.

Support:

* semantic HTML;
* keyboard navigation;
* visible focus;
* screen-reader labels;
* accessible dialogs;
* focus trapping where appropriate;
* escape behavior;
* reduced-motion preferences;
* status announcements;
* accessible form errors;
* sufficient target sizes.

Do not use inaccessible clickable `div` elements where semantic controls are appropriate.

---

# RESPONSIVE ARCHITECTURE

The map application must support:

* desktop;
* tablet;
* mobile browser widths.

The layout must adapt without duplicating the entire application.

Evaluate:

* side panel;
* bottom sheet;
* responsive search controls;
* map/full-panel transitions;
* touch interactions.

Do not assume desktop screen dimensions.

---

# APPLICATION SHELL

Implement the main application shell including:

* top-level navigation;
* search entry;
* account controls;
* map viewport;
* contextual side/bottom panel;
* global status area.

The shell must support future expansion without redesigning the entire page structure.

---

# MAP FOUNDATION

Implement MapLibre-compatible map rendering.

Support:

* map initialization;
* style loading;
* vector-tile source configuration;
* initial viewport;
* pan;
* zoom;
* rotation where supported and appropriate;
* resize handling;
* control placement;
* style errors;
* tile failures;
* loading states.

Do not implement custom map rendering from scratch.

---

# MAP VIEWPORT STATE

Define a stable frontend viewport model containing, as applicable:

* latitude;
* longitude;
* zoom;
* bearing;
* pitch;
* viewport bounds.

Synchronize viewport state carefully.

Do not update application state on every animation frame unless the UI requires it.

Throttle high-frequency viewport updates.

---

# MAP STYLE

Consume the authoritative map-style contract.

Support:

* style loading;
* style version;
* tile source version;
* attribution.

Do not hardcode production tile endpoints into reusable components.

Use environment-driven configuration where appropriate.

---

# MAP CONTROLS

Implement appropriate map controls such as:

* zoom in;
* zoom out;
* reset orientation;
* current location;
* recenter;
* fullscreen where supported.

Controls must be accessible by keyboard and screen reader.

Do not overload the map with unnecessary controls.

---

# CURRENT LOCATION

Implement browser-based current-location support where permission is granted.

Handle:

* permission granted;
* permission denied;
* permission prompt;
* unsupported browser;
* timeout;
* unavailable position;
* low accuracy.

The browser's geolocation API is an untrusted input.

Do not transmit continuous location to the backend during this milestone.

---

# LOCATION PRIVACY

Current-location data must remain local unless explicitly required by a backend API in this milestone.

Do not:

* persist location history;
* send exact location to analytics by default;
* place exact coordinates in logs;
* encode precise location into shareable URLs without explicit user action.

---

# SEARCH EXPERIENCE

Implement the primary search interaction.

Support:

* search input;
* submit;
* clear;
* loading state;
* error state;
* empty state;
* result rendering;
* result selection;
* map synchronization.

The UI must consume the backend search contract rather than implement client-side search logic independently.

---

# AUTOCOMPLETE

Implement autocomplete interaction.

Support:

* debounced requests;
* cancellation of superseded requests;
* keyboard navigation;
* pointer selection;
* highlighted matches where provided;
* result limit;
* loading state;
* empty state;
* error recovery.

Do not send a request for every keystroke without debounce/cancellation.

Do not expose raw backend search-engine functionality to the client.

---

# AUTOCOMPLETE REQUEST CONTROL

Implement:

* minimum query length;
* maximum query length;
* debounce;
* request cancellation;
* stale-response rejection.

A slower response from an older query must never replace the current query's results.

---

# SEARCH SESSION STATE

Where the backend contract supplies a search/autocomplete session token:

* create it appropriately;
* retain it only for the intended session;
* do not use it as authentication;
* do not expose it in analytics unnecessarily.

---

# SEARCH RESULTS

Render search results with enough contextual information to distinguish locations.

Support:

* name;
* category;
* address;
* distance where provided;
* geographic context;
* relevant secondary information.

Do not display internal search-ranking scores.

---

# SEARCH RESULT INTERACTION

When a result is selected:

* center or fit the map appropriately;
* show a selected-place state;
* open the place-details panel;
* update URL state when appropriate;
* preserve back/forward behavior.

Do not force unnecessary full-page navigations for map-centric selection.

---

# NEARBY SEARCH

Provide a UI path for nearby discovery.

Use the map viewport or explicitly selected location as context.

Bound requests.

Do not continuously query nearby results while the user pans unless the product interaction explicitly requires it.

Provide controlled refresh behavior.

---

# SEARCH ERROR STATES

Distinguish:

* validation errors;
* rate limiting;
* backend unavailable;
* empty results;
* network failure.

Do not show technical stack traces.

Provide accessible and actionable retry behavior.

---

# PLACE DETAILS

Implement a place-details panel/page consuming the canonical Place API.

Display appropriate:

* name;
* category;
* address;
* coordinates through map presentation;
* contact information where available;
* opening hours where provided;
* attribution/source information where required.

Do not display unavailable future review/media information as fake placeholders.

---

# PLACE-MAP SYNCHRONIZATION

Place selection must synchronize with the map.

Support:

* selected-marker state;
* map centering;
* viewport adjustment;
* panel opening;
* deselection;
* deep links.

Do not create multiple competing sources of truth for selected place state.

---

# DEEP LINKING

A place can be represented through a stable URL.

The URL must use a public place identifier or another canonical public representation rather than internal database IDs.

Opening a place URL should:

* load the place;
* position the map;
* open the details experience;
* handle deleted/merged/not-found cases.

---

# PLACE NOT-FOUND

Handle:

* nonexistent place;
* deleted place;
* merged/superseded place;
* unavailable backend.

Do not fabricate a place from URL parameters.

---

# GEOCODING UI

Implement the frontend foundation for address/geocoding workflows.

Where the backend supports forward and reverse geocoding:

* allow users to enter an address;
* display candidate results;
* select a candidate;
* update the map;
* preserve precision semantics.

Do not display approximate results as exact addresses.

---

# DIRECTIONS ENTRY

Implement the initial directions experience.

Support:

* origin field;
* destination field;
* swap origin/destination;
* place selection;
* current-location origin where permitted;
* travel-mode selection;
* submit;
* loading;
* validation;
* routing errors.

Do not implement full turn-by-turn navigation UI during this milestone.

---

# TRAVEL MODES

Expose only the routing modes that the backend currently advertises as supported.

Potential modes include:

* driving;
* walking;
* cycling;
* transit.

Do not display unsupported modes merely because the UI has a generic icon.

---

# ROUTE REQUEST STATE

Represent route-request lifecycle explicitly:

* idle;
* loading;
* success;
* empty/no route;
* error.

Prevent duplicate submissions where practical.

Cancel superseded route requests.

---

# ROUTE RESULT FOUNDATION

Render the basic route result structure returned by the backend.

Support:

* primary route;
* alternatives;
* total distance;
* total duration;
* ETA where provided;
* warnings;
* route geometry.

Do not implement turn-by-turn navigation panels yet.

---

# ROUTE MAP RENDERING

Render route geometry on the map.

Support:

* route line;
* alternative routes;
* selected route;
* viewport fitting;
* origin marker;
* destination marker;
* waypoint markers where applicable.

Route rendering must remain separate from map-tile rendering.

Do not mutate route geometry on the client.

---

# ROUTE ALTERNATIVES

Allow users to select among route alternatives when the backend provides them.

Selection must:

* update visual emphasis;
* update summary information;
* preserve route contract;
* avoid triggering a redundant route calculation unless necessary.

---

# ROUTE ERROR HANDLING

Handle:

* invalid input;
* unsupported mode;
* no route;
* routing unavailable;
* timeout;
* traffic unavailable;
* rate limited;
* network error.

Do not silently fall back to fake routes.

---

# API CLIENT

Implement a typed API client layer.

It must provide:

* centralized base URL configuration;
* authentication handling;
* request IDs/correlation where required;
* JSON parsing;
* schema validation where appropriate;
* error normalization;
* timeout/cancellation;
* retry only for safe operations;
* credentials handling.

Do not duplicate HTTP logic across components.

---

# AUTHENTICATION CLIENT

Integrate the backend authentication contract.

Support:

* login state;
* session restoration;
* logout;
* token refresh according to the backend contract;
* protected requests.

Do not store sensitive tokens in insecure browser storage when the project's authentication architecture uses secure HTTP-only cookies.

The final storage behavior must match the backend security contract.

---

# SESSION EXPIRATION

Handle:

* access-token expiration;
* refresh failure;
* revoked session;
* logout elsewhere.

When authentication becomes invalid:

* update client state;
* protect private routes;
* avoid endless refresh loops.

---

# AUTHENTICATED ROUTES

Protect only routes that genuinely require authentication.

Public map/search/place functionality should remain public when the backend contract allows it.

Do not duplicate backend authorization logic in the frontend.

The frontend may hide inaccessible controls, but the server remains authoritative.

---

# SERVER-STATE MANAGEMENT

Use a consistent server-state strategy.

Cache appropriate read operations such as:

* place details;
* search results;
* autocomplete;
* user profile.

Avoid caching highly dynamic data indefinitely.

Invalidate or version cached data when:

* auth state changes;
* selected entities change;
* server data becomes stale.

---

# CLIENT-STATE MANAGEMENT

Keep transient UI state separate from server state.

Client state may include:

* open panel;
* selected place;
* map viewport;
* search input;
* active direction mode;
* active route selection.

Do not duplicate the complete backend database in client state.

---

# REQUEST CANCELLATION

Cancel superseded browser requests for:

* autocomplete;
* search;
* geocoding;
* nearby search;
* route calculation.

Use `AbortController` or the repository's equivalent.

A cancelled request must not generate an error toast as though the backend failed.

---

# RETRY POLICY

Do not retry blindly.

Safe automatic retries may apply to idempotent reads when:

* the failure is transient;
* retry count is bounded;
* backoff is used.

Do not automatically retry:

* non-idempotent mutations;
* user actions that may create duplicates.

---

# ERROR NORMALIZATION

Normalize backend errors into user-facing categories.

Maintain enough structured information for:

* validation;
* authorization;
* rate limiting;
* unavailable services;
* no-result conditions.

Do not expose:

* stack traces;
* internal hostnames;
* SQL details;
* provider secrets.

---

# OBSERVABILITY

Implement frontend telemetry for:

* route transitions;
* search latency;
* autocomplete latency;
* map-load timing;
* API latency;
* API errors;
* route-calculation failures;
* client rendering errors.

Use correlation identifiers where the backend provides them.

Do not send exact private location data into analytics by default.

---

# ERROR BOUNDARIES

Implement error boundaries for:

* application shell;
* map rendering;
* search panel;
* place details;
* directions panel.

An isolated component failure should not unnecessarily destroy the entire application.

Provide accessible recovery UI.

---

# PERFORMANCE

Optimize:

* initial page load;
* JavaScript bundle size;
* map initialization;
* search interaction;
* autocomplete;
* route rendering;
* rendering of dense map overlays.

Avoid unnecessary rerenders from high-frequency map viewport changes.

Use:

* code splitting;
* lazy loading;
* memoization where justified;
* virtualization for long result lists;
* debounced high-frequency interactions.

Do not optimize prematurely with unreadable abstractions.

---

# MAP PERFORMANCE

Do not render hundreds or thousands of DOM markers when vector-tile or native map layers are more appropriate.

Use map-source/layer rendering for dense geographic content.

Use DOM markers only for small interactive sets such as:

* selected place;
* origin;
* destination;
* a limited result set.

---

# SEARCH PERFORMANCE

Avoid unnecessary full rerenders during typing.

Use:

* debounce;
* request cancellation;
* stable component keys;
* memoized result rendering.

Do not fetch detailed place data for every autocomplete result.

---

# ACCESSIBILITY TESTING

Test:

* keyboard-only navigation;
* search autocomplete;
* focus movement;
* dialogs/drawers;
* place panel;
* directions inputs;
* map controls;
* route selection;
* error announcements.

Map interactions must have accessible non-map alternatives for core functionality.

Do not make map visualization the only way to understand a place search result or route summary.

---

# SECURITY

Inspect the frontend for:

* XSS;
* unsafe HTML injection;
* token leakage;
* secret exposure;
* open redirects;
* malicious URL parameters;
* insecure external resource loading;
* unsafe iframe behavior.

Do not render backend-provided HTML as trusted content without explicit sanitization.

Do not embed secrets in client-side environment variables.

---

# MAP SECURITY

Treat external map style and tile URLs as configuration.

Validate allowed origins where appropriate.

Do not accept arbitrary tile/style URLs directly from users.

Do not allow user-controlled URL parameters to cause unrestricted network access from server-side rendering components.

---

# CONTENT SECURITY

Where user-generated text is displayed:

* escape safely;
* respect text length limits;
* avoid unsafe HTML;
* protect against script injection.

Do not trust place names, reviews, contribution text, or provider-returned labels as executable markup.

---

# PRIVACY

The web application must not unnecessarily transmit or retain:

* exact location;
* search history;
* private saved places;
* private account information.

Avoid placing sensitive values in:

* URL query strings;
* analytics payloads;
* browser storage;
* logs.

Use browser storage only for non-sensitive state unless the project's authentication design explicitly allows another mechanism.

---

# MAP ERROR HANDLING

Handle map failures such as:

* style-load failure;
* tile-load failure;
* unsupported browser;
* WebGL failure;
* network failure.

Provide a recoverable message.

Do not replace a failed map with a fake static image that implies live map functionality.

Provide an accessible textual fallback for critical place/routing information.

---

# TESTING — COMPONENTS

Create component tests for:

* application shell;
* search input;
* autocomplete;
* search results;
* place panel;
* map controls;
* directions inputs;
* route summary;
* route alternative selection;
* authentication UI;
* loading/error/empty states.

---

# TESTING — INTEGRATION

Create integration tests validating:

* authenticated session restoration;
* logout;
* search request flow;
* autocomplete request flow;
* place selection;
* place details loading;
* geocoding flow;
* directions request;
* route rendering;
* route alternative selection;
* error handling.

Use contract-compatible test responses.

Do not silently diverge from backend schemas merely to simplify frontend tests.

---

# TESTING — API CONTRACTS

Validate that the web client consumes the authoritative API contracts correctly.

Check:

* field names;
* enums;
* timestamps;
* coordinates;
* pagination;
* errors;
* authentication responses;
* route representations;
* place representations.

Where generated API types are available, use them rather than manually duplicating schemas.

---

# TESTING — MAP

Test:

* map initialization;
* style loading;
* tile-source configuration;
* current-location permission handling;
* control behavior;
* selected place;
* route rendering;
* viewport fitting;
* resize behavior;
* map failure recovery.

Do not depend exclusively on visual snapshots for map correctness.

---

# TESTING — ACCESSIBILITY

Run available accessibility tooling.

Verify:

* no missing required labels;
* focus order;
* keyboard interaction;
* color-independent state communication;
* accessible names;
* dialog behavior;
* form errors.

---

# TESTING — PERFORMANCE

Measure practical:

* initial render;
* map initialization;
* search response handling;
* autocomplete interaction;
* route rendering;
* large-result rendering.

Do not claim global-scale browser performance from a single local machine.

---

# DOCUMENTATION

Create or update documentation covering:

* web application architecture;
* setup;
* environment variables;
* authentication integration;
* API client;
* map integration;
* map style configuration;
* tile configuration;
* search/autocomplete;
* place details;
* directions foundation;
* state management;
* accessibility;
* testing;
* telemetry;
* security;
* browser limitations.

Document actual implementation only.

---

# CROSS-PART COMPATIBILITY

This web implementation must remain compatible with:

## Backend

Consume:

* authentication;
* place APIs;
* search;
* autocomplete;
* geocoding;
* reverse geocoding;
* routing;
* user/profile APIs.

Use the backend's canonical identifiers, enums, timestamps, coordinates, and error contracts.

## Map Backend

Consume:

* versioned map styles;
* vector tiles;
* tile metadata;
* attribution.

Do not hardcode assumptions that conflict with map-data versioning.

## Navigation Backend

This milestone only establishes route-display compatibility.

Do not implement the full realtime navigation protocol here.

## Mobile

The web and mobile clients must use the same project-wide domain contracts.

Do not create web-only interpretations of Place or Route schemas.

## QA

Expose deterministic component and integration seams so QA can validate:

* search;
* map;
* directions;
* authentication;
* accessibility;
* performance;
* security.

---

# PORTABLE FRONTEND CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* web route map;
* API client conventions;
* frontend error mapping;
* authentication client behavior;
* map configuration;
* map-style consumption;
* tile configuration;
* search UI contract;
* autocomplete UI contract;
* place-detail representation;
* directions result representation;
* accessibility conventions.

Do not create a second backend contract source of truth.

---

# EXTERNAL SERVICE REALISM

Map tile/style providers and browser geolocation are external/runtime dependencies.

When unavailable:

* implement configuration correctly;
* provide controlled error handling;
* provide test fixtures or test adapters where appropriate;
* accurately report the limitation.

Do not fabricate live map tiles.

Do not fabricate current user location.

Do not claim successful provider connectivity unless actually verified.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                        | Required Behavior                                                                                                 |
| ------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| Authentication API unavailable | Preserve existing authenticated state if safe; surface controlled service error for new authentication operations |
| Session refresh fails          | End authenticated state safely; avoid infinite refresh loops                                                      |
| Search unavailable             | Show recoverable error without corrupting current map state                                                       |
| Autocomplete request cancelled | Ignore cancelled result without user-facing failure                                                               |
| Place unavailable              | Show not-found/unavailable state                                                                                  |
| Geocoding unavailable          | Show controlled service error                                                                                     |
| Routing unavailable            | Preserve origin/destination input and show routing error; never fabricate a route                                 |
| Map style unavailable          | Show recoverable map failure                                                                                      |
| Tile unavailable               | Preserve map shell and show degraded map state where possible                                                     |
| Browser geolocation denied     | Allow manual location entry and continue without exact location                                                   |
| WebGL unavailable              | Show supported fallback for core textual workflows where possible                                                 |
| API rate limited               | Respect retry-after behavior where available                                                                      |
| Unexpected client exception    | Recover through error boundary without exposing technical details                                                 |

---

# FINAL DIFF REVIEW

Before completion:

* inspect all changed files;
* inspect client routing;
* inspect API client;
* inspect auth/session handling;
* inspect token storage;
* inspect map initialization;
* inspect tile/style configuration;
* inspect search/autocomplete;
* inspect place synchronization;
* inspect directions flow;
* inspect accessibility;
* inspect telemetry;
* inspect environment variables;
* run tests;
* run type checking;
* run linting;
* run formatting;
* run production build;
* inspect bundle/performance output where available;
* remove debug code;
* remove unused dependencies;
* verify no secrets entered client bundles;
* verify no fake backend responses were introduced;
* verify no unrelated future functionality was implemented.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* Next.js/application architecture changes;
* routing changes;
* design-system changes;
* responsive-layout changes;
* accessibility changes;
* API-client changes;
* authentication changes;
* session handling;
* map integration;
* map-style integration;
* tile configuration;
* current-location behavior;
* search implementation;
* autocomplete implementation;
* nearby-search implementation;
* place-details implementation;
* geocoding UI;
* directions-entry implementation;
* route rendering;
* route alternatives;
* state-management changes;
* caching changes;
* telemetry;
* security changes;
* tests created;
* tests executed;
* accessibility validation;
* performance validation;
* documentation updates;
* compatibility considerations;
* known limitations;
* unresolved external-provider dependencies.

The report must accurately describe actual repository changes.

Do not claim that full turn-by-turn navigation, realtime navigation, complete traffic visualization, transit UI, media UI, reviews UI, or administrative UI was implemented.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* the web application foundation is production-usable;
* Next.js architecture is coherent;
* TypeScript is consistently used;
* application routes are defined;
* the application shell is implemented;
* responsive behavior is implemented;
* design-system foundations are implemented;
* reusable UI primitives exist;
* accessibility foundations are implemented;
* keyboard interaction works for core workflows;
* error boundaries exist;
* loading and empty states exist;
* authentication client integration is implemented;
* session restoration is implemented;
* logout is implemented;
* token/session handling follows the backend contract;
* protected routes are enforced appropriately;
* API client behavior is centralized;
* request cancellation is implemented;
* API errors are normalized;
* safe retry behavior exists;
* server-state management is coherent;
* client UI state is separated from server state;
* map rendering is implemented;
* map styles are loaded through configuration/contracts;
* vector tiles are consumed;
* map controls are accessible;
* viewport state is handled efficiently;
* current-location behavior is implemented safely;
* location permission failures are handled;
* search UI is implemented;
* autocomplete is debounced;
* stale autocomplete results cannot overwrite current results;
* search results are rendered;
* nearby discovery is implemented;
* place details are implemented;
* selected places synchronize with the map;
* deep links are implemented;
* deleted/merged/not-found places are handled safely;
* forward/reverse geocoding UI is implemented where supported;
* directions entry is implemented;
* origin/destination handling works;
* supported travel modes are accurately represented;
* route requests are cancellable;
* route results are rendered;
* route alternatives are selectable;
* route errors are handled safely;
* no fake route is shown;
* observability is implemented;
* private location is not unnecessarily sent to analytics;
* frontend security protections are implemented;
* user-generated text is safely rendered;
* no client secrets are exposed;
* component tests exist;
* integration tests exist;
* API contract tests exist;
* map tests exist;
* accessibility tests exist;
* performance validation exists;
* documentation is current;
* portable frontend integration conventions are documented;
* the final diff was inspected;
* the production build succeeds where the environment permits;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no fake backend behavior was introduced;
* no credentials or secrets were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement full realtime navigation, transit, reviews, media, notifications, moderation, administration, or the complete mobile application during this frontend foundation milestone.
