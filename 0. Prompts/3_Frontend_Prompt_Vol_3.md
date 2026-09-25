# Google Maps-Style Mapping & Navigation Platform — Frontend Prompt — Volume 3

# ROLE

You are the senior frontend engineering agent responsible for implementing the **production authenticated user, saved-place, user-contribution, review, rating, media, notification, and account-management web experiences** for a production-grade **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary frontend engineering organization consisting of:

* Principal Frontend Engineer
* Staff React Engineer
* Next.js Engineer
* UX Engineer
* UI Systems Engineer
* Accessibility Engineer
* API Integration Engineer
* State-Management Engineer
* Media UX Engineer
* Security Engineer
* Privacy Engineer
* Performance Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement complete user-facing web experiences for authenticated personal data and user-generated place content while preserving the authoritative backend domain contracts.

This prompt defines a bounded frontend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed web application is intended to provide:

* interactive maps;
* place discovery;
* search;
* autocomplete;
* geocoding;
* directions;
* navigation;
* traffic;
* public-transit journeys;
* saved places;
* user-created lists;
* place contributions;
* reviews and ratings;
* place photos and media;
* notifications;
* account and security management;
* moderation-aware content states;
* administration experiences for authorized personnel.

This milestone implements the authenticated personal-data and user-generated-content web experience.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* authenticated user account area;
* user profile management;
* user preference management;
* session/device management;
* sign-out and session revocation UI;
* account-security UI;
* saved places;
* saved-place lists;
* list creation/editing/deletion;
* list visibility;
* saved-place ordering;
* saved-place notes;
* saved-place search/filtering;
* place saving from map/place-detail experiences;
* contribution creation;
* contribution editing;
* contribution submission;
* contribution withdrawal;
* contribution-status presentation;
* place-correction workflows;
* review creation;
* rating input;
* review editing;
* review deletion;
* review reporting;
* review moderation-state presentation where publicly available;
* media upload experience;
* media association with supported entities;
* upload progress;
* media validation/error states;
* media preview;
* media deletion;
* notification center;
* notification read state;
* notification preferences;
* push-notification registration integration where supported by the web environment;
* privacy controls relevant to these experiences;
* authorization-aware rendering;
* optimistic UI only where safe;
* server-state caching/invalidation;
* API contract integration;
* accessibility;
* responsive behavior;
* security;
* telemetry;
* automated tests;
* integration tests;
* accessibility tests;
* media tests;
* authorization tests;
* privacy tests;
* performance validation;
* documentation.

The backend remains authoritative for:

* ownership;
* permissions;
* content lifecycle;
* moderation;
* persistence;
* media processing;
* notification delivery;
* privacy enforcement.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* moderation-admin application;
* administrator dashboards;
* moderation queue operations for staff;
* backend implementation;
* map rendering architecture;
* routing engine;
* navigation backend;
* transit backend;
* traffic backend;
* search backend;
* map-tile generation;
* production cloud provisioning;
* Kubernetes infrastructure;
* analytics dashboards;
* advanced machine-learning moderation;
* custom fraud systems.

This milestone may consume moderation and notification contracts exposed by the backend.

Do not fabricate backend approval, notification delivery, media-processing, or moderation outcomes.

---

# REPOSITORY INSPECTION

Inspect the repository first.

Determine:

* current Next.js structure;
* authentication state;
* API client;
* profile/account screens;
* place-detail implementation;
* saved-place functionality;
* user-content components;
* review components;
* media components;
* notification components;
* design system;
* state management;
* server-state management;
* form validation;
* upload infrastructure;
* browser APIs;
* accessibility tooling;
* telemetry;
* tests;
* environment configuration;
* route structure;
* existing authorization-aware UI.

Treat the current repository as authoritative.

Do not assume another AI conversation implemented earlier work.

Preserve compatible behavior.

Do not create duplicate account, place, review, or notification models when existing ones are authoritative.

---

# FRONTEND TECHNOLOGY CONTEXT

Use the project's established frontend stack:

* TypeScript;
* React;
* Next.js;
* repository-selected state-management;
* repository-selected server-state/caching;
* existing design-system primitives;
* browser-supported upload APIs;
* semantic HTML;
* accessible controls.

Prefer existing project dependencies.

Do not introduce a second form library, state manager, or component framework without a compelling reason.

---

# ACCOUNT EXPERIENCE

Implement a production account area.

Support:

