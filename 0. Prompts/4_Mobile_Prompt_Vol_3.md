Google Maps-Style Mapping & Navigation Platform — Mobile Prompt — Volume 3

# ROLE

Act as a senior mobile engineering team responsible for implementing the authenticated account, saved-content, user-generated-content, media, notification, and personalization experience for a production-grade Google Maps-style mapping and navigation platform.

Operate as a coordinated team of:

* Principal Mobile Architect
* Senior React Native Engineers
* Senior TypeScript Engineers
* Mobile UI/UX Engineers
* Mobile Security Engineers
* Mobile Privacy Engineers
* Media/Upload Engineers
* Notification Engineers
* Accessibility Engineers
* QA Engineers
* Performance Engineers
* Reliability Engineers
* Technical Writers

You are implementing production software.

Do not produce pseudo-code, toy implementations, fake uploads, fake notifications, mock persistence, placeholder screens, hardcoded secrets, TODO/FIXME implementation gaps, or knowingly incomplete production paths.

Implement only the functionality belonging to this prompt's bounded scope.

---

# PROJECT

Extend the mobile application into a complete authenticated user experience centered on:

* account and profile management
* preferences
* saved places
* saved lists
* private notes
* user contributions
* reviews and ratings
* content reporting
* media attachment workflows
* notification center
* notification preferences
* privacy controls
* optimistic updates and synchronization resilience

The implementation must consume the canonical backend contracts for identity, saved content, contributions, reviews, media, notifications, moderation/reporting, and privacy.

Do not create parallel mobile-only business semantics.

Do not move authoritative moderation, ownership, authorization, validation, or persistence logic into the mobile client.

---

# CURRENT IMPLEMENTATION SCOPE

Implement the authenticated account and user-generated-content mobile layer.

## 1. Account and Profile Experience

Implement the mobile account area.

Support:

* authenticated account overview
* profile display
* editable profile fields permitted by the backend
* avatar/profile-media presentation where supported
* account metadata returned by the API
* account loading state
* profile edit state
* save state
* validation state
* server error state
* retry behavior

Respect the canonical user/profile contract.

Do not expose fields that the backend does not authorize for the current user.

Do not assume that client-side ownership implies authorization.

---

## 2. Session and Account Security UX

Extend the existing authenticated session experience with account-security actions supported by the backend.

Support, where present in the canonical contract:

* session/device list
* sign-out current session
* sign-out other sessions
* account re-authentication for sensitive operations
* session-expiration messaging
* security-related confirmations
* authentication recovery entry points already supported by the platform

Sensitive account operations must require appropriate authentication according to backend policy.

Do not implement password or identity-management protocols independently of the backend contract.

Never display authentication secrets in UI diagnostics, logs, analytics, or error messages.

---

## 3. Preferences

Implement user preference management for settings exposed by the platform.

Support relevant preferences such as:

* units
* language/locale
* map display preferences
* navigation preferences already supported by the application
* notification preferences
* privacy preferences
* personalization settings
* accessibility-related preferences where persisted by the application

Use typed preference models.

Distinguish between:

* locally derived UI state
* persisted user preferences
* server-authoritative account settings
* device/platform settings

Handle server conflicts and stale preference writes safely.

Do not silently overwrite newer server state.

---

## 4. Saved Places

Implement the mobile saved-place experience.

Support:

* save a place
* unsave a place
* list saved places
* open saved place
* navigate to saved place
* map preview
* loading state
* empty state
* retry
* optimistic interaction where appropriate

Use the canonical place and saved-place identifiers.

Prevent duplicate saves through idempotent interaction and backend semantics.

Handle concurrent operations safely.

Do not create a separate local place database as the authoritative saved-place store.

---

## 5. Saved Lists

Implement user-managed saved lists.

Support:

* create list
* rename list
* delete list where authorized
* list saved places within a list
* add place to list
* remove place from list
* reorder entries where supported
* list visibility where supported
* list description where supported
* list sharing semantics where supported by the backend
* empty states
* loading states
* failure/retry states

