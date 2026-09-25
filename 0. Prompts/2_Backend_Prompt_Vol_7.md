# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 7

# ROLE

You are the senior backend engineering agent responsible for implementing the **user-owned location data, saved places, user contributions, reviews, ratings, place corrections, and associated moderation-ready backend capabilities** for a production-grade **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Backend Domain Engineer
* API Engineer
* PostgreSQL Engineer
* Geospatial Engineer
* Security Engineer
* Privacy Engineer
* Moderation Systems Engineer
* Distributed Systems Engineer
* Reliability Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement real, production-quality backend functionality for user-owned place organization and user-generated place information while preserving the authoritative geographic data model and keeping public source data, user data, and moderation state clearly separated.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive maps;
* geographic features;
* place discovery;
* search;
* autocomplete;
* geocoding;
* routing;
* traffic-aware routing;
* turn-by-turn navigation;
* real-time location;
* saved places;
* user contributions;
* reviews and ratings;
* place photos and media;
* notifications;
* moderation;
* administration;
* analytics;
* operational observability.

This milestone implements the backend capabilities that allow users to organize places and contribute information about places while maintaining clear separation between authoritative geographic records and user-generated content.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* saved places;
* user-created saved-place lists;
* saved-place organization;
* private place notes;
* contribution submission;
* contribution editing;
* contribution withdrawal;
* place-correction requests;
* user-generated place attributes where supported;
* reviews;
* ratings;
* review editing;
* review deletion;
* review reporting;
* contribution lifecycle;
* review lifecycle;
* moderation-ready state transitions;
* user-content ownership;
* content versioning;
* optimistic concurrency where needed;
* content idempotency;
* content rate limiting;
* duplicate-submission protection;
* moderation-event hooks;
* search/indexing event hooks;
* audit behavior for content changes;
* privacy controls;
* authorization;
* abuse prevention;
* API implementation;
* machine-readable contracts;
* database migrations;
* Redis usage where justified;
* observability;
* reliability controls;
* automated tests;
* integration tests;
* contract tests;
* concurrency tests;
* moderation-boundary tests;
* documentation.

This milestone establishes the user-generated content and saved-place backend.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* media-upload implementation;
* image processing;
* thumbnail generation;
* CDN media delivery;
* complete moderation/admin UI;
* advanced automated moderation or machine-learning classifiers;
* notification provider implementation;
* complete search ranking changes;
* map-tile generation;
* routing;
* navigation;
* live location telemetry;
* traffic processing;
* complete web application;
* complete mobile application;
* production Kubernetes provisioning;
* production cloud provisioning;
* analytics warehouse implementation.

This milestone may create event and contract hooks required by those systems.

Do not create fake media, moderation, or notification behavior merely to simulate future functionality.

---

# REPOSITORY INSPECTION

Inspect the repository before making changes.

Determine:

* current backend structure;
* user/account implementation;
* authorization implementation;
* Place and Address models;
* PlaceCategory implementation;
* dataset/provenance model;
* API contracts;
* OpenAPI;
* database schema;
* migrations;
* Redis;
* event infrastructure;
* queue infrastructure;
* search projection;
* audit implementation;
* existing saved-place code;
* existing review code;
* existing contribution code;
* existing moderation structures;
* observability;
* rate limiting;
* tests;
* documentation.

Treat the repository as authoritative for actual implementation state.

Do not assume previous AI conversations were executed.

Do not duplicate existing authoritative models.

Preserve compatible functionality.

When repository structures differ from the expected domain boundaries, make the smallest coherent compatibility-preserving change necessary within the current scope.

---

# BACKEND TECHNOLOGY CONTEXT

Use the project's existing backend direction:

* TypeScript;
* NestJS or the repository's compatible modular backend framework;
* PostgreSQL;
* PostGIS for geographic references;
* Redis where justified;
* event/queue infrastructure where available;
* OpenTelemetry-compatible observability;
* automated testing.

User-generated place content must reference the canonical Place entity rather than duplicating geographic truth.

---

# DOMAIN OWNERSHIP

Establish the following ownership boundaries:

* **Place domain** owns authoritative place identity and geographic source data.
* **Saved Places domain** owns user-owned saved-place organization.
* **Contribution domain** owns submitted corrections and user-proposed place changes.
* **Review domain** owns ratings and review content.
* **Moderation domain** owns moderation decisions and case state.
* **Media domain** will own media files in a later milestone.
* **Search domain** consumes approved/publicly visible content as derived data.
* **Notification domain** consumes events to deliver notifications later.

Do not place review or contribution state directly inside the authoritative Place table merely for convenience.

---

# SAVED-PLACE MODEL

Implement a user-owned saved-place model.

Support:

* saved-place ID;
* user ID;
* place ID;
* list ID where applicable;
* custom label;
* private note;
* created-at;
* updated-at;
* ordering metadata where needed.

Saved places must be private by default.

Do not expose a user's saved places to another user without explicit product authorization.

---

# SAVED-PLACE LISTS

Implement user-created lists.

A list should support:

* list ID;
* owner user ID;
* name;
* description where appropriate;
* visibility;
* created-at;
* updated-at;
* version.

Where supported, visibility may include:

* private;
* shared;
* public.

Do not implement complex collaboration unless explicitly supported by the repository's existing architecture.

---

# SAVED-PLACE UNIQUENESS

Define duplicate rules.

At minimum determine whether a user can save the same place:

* multiple times in one list;
* across different lists.

Use database constraints where the rule is deterministic.

Do not rely entirely on application-level duplicate checks.

Return controlled conflict responses for prohibited duplicates.

---

# SAVED-PLACE ORDERING

If lists support ordering:

* define an ordering model;
* support deterministic retrieval;
* avoid requiring full-list rewrites for every small reorder where possible.

Do not introduce an unnecessarily complex ranking system for a basic personal list.

---

# SAVED-PLACE AUTHORIZATION

Implement server-side authorization so that:

* users can access their own saved places;
* users cannot alter another user's private saved places;
* public/shared lists are accessible only according to their explicit visibility;
* administrative access is separately controlled.

Never trust a client-provided owner ID.

---

# SAVED-PLACE API

Implement APIs for:

* create list;
* update list;
* delete list;
* list user's lists;
* add place;
* remove place;
* update saved-place metadata;
* list places in a list;
* reorder where supported.

All APIs must use the project's canonical error and identifier conventions.

Use cursor pagination for large saved-place collections where appropriate.

---

# SAVED-PLACE CONCURRENCY

Protect against concurrent modifications.

Where ordering or list membership is versioned:

* use optimistic concurrency;
* expose a version or ETag equivalent where appropriate;
* reject stale writes;
* avoid silent last-write-wins behavior when it could cause data loss.

---

# SAVED-PLACE PRIVACY

Do not include:

* private notes;
* private lists;
* exact personal location history;

in public place APIs or search documents.

Public/shared lists require an explicit visibility model.

Do not log private saved-place contents unnecessarily.

---

# CONTRIBUTION DOMAIN

Implement a contribution model for user-proposed corrections and additions.

Contributions may propose:

* place correction;
* place information update;
* category correction;
* address correction;
* operating-hours correction;
* place addition where the product allows it;
* geographic correction where safely supported.

Do not allow contributions to directly overwrite authoritative place data.

---

# CONTRIBUTION MODEL

A contribution should support:

* contribution ID;
* contributor user ID;
* target place ID where applicable;
* contribution type;
* proposed changes;
* evidence/reference data where appropriate;
* status;
* version;
* created-at;
* updated-at;
* submitted-at;
* resolved-at.

The proposed change must remain separate from the canonical Place representation until approved.

---

# CONTRIBUTION PAYLOAD

Represent proposed changes structurally.

Avoid storing arbitrary unvalidated JSON when a typed schema is practical.

For each supported contribution type define allowed fields.

Validate:

* field presence;
* field types;
* field ranges;
* maximum size;
* allowed transitions;
* target ownership.

Do not allow a contributor to modify protected internal fields.

---

# CONTRIBUTION LIFECYCLE

Implement explicit states such as:

```text
DRAFT
  ↓
SUBMITTED
  ↓
UNDER_REVIEW
  ↓
APPROVED / REJECTED / WITHDRAWN
  ↓
PUBLISHED
```

Define legal transitions.

Prevent clients from directly setting moderation states.

Only authorized moderation/backend processes may transition a submitted contribution into an approval/rejection state.

---

# CONTRIBUTION IDEMPOTENCY

Use idempotency for contribution submission where duplicate submissions are possible.

Protect against:

* client retry;
* network retry;
* repeated submission;
* duplicate browser/mobile actions.

A duplicate request must not create multiple logically identical contributions when the same idempotency contract applies.

---

# CONTRIBUTION VERSIONING

Allow contributors to update a contribution only when its lifecycle permits it.

Use:

* version number;
* updated-at;
* optimistic concurrency.

A contribution that has entered a terminal moderation state should not be silently modified in place.

---

# CONTRIBUTION TO PLACE APPLICATION

When a contribution is approved:

* apply the authorized change to the authoritative Place domain through an explicit domain boundary;
* preserve source provenance;
* preserve audit history;
* record the contribution that caused the change;
* emit an appropriate domain event.

Do not bypass the authoritative place service by modifying its database directly from the contribution module.

---

# CONTRIBUTION REJECTION

Rejected contributions must remain auditable according to the project's retention/privacy model.

Store:

* decision;
* moderator/system actor;
* timestamp;
* reason where appropriate.

Do not expose internal moderation details to ordinary public users unless the product contract explicitly permits it.

---

# REVIEW MODEL

Implement the review domain.

A review should support:

* review ID;
* author user ID;
* place ID;
* rating;
* text;
* language where available;
* moderation status;
* created-at;
* updated-at;
* deleted-at where appropriate;
* version.

Reviews are user-generated content.

They must never become authoritative geographic truth.

---

# RATING MODEL

Implement the rating representation.

Define:

* minimum rating;
* maximum rating;
* allowed precision;
* validation;
* association with review where required.

Do not allow arbitrary strings for rating values.

Keep the canonical numerical representation separate from presentation formatting.

---

# REVIEW UNIQUENESS

Define whether a user may submit:

* one active review per place;
* multiple reviews;
* one review with edits.

Implement the selected policy consistently.

If one active review per place is the product rule, enforce it through a database constraint where practical.

Do not allow concurrent requests to create unintended duplicate active reviews.

---

# REVIEW CREATION

Implement secure review creation.

Validate:

* authenticated user;
* target place;
* rating;
* text length;
* permitted language fields;
* content limits.

Do not trust client-provided author IDs.

The authenticated user must be the authoritative review author.

---

# REVIEW EDITING

Implement review updates according to the lifecycle model.

Use optimistic concurrency.

Prevent edits to:

* another user's review;
* deleted reviews;
* terminally moderated content where editing is prohibited.

Every modification must update appropriate timestamps/version information.

---

# REVIEW DELETION

Implement user-initiated deletion where supported.

Prefer a lifecycle-aware deletion model when auditability or moderation requires preserving internal records.

Public APIs must not expose deleted content.

Do not physically destroy moderation/audit information merely because a user-visible review was deleted unless the project's privacy/retention policy requires it.

---

# REVIEW REPORTING

Implement a reporting endpoint for reviews.

A report should support:

* report ID;
* reporter;
* target review;
* reason code;
* optional details;
* created-at;
* status.

Validate:

* authenticated user;
* target existence;
* reason validity;
* duplicate-report policy.

Do not allow reporters to set the moderation result.

---

# CONTENT ABUSE PROTECTION

Protect contributions and reviews against:

* spam;
* automation;
* flooding;
* duplicate submissions;
* excessive edits;
* abusive payloads;
* unauthorized targeting;
* oversized text;
* enumeration.

Use:

* rate limits;
* input limits;
* authentication;
* idempotency;
* moderation states.

Do not invent an automated trust score without an explicit product requirement.

---

# CONTENT RATE LIMITING

Apply content-specific rate limits for:

* contribution submissions;
* contribution edits;
* review creation;
* review edits;
* review reports;
* saved-list creation where appropriate.

Differentiate high-value mutation operations from inexpensive reads.

Do not use a single universal limit for all content actions.

---

# REVIEW TEXT LIMITS

Define explicit limits for:

* minimum text length where required;
* maximum review length;
* control characters;
* excessive repeated characters;
* oversized payloads.

Avoid silently truncating user content.

Reject invalid oversized content with a stable validation response.

---

# CONTENT NORMALIZATION

Normalize content only where safe and necessary.

Examples:

* Unicode normalization;
* whitespace normalization;
* canonical language metadata.

Preserve user-visible text separately from normalized forms.

Do not rewrite a user's review text into a different meaning.

---

# MODERATION BOUNDARY

Create the backend integration boundary for moderation.

Moderation must be able to evaluate:

* reviews;
* reports;
* contributions.

The moderation subsystem owns the moderation state.

Do not allow individual domain modules to invent incompatible moderation workflows.

---

# MODERATION CASE MODEL

Where the current repository architecture permits, implement the foundational moderation case model.

A case may support:

* case ID;
* target type;
* target ID;
* reporter;
* reason;
* status;
* assigned moderator;
* decision;
* decision reason;
* created-at;
* updated-at;
* resolved-at.

Do not implement the complete administrative moderation interface in this milestone.

---

# MODERATION STATES

Use explicit states such as:

* pending;
* under-review;
* approved;
* rejected;
* removed;
* restored;
* closed.

Define legal transitions.

Do not allow arbitrary client-selected transitions.

---

# MODERATION AUTHORIZATION

Only authorized moderation roles may:

* inspect restricted moderation data;
* approve contributions;
* reject contributions;
* remove content;
* restore content;
* change moderation state.

Moderation authorization must be enforced server-side.

---

# MODERATION AUDIT

Record:

* actor;
* action;
* target;
* previous state;
* new state;
* timestamp;
* reason;
* request/correlation ID.

Do not store unnecessary private content inside audit records.

---

# SEARCH INTEGRATION

Approved/public user-generated content may influence future search projections.

Do not write directly into the search index from the review or contribution database transaction.

Instead:

* persist canonical content;
* emit versioned domain events;
* let the search projection consume approved changes.

Applicable events may include:

* `ContributionSubmitted`;
* `ContributionApproved`;
* `ContributionRejected`;
* `ReviewCreated`;
* `ReviewUpdated`;
* `ReviewDeleted`;
* `ReviewModerated`.

Preserve the project's established event envelope and versioning.

---

# PLACE UPDATE INTEGRATION

Approved place corrections must flow through the authoritative Place domain.

Do not:

* mutate place records directly from a review/contribution controller;
* bypass place-domain authorization;
* bypass source/provenance handling;
* bypass audit.

Use a well-defined internal application/domain interface.

---

# EVENT IDEMPOTENCY

Events generated by this milestone must be safe for at-least-once delivery.

Consumers must be able to identify:

* event ID;
* entity ID;
* version;
* occurred-at;
* producer.

Do not require exactly-once messaging semantics.

---

# NOTIFICATION INTEGRATION HOOKS

The following events may later drive notifications:

* contribution submitted;
* contribution approved/rejected;
* review reported;
* review moderated;
* shared-list changes where applicable.

This milestone may publish notification intents/events, but does not implement third-party notification delivery.

Do not fabricate push/email delivery.

---

# REDIS

Use Redis only where justified.

Potential uses include:

* short-lived duplicate-report suppression;
* mutation rate limiting;
* idempotency windows;
* cached public review summaries where appropriate.

For every key define:

* namespace;
* TTL;
* serialization;
* owner;
* failure behavior.

Do not store authoritative reviews or contributions only in Redis.

---

# CACHE SAFETY

Public review summaries may be cached only if:

* the cache key is deterministic;
* moderation/deletion changes invalidate or version the cached representation;
* private content is never stored in a shared public cache;
* stale behavior is documented.

Do not cache private contribution data in shared caches.

---

# DATABASE MODEL

