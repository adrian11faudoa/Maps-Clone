# Google Maps-Style Mapping & Navigation Platform — QA Prompt — Volume 2

# ROLE

Act as a senior quality engineering organization responsible for validating the complete user-facing web and mobile experiences of a production-grade Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal QA Architect
* Senior Web QA Engineers
* Senior Mobile QA Engineers
* Browser Automation Engineers
* Mobile Device Automation Engineers
* Geospatial QA Engineers
* Navigation QA Engineers
* Accessibility Engineers
* Localization QA Engineers
* Visual Regression Engineers
* Security QA Engineers
* Reliability Engineers
* Test Infrastructure Engineers
* Technical Writers

You are implementing and executing production-quality end-to-end and user-experience validation.

Do not produce superficial smoke tests, placeholder assertions, tests that only verify page existence, fake navigation behavior, inaccessible test shortcuts, disabled assertions, permanent skips for critical journeys, hardcoded production credentials, TODO/FIXME test gaps, or knowingly incomplete critical user-flow coverage.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Validate the complete customer-facing experience across the web and mobile applications.

The platform includes:

* interactive maps
* place search
* autocomplete
* geocoding
* place details
* directions
* route results
* active navigation
* traffic
* public transit
* multimodal journeys
* saved places
* saved lists
* contributions
* reviews
* reports
* media uploads
* notifications
* account management
* privacy controls
* authentication
* responsive interfaces
* accessibility
* localization

This prompt focuses on end-to-end behavior across real application boundaries.

The test suite must validate that the web and mobile products correctly consume the backend and infrastructure contracts established elsewhere in the project.

Do not duplicate low-level service tests already covered by the foundational QA layer when an end-to-end test is not required.

Prioritize complete user journeys, cross-feature interactions, accessibility, localization, browser/device behavior, visual stability, and client-side recovery.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the production-grade web and mobile end-to-end QA layer.

## 1. End-to-End Test Architecture

Establish a dedicated E2E architecture for:

* web browser testing
* mobile device/emulator testing
* cross-service user journeys
* authenticated flows
* anonymous flows
* network-degraded flows
* permission-dependent flows
* accessibility verification
* visual regression
* localization validation

Define:

* environment configuration
* test-user management
* test data lifecycle
* authentication setup
* browser/device matrix
* deterministic state preparation
* cleanup strategy
* screenshots/video/traces
* failure artifact handling

Tests must remain isolated from production environments.

---

## 2. Web Browser Test Foundation

Implement browser automation for the supported web application.

Cover the browser capabilities required by the project, including where appropriate:

* Chromium-based browser
* Firefox
* WebKit/Safari-equivalent coverage where supported by the chosen framework

Validate:

* application bootstrap
* routing
* deep links
* responsive layouts
* keyboard behavior
* browser permission flows
* map initialization
* API failures
* authentication
* navigation

Do not claim a browser is covered merely because the same test suite technically launches it. Execute meaningful scenarios on each required browser family.

---

## 3. Mobile End-to-End Test Foundation

Implement E2E automation for supported mobile targets.

Cover:

* Android
* iOS

Where the available environment cannot execute one platform, configure the suite and report the limitation accurately rather than claiming execution.

Validate native behaviors such as:

* permissions
* app lifecycle
* location
* background/foreground transitions
* deep links
* notifications
* camera/photo-library access
* audio
* network transitions

---

## 4. Test Accounts and Roles

Create controlled test identities for:

* anonymous user
* standard user
* user with saved content
* user with contributions/reviews
* user with notifications
* privileged test identity where a client-facing workflow requires it

Test accounts must be:

* non-production
* deterministic
* independently resettable
* scoped to the test environment

Do not use shared personal accounts.

Avoid one account carrying all test state.

---

## 5. Authentication E2E

Validate complete authentication flows.

Cover:

* sign-in
* invalid credentials
* authenticated landing state
* session restoration
* session expiration
* refresh/re-authentication
* logout
* protected-route access
* unauthenticated deep link
* account transition

Verify that authenticated UI never displays another user's cached state.

Validate behavior after:

* refresh
* browser restart where applicable
* app restart
* network loss
* expired session

---

## 6. Search and Discovery E2E

Implement end-to-end tests for:

* search entry
* autocomplete
* result selection
* place details
* map focus
* no results
* search errors
* retry
* localized search where supported
* coordinate/map search

Validate that search results lead to the correct place resource.

Test rapid typing.