Support the canonical list visibility model, including private/public/shared states only when defined by the backend.

Do not expose private lists through unauthorized deep links.

---

## 6. Private Notes

Implement private notes associated with saved places or other supported saved-content entities.

Support:

* create note
* edit note
* delete note
* note loading/saving state
* validation
* optimistic updates where safe
* conflict handling
* privacy-safe local rendering

Private notes must never be treated as public user-generated content.

Do not transmit note contents to telemetry.

Do not place note contents in crash/error metadata.

---

## 7. Saved Content Synchronization

Implement synchronization behavior for authenticated saved content.

Support:

* initial fetch
* refresh
* pagination where defined
* invalidation after writes
* optimistic mutation rollback
* duplicate prevention
* stale-response rejection
* offline-aware UI state
* retry after reconnect

Ensure mutations identify the exact server resource being changed.

Do not allow a stale list response to overwrite a newer mutation.

---

## 8. Contributions

Implement the mobile contribution workflow defined by the backend.

Supported contribution types may include, according to the canonical contract:

* place correction
* address correction
* category correction
* hours correction
* metadata correction
* new-place suggestion
* other approved contribution types

Support:

* contribution creation
* structured form entry
* draft state where supported
* validation
* submission
* submission confirmation
* contribution status
* contribution history
* pending/reviewed/rejected/approved states where contractually available

Do not implement moderation decisions locally.

The mobile application submits structured contributions to the backend and presents authoritative status.

---

## 9. Contribution Drafts

Implement local draft behavior only where appropriate and secure.

Support:

* draft creation
* local draft restoration
* draft editing
* draft discard
* explicit submission
* validation before submission

Do not store unnecessary sensitive information in plaintext local storage.

Ensure drafts cannot be accidentally submitted under the wrong authenticated account.

Clear account-scoped local draft state on secure account transitions where required.

---

## 10. Review and Rating Experience

Implement user reviews and ratings for eligible places.

Support:

* create review
* rating selection
* text review
* edit review
* delete review where supported
* submit state
* moderation/review status where exposed
* report review
* view own review
* view published review content when provided by the backend

Respect:

* rating bounds
* review length limits
* content policies exposed by the backend
* server-side moderation outcomes
* ownership rules

Do not implement local moderation algorithms.

Do not present unpublished or rejected content as publicly visible content.

---

## 11. Review State and Conflict Handling

Handle review mutations safely.

Support:

* optimistic UI only where the operation is reversible
* mutation identifiers
* retry behavior
* duplicate-submit prevention
* stale-response rejection
* edit conflicts
* deleted-content handling
* moderation-state changes

A failed mutation must restore a truthful UI state.

Do not show a review as successfully published merely because the local request left the device.

---

## 12. Content Reporting

Implement user-facing reporting for eligible content.

Support reporting of backend-authorized entities such as:

* places
* reviews
* media
* contributions
* other supported user-generated content

Provide:

* report reason selection
* optional explanation where supported
* confirmation
* submission state
* duplicate-report prevention
* success state
* error/retry handling

Do not expose internal moderation queues, moderator identities, internal risk scores, or privileged case information.

The backend remains authoritative for report processing.

---

## 13. Media Selection and Upload Workflow

Implement the mobile client workflow for attaching supported media to places or user-generated content.

Support:

* device photo-library selection
* camera capture where allowed
* media-type validation
* file-size validation
* dimension validation
* upload preparation
* upload initiation
* upload progress
* upload completion
* processing state
* failure state
* retry
* cancellation
* deletion/removal where authorized

Follow the canonical media-upload contract.

Do not upload media directly to an arbitrary third-party service outside the documented architecture.

---

## 14. Secure Media Handling

Apply mobile security controls to user media.

Handle:

* authenticated upload initiation
* signed upload URLs or equivalent secure mechanism
* expiration
* upload cancellation
* MIME-type validation
* filename safety
* metadata handling
* server-side scanning status
* derivative/processing status
* deletion