* profile display;
* profile editing;
* locale;
* distance units;
* speed units;
* privacy-related preferences where provided;
* notification preferences;
* active sessions/devices.

The account experience must distinguish between:

* account identity;
* profile data;
* user preferences;
* security/session state.

Do not expose password hashes or sensitive authentication internals.

---

# PROFILE EDITING

Implement accessible profile editing.

Support fields exposed by the backend contract such as:

* display name;
* avatar/media reference;
* preferred language;
* measurement units.

Handle:

* validation;
* loading;
* success;
* conflict;
* authorization failure;
* backend failure.

Do not silently overwrite a concurrent server-side profile update when the backend exposes versioning/concurrency controls.

---

# SESSION MANAGEMENT

Implement a session-management interface.

Display appropriate safe information such as:

* device/platform;
* last seen;
* application version;
* created-at;
* current-session indicator.

Support:

* revoke session;
* revoke other sessions where permitted.

Do not display:

* raw refresh tokens;
* access tokens;
* internal session secrets.

---

# ACCOUNT SECURITY

Implement account-security actions exposed by the backend.

Where supported:

* password change;
* account deactivation;
* account deletion request;
* session invalidation.

High-risk operations should use explicit confirmation.

Do not place sensitive credentials into URL parameters.

---

# ACCOUNT DELETION

Implement a clear account-deletion workflow.

The UI must explain:

* what the action means;
* whether the action is reversible;
* which account functionality will cease;
* any applicable waiting period or confirmation flow.

Do not claim that every historical domain record disappears immediately unless the backend contract guarantees it.

---

# SAVED-PLACE EXPERIENCE

Implement a complete saved-place experience.

Support:

* save place;
* remove saved place;
* choose list;
* create list;
* move between lists;
* edit saved metadata;
* add private note;
* view saved items.

The UI must use canonical place IDs.

Do not duplicate place data locally as an independent source of truth.

---

# SAVED-LIST EXPERIENCE

Implement:

* list creation;
* list editing;
* list deletion;
* list visibility;
* list detail;
* list membership management;
* item ordering.

Support:

* empty state;
* loading;
* error;
* conflict.

Do not allow a user to select another user's private list as the destination of a save operation.

---

# SAVED-LIST VISIBILITY

Represent visibility explicitly.

Possible states include:

* private;
* shared;
* public;

when supported by the backend.

When a list becomes non-private:

* warn the user appropriately;
* do not expose private notes;
* do not expose account-private metadata.

Do not infer public visibility merely from a share URL.

---

# SAVED-PLACE NOTES

Private notes must remain private.

Do not:

* send private notes to search APIs;
* include them in public place URLs;
* place them in analytics events;
* display them in public list views.

Render them only in an authorized user-owned context.

---

# SAVED-PLACE REORDERING

Implement ordering where supported.

Use efficient mutation semantics.

Avoid sending the entire list as a new full payload for every single item movement when the backend supports positional or versioned updates.

Handle stale-version conflicts gracefully.

---

# PLACE SAVE INTEGRATION

Integrate saving into:

* place details;
* place search result actions where appropriate;
* map-selected place panels.

The action should reflect current saved state.

Avoid duplicate client sources of truth.

---

# CONTRIBUTION EXPERIENCE

Implement the user-facing contribution workflow.

Support appropriate contribution types such as:

* place correction;
* address correction;
* category correction;
* operating-hours correction;
* place addition where supported.

Do not allow the client to modify authoritative Place records directly.

---

# CONTRIBUTION FORM

Implement structured contribution forms.

Support:

* field-level validation;
* original/current value where useful;
* proposed value;
* explanation/evidence where supported;
* draft state;
* submit;
* withdraw.

Do not use arbitrary uncontrolled JSON editors for normal end-user contribution workflows.

---

# CONTRIBUTION DRAFTS

Where the backend supports drafts:

* save drafts;
* restore drafts;
* edit drafts;
* discard drafts.

Drafts must remain private to the authenticated user.

Do not publish drafts to search or public place views.

---

# CONTRIBUTION STATUS

Display states such as:

* draft;
* submitted;
* under review;
* approved;
* rejected;
* withdrawn;
* published.

Use backend status values exactly.

Do not create client-only lifecycle states that contradict backend semantics.

---

# CONTRIBUTION FEEDBACK

When a contribution is rejected or requires changes:

* display backend-provided safe information;
* distinguish moderator-facing internal data from user-facing feedback;
* preserve the user's ability to understand the outcome where the product provides that information.

Do not expose internal moderation notes.