Test stale autocomplete responses.

Test network interruption during search.

---

## 7. Place Details E2E

Validate place-details journeys.

Cover:

* opening place details from search
* opening from map selection
* deep-linking directly to a place
* refreshing place details
* unavailable/deleted place
* authenticated versus anonymous presentation
* available hours/contact information
* place-to-directions transition
* place-to-save transition

Verify that private or unauthorized information is never shown.

---

## 8. Map Interaction E2E

Validate the interactive map itself.

Cover:

* initial load
* pan
* zoom
* rotation where supported
* pitch where supported
* recenter
* current location
* map tap
* selected coordinate
* reverse geocoding
* layer/style loading
* tile-loading failure
* map recovery

Test map behavior across:

* different viewport sizes
* supported browsers
* supported mobile devices

Do not use image-only assertions as the sole verification mechanism for map correctness.

---

## 9. Directions E2E

Validate complete route-planning workflows.

Cover:

* origin selection
* destination selection
* current location
* searched place
* map coordinate
* origin/destination swap
* travel-mode selection
* route request
* route alternatives
* route geometry
* route summary
* step list
* warnings
* traffic information
* route failure
* retry

Test:

* invalid origin
* invalid destination
* unsupported mode
* unavailable routing service
* timeout
* stale route response

---

## 10. Active Navigation E2E

Implement realistic active-navigation test journeys.

Validate:

* route → start navigation
* navigation-session creation
* current-position rendering
* route progress
* maneuver progression
* ETA
* traffic updates
* navigation alerts
* off-route detection
* rerouting
* navigation completion
* navigation cancellation

Use deterministic simulated location input where physical movement is impractical.

The simulation must exercise the real navigation application path rather than bypassing the navigation subsystem.

Do not replace production navigation logic with test-only branching.

---

## 11. Location Permission E2E

Validate location permissions.

Cover:

* first-time request
* allow
* deny
* deny then retry
* permission revoked after grant
* location services disabled
* approximate/coarse location where the platform supports it
* foreground versus background permission behavior where applicable

Verify that the user experience remains truthful about available location accuracy.

Do not bypass the operating-system permission layer in the production application merely to simplify tests.

---

## 12. Background Navigation E2E

Where supported, validate:

* app backgrounding
* screen lock
* navigation continuity
* location continuity
* notification/audio behavior
* app restoration
* session recovery

Verify that behavior matches platform constraints.

Do not claim background behavior is supported on a platform where the implementation or test environment does not permit it.

---

## 13. Realtime Navigation E2E

Validate end-to-end realtime behavior.

Cover:

* WebSocket connection
* authentication
* navigation-session binding
* live location updates
* server route updates
* ETA changes
* traffic updates
* navigation alerts
* disconnect
* reconnect
* duplicate events
* stale events
* session termination

Test network changes during navigation.

Verify that stale server events do not overwrite current state.

---

## 14. Transit E2E

Validate transit journeys.

Cover:

* transit mode selection
* departure search
* journey results
* walking legs
* transit legs
* transfers
* station/stop details
* departure/arrival times
* delays
* cancellations
* service alerts
* accessibility information
* stale realtime data

Ensure transit journeys render correctly on supported web and mobile clients.

---

## 15. Multimodal E2E

Validate journeys combining multiple modes.

Cover combinations supported by the product, such as:

* walking + transit
* walking + driving
* cycling + transit

Validate:

* leg sequencing
* transfer presentation
* duration
* arrival time
* mode changes
* warnings
* accessibility metadata

Do not assume all backend-supported combinations must be tested unless they are exposed by the client.

---

## 16. Traffic and Incident E2E

Validate user-facing traffic information.

Cover:

* traffic-aware route
* traffic overlays where available
* incident markers
* route warnings
* traffic delays
* stale traffic state
* unavailable traffic
* traffic update while viewing directions
* traffic update during navigation

Verify that stale or unavailable traffic is not represented as live.

---

## 17. Saved Places E2E

Validate:

* save place
* unsave place
* open saved place
* create saved list
* rename list
* add/remove place
* reorder entries
* visibility where supported
* delete list
* empty state
* refresh
* retry

Test the interaction between:

* search
* place details
* map
* saved content
* directions

---

## 18. Private Notes E2E

Validate:

* create note
* edit note
* delete note
* restore state after navigation
* account isolation

Verify that private notes do not become:

* public content
* search results
* notification payloads
* analytics payloads
* another user's visible data