Implement real PostgreSQL migrations for:

* saved-place lists;
* saved places;
* contributions;
* contribution versions where required;
* reviews;
* review reports;
* moderation cases where in scope.

Use:

* foreign keys;
* unique constraints;
* indexes;
* version fields;
* timestamps;
* status constraints.

Do not store arbitrary unbounded JSON blobs when relational structure is practical.

---

# DATABASE INDEXING

Add indexes appropriate to access patterns.

Evaluate indexes for:

* user → saved lists;
* list → saved places;
* user → contributions;
* place → contributions;
* user → reviews;
* place → reviews;
* review → reports;
* moderation status;
* moderation assignment;
* lifecycle state;
* created-at/updated-at.

Avoid indexing every field.

Validate important query plans.

---

# TRANSACTIONS

Use transactions for operations that require atomic consistency, including where applicable:

* saved-place creation plus membership;
* contribution submission;
* review creation;
* review report creation;
* moderation state transition;
* approved contribution application.

Do not hold transactions open during external provider calls.

---

# CONCURRENCY

Protect concurrent operations such as:

* duplicate saved-place insertion;
* simultaneous review creation;
* concurrent review edits;
* contribution edits;
* contribution approval;
* moderation transitions.

Use:

* database uniqueness;
* optimistic versions;
* row-level locking where justified;
* transactional state transitions.

Do not rely solely on application checks in race-prone operations.

---

# REVIEW SUMMARY PROJECTION

Where the product requires place rating summaries, implement them as derived data.

A place's rating summary may include:

* total review count;
* average rating;
* distribution by rating.

Clearly distinguish:

* individual review source of truth;
* derived summary.

Use transactional or asynchronous projection according to the repository architecture.

Do not place authoritative review content inside Place merely to compute a summary.

---

# REVIEW SUMMARY CONSISTENCY

Define acceptable consistency.

After a review mutation:

* update derived summary synchronously when required by product semantics;
* or emit an event for asynchronous recalculation.

Whichever model is selected must be documented.

Do not claim immediate consistency if the implementation is asynchronous.

---

# CONTRIBUTION APPLICATION SAFETY

When an approved contribution modifies a place:

* validate the proposed field again against current authoritative state;
* detect conflicts;
* use concurrency control;
* preserve provenance;
* emit an audit record;
* emit the appropriate domain event.

A contribution that was valid against an older place revision must not blindly overwrite newer authoritative changes.

---

# CONTENT CONFLICTS

When contribution approval encounters a changed place:

* detect version mismatch;
* reject or re-evaluate the stale contribution;
* do not overwrite newer authoritative information silently.

Return a controlled conflict outcome.

---

# USER DATA PRIVACY

The following data is user-owned and potentially private:

* saved-place lists;
* private notes;
* contribution drafts;
* unpublished contributions;
* moderation reports;
* account-associated review history.

Apply server-side authorization and appropriate retention.

Do not put private notes or unpublished contributions into search indexes.

---

# PUBLIC REVIEW DATA

Public review responses must expose only approved/public fields.

Do not expose:

* moderator identity unless explicitly permitted;
* private moderation notes;
* internal abuse scores;
* reporter identity without authorization;
* internal database identifiers where not intended.

---

# ADMINISTRATIVE READ BOUNDARIES

Moderation/support users may have broader access, but permissions must remain explicit.

A support operator must not automatically receive all administrator permissions.

A moderator should not receive unrelated infrastructure or security credentials.

Use least privilege.

---

# AUDIT

Generate audit records for security-sensitive content actions including:

* contribution approval/rejection;
* review removal/restoration;
* moderation decisions;
* administrative edits;
* private-list visibility changes where required.

Audit records must include request/correlation context where safe.

Do not record secrets or unnecessary private content.

---

# OBSERVABILITY

Instrument:

* saved-place mutations;
* contribution submissions;
* contribution approvals;
* review creation;
* review edits;
* review deletion;
* review reports;
* moderation transitions;
* duplicate/conflict responses;
* rate-limit rejections;
* database latency;
* event publication;
* derived review-summary updates.

Track:

* request rate;
* p50/p95/p99 latency;
* validation failure rate;
* moderation backlog where available;
* event lag;
* cache behavior where used.

Avoid logging private notes and sensitive user content.

---

# SECURITY

Protect against:

* IDOR;
* unauthorized list access;
* unauthorized review editing;
* unauthorized contribution modification;
* privilege escalation;
* moderation bypass;
* malicious payloads;
* spam;
* scraping;
* mass-report abuse;
* duplicate mutation;
* race conditions;
* SQL injection;
* excessive payload size.

Never trust:

* user ID from request body;
* role from client;
* author ID;
* contribution owner ID;
* moderation status from client.

Derive authoritative identity and permission from the authenticated server-side context.

---

# RATE-LIMIT AND ABUSE POLICY

Implement bounded limits for:

* saved-list creation;
* contribution creation;
* contribution submission;
* review creation;
* review edits;
* reports;
* moderation actions.

Use stronger controls for high-cost or abuse-prone operations.

Do not allow a single client to flood moderation with unlimited reports.

---

# API IMPLEMENTATION

Implement APIs according to the project's canonical contract.

At minimum support:

## Saved Places

* list management;
* saved-place creation;
* saved-place deletion;
* saved-place metadata update;
* retrieval;
* ordering where supported.

## Contributions

* draft creation where supported;
* submission;
* update;
* withdrawal;
* status retrieval.

## Reviews

* create;
* retrieve;
* list;
* update;
* delete;
* report.

## Moderation

Only the bounded backend moderation endpoints required by this milestone.

Do not implement a complete administration application.

---

# PAGINATION

Use bounded cursor pagination for:

* saved places;
* list contents;
* contribution history;
* review lists;
* reports;
* moderation cases.

Define:

* cursor;
* stable sort;
* page size;
* maximum page size;
* invalid cursor behavior.

Do not rely on unbounded offsets for large review collections.

---

# API RESPONSE PRIVACY

Ensure list endpoints do not accidentally return:

* private notes;
* unpublished contributions;
* hidden reviews;
* moderator-only fields;
* reporter identity;
* internal moderation metadata.

Response schemas must be explicitly defined.

---

# API CONTRACTS

Create or update machine-readable contracts for:

* saved-place APIs;
* contribution APIs;
* review APIs;
* review-report APIs;
* moderation APIs;
* relevant error codes;
* status enums;
* pagination.

Ensure API documentation matches the implementation.

---

# EVENT CONTRACTS

Create or update event schemas for applicable events:

* `SavedPlaceCreated`;
* `SavedPlaceRemoved`;
* `SavedListCreated`;
* `ContributionSubmitted`;
* `ContributionWithdrawn`;
* `ContributionApproved`;
* `ContributionRejected`;
* `ReviewCreated`;
* `ReviewUpdated`;
* `ReviewDeleted`;
* `ReviewReported`;
* `ReviewModerated`.

For each event define:

* producer;
* payload;
* version;
* entity ID;
* timestamp;
* correlation ID;
* delivery semantics;
* compatibility behavior.

Do not create duplicate event names if compatible definitions already exist.

---

# TESTING — UNIT

Create meaningful unit tests for:

* saved-place ownership;
* list visibility;
* contribution validation;
* lifecycle transitions;
* review validation;
* rating boundaries;
* moderation transitions;
* authorization policies;
* conflict detection;
* event creation;
* pagination;
* cache-key construction;
* rate-limit policy.

---

# TESTING — DATABASE

Use real PostgreSQL integration tests where available.

Validate:

* migrations;
* constraints;
* unique saved-place rules;
* review uniqueness if applicable;
* foreign keys;
* indexes;
* concurrent mutation behavior;
* transactional moderation;
* contribution approval behavior.

Do not replace race-prone database behavior entirely with mocks.

---

# TESTING — API

Test:

* unauthorized access;
* authorized access;
* cross-user access;
* saved-place creation;
* duplicate saved place;
* contribution creation;
* contribution submission;
* contribution withdrawal;
* review creation;
* review editing;
* review deletion;
* review reporting;
* moderation authorization;
* pagination;
* rate limiting;
* safe response filtering.