---

# REVIEW EXPERIENCE

Implement review creation for supported places.

Support:

* rating selection;
* review text;
* optional language;
* submission;
* edit;
* delete;
* report.

Require authentication where the backend contract requires it.

---

# RATING CONTROL

Implement an accessible rating control.

Support:

* keyboard interaction;
* screen-reader labeling;
* exact rating value;
* clear selected state.

Do not use color alone to communicate rating value.

---

# REVIEW FORM

Support:

* validation;
* text-length guidance;
* error display;
* loading state;
* success state;
* conflict state;
* moderation-pending state where applicable.

Do not silently truncate review text.

---

# REVIEW DISPLAY

Render public review data using the backend's canonical representation.

Display only public fields.

Do not expose:

* internal moderation data;
* reporter identity;
* internal abuse signals;
* moderator information not intended for public display.

---

# REVIEW EDITING

Allow users to edit only their own review where the backend permits it.

Handle:

* concurrency conflict;
* moderation lock;
* deleted review;
* authorization failure.

Do not optimistically overwrite a newer server-side version.

---

# REVIEW DELETION

Provide explicit confirmation for deletion.

After success:

* update cached review state;
* remove the review from public display;
* update any local rating-summary state according to server responses.

Do not infer a new rating average locally when the backend provides authoritative derived summaries.

---

# REVIEW REPORTING

Implement accessible review-reporting flow.

Support:

* reason selection;
* optional details;
* submission;
* success;
* duplicate-report state;
* rate-limit error.

Do not expose the moderation case itself to the reporting user unless the product contract permits it.

---

# RATING SUMMARY

Consume the backend's derived rating summary.

Display:

* average;
* count;
* distribution where provided.

Do not calculate the authoritative rating average solely from the currently loaded page of reviews.

---

# MEDIA UPLOAD EXPERIENCE

Implement supported user media uploads.

Support:

* file selection;
* drag-and-drop where useful;
* preview;
* upload progress;
* cancellation;
* retry;
* processing state;
* validation failure;
* publication state;
* deletion.

The backend controls the upload authorization and media lifecycle.

---

# MEDIA VALIDATION UI

Validate client-side where useful:

* supported file type;
* approximate file-size limit;
* basic dimensions.

Client validation is only an early user experience improvement.

The backend remains authoritative for security validation.

Do not assume client-side MIME type validation makes an upload safe.

---

# MEDIA UPLOAD SECURITY

Do not:

* expose storage credentials;
* accept arbitrary storage URLs from users;
* allow user-controlled object keys;
* trust MIME types;
* render untrusted image URLs as safe application HTML.

Use backend-issued upload authorization.

---

# MEDIA PROCESSING STATES

Display backend media states such as:

* uploading;
* validating;
* scanning;
* processing;
* ready;
* published;
* rejected;
* failed;
* deleted.

Do not display "published" merely because upload completed.

---

# MEDIA PREVIEW

Preview supported media safely.

For images:

* use controlled object URLs;
* release object URLs when no longer needed;
* avoid rendering malicious content as executable HTML.

Do not support arbitrary user-supplied HTML as media.

---

# MEDIA DELETION

Allow authorized users to delete their media where the backend permits it.

Handle:

* confirmation;
* loading;
* successful deletion;
* failure;
* asynchronous deletion state.

Do not immediately assume underlying object storage has been physically deleted if the backend uses asynchronous cleanup.

---

# NOTIFICATION CENTER

Implement a production notification center.

Support:

* notification list;
* unread count;
* read/unread state;
* mark read;
* mark all read where supported;
* notification type;
* timestamp;
* relevant action/deep link.

Use cursor pagination.

Do not fetch the entire notification history.

---

# NOTIFICATION DEEP LINKS

Notifications may link to:

* a place;
* a review;
* a contribution;
* an account/security screen;
* a saved list;
* a navigation/trip state;

when the backend provides a valid public or authorized target.

Validate routes before navigation.

Do not trust arbitrary URLs supplied through notification payloads.

---

# NOTIFICATION PREFERENCES

Implement user notification preferences.

Support:

* category;
* channel;
* enabled/disabled state.

Where certain security notifications are mandatory, represent them according to backend policy rather than allowing the client to disable them arbitrarily.

---

# PUSH NOTIFICATIONS

Where browser push is supported:

* register the browser/device with the backend;
* handle permission state;
* allow notification disablement through browser controls;
* deregister on logout where required;
* handle invalid/expired tokens.