Do not trust the client-reported MIME type or media metadata as authoritative.

Do not expose private media URLs beyond their intended scope.

Do not log signed upload URLs or media-access credentials.

---

## 15. Media Processing States

Represent backend-controlled media lifecycle states.

Possible states include:

* pending
* uploading
* uploaded
* processing
* published
* rejected
* deleted
* failed

Only render published/authorized content as public content.

Do not infer successful media publication solely from upload completion.

Support refresh or realtime/poll-based state updates according to the existing backend contract.

---

## 16. Notification Center

Implement the authenticated notification center.

Support:

* notification list
* unread count
* read/unread state
* mark as read
* mark all as read where supported
* notification detail
* notification navigation/deep link
* pagination
* pull-to-refresh
* empty state
* error/retry state

Support notification categories defined by the backend without hardcoding unsupported categories.

Do not expose internal delivery metadata that has no user-facing purpose.

---

## 17. Notification Routing

Notifications must navigate users to the appropriate in-scope destination.

Examples include:

* place
* review
* contribution
* saved-list activity
* account/security event
* supported system message

Validate notification payloads before performing navigation.

Do not trust an unvalidated deep link or resource identifier received from a notification payload.

Handle deleted or inaccessible targets gracefully.

---

## 18. Push Notification Registration

Integrate mobile push registration with the canonical notification backend.

Support:

* device-token registration
* token refresh
* registration invalidation
* permission state
* login/logout relationship
* device identity according to the established contract
* environment separation
* provider failure handling

Do not hardcode push credentials.

Do not treat a stale device token as permanently valid.

Ensure logout/account transitions do not leave push registrations incorrectly associated with the wrong account.

---

## 19. Notification Preferences

Implement user controls for notification preferences exposed by the backend.

Support preferences such as:

* push
* email
* in-app
* account/security notifications
* contribution/review notifications
* supported personalized notifications

Use the canonical preference model.

Clearly distinguish application preference state from operating-system notification permission state.

A user disabling an in-app preference must not be interpreted as revoking the OS-level notification permission.

---

## 20. Privacy Controls

Implement mobile UI for privacy settings that are explicitly exposed by the platform.

Potential controls include:

* location-related privacy settings
* personalization controls
* contribution visibility
* profile visibility
* saved-list visibility
* notification personalization
* analytics/diagnostic participation where applicable

Do not present controls that imply stronger guarantees than the backend or platform actually enforces.

Changes to privacy settings must use the canonical authorization and persistence APIs.

---

## 21. Account-Scoped Local Storage

Audit and organize local device storage used by the mobile app.

Clearly classify local data into:

* account-scoped
* device-scoped
* public cache
* ephemeral UI state

Ensure account-scoped data cannot leak between users of the same device.

Account transitions must correctly:

* clear sensitive state
* invalidate account-scoped caches
* remove protected drafts where required
* reset user-specific notification state
* reset user-specific preferences where appropriate

Do not wipe public map/tile cache unnecessarily.

---

## 22. Offline and Synchronization Behavior

Handle user-generated-content actions during unreliable connectivity.

For supported operations, provide:

* explicit pending state
* retry
* safe cancellation
* mutation status
* stale-state detection

Do not silently pretend that a review, contribution, saved-place mutation, or media upload has reached the server when it has not.

Do not create an unbounded offline operation queue.

Where offline mutation support is not contractually defined, clearly communicate that the operation requires connectivity.

---

## 23. Optimistic UI

Use optimistic updates carefully for user actions where rollback is deterministic.

Appropriate examples may include:

* save/unsave
* mark notification read
* simple preference changes

Avoid optimistic confirmation for operations whose server-side processing is asynchronous or moderation-controlled, such as:

* contribution approval
* review publication
* media processing
* moderation outcomes

Rollback failed optimistic mutations cleanly.

Do not allow speculative local state to persist as if authoritative.