Verify responses against OpenAPI or equivalent contracts.

---

# TESTING — CONCURRENCY

Explicitly test race conditions for:

* duplicate review creation;
* concurrent review edits;
* concurrent contribution updates;
* simultaneous contribution approval;
* duplicate saved-place creation.

Verify database and versioning protections actually prevent inconsistent state.

---

# TESTING — MODERATION

Test:

* valid transitions;
* invalid transitions;
* unauthorized transitions;
* approved contribution application;
* rejected contribution behavior;
* removed review behavior;
* restored review behavior;
* audit creation.

Ensure ordinary users cannot mutate moderation state.

---

# TESTING — EVENTS

Validate:

* event schemas;
* event version;
* entity identifiers;
* duplicate delivery safety;
* stale event handling;
* publication failure behavior.

Do not claim exactly-once delivery.

---

# TESTING — PRIVACY AND SECURITY

Verify:

* users cannot read another user's private lists;
* users cannot read another user's private notes;
* users cannot edit another user's review;
* users cannot modify another user's contribution;
* moderators cannot access unrelated administrator capabilities;
* internal moderation fields are hidden;
* secrets are not logged;
* private data is not emitted in public events.

---

# PERFORMANCE

Validate practical performance for:

* saved-place listing;
* review listing;
* review creation;
* contribution submission;
* moderation queues.

Inspect:

* database indexes;
* pagination queries;
* duplicate-check queries;
* aggregation queries;
* transaction duration.

Do not load an entire review collection into application memory.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                               | Required Behavior                                                                                   |
| ------------------------------------- | --------------------------------------------------------------------------------------------------- |
| PostgreSQL unavailable                | Return controlled service failure; never fabricate user content                                     |
| Redis unavailable                     | Bypass cache where safe; preserve authoritative data                                                |
| Event publication unavailable         | Preserve transactional state and use the project's reliable publication mechanism where implemented |
| Duplicate review submission           | Return a controlled conflict according to policy                                                    |
| Stale contribution update             | Return a concurrency conflict                                                                       |
| Contribution applied to changed place | Reject/reconcile rather than silently overwrite newer place data                                    |
| Unauthorized moderation request       | Return controlled authorization failure                                                             |
| Moderation transition conflict        | Reject without corrupting state                                                                     |
| Excessive report traffic              | Rate-limit safely                                                                                   |
| Invalid review content                | Return stable validation error                                                                      |

Do not fabricate successful content mutations when persistence or required downstream processing failed.

---

# DOCUMENTATION

Create or update documentation covering:

* saved places;
* list visibility;
* saved-place ownership;
* contribution lifecycle;
* contribution schema;
* contribution approval flow;
* review model;
* rating rules;
* review lifecycle;
* reporting;
* moderation boundaries;
* authorization;
* privacy;
* rate limits;
* events;
* search integration hooks;
* derived rating summaries;
* concurrency;
* migrations;
* testing;
* operational behavior.

Document actual implementation only.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* authoritative places;
* search;
* notifications;
* moderation;
* administration;
* media;
* analytics.

## Web

The web client must be able to consume:

* saved lists;
* saved places;
* place contributions;
* reviews;
* ratings;
* reports where authorized.

## Mobile

The mobile client must be able to:

* manage saved places;
* submit contributions;
* create/edit reviews;
* report content;
* receive public moderation outcomes where supported.

## Infrastructure

Infrastructure must support:

* PostgreSQL;
* Redis where used;
* event/queue infrastructure;
* observability;
* API scaling.

## QA

QA must be able to validate:

* ownership;
* moderation;
* content lifecycle;
* concurrency;
* pagination;
* privacy;
* security;
* event compatibility.

Do not create separate web and mobile content models.

---

# PORTABLE CONTENT CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* saved-place schema;
* saved-list schema;
* contribution schema;
* contribution lifecycle;
* review schema;
* rating rules;
* report schema;
* moderation case schema;
* moderation transitions;
* content visibility rules;
* relevant API contracts;
* event contracts;
* pagination rules;
* authorization matrix.