---

## 19. Contributions E2E

Validate the contribution experience.

Cover:

* open contribution flow
* structured field editing
* validation
* draft
* resume draft
* submit
* pending state
* reviewed/approved/rejected state where exposed
* error/retry

Verify user-facing status matches backend-authoritative state.

Do not assert that every submitted contribution is approved.

---

## 20. Reviews and Ratings E2E

Validate:

* view eligible place
* create rating
* create review
* edit review
* delete review
* report review
* validation errors
* publication state
* moderation state where exposed

Test:

* duplicate submission
* failed submission
* expired session
* stale review state

Verify that the user interface distinguishes local submission success from actual publication.

---

## 21. Media Upload E2E

Validate end-to-end media workflows.

Cover:

* selecting image
* capturing image where supported
* validation
* upload initialization
* progress
* cancellation
* completion
* processing
* publication
* rejection
* deletion

Test:

* oversized media
* unsupported MIME type
* corrupted media
* network interruption
* expired upload authorization

Do not fake processing completion.

---

## 22. Notification E2E

Validate:

* notification center
* unread count
* mark read
* mark all read
* notification pagination
* notification deep link
* deleted target
* inaccessible target
* empty state
* network failure

Where supported, test push notifications on real/emulated device flows.

Validate account isolation.

---

## 23. Push Permission and Registration E2E

Test:

* first push permission request
* allow
* deny
* later re-enable through system settings where supported
* token registration
* token refresh
* logout
* account change
* invalid token behavior

Verify that notifications are associated with the correct test account.

Do not use production push credentials.

---

## 24. Account and Preference E2E

Validate:

* profile editing
* preferences
* units
* language
* notification preferences
* privacy settings
* session/device management where exposed

Test persistence after:

* refresh
* logout/login
* app restart
* network interruption

Verify server-authoritative settings are reflected correctly.

---

## 25. Offline and Network-Degraded E2E

Implement controlled network simulations for:

* offline
* slow network
* high latency
* connection reset
* intermittent connectivity
* server timeout
* partial API failure

Validate behavior for:

* search
* place details
* directions
* active navigation
* saved content
* reviews
* contributions
* media uploads
* notifications

The interface must communicate what is currently unavailable.

Do not allow optimistic state to remain falsely confirmed after a failed mutation.

---

## 26. Deep-Link E2E

Validate deep links for:

* places
* coordinates
* directions
* notifications
* saved content where applicable

Test:

* app closed
* app backgrounded
* app already open
* unauthenticated state
* authenticated state
* malformed URL
* missing resource
* unauthorized resource

Verify the destination is correct.

---

## 27. Browser and Device Responsiveness

Validate user journeys across representative:

### Web

* desktop
* laptop
* tablet
* narrow/mobile viewport

### Mobile

* small screen
* large screen
* portrait
* landscape where supported
* lower-memory device profile
* performance-constrained device profile

Verify:

* no clipping
* usable controls
* map interaction
* bottom sheets
* dialogs
* keyboard handling
* navigation
* accessibility layout

---

## 28. Accessibility E2E

Implement automated accessibility validation for critical user journeys.

Cover:

* semantic structure
* accessible names
* roles
* labels
* keyboard navigation
* focus order
* focus traps
* screen-reader-compatible controls
* form errors
* dynamic announcements
* touch targets
* contrast checks where tooling permits

Critical flows include:

* authentication
* search
* place details
* directions
* route results
* active navigation
* saved places
* contributions
* reviews
* notifications
* settings

Do not treat automated accessibility tooling as proof of full accessibility.

Where manual/assistive-technology verification is required, document the limitation.

---

## 29. Localization E2E

Validate representative locales for:

* English
* Spanish
* at least one locale using a non-Latin script where supported
* RTL locale where supported

Cover:

* search
* place details
* directions
* navigation instructions
* transit
* notifications
* account settings
* validation messages
* accessibility labels

Test:

* long strings
* pluralization
* date/time formatting
* units
* RTL layout
* mixed-script place names

Do not validate localization only by checking that translation files exist.

---

## 30. Visual Regression Testing

Implement controlled visual-regression coverage for high-value stable surfaces.

Target:

* application shell
* search
* place details
* route results
* navigation guidance
* transit results
* saved lists
* contribution form
* review form
* notification center
* key account/settings views

Use deterministic test data and viewport configuration.

Avoid brittle full-screen snapshots of highly dynamic map imagery where visual differences are expected.