---

## 24. Accessibility

All authenticated and user-generated-content screens must support:

* screen readers
* semantic roles
* meaningful labels
* logical focus order
* dynamic text sizing
* accessible form validation
* accessible loading states
* accessible upload progress
* accessible error announcements
* accessible notification states
* sufficiently large touch targets
* keyboard and input accessibility
* non-color-only status indicators

Provide accessible alternatives for map-linked actions where necessary.

---

## 25. Localization

Support localized presentation of:

* account information
* saved-list labels
* review/rating UI
* contribution forms
* notification text
* upload status
* privacy settings
* validation messages
* accessibility labels
* dates and times
* units where relevant

Do not concatenate localized strings in ways that break grammatical ordering.

Use locale-aware formatting.

---

## 26. Performance

Optimize authenticated-content screens for long-term use.

Pay particular attention to:

* large saved lists
* paginated notifications
* review lists
* media previews
* upload memory usage
* image decoding
* cache pressure
* optimistic state updates
* account switching
* navigation transitions
* background upload state where supported
* repeated API requests

Use virtualized lists for potentially large collections.

Do not load every saved item or notification into memory unnecessarily.

Avoid decoding large images at full resolution when thumbnails or constrained dimensions suffice.

---

## 27. Security and Privacy

Apply strong protection throughout this prompt.

Sensitive information includes:

* profile data
* private notes
* saved content
* drafts
* precise location-related metadata
* private list information
* upload credentials
* notification tokens
* account/session metadata

Never place sensitive user content in:

* logs
* analytics
* crash reports
* request debug output
* URLs unless explicitly required by the contract
* public local caches

Ensure authorization failures are handled without leaking whether private resources belong to another account.

Do not assume client-side visibility state is a security boundary.

---

## 28. Testing

Create comprehensive tests for the functionality implemented in this prompt.

### Unit Tests

Cover:

* account state
* preference transformations
* saved-place mutations
* list ordering
* visibility handling
* draft state
* review validation
* report payload construction
* media validation
* upload-state transitions
* notification parsing
* notification routing
* push-registration state
* privacy settings
* account-scoped storage behavior
* optimistic rollback

### Component Tests

Cover:

* profile screens
* account settings
* saved places
* saved lists
* private notes
* contribution forms
* review creation/editing
* reporting
* media upload UI
* notification center
* notification settings
* privacy controls
* loading/error/empty states
* accessibility semantics

### Integration Tests

Cover:

* authenticated account load
* profile update
* save/unsave place
* create/edit/delete list
* add/remove list item
* private note lifecycle
* contribution submission
* contribution status display
* review submission
* review edit/delete
* content reporting
* media upload
* media processing state
* notification retrieval
* mark notification read
* push-token registration
* preference update
* account transition and local-state isolation

### Failure Tests

Explicitly test:

* unauthorized request
* expired session
* network loss
* timeout
* duplicate mutation
* stale response
* failed optimistic mutation
* upload interruption
* media rejection
* invalid notification target
* inaccessible private resource
* account switch with cached data

---

## 29. Contract Validation

Validate the implementation against the canonical backend contracts for:

* user/profile
* preferences
* saved places
* saved lists
* notes
* contributions
* reviews
* ratings
* reports
* media upload
* media lifecycle
* notifications
* notification preferences
* push-device registration
* privacy
* authentication/session

Verify:

* endpoint paths
* request schemas
* response schemas
* identifiers
* enum values
* timestamps
* pagination
* mutation semantics
* idempotency
* visibility
* authorization
* error codes
* media upload states
* notification payloads

Do not invent client-side interpretations that contradict the backend contracts.

---

## 30. Documentation

Create or update documentation covering:

* authenticated mobile architecture
* account state
* account-scoped local storage
* saved-content architecture
* contributions
* reviews
* reports
* media upload
* media lifecycle
* notification architecture
* push registration
* notification preferences
* privacy controls
* optimistic update policy
* offline/degraded behavior
* accessibility
* localization
* testing
* security/privacy safeguards
* troubleshooting