Document which artifact is authoritative.

Do not create conflicting duplicate models.

---

# SECURITY REVIEW

Before completion, inspect for:

* IDOR;
* ownership bypass;
* moderation bypass;
* role escalation;
* cross-user content access;
* report abuse;
* contribution flooding;
* review flooding;
* malicious text;
* payload-size abuse;
* SQL injection;
* cache leakage;
* private-data logging;
* public-event leakage.

Use server-side authorization and typed request validation.

---

# PRIVACY REVIEW

Verify that:

* private saved lists remain private;
* private notes never appear in public search;
* unpublished contributions remain restricted;
* moderation data is restricted;
* reviewer identity is represented according to product policy;
* deleted/removed content follows retention rules;
* exact user location is not introduced into content records unnecessarily.

Do not use content records as a substitute for location history.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* inspect migrations;
* inspect authorization guards;
* inspect ownership checks;
* inspect state transitions;
* inspect unique constraints;
* inspect concurrency handling;
* inspect event schemas;
* inspect OpenAPI;
* inspect pagination;
* inspect logs;
* inspect privacy behavior;
* inspect tests;
* run type checking;
* run linting;
* run formatting;
* remove debug code;
* remove unused dependencies;
* verify no media implementation was fabricated;
* verify no unrelated future-domain implementation was introduced.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* saved-list implementation;
* saved-place implementation;
* visibility/authorization behavior;
* contribution implementation;
* contribution lifecycle;
* contribution validation;
* contribution concurrency;
* contribution approval integration;
* review implementation;
* rating implementation;
* review editing/deletion;
* review reporting;
* moderation case foundation;
* moderation transitions;
* audit changes;
* Redis changes;
* database migrations;
* database/index changes;
* API changes;
* event changes;
* rate limiting;
* security changes;
* privacy changes;
* observability changes;
* tests created;
* tests executed;
* concurrency validation;
* moderation validation;
* documentation updates;
* compatibility considerations;
* known limitations;
* unresolved issues.

The report must accurately describe actual repository changes.

Do not claim that media, notifications, advanced moderation automation, analytics, or complete client applications were implemented.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* saved lists are implemented;
* saved places are implemented;
* ownership is enforced server-side;
* list visibility is implemented;
* duplicate saved-place rules are enforced;
* list ordering is deterministic where supported;
* pagination is bounded;
* optimistic concurrency exists where required;
* contributions are implemented;
* contribution payloads are typed and validated;
* contribution ownership is enforced;
* contribution lifecycle states are enforced;
* clients cannot set moderation decisions;
* contribution submission is idempotent where required;
* contribution versions prevent stale overwrites;
* approved contributions flow through the authoritative Place domain;
* contribution provenance is preserved;
* contribution conflicts are handled;
* reviews are implemented;
* ratings are validated;
* review ownership is enforced;
* review uniqueness policy is enforced;
* review editing is concurrency-safe;
* review deletion is implemented;
* review reporting is implemented;
* moderation cases are implemented where in scope;
* moderation transitions are enforced;
* moderation authorization is server-side;
* moderation actions are auditable;
* public responses hide restricted fields;
* content-specific rate limits are implemented;
* abuse protections exist;
* Redis is used only for justified ephemeral/caching workloads;
* PostgreSQL migrations are real;
* constraints and indexes are appropriate;
* transactions are correct;
* concurrency behavior is tested;
* search integration hooks are event-driven;
* notification integration hooks do not fabricate delivery;
* rating summaries are clearly derived from reviews;
* observability is implemented;
* privacy requirements are enforced;
* security review is complete;
* unit tests exist;
* database integration tests exist;
* API tests exist;
* concurrency tests exist;
* moderation tests exist;
* event tests exist;
* privacy/security tests exist;
* performance validation exists;
* documentation is current;
* portable content contracts exist;
* the final diff was inspected;
* there are no fake moderation outcomes;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no credentials or external services were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement media processing, notifications, advanced moderation automation, analytics, web/mobile clients, routing, navigation, or production cloud infrastructure during this user-content backend milestone.