Prefer component/surface-level assertions for dynamic map content.

---

## 31. UX State Coverage

Every critical E2E journey must explicitly exercise relevant:

* loading
* success
* empty
* validation-error
* unauthorized
* not-found
* network-error
* timeout
* degraded
* retry
* stale-data

Do not consider a journey fully covered by one successful path.

---

## 32. Cross-Feature Journey Tests

Create complete journeys crossing multiple platform capabilities.

Examples include:

### Discovery → Navigation

Search a place → open details → start directions → view route → start navigation → receive route progress → complete navigation.

### Discovery → Save

Search place → open details → save place → add to list → reopen saved item → start directions.

### Contribution

Search place → open contribution → edit data → save draft → resume → submit → view status.

### Review

Open place → create rating/review → submit → reopen place → inspect publication state → edit/delete/report where applicable.

### Transit

Search destination → select transit → inspect journey → inspect transfer → view delay/alert → return to map.

### Notification

Receive notification → open notification → navigate to related resource → handle unavailable/deleted target.

Cross-feature failures must leave application state coherent.

---

## 33. Session and State-Restoration E2E

Test application behavior after:

* browser refresh
* browser restart
* app restart
* screen rotation
* background/foreground transition
* navigation away and back
* process recreation where supported

Verify restoration of appropriate:

* authentication
* map state
* search state
* active navigation state
* saved content state
* notification state

Do not restore stale or unauthorized account state.

---

## 34. Client-Side Cache E2E

Validate caching behavior visible to users.

Cover:

* initial fetch
* cached display
* refresh
* mutation invalidation
* stale cache
* account transition
* logout
* re-login as different user

Verify caches cannot leak private resources between users.

---

## 35. Error-Recovery E2E

Create tests for realistic failure/recovery paths.

Examples:

* search fails → retry succeeds
* route request times out → retry succeeds
* WebSocket disconnects → reconnect succeeds
* upload fails → retry succeeds
* push token registration fails → later retry succeeds
* place disappears → user receives correct unavailable state
* session expires → re-authentication succeeds

Tests must verify both the failure and the resulting recovered state.

---

## 36. Security-Focused E2E

Validate client-facing protections such as:

* protected route enforcement
* unauthorized deep links
* private saved content isolation
* private notes isolation
* account switching
* secure upload flow
* no sensitive information in visible errors
* no token exposure in URLs
* logout state cleanup

Use dedicated security test identities and controlled data.

Do not perform destructive security testing against production systems.

---

## 37. Performance Smoke E2E

Implement lightweight user-experience performance checks.

Measure where practical:

* application startup
* first meaningful render
* map readiness
* search response-to-render latency
* route-result rendering
* navigation-screen startup
* notification loading
* saved-list rendering

Use thresholds derived from the project's documented targets.

Do not invent arbitrary pass/fail numbers without documenting their source.

---

## 38. Test Parallelization and Isolation

Make E2E tests safely parallelizable where practical.

Ensure:

* unique test data ownership
* isolated browser contexts
* isolated mobile state
* account separation
* deterministic setup
* independent cleanup

Do not parallelize tests that share mutable state without explicit synchronization.

---

## 39. Failure Artifacts

Capture useful E2E failure information:

* screenshots
* video where appropriate
* browser/device logs
* network traces where safe
* application logs
* WebSocket diagnostics
* console errors
* test metadata
* timing data

Redact:

* access tokens
* session credentials
* signed upload URLs
* private user content
* precise location data where not necessary

---

## 40. CI Execution Matrix

Integrate E2E validation into CI at appropriate stages.

Provide separate suites for:

* pull-request smoke tests
* merge-gate critical journeys
* scheduled broad regression
* browser matrix
* mobile matrix
* accessibility
* localization
* visual regression

Do not execute the entire expensive matrix on every trivial change when a staged strategy can provide equivalent protection.

Critical journey regressions must remain blocking.

---

## 41. Test Data Reset and Cleanup

Implement reliable cleanup.

Reset:

* saved places
* lists
* notes
* contributions
* reviews
* reports
* media
* notification state
* sessions
* device registrations

Ensure cleanup does not remove shared baseline data required by other tests.

Do not leave indefinite test artifacts in object storage or databases.

---

## 42. Documentation

Create or update QA documentation covering:

* E2E architecture
* supported browsers
* supported devices
* test accounts
* data setup
* location simulation
* network simulation
* accessibility testing
* localization testing
* visual regression
* CI suites
* failure artifacts
* debugging
* cleanup
* known platform limitations
* manual verification requirements
* test ownership

Documentation must describe the actual executable test system.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement:

* large-scale load testing
* multi-hour soak testing
* chaos engineering
* formal penetration testing
* full production disaster-recovery exercises
* destructive production testing
* backend unit-test expansion already covered by QA Volume 1
* infrastructure capacity benchmarking
* complete visual review of every application screen
* manual certification claims that were not performed

Do not create placeholder suites for these systems.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect the existing web E2E framework.
2. Inspect existing mobile E2E tooling.
3. Inspect browser automation configuration.
4. Inspect device/emulator configuration.
5. Inspect application routing and deep links.
6. Inspect authentication test infrastructure.
7. Inspect test-account setup.
8. Inspect deterministic fixtures.
9. Inspect location simulation capabilities.
10. Inspect network interception/simulation tooling.
11. Inspect API contracts used by clients.
12. Inspect existing accessibility tooling.
13. Inspect localization infrastructure.
14. Inspect visual-regression infrastructure.
15. Inspect CI workflows.
16. Inspect existing failure-artifact collection.
17. Inspect cleanup/reset utilities.
18. Inspect documentation describing supported client environments.
19. Inspect the architecture and product contracts relevant to the end-to-end flows.

Reuse compatible tooling.

Do not assume previous AI conversations or hidden test suites exist.

Do not replace existing working E2E infrastructure without a documented reason.

The repository and explicit portable contract artifacts are the available sources of truth.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real end-to-end tests.
* Do not create tests that only assert a page/screen exists.
* Do not bypass production user flows through hidden test-only APIs unless they are explicitly defined as test setup interfaces.
* Do not disable assertions.
* Do not permanently skip critical journeys.
* Do not use production accounts.
* Do not use production credentials.
* Do not send test mutations to production.
* Keep test data deterministic.
* Keep test state isolated.
* Clean up test-created resources.
* Redact secrets from artifacts.
* Do not use brittle selectors when stable semantic selectors are available.
* Do not rely exclusively on coordinate-based UI clicking when accessible/semantic targeting is available.
* Do not use screenshots as the sole assertion for functional behavior.
* Keep map assertions focused on stable semantics rather than unstable visual imagery.
* Simulate location through the actual navigation path.
* Test failure and recovery, not only happy paths.
* Validate account isolation.
* Validate stale-state handling.
* Validate accessibility.
* Validate localization.
* Keep visual baselines deterministic.
* Distinguish automated evidence from manual verification.
* Do not claim coverage that was not executed.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Execute critical web E2E journeys.
* Execute critical mobile E2E journeys where the environment permits.
* Execute authentication flows.
* Execute search/place journeys.
* Execute map interaction tests.
* Execute directions tests.
* Execute active-navigation tests.
* Execute realtime navigation tests.
* Execute traffic/incident flows.
* Execute transit and multimodal flows.
* Execute saved-content flows.
* Execute contribution flows.
* Execute reviews/ratings.
* Execute media upload flows.
* Execute notification flows.
* Execute account/preferences flows.
* Execute deep-link tests.
* Execute offline/degraded-network tests.
* Execute lifecycle/state-restoration tests.
* Execute accessibility automation.
* Execute localization tests.
* Execute visual-regression suites.
* Execute security-focused client tests.
* Execute performance smoke tests.
* Validate test-data cleanup.
* Validate CI gates.
* Review failure artifacts.
* Confirm no secrets or private data were captured in artifacts.
* Confirm tests cannot target production.
* Document platform/environment limitations.

Resolve in-scope defects discovered during validation.

Do not claim browser/device coverage that was not actually executed.

---

# EXPECTED DELIVERABLES

Produce the actual E2E QA implementation and supporting artifacts.

Expected deliverables include, as applicable:

* web E2E framework/configuration
* mobile E2E framework/configuration
* browser matrix
* device/emulator matrix
* controlled test accounts
* data setup/reset utilities
* authentication E2E
* search/discovery E2E
* place E2E
* map E2E
* directions E2E
* active-navigation E2E
* location-permission E2E
* background-navigation E2E
* realtime E2E
* traffic/incident E2E
* transit E2E
* multimodal E2E
* saved-content E2E
* contribution E2E
* review/rating E2E
* media E2E
* notification/push E2E
* account/preferences E2E
* network-degradation E2E
* deep-link E2E
* responsiveness tests
* accessibility tests
* localization tests
* visual-regression tests
* cross-feature journey tests
* session/state-restoration tests
* cache-isolation tests
* security-focused client tests
* performance-smoke tests
* CI execution matrix
* failure-artifact collection
* cleanup utilities
* QA documentation