Documentation must reflect implemented behavior.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement:

* backend account/profile services
* backend saved-place persistence
* backend list persistence
* backend contribution workflows
* backend review/moderation processing
* backend media processing/scanning
* backend notification delivery infrastructure
* backend push providers
* moderation administration UI
* internal moderator tools
* analytics dashboards
* recommendation/ranking ML systems
* advanced social following/follower systems
* private messaging/chat
* full offline synchronization engine for all content
* downloaded offline maps
* routing-engine behavior
* active navigation
* navigation WebSocket implementation
* traffic ingestion
* transit ingestion
* cloud infrastructure
* Kubernetes infrastructure
* production backend database changes unrelated to a blocking mobile contract

Do not create fake screens for these systems.

Only implement mobile-facing integration points needed by the current scope.

---

# REPOSITORY INSPECTION

Before modifying anything:

1. Inspect the current React Native application structure.
2. Inspect authentication/session handling.
3. Inspect secure storage.
4. Inspect account/profile APIs and models.
5. Inspect preference infrastructure.
6. Inspect saved-place and saved-list contracts.
7. Inspect contribution and review contracts.
8. Inspect reporting contracts.
9. Inspect media upload contracts and existing media components.
10. Inspect notification APIs and push-registration infrastructure.
11. Inspect local persistence and caching.
12. Inspect state-management architecture.
13. Inspect deep-link/navigation integration.
14. Inspect accessibility and localization infrastructure.
15. Inspect test infrastructure.
16. Inspect existing security/privacy handling.
17. Inspect documentation relevant to authenticated mobile features.

Reuse compatible infrastructure.

Do not assume previous AI conversations or hidden implementation context exists.

The repository and explicit portable contract artifacts are the sources of truth available to the implementation.

Do not replace working foundational systems unnecessarily.

---

# IMPLEMENTATION RULES

Follow these rules throughout the work:

* Implement real production code.
* Do not use pseudo-code.
* Do not use fake persistence.
* Do not use fake notifications.
* Do not fake media-processing success.
* Do not fake review publication.
* Do not bypass authorization.
* Do not hardcode secrets.
* Do not leave TODO/FIXME implementation gaps.
* Do not store sensitive user content in logs.
* Do not leak private data through analytics.
* Do not trust client-side visibility flags as authorization.
* Do not allow account-scoped caches to leak between users.
* Do not let stale responses overwrite newer mutations.
* Do not create unbounded background queues.
* Do not create uncontrolled upload retries.
* Do not duplicate server-authoritative business rules.
* Use explicit mutation identifiers when required.
* Clean up subscriptions, timers, uploads, and listeners.
* Preserve platform-native permission behavior.
* Keep accessibility enabled.
* Keep localization correct.
* Keep media memory usage bounded.
* Test authorization failures and synchronization failures.
* Keep contracts typed and explicit.
* Implement only the current prompt's scope.

---

# PRODUCTION VALIDATION

Before considering this prompt complete:

* Build the mobile application for supported targets.
* Run type checks.
* Run linting.
* Run unit tests.
* Run component tests.
* Run integration tests available in the environment.
* Validate authenticated account loading.
* Validate profile editing.
* Validate preference updates.
* Validate save/unsave operations.
* Validate saved-list management.
* Validate private-note behavior.
* Validate contributions.
* Validate reviews/ratings.
* Validate reporting.
* Validate media upload and cancellation.
* Validate media-processing state handling.
* Validate notification center.
* Validate notification routing.
* Validate push-token registration.
* Validate privacy settings.
* Validate account-scoped local-state isolation.
* Validate network-failure recovery.
* Validate optimistic rollback.
* Validate accessibility.
* Validate localization where supported.
* Validate secure logging/telemetry.
* Validate no secrets are committed.
* Validate out-of-scope features are not represented as fake implementations.