Do not implement push delivery from the browser directly through provider credentials.

---

# NOTIFICATION READ STATE

Keep read state synchronized with backend.

Handle:

* optimistic mark-read where safe;
* rollback after failure;
* stale server state;
* multi-device updates where supported.

Do not assume local read state is authoritative.

---

# SERVER-STATE MANAGEMENT

Use one coherent caching strategy for:

* profile;
* sessions;
* saved lists;
* saved places;
* contributions;
* reviews;
* rating summaries;
* media metadata;
* notifications.

Define cache invalidation after mutations.

Do not cache private data under globally shared keys.

---

# OPTIMISTIC UI

Use optimistic updates only for mutations where:

* the operation is safe to compensate;
* authorization is already established;
* rollback is deterministic;
* the backend has suitable idempotency/concurrency semantics.

Appropriate candidates may include:

* marking a notification read;
* toggling a saved place;
* reordering a saved list.

Do not optimistically confirm:

* account deletion;
* contribution approval;
* review publication;
* media publication;
* moderation decisions.

---

# ERROR HANDLING

Handle:

* authentication expiration;
* authorization denial;
* validation failure;
* conflict;
* rate limiting;
* backend unavailable;
* upload failure;
* media-processing failure;
* notification failure.

Use accessible messages.

Do not expose backend stack traces.

---

# AUTHORIZATION-AWARE UI

The client may adapt visible controls according to known permissions.

Examples:

* show edit controls only for the user's own review;
* show saved-list edit controls only to owners;
* show contribution actions only to eligible users.

However:

**The backend remains the authoritative authorization boundary.**

Never consider hidden UI controls a security mechanism.

---

# PRIVACY

Ensure the UI does not accidentally expose:

* private saved notes;
* private lists;
* drafts;
* moderation details;
* private account data;
* exact location history.

Avoid putting sensitive information into:

* URLs;
* browser history;
* analytics;
* local storage;
* shared cache.

---

# LOCAL STORAGE

Use browser storage only for data appropriate to browser persistence.

Do not persist:

* access tokens where the authentication model uses secure cookies;
* refresh tokens;
* passwords;
* private moderation data;
* precise location history.

Temporary non-sensitive drafts may use local storage only when the product and privacy model permit it.

---

# FORM SECURITY

Protect forms against:

* XSS;
* unsafe HTML;
* unexpected rich-text injection;
* oversized payloads;
* malicious URLs.

Do not render review/contribution text as HTML unless the backend contract explicitly provides sanitized content and the client uses the required safe rendering path.

---

# ACCESSIBILITY

All authenticated experiences must support:

* keyboard navigation;
* screen readers;
* focus management;
* semantic labels;
* form error associations;
* accessible dialogs;
* accessible upload controls;
* accessible rating control;
* accessible notification state.

Ensure dynamically updated content is announced appropriately without excessive screen-reader noise.

---

# RESPONSIVE DESIGN

The authenticated area must work across:

* desktop;
* tablet;
* mobile browser.

Saved lists, reviews, contributions, and notifications should transition cleanly between:

* desktop side panels;
* responsive cards;
* mobile pages/drawers.

Do not build separate unrelated UIs for each breakpoint.

---

# PERFORMANCE

Optimize:

* long notification lists;
* review lists;
* saved-place lists;
* contribution history;
* media previews;
* upload progress;
* account pages.

Use:

* cursor pagination;
* list virtualization when justified;
* lazy media loading;
* image dimensions;
* efficient cache invalidation.

Do not load all reviews or notifications into memory.

---

# MEDIA PERFORMANCE

Use:

* appropriate preview dimensions;
* lazy loading;
* object URL cleanup;
* upload concurrency limits;
* resumable/chunked uploads where the backend contract supports them.

Do not upload large files multiple times because of unnecessary component remounts.

---

# NETWORK RESILIENCE

Handle:

* connection loss;
* request cancellation;
* slow uploads;
* retry;
* duplicate submission;
* resumed sessions.

Do not retry non-idempotent mutations blindly.

For uploads, use the backend's upload-session semantics where available.

---

# OBSERVABILITY

Instrument user-experience events such as:

* account settings save;
* saved-place mutation;
* contribution submission;
* review submission;
* media upload;
* notification interaction.

Collect only necessary telemetry.

Do not send:

* private notes;
* full review bodies;
* contribution drafts;
* push tokens;
* exact private locations;

into analytics by default.

---

# SECURITY

Inspect for:

* XSS;
* insecure browser storage;
* open redirects;
* token leakage;
* unauthorized route exposure;
* malicious media URLs;
* unsafe notification links;
* cross-user data display;
* privilege-escalation UI assumptions.

Do not trust route parameters for ownership.

---

# TESTING — ACCOUNT

Test:

* profile retrieval;
* profile editing;
* preferences;
* sessions;
* revocation;
* logout;
* account-security actions;
* authorization failure;
* session expiration.

---

# TESTING — SAVED PLACES

Test:

* save place;
* remove place;
* create list;
* edit list;
* delete list;
* add/remove item;
* private note;
* visibility;
* reordering;
* duplicate save;
* stale-version conflict;
* cross-user access denial.

---

# TESTING — CONTRIBUTIONS

Test:

* contribution creation;
* draft;
* edit;
* submission;
* withdrawal;
* status presentation;
* validation;
* conflict;
* authorization.

Verify that the UI never directly mutates authoritative Place data.

---

# TESTING — REVIEWS

Test:

* rating control;
* review creation;
* validation;
* editing;
* deletion;
* reporting;
* moderation-state presentation;
* duplicate-review conflict;
* unauthorized editing.

---

# TESTING — MEDIA

Test:

* file selection;
* validation;
* preview;
* upload authorization;
* upload progress;
* upload cancellation;
* processing state;
* failure;
* retry;
* deletion;
* authorization.

Use real upload behavior where the test environment permits it.

Do not treat mocked progress events as proof of backend upload correctness.

---

# TESTING — NOTIFICATIONS

Test:

* notification list;
* unread state;
* mark read;
* mark all read;
* pagination;
* notification deep links;
* preferences;
* push registration where supported;
* cross-user authorization.

---

# TESTING — PRIVACY

Verify that:

* private notes never appear in public components;
* private lists remain private;
* drafts remain private;
* moderation details are restricted;
* sensitive tokens are not stored insecurely;
* notification payloads do not expose unauthorized data.

---

# TESTING — ACCESSIBILITY

Run accessibility checks for:

* forms;
* dialogs;
* saved lists;
* reviews;
* contribution workflows;
* media upload;
* notification center;
* account settings.

Test keyboard-only flows.

---

# TESTING — PERFORMANCE

Measure practical performance for:

* long saved-list rendering;
* long review rendering;
* notification list;
* media upload UI;
* account page loading.

Do not claim global-scale browser performance from local benchmarks.

---

# DOCUMENTATION

Create or update documentation covering:

* authenticated web architecture;
* account management;
* session management;
* saved places;
* contributions;
* reviews;
* media uploads;
* notifications;
* preferences;
* authorization-aware UI;
* privacy;
* accessibility;
* caching;
* testing;
* upload configuration;
* browser push limitations.

Document actual implementation behavior only.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

Consume:

* account/profile APIs;
* session APIs;
* saved-place APIs;
* contribution APIs;
* review APIs;
* media APIs;
* notification APIs;
* moderation state;
* authorization contracts.

Use canonical IDs, enums, timestamps, and error contracts.

## Search

Publicly visible approved user-generated content may become searchable through the backend search projection.

Do not update search indexes directly from the frontend.

## Map

Saved places and reviews may be initiated from place-detail experiences.

Do not duplicate place truth.

## Navigation

Saved places may later be used as route origins/destinations.

Keep public place identifiers stable.

## Mobile

The web and mobile clients must use the same domain semantics for:

* saved places;
* reviews;
* contributions;
* media;
* notifications;
* account state.

## QA

Expose deterministic components and integration seams for comprehensive validation.

---

# PORTABLE FRONTEND CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* account UI state;
* saved-list UI model;
* contribution form model;
* review form model;
* media-upload state machine;
* notification UI model;
* authorization-aware component conventions;
* privacy conventions;
* accessibility behavior.

Do not create a competing source of truth for backend schemas.

---

# EXTERNAL SERVICE REALISM

Browser push, object storage, media-processing services, and notification providers may require external infrastructure.

When unavailable:

* implement the repository-side integration correctly;
* provide controlled error handling;
* provide deterministic test seams;
* accurately report external validation limitations.

Do not fabricate:

* successful media processing;
* push delivery;
* email delivery;
* provider credentials;
* cloud resources.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                               | Required Behavior                                              |
| ------------------------------------- | -------------------------------------------------------------- |
| Profile API unavailable               | Preserve existing local UI state and show recoverable error    |
| Session API unavailable               | Do not fabricate session information                           |
| Saved-place mutation fails            | Roll back optimistic state where used                          |
| Contribution submission fails         | Preserve form contents where safe and show failure             |
| Review submission fails               | Preserve unsent content and show retryable error               |
| Media upload fails                    | Preserve selected file state when possible and allow retry     |
| Media processing fails                | Show processing failure from backend; do not claim publication |
| Notification API unavailable          | Preserve already-loaded notifications and show refresh failure |
| Push registration fails               | Continue in-app notification experience                        |
| Notification preferences update fails | Keep server-confirmed state and show retry                     |
| Unauthorized resource access          | Remove/restrict inaccessible state without exposing details    |
| Session expires                       | Re-authenticate safely and stop privileged mutations           |
| Rate limit                            | Respect retry behavior and prevent mutation loops              |

Never fabricate successful user-content or media operations.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* inspect account routes;
* inspect session handling;
* inspect saved-place state;
* inspect list visibility;
* inspect contribution forms;
* inspect review forms;
* inspect moderation-state rendering;
* inspect media uploads;
* inspect notification state;
* inspect push integration;
* inspect browser storage;
* inspect privacy behavior;
* inspect authorization-aware UI;
* inspect accessibility;
* run tests;
* run type checking;
* run linting;
* run formatting;
* run production build;
* inspect performance;
* inspect generated client bundles for secrets;
* remove debug code;
* remove unused dependencies;
* verify no fake backend behavior;
* verify no unrelated future-domain implementation.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* account UI;
* profile UI;
* preference UI;
* session/device management;
* security UI;
* saved-place experience;
* saved-list experience;
* visibility;
* ordering;
* private notes;
* contribution workflows;
* contribution states;
* review creation;
* rating controls;
* review editing/deletion;
* review reporting;
* moderation-state presentation;
* media upload;
* media preview;
* media-processing state;
* media deletion;
* notification center;
* notification preferences;
* push registration where supported;
* server-state/caching changes;
* optimistic updates;
* privacy changes;
* accessibility changes;
* security changes;
* observability;
* tests created;
* tests executed;
* accessibility validation;
* performance validation;
* documentation updates;
* compatibility considerations;
* known limitations;
* unresolved external dependencies.

The report must accurately describe actual repository changes.

Do not claim that media processing, push delivery, notification-provider delivery, moderation decisions, or external infrastructure were completed unless genuinely verified.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* account management is implemented;
* profile management is implemented;
* user preferences are implemented where supported;
* session/device management is implemented;
* logout is implemented;
* security actions are implemented where supported;
* high-risk account actions have explicit confirmation;
* authentication state is handled safely;
* saved places are implemented;
* saved lists are implemented;
* ownership is reflected in the UI;
* list visibility is implemented;
* private notes remain private;
* saved-place ordering works;
* saved-place conflicts are handled;
* contribution forms are implemented;
* contribution drafts work where supported;
* contribution submission works;
* contribution withdrawal works;
* contribution states are displayed accurately;
* authoritative Place data cannot be directly mutated by the client;
* review creation works;
* rating input is accessible;
* review editing works for authorized owners;
* review deletion works;
* review reporting works;
* public moderation states are displayed only when permitted;
* rating summaries use authoritative backend data;
* media selection works;
* client-side upload checks exist;
* backend upload authorization is consumed;
* upload progress works;
* processing states are represented;
* media previews are safe;
* media deletion works;
* notification center works;
* notification pagination is bounded;
* read state works;
* notification preferences work;
* browser push integration works where supported;
* invalid push registration is handled;
* private data is not placed into shared caches;
* sensitive data is not persisted insecurely;
* authorization-aware UI is implemented;
* frontend security protections are implemented;
* accessibility requirements are satisfied;
* responsive layouts work;
* server-state management is coherent;
* optimistic updates are used only where safe;
* network failures are handled;
* observability is implemented;
* account tests exist;
* saved-place tests exist;
* contribution tests exist;
* review tests exist;
* media tests exist;
* notification tests exist;
* privacy/security tests exist;
* accessibility tests exist;
* performance validation exists;
* API contracts are respected;
* documentation is current;
* portable frontend conventions are documented;
* the final diff was inspected;
* the production build succeeds where the environment permits;
* there are no fake provider results;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no credentials or secrets were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement administration dashboards, backend systems, routing/navigation engines, map-tile generation, or production cloud infrastructure during this authenticated user and user-generated-content frontend milestone.