Do not artificially split tests merely to increase file count.

---

# INTEGRATION REQUIREMENTS

The E2E layer must use the real application boundaries.

Test journeys must flow through:

* the real web/mobile UI
* the real client state-management path
* the real API client
* real backend contracts
* real authentication/session semantics
* real map/tile interfaces
* real routing/navigation contracts
* real notification contracts
* real media-upload interfaces

Use controlled test doubles only for external dependencies that cannot reasonably be exercised in the E2E environment, and document every such boundary.

Do not bypass the functionality under test.

Test data must correspond to canonical entity models and contracts.

The E2E suite must remain compatible with future frontend, mobile, backend, and QA changes.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. E2E architecture implemented.
2. Web browser automation implemented.
3. Mobile device automation implemented.
4. Test accounts implemented.
5. Authentication E2E implemented.
6. Search/discovery E2E implemented.
7. Place-details E2E implemented.
8. Map-interaction E2E implemented.
9. Directions E2E implemented.
10. Active-navigation E2E implemented.
11. Location-permission E2E implemented.
12. Background-navigation E2E implemented where supported.
13. Realtime-navigation E2E implemented.
14. Traffic/incident E2E implemented.
15. Transit E2E implemented.
16. Multimodal E2E implemented.
17. Saved-content E2E implemented.
18. Private-note E2E implemented.
19. Contribution E2E implemented.
20. Review/rating E2E implemented.
21. Media-upload E2E implemented.
22. Notification/push E2E implemented.
23. Account/preferences E2E implemented.
24. Offline/network-degraded E2E implemented.
25. Deep-link E2E implemented.
26. Responsive/browser/device coverage implemented.
27. Accessibility E2E implemented.
28. Localization E2E implemented.
29. Visual-regression coverage implemented.
30. Cross-feature journeys implemented.
31. State-restoration/cache-isolation testing implemented.
32. Security-focused client E2E implemented.
33. Performance smoke tests implemented.
34. CI execution matrix implemented.
35. Failure artifacts implemented.
36. Cleanup/reset implemented.
37. Tests actually executed and outcomes.
38. Browser/device/platform limitations.
39. Important implementation decisions or deviations.
40. Exact files/modules/artifacts changed or created.
41. Documentation created or updated.

Do not claim execution of a browser, device, platform, or scenario unless it actually ran.

---

# DEFINITION OF DONE

This prompt is complete only when:

* A maintainable web and mobile E2E architecture exists.
* Test accounts and deterministic test-data lifecycle are implemented.
* Critical authentication journeys are covered.
* Search and place-discovery journeys are covered.
* Map interactions are covered.
* Directions and route-result journeys are covered.
* Active navigation is tested through the real client path.
* Location permissions and lifecycle transitions are tested.
* Realtime navigation disconnect/reconnect behavior is tested.
* Traffic and incident presentation is tested.
* Transit and multimodal journeys are tested.
* Saved places/lists and private notes are tested.
* Contributions and reviews/ratings are tested.
* Media upload lifecycle is tested.
* Notification center and push-related journeys are tested where supported.
* Account, preferences, and privacy journeys are tested.
* Deep links are tested across relevant application states.
* Offline and degraded-network behavior is verified.
* Browser/device responsiveness is verified.
* Accessibility automation covers critical user journeys.
* Localization is tested across representative locales.
* Visual-regression protection exists for important stable surfaces.
* Cross-feature journeys validate end-to-end integration.
* Session restoration and account-scoped cache isolation are verified.
* Client-facing security boundaries are tested.
* Performance smoke checks exist for critical user experiences.
* CI executes appropriate smoke, regression, accessibility, localization, and visual suites.
* Failure artifacts are useful and privacy-safe.
* Test data is cleaned reliably.
* No production credentials or production data are used.
* No critical tests are silently disabled or permanently skipped.
* Automated evidence is clearly distinguished from manual verification.
* Documentation reflects actual E2E behavior and limitations.
* No fake test paths, placeholder assertions, TODO/FIXME gaps, or pseudo-tests remain in scope.

**Implement only the current prompt's scope.**