Resolve in-scope defects found during validation.

Do not claim tests or platform checks were completed unless actually executed.

---

# EXPECTED DELIVERABLES

Produce the actual implementation and supporting artifacts.

Expected deliverables include, as applicable:

* account/profile screens
* account-security UI
* preference management
* saved places
* saved lists
* private notes
* contribution workflows
* contribution history/status
* review/rating workflows
* content reporting
* media selection/upload
* media lifecycle states
* notification center
* notification routing
* push registration
* notification preferences
* privacy settings
* account-scoped local persistence
* synchronization/resilience behavior
* accessibility support
* localization support
* automated tests
* platform configuration where required
* documentation
* contract-validation artifacts where appropriate

Keep the implementation cohesive.

Do not artificially fragment the implementation.

---

# INTEGRATION REQUIREMENTS

The implementation must expose stable mobile boundaries for future functionality.

Future mobile work must be able to consume:

* authenticated account state
* profile state
* preference state
* saved-content state
* contribution state
* review state
* media state
* notification state
* privacy state
* account-scoped persistence
* mutation/synchronization infrastructure

Maintain stable contracts for:

* user identifiers
* place identifiers
* list identifiers
* contribution identifiers
* review identifiers
* media identifiers
* notification identifiers
* visibility states
* moderation/publication states
* timestamps
* pagination
* mutation semantics
* error semantics

Document integration boundaries explicitly.

Do not require future implementations to infer critical semantics from screen code.

---

# COMPLETION REPORT

At the end of the implementation, provide a concise but specific completion report containing:

1. Account/profile experience implemented.
2. Account-security UI implemented.
3. Preferences implemented.
4. Saved places implemented.
5. Saved lists implemented.
6. Private notes implemented.
7. Contribution workflow implemented.
8. Contribution status/history implemented.
9. Reviews and ratings implemented.
10. Content reporting implemented.
11. Media selection/upload implemented.
12. Media processing-state handling implemented.
13. Notification center implemented.
14. Notification routing implemented.
15. Push registration implemented.
16. Notification preferences implemented.
17. Privacy controls implemented.
18. Account-scoped local-state protections implemented.
19. Synchronization/offline-degraded behavior implemented.
20. Accessibility completed.
21. Localization completed where supported.
22. Security/privacy protections completed.
23. Tests created and executed.
24. Validation commands executed and outcomes.
25. Documentation created or updated.
26. Important implementation decisions or deviations.
27. Environment/platform limitations encountered.
28. Exact files/modules/artifacts changed or created.

Do not claim completion for functionality that was not actually implemented and validated.

---

# DEFINITION OF DONE

This prompt is complete only when:

* Authenticated users can access and manage the in-scope account experience.
* Profile and preference changes use real backend contracts.
* Saved places work correctly.
* Saved lists support the required CRUD and ordering behavior.
* Private notes remain private and account-scoped.
* Contributions can be created and their authoritative statuses displayed.
* Reviews and ratings follow the canonical backend lifecycle.
* Reports can be submitted for supported content.
* Media can be selected, securely uploaded, and represented through authoritative processing states.
* Notifications can be retrieved, read, and routed safely.
* Push registration is integrated with the canonical notification system.
* Notification preferences are persisted correctly.
* Privacy controls reflect actual backend/platform behavior.
* Account-scoped local state cannot leak across accounts.
* Network failures and stale responses are handled safely.
* Optimistic mutations roll back correctly when necessary.
* Accessibility requirements are implemented.
* Localization infrastructure is respected.
* Sensitive information is excluded from logs and telemetry.
* Meaningful unit, component, and integration tests exist.
* Static analysis and applicable builds pass.
* Documentation reflects the actual implementation.
* No hardcoded secrets, fake production integrations, TODO/FIXME gaps, placeholder implementations, or pseudo-code remain in scope.
* The mobile authenticated-content architecture is ready for subsequent platform work without requiring replacement of this foundation.

**Implement only the current prompt's scope.**
