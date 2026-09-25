# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 8

# ROLE

You are the senior backend engineering agent responsible for implementing the **production media, notifications, user-preference delivery, administrative operations, moderation tooling backend, audit workflows, and operational support APIs** for a **Google Maps-style mapping and navigation platform**.

Operate as a multidisciplinary engineering organization consisting of:

* Principal Backend Engineer
* Backend Domain Engineer
* Media Platform Engineer
* Notification Systems Engineer
* Administration Systems Engineer
* Moderation Systems Engineer
* API Engineer
* Storage Engineer
* Distributed Systems Engineer
* Security Engineer
* Privacy Engineer
* Reliability Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement real, production-grade backend capabilities for media handling, notification orchestration, administration, moderation operations, auditability, and operational support while preserving the project's existing domain contracts.

This prompt defines a bounded backend implementation milestone.

**Implement only the current prompt's scope.**

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to provide:

* interactive maps;
* geographic features;
* places;
* address search;
* autocomplete;
* geocoding;
* route planning;
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

This milestone implements the backend media, notification, administration, moderation operations, and support capabilities needed by the completed platform.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* media asset management;
* secure media upload authorization;
* media metadata;
* media ownership;
* media-to-entity association;
* upload validation;
* MIME/content verification;
* file-size controls;
* checksum handling;
* malware/scanning integration boundary;
* media processing lifecycle;
* media derivatives;
* thumbnail generation where applicable;
* image metadata normalization;
* object-storage integration;
* signed media access;
* CDN-compatible media delivery;
* media deletion;
* media lifecycle cleanup;
* media moderation states;
* notification domain foundation;
* notification preferences;
* notification intents;
* in-app notifications;
* push-notification integration boundary;
* email-notification integration boundary where required;
* notification delivery state;
* delivery retries;
* provider abstraction;
* notification deduplication;
* notification rate limiting;
* administrative APIs;
* moderation operational APIs;
* report management;
* moderation assignment;
* moderation decisions;
* account restriction operations;
* administrative place/content actions within authorized scope;
* audit-log APIs;
* operational-support APIs;
* privileged authorization;
* high-risk action confirmation controls where appropriate;
* security and privacy protections;
* observability;
* reliability;
* queue/background processing;
* API contracts;
* event contracts;
* automated tests;
* integration tests;
* media-processing tests;
* notification tests;
* moderation tests;
* authorization tests;
* audit tests;
* resilience tests;
* documentation.

This milestone completes the backend operational capabilities surrounding media, notifications, moderation, and administration.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future domains.

The following are explicitly outside this milestone:

* complete web administration UI;
* complete mobile administration UI;
* full analytics warehouse/data lake;
* advanced machine-learning moderation;
* proprietary fraud-detection systems;
* search-engine redesign;
* routing-engine redesign;
* map-tile generation;
* navigation-engine redesign;
* complete mobile application;
* complete web application;
* production cloud provisioning;
* production Kubernetes provisioning;
* third-party account creation;
* fabrication of push, email, or storage provider credentials;
* fabrication of live provider responses;
* arbitrary financial/payment functionality.

This milestone may expose backend contracts consumed by client and infrastructure prompts.

Do not create fake provider behavior and present it as production integration.

---

# REPOSITORY INSPECTION

Inspect the repository first.

Determine:

* existing backend modules;
* user/account implementation;
* authentication;
* authorization;
* place domain;
* saved places;
* contributions;
* reviews;
* moderation model;
* audit system;
* object storage integration;
* media code;
* notification code;
* queue workers;
* event infrastructure;
* Redis;
* PostgreSQL schema;
* OpenAPI;
* configuration;
* observability;
* rate limiting;
* existing administration APIs;
* tests;
* architecture and contract artifacts.

Treat the repository as the source of truth for actual implementation state.

Do not assume previous AI conversations were executed.

Preserve compatible existing implementations.

Do not create duplicate media, notification, moderation, or audit models when authoritative implementations already exist.

---

# BACKEND TECHNOLOGY CONTEXT

Use the project's established backend technology direction:

* TypeScript;
* NestJS or the repository's compatible modular backend framework;
* PostgreSQL;
* Redis where justified;
* object storage;
* queue/event infrastructure;
* OpenTelemetry-compatible observability.

For image processing, use established libraries/tools such as ImageMagick, libvips, Sharp, or another repository-compatible production tool where appropriate.

Do not implement image codecs manually.

---

# DOMAIN OWNERSHIP

Maintain clear ownership:

* **Media domain** owns asset metadata, processing state, derivatives, and media lifecycle.
* **Object storage** owns binary objects.
* **Place domain** owns place identity.
* **Review/Contribution domains** own content associations.
* **Notification domain** owns notification intent, preference evaluation, and delivery state.
* **Provider adapters** own external push/email delivery integration.
* **Moderation domain** owns moderation decisions and case state.
* **Administration domain** owns privileged operational actions.
* **Audit domain** owns immutable operational audit records.

Do not allow media binaries, provider delivery state, or moderation decisions to become hidden fields in unrelated domains.

---

# MEDIA ASSET MODEL

Implement the canonical MediaAsset model.

Support, as applicable:

* media ID;
* owner user ID;
* associated entity type;
* associated entity ID;
* media type;
* declared MIME type;
* verified MIME type;
* size;
* checksum;
* storage key;
* processing status;
* moderation status;
* visibility;
* width;
* height;
* duration for supported media;
* derivative references;
* created-at;
* updated-at;
* deleted-at.

Do not trust client-provided MIME types.

---

# MEDIA LIFECYCLE

Implement explicit media states such as:

```text
REQUESTED
   ↓
UPLOAD_AUTHORIZED
   ↓
UPLOADED
   ↓
VALIDATING
   ↓
SCANNING
   ↓
PROCESSING
   ↓
READY
   ↓
PUBLISHED
```

Also support controlled terminal/exception states such as:

* rejected;
* quarantined;
* failed;
* deleted.

Define legal state transitions.

Clients must not arbitrarily mutate processing or moderation states.

---

# MEDIA UPLOAD AUTHORIZATION

Implement a secure upload workflow.

The backend should:

1. authenticate the requester where required;
2. authorize the target entity;
3. validate content type;
4. validate file size;
5. issue bounded upload authorization;
6. associate the resulting object with a MediaAsset;
7. require verification before publication.

Where direct-to-object-storage upload is used:

* issue short-lived scoped upload credentials or signed URLs;
* restrict object key;
* restrict content length where supported;
* restrict content type where appropriate;
* avoid exposing storage credentials.

Never expose permanent object-storage credentials to clients.

---

# OBJECT STORAGE

Implement the repository integration boundary for object storage.

Store binary objects using deterministic, non-user-controlled storage-key construction.

Keys must incorporate appropriate identifiers such as:

* media ID;
* asset type;
* derivative type;
* version.

Do not directly concatenate arbitrary client-supplied filenames into object keys.

Maintain enough metadata to recover or rebuild media derivatives.

---

# MEDIA VALIDATION

Validate uploaded content.

At minimum consider:

* actual MIME type;
* file signature/magic bytes where applicable;
* maximum size;
* dimensions;
* supported codecs;
* malformed image handling;
* decompression-bomb protections;
* corrupted file behavior.

Do not assume a valid extension means a valid file.

Reject unsupported or unsafe content.

---

# IMAGE PROCESSING

For supported image assets, implement derivative processing such as:

* thumbnail;
* preview;
* standard display size;
* high-resolution display variant where justified.

Define:

* maximum dimensions;
* resizing policy;
* orientation handling;
* metadata stripping where privacy requires it;
* output formats;
* quality policy;
* derivative naming.

Do not create unrestricted arbitrary client-selected transformations.

---

# MEDIA METADATA PRIVACY

Remove or restrict metadata such as:

* embedded GPS/EXIF coordinates;
* device identifiers;
* unnecessary timestamps;
* other sensitive embedded metadata.

Do not expose original private metadata merely because it exists in the uploaded file.

---

# MEDIA MODERATION

Media must pass through moderation/validation state before becoming public where the product requires it.

Separate:

* technical validation;
* malware/scanning;
* policy moderation;
* publication.

Do not treat successful image decoding as proof that media is safe for publication.

---

# MEDIA ACCESS CONTROL

Define visibility states such as:

* private;
* restricted;
* public;
* moderation-pending.

Server-side authorization must govern access.

Public media may be delivered through a CDN or controlled origin.

Private media must use authorization or short-lived signed access.

Do not expose unrestricted bucket access.

---

# MEDIA DELETION

Implement media deletion semantics.

Deletion must:

* revoke public availability where required;
* remove or invalidate derivatives;
* delete object references safely;
* preserve necessary audit records;
* support idempotent retries.

If asynchronous deletion is used, maintain explicit deletion state.

Do not declare deletion complete before the system has reached the defined terminal state.

---

# MEDIA CLEANUP

Implement background cleanup for:

* abandoned uploads;
* failed processing artifacts;
* orphaned derivatives;
* expired temporary objects.

Cleanup must be:

* bounded;
* observable;
* retry-safe;
* idempotent.

Do not delete an object that may still be referenced by an active MediaAsset.

---

# MEDIA JOBS

Use background jobs for:

* scanning;
* image processing;
* derivative generation;
* metadata extraction;
* cleanup.

Each job must define:

* job type;
* payload;
* timeout;
* retries;
* backoff;
* concurrency;
* idempotency;
* dead-letter behavior.

Do not process large image transformations synchronously inside latency-sensitive API requests.

---

# MEDIA EVENTS

Emit appropriate versioned events such as:

* `MediaUploadAuthorized`;
* `MediaUploaded`;
* `MediaValidationFailed`;
* `MediaProcessingCompleted`;
* `MediaPublished`;
* `MediaRemoved`.

Events must use the project's canonical event envelope.

Do not emit events containing secrets or unnecessary private metadata.

---

# NOTIFICATION DOMAIN

Implement the canonical Notification model.

A notification should support:

* notification ID;
* recipient user ID;
* notification type;
* title/body or structured content reference;
* channel;
* priority where applicable;
* delivery status;
* read status;
* provider message ID;
* created-at;
* sent-at;
* delivered-at;
* failed-at;
* expires-at where appropriate.

Do not make a notification itself the source of truth for the originating domain event.

---

# NOTIFICATION INTENT

Separate:

```text
Domain Event
     ↓
Notification Intent
     ↓
Preference Evaluation
     ↓
Channel Selection
     ↓
Provider Delivery
     ↓
Delivery Status
```

The Notification domain owns the orchestration.

Do not tightly couple core domain transactions to external notification providers.

---

# NOTIFICATION PREFERENCES

Implement user notification preferences for relevant channels.

Support, as appropriate:

* in-app;
* push;
* email.

Preferences must allow category-level controls where needed.

Do not hardcode every notification type directly into user rows.

Keep the preference model extensible.

---

# NOTIFICATION CATEGORIES

Define stable notification categories such as:

* account/security;
* contribution;
* review/moderation;
* saved-list sharing where applicable;
* navigation/trip alerts where product requirements permit;
* operational/product announcements where appropriate.

Security-critical account notifications may require mandatory delivery behavior according to product policy.

---

# NOTIFICATION DEDUPLICATION

Prevent duplicate notifications caused by:

* repeated domain events;
* retrying workers;
* provider retries;
* reconnects.

Use:

* event ID;
* idempotency key;
* notification identity;
* delivery attempt state.

Do not send duplicate user-visible notifications merely because a worker restarted.

---

# NOTIFICATION DELIVERY

Implement provider abstractions for:

* push notifications;
* email where required.

Each provider adapter must define:

* request;
* authentication;
* timeout;
* retry;
* error mapping;
* provider ID;
* rate limits;
* observability.

Never hardcode provider credentials.

---

# PUSH NOTIFICATION DEVICE TOKENS

Where push is implemented, support secure storage of:

* device ID;
* platform;
* application version;
* provider token;
* token status;
* last-seen timestamp.

Treat push tokens as sensitive credentials.

Do not expose raw provider tokens through APIs.

---

# EMAIL DELIVERY

Where email is included:

* normalize provider responses;
* support bounded retries;
* respect user preferences;
* avoid sending duplicates;
* record delivery state;
* redact email provider secrets.

Do not require live provider access for local unit tests.

---

# NOTIFICATION RETRIES

Retry transient failures only.

Use:

* bounded retry count;
* exponential backoff;
* jitter;
* provider-specific retry classification.

Do not endlessly retry invalid recipient/device tokens.

---

# INVALID DEVICE TOKENS

When a push provider indicates that a device token is invalid:

* mark it inactive;
* stop retrying indefinitely;
* preserve the device record;
* permit future re-registration.

Do not delete user accounts because of invalid push credentials.

---

# IN-APP NOTIFICATIONS

Implement a durable in-app notification store.

Support:

* unread state;
* mark read;
* mark all read where appropriate;
* bounded list retrieval;
* expiration where appropriate.

Use cursor pagination.

Do not load every historical notification into application memory.

---

# NOTIFICATION API

Implement APIs for:

* list notifications;
* mark notification read;
* mark multiple read where supported;
* retrieve notification preferences;
* update notification preferences;
* register/unregister push token where applicable.

Every endpoint must enforce authentication and user ownership.

A user must never access another user's notification records.

---

# NOTIFICATION PRIVACY

Notification payloads must not leak:

* private location;
* private saved notes;
* moderation details;
* sensitive account information;

unless the recipient is explicitly authorized and the product requires it.

Provider payloads must contain the minimum required data.

---

# ADMINISTRATION DOMAIN

Implement backend administration APIs for the operational tasks explicitly supported by the platform.

Potential capabilities include:

* user lookup;
* account suspension;
* account restoration;
* report lookup;
* moderation-case lookup;
* moderation assignment;
* content removal;
* content restoration;
* place correction review;
* audit-log search;
* operational status inspection.

Every operation must have explicit role authorization.

---

# ADMINISTRATIVE ROLE SEPARATION

Maintain least privilege between:

* support;
* moderator;
* administrator;
* security administrator;
* service account.

Do not give every administrative role unrestricted system access.

High-risk operations should require the highest appropriate permission.

---

# USER ACCOUNT OPERATIONS

Implement appropriately authorized administrative operations for:

* suspend account;
* restore account;
* invalidate sessions;
* force security reset where supported;
* inspect non-sensitive account metadata.

Do not expose passwords, raw refresh tokens, or secret authentication material to administrators.

---

# CONTENT OPERATIONS

Authorized moderators/administrators may:

* hide public review;
* restore review;
* resolve contribution;
* reject contribution;
* restrict media;
* restore media where policy permits;
* manage reports.

Every content operation must preserve lifecycle state and audit history.

---

# MODERATION QUEUE

Implement operational retrieval for moderation cases.

Support:

* status;
* priority;
* target type;
* target ID;
* assigned moderator;
* created-at;
* updated-at.

Use bounded cursor pagination.

Do not return unrestricted private evidence or internal metadata to unauthorized roles.

---

# MODERATION ASSIGNMENT

Where assignment is supported:

* prevent unauthorized assignment;
* support explicit assignee;
* preserve assignment history where useful;
* handle reassignment safely.

Concurrent moderators must not silently overwrite each other's actions.

---

# MODERATION DECISION

Implement server-side decision workflows.

A moderation decision must capture:

* actor;
* previous state;
* new state;
* reason;
* timestamp;
* request/correlation ID.

Do not permit clients to bypass valid lifecycle transitions.

---

# REPORT MANAGEMENT

Implement administrative retrieval of user reports.

Support:

* report status;
* target;
* reason;
* reporter access according to privacy policy;
* moderation linkage;
* creation/update timestamps.

Do not expose reporter identity broadly.

---

# HIGH-RISK ADMIN ACTIONS

For high-risk operations such as:

* account suspension;
* mass content removal;
* security resets;
* role changes;

implement stronger controls where appropriate:

* explicit permission;
* audit record;
* reason;
* confirmation;
* bounded batch size;
* idempotency.

Do not build unrestricted bulk mutation endpoints.

---

# ADMINISTRATIVE SEARCH

Administrative search must use explicit filters.

Do not expose raw SQL or search-engine query syntax.

Support only authorized fields and bounded result sets.

Protect against account enumeration and unnecessary exposure of personal data.

---

# AUDIT LOGGING

Expand the audit system to cover:

* media moderation;
* notification configuration changes where security-sensitive;
* account suspension/restoration;
* session invalidation;
* role changes;
* moderation decisions;
* content removal/restoration;
* administrative configuration changes.

Audit records must be append-only from the application's perspective.

Do not provide an API that allows arbitrary deletion or editing of historical audit records.

---

# AUDIT SEARCH

Implement a bounded audit-search API for authorized personnel.

Support filters such as:

* actor;
* action;
* target;
* date range;
* outcome.

Enforce:

* authorization;
* pagination;
* maximum date ranges;
* rate limiting.

Do not expose secrets or raw private payloads.

---

# ADMINISTRATIVE RATE LIMITING

Apply stronger protections to administrative endpoints.

Protect against:

* credential compromise;
* abusive automation;
* bulk deletion;
* mass suspension;
* report flooding;
* expensive audit searches.

Use:

* role-aware rate limits;
* request complexity limits;
* batch-size limits;
* audit logging.

---

# SECURITY

Protect media, notification, moderation, and administrative systems against:

* IDOR;
* privilege escalation;
* unauthorized media access;
* storage-key injection;
* malicious uploads;
* notification abuse;
* token leakage;
* moderation bypass;
* mass administrative actions;
* audit tampering;
* SSRF through provider integrations;
* unsafe provider callbacks.

Never trust:

* owner IDs;
* moderator IDs;
* role values;
* target IDs;
* notification recipients;

supplied by untrusted clients.

---

# MEDIA SECURITY

For media providers and processing workers:

* sandbox dangerous processing where practical;
* enforce resource limits;
* reject malformed files;
* prevent decompression bombs;
* prevent path traversal;
* prevent arbitrary command execution;
* use least-privileged storage access.

If FFmpeg or command-line media tools are used:

* invoke them through safe argument arrays;
* never construct shell commands from untrusted input;
* enforce execution time and resource limits.

---

# NOTIFICATION SECURITY

Protect against:

* notification impersonation;
* recipient substitution;
* provider-token leakage;
* notification flooding;
* preference bypass.

The backend must derive recipients from authoritative domain events or authenticated server state.

Do not trust client-provided recipient IDs for privileged notification operations.

---

# ADMINISTRATION SECURITY

Administrative authentication must be stronger than ordinary public API assumptions where the repository supports such controls.

Apply:

* least privilege;
* session controls;
* auditability;
* rate limits;
* secure authentication;
* authorization at every sensitive endpoint.

Do not create hidden backdoor administrative routes.

---

# PRIVACY

Media, notification, moderation, and administration all process potentially sensitive data.

Minimize:

* stored provider metadata;
* notification content;
* precise location references;
* user-identifying telemetry;
* administrative notes.

Do not place private navigation/location data into notification bodies unless necessary for a recipient-authorized capability.

---

# REDIS

Use Redis only for justified temporary workloads such as:

* notification deduplication;
* rate limiting;
* media-processing coordination;
* administrative lock coordination.

Every Redis key must define:

* namespace;
* TTL;
* ownership;
* serialization;
* failure behavior.

Do not store authoritative media, notifications, or audit logs solely in Redis.

---

# QUEUES

Use background queues for:

* media scanning;
* image processing;
* derivative generation;
* notification delivery;
* notification retries;
* stale-token cleanup;
* orphaned-media cleanup;
* moderation backfill where needed.

Each job must define:

* payload;
* timeout;
* retry count;
* backoff;
* concurrency;
* idempotency;
* dead-letter behavior.

Interactive administrative decisions must not disappear into an unobservable background queue.

---

# EVENTS

Consume/emit versioned events such as:

* `MediaUploaded`;
* `MediaPublished`;
* `MediaRemoved`;
* `NotificationRequested`;
* `NotificationDelivered`;
* `NotificationFailed`;
* `ContributionApproved`;
* `ContributionRejected`;
* `ReviewModerated`;
* `AccountSuspended`;
* `AccountRestored`;
* `SessionInvalidated`;
* `ModerationCaseAssigned`.

Preserve the project's canonical envelope.

Do not create duplicate versions of existing event definitions.

---

# FAILURE BEHAVIOR

Implement controlled behavior for:

| Failure                                                       | Required Behavior                                                                         |
| ------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| Object storage unavailable                                    | Preserve authoritative media metadata; fail upload/processing safely                      |
| Media scanner unavailable                                     | Keep media unpublished/quarantined; do not bypass scanning                                |
| Image processor unavailable                                   | Retry bounded processing; do not claim media ready                                        |
| Notification provider unavailable                             | Preserve notification intent/delivery state for retry where supported                     |
| Push token invalid                                            | Mark token inactive; do not retry indefinitely                                            |
| Email provider unavailable                                    | Retry transient failures; preserve delivery state                                         |
| Redis unavailable                                             | Continue authoritative operations where safe; disable only dependent ephemeral behavior   |
| Queue worker unavailable                                      | Preserve durable jobs for later recovery                                                  |
| Moderation database unavailable                               | Do not claim moderation action succeeded                                                  |
| Audit persistence unavailable during mandatory audited action | Fail or block the action according to the security policy; do not silently omit the audit |
| Concurrent moderation action                                  | Reject stale/conflicting mutation rather than silently overwriting                        |
| Unauthorized administrative request                           | Return controlled authorization failure                                                   |
| Media deletion partially fails                                | Maintain deletion state and retry safely                                                  |

Never fabricate successful media, notification, moderation, or administrative outcomes.

---

# OBSERVABILITY

Instrument:

* media-upload requests;
* processing latency;
* scan failures;
* derivative generation;
* object-storage operations;
* media deletion;
* notification creation;
* notification delivery;
* provider failure;
* invalid token rates;
* moderation queue size;
* moderation latency;
* administrative actions;
* audit writes;
* audit searches;
* rate-limit rejections.

Track:

* p50;
* p95;
* p99;
* error rates;
* retry rates;
* queue depth;
* processing lag;
* notification delivery lag.

Never log:

* provider secrets;
* push tokens;
* passwords;
* access tokens;
* refresh tokens;
* signed URLs where logging them could grant access;
* unnecessary private notification contents;
* unnecessary moderation evidence.

---

# PERFORMANCE

Validate:

* media-upload authorization latency;
* media metadata lookup;
* notification creation;
* notification retrieval;
* moderation queue retrieval;
* audit search;
* concurrent media-processing workloads;
* notification worker throughput.

Do not perform expensive image transformations synchronously in request handlers.

Do not use unbounded database scans for audit or notification retrieval.

---

# API CONTRACTS

Implement/update authoritative API contracts for:

## Media

* upload authorization;
* metadata retrieval;
* association;
* deletion;
* public/private access where applicable.

## Notifications

* list;
* read;
* preferences;
* push-token registration.

## Administration

* authorized user management;
* moderation cases;
* reports;
* content actions;
* audit search.

All endpoints must define:

* authentication;
* authorization;
* request;
* response;
* errors;
* pagination;
* rate limits;
* idempotency where applicable.

---

# MEDIA CONTRACT

The public media contract must make clear:

* media ID;
* associated entity;
* processing status;
* moderation status;
* visibility;
* dimensions;
* available derivatives;
* public access URL/reference where authorized.

Do not return private object-storage credentials.

---

# NOTIFICATION CONTRACT

Notification APIs must distinguish:

* notification identity;
* type;
* payload;
* read state;
* delivery state.

Do not expose internal provider details unnecessarily.

---

# ADMIN CONTRACT

Administrative APIs must expose only the minimum information required for authorized operations.

Responses must distinguish:

* public content;
* operational metadata;
* privileged moderation information;
* sensitive security information.

---

# TESTING — MEDIA

Create integration and unit tests covering:

* upload authorization;
* invalid MIME;
* spoofed extension;
* oversized files;
* malformed images;
* EXIF stripping;
* derivative generation;
* object-storage failures;
* scan failure;
* processing retries;
* deletion;
* orphan cleanup;
* access control;
* signed-access expiry;
* media moderation state.

Where media tooling is available, use real processing rather than mocks for processing correctness tests.

---

# TESTING — NOTIFICATIONS

Test:

* notification intent creation;
* preference evaluation;
* disabled channel;
* enabled channel;
* deduplication;
* provider success;
* provider transient failure;
* provider permanent failure;
* invalid push token;
* retry/backoff;
* read/unread state;
* notification pagination;
* cross-user authorization.

Do not rely entirely on mocked providers for orchestration logic.

---

# TESTING — MODERATION

Test:

* case retrieval;
* assignment;
* reassignment;
* decision transitions;
* unauthorized moderator access;
* stale concurrent actions;
* report handling;
* content removal;
* restoration;
* audit creation.

Verify role separation.

---

# TESTING — ADMINISTRATION

Test:

* support permissions;
* moderator permissions;
* administrator permissions;
* denied privilege escalation;
* account suspension;
* session invalidation;
* high-risk action confirmation;
* bounded bulk operations if implemented;
* audit search authorization.

---

# TESTING — AUDIT

Verify:

* mandatory audited operations create records;
* audit records contain actor/action/target/time;
* audit records cannot be modified through normal APIs;
* unauthorized users cannot search audit history;
* secrets do not enter audit metadata.

---

# TESTING — SECURITY

Verify:

* media access control;
* object-storage key safety;
* provider-token secrecy;
* notification recipient integrity;
* moderation authorization;
* administrative authorization;
* IDOR resistance;
* rate limiting;
* request-size limits;
* safe error handling;
* audit integrity.

---

# TESTING — FAILURE AND RESILIENCE

Test:

* object-storage outage;
* scanner outage;
* processing worker outage;
* notification-provider outage;
* invalid push token;
* queue outage;
* Redis outage;
* database outage;
* audit-write failure;
* concurrent moderation;
* duplicate notification events;
* duplicate media-processing jobs.

Ensure failures preserve authoritative data integrity.

---

# TESTING — PERFORMANCE

Use representative fixtures to measure:

* concurrent image processing;
* notification throughput;
* moderation queue retrieval;
* audit search;
* media metadata operations.

Do not claim production global-scale throughput from local fixtures.

---

# DOCUMENTATION

Create or update documentation covering:

* media lifecycle;
* upload security;
* object storage;
* image processing;
* metadata privacy;
* media access;
* deletion and cleanup;
* notification architecture;
* notification preferences;
* provider adapters;
* delivery retries;
* moderation operations;
* administrative authorization;
* audit operations;
* operational rate limits;
* queues;
* events;
* failure recovery;
* testing.

Document actual implementation only.

---

# CROSS-PART COMPATIBILITY

This implementation must remain compatible with:

## Backend

* places;
* saved places;
* contributions;
* reviews;
* moderation;
* search;
* notifications;
* navigation;
* analytics;
* administration.

## Web

The web client must be able to:

* upload supported media;
* view authorized media;
* receive in-app notifications;
* manage notification preferences;
* consume authorized moderation state;
* consume supported administrative APIs.

## Mobile

The mobile client must be able to:

* upload media securely;
* receive push notifications;
* manage notification preferences;
* display in-app notifications;
* consume supported user-content states.

## Infrastructure

Infrastructure must support:

* object storage;
* media workers;
* notification workers;
* provider integrations;
* queues;
* Redis;
* database;
* observability;
* secure networking.

## QA

QA must be able to validate:

* media lifecycle;
* notification delivery;
* moderation;
* administrative authorization;
* auditability;
* security;
* privacy;
* resilience.

Do not create separate incompatible contracts for different clients.

---

# PORTABLE CONTRACT ARTIFACTS

Create or update stable repository artifacts for:

* MediaAsset;
* media lifecycle;
* media upload contract;
* media processing job;
* notification;
* notification intent;
* notification preferences;
* provider delivery contract;
* moderation administration;
* report administration;
* user-administration contract;
* audit record;
* audit search;
* authorization matrix;
* relevant error codes;
* event contracts.

Document authoritative locations.

Do not maintain duplicate conflicting definitions.

---

# EXTERNAL SERVICE REALISM

Object storage, malware scanning, push providers, and email providers may require external infrastructure.

When access is unavailable:

* implement the repository-side adapter;
* validate configuration;
* create deterministic local/test substitutes only for isolated tests;
* accurately report external validation limitations.

Do not claim:

* bucket creation;
* provider activation;
* push delivery;
* email delivery;
* malware scanning;

unless these were actually verified.

---

# FINAL SECURITY REVIEW

Before completion, inspect for:

* object-storage path traversal;
* arbitrary file access;
* malicious media processing;
* command injection;
* provider secret leakage;
* push-token leakage;
* notification impersonation;
* cross-user notification access;
* moderation bypass;
* administrative privilege escalation;
* audit tampering;
* mass-operation abuse;
* SSRF through external-provider adapters;
* signed-URL leakage.

Use established security libraries and safe process-execution APIs.

Do not create custom cryptography.

---

# FINAL DIFF REVIEW

Before completion:

* inspect every changed file;
* inspect migrations;
* inspect media lifecycle;
* inspect object-storage paths;
* inspect processing workers;
* inspect notification orchestration;
* inspect provider adapters;
* inspect moderation authorization;
* inspect administrative authorization;
* inspect audit logic;
* inspect event schemas;
* inspect queue configuration;
* inspect rate limits;
* inspect logs;
* inspect privacy controls;
* run tests;
* run type checking;
* run linting;
* run formatting;
* inspect documentation;
* remove debug code;
* remove unused dependencies;
* verify no provider credentials were committed;
* verify no unrelated future-domain implementation was introduced.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* media model;
* upload authorization;
* storage integration;
* validation/scanning;
* image processing;
* derivatives;
* metadata privacy;
* media access control;
* deletion/cleanup;
* notification model;
* notification preferences;
* notification orchestration;
* push integration;
* email integration where applicable;
* notification deduplication;
* notification retry behavior;
* moderation administration;
* report administration;
* user/account administration;
* audit changes;
* Redis changes;
* queue changes;
* event changes;
* API contract changes;
* security changes;
* privacy changes;
* observability changes;
* tests created;
* tests executed;
* resilience validation;
* performance validation;
* documentation updates;
* compatibility considerations;
* known limitations;
* unresolved external dependencies.

The report must accurately describe actual repository changes.

Do not claim that external media, push, email, scanning, cloud, or CDN infrastructure was provisioned unless it was actually verified.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* media ownership is explicit;
* MediaAsset persistence is implemented;
* upload authorization is secure;
* object-storage integration is real where used;
* content type is verified;
* file-size limits are enforced;
* checksum handling is implemented where appropriate;
* media lifecycle states are explicit;
* processing is asynchronous where appropriate;
* scanning/validation boundaries are implemented;
* image processing uses established safe tooling;
* derivatives are generated correctly;
* sensitive embedded media metadata is handled appropriately;
* media access control is server-side;
* private media cannot be accessed by unauthorized users;
* public media uses controlled delivery;
* media deletion is implemented;
* orphan/failed-artifact cleanup exists;
* media jobs are idempotent;
* media events are versioned;
* notifications have an authoritative model;
* notification intent is separated from provider delivery;
* notification preferences are implemented;
* notification channels are explicit;
* notification deduplication is implemented;
* provider retries are bounded;
* invalid push tokens are handled;
* in-app notifications are persisted;
* notification APIs are implemented;
* notification authorization is enforced;
* notification privacy is preserved;
* administrative APIs are implemented within scope;
* administrative roles are separated;
* moderation operations are implemented;
* moderation assignment is concurrency-safe;
* moderation decisions are authorized and auditable;
* report administration is implemented;
* account administrative operations are authorized;
* high-risk actions are appropriately protected;
* audit records are generated;
* audit search is bounded and authorized;
* administrative rate limits are implemented;
* queues are implemented where appropriate;
* Redis is bounded and justified;
* events are implemented consistently;
* failure behavior is deterministic;
* observability is implemented;
* security review is complete;
* privacy review is complete;
* media tests exist;
* notification tests exist;
* moderation tests exist;
* administration tests exist;
* audit tests exist;
* security tests exist;
* resilience tests exist;
* performance validation exists;
* API contracts exist;
* documentation is current;
* external dependencies are accurately reported;
* the final diff was inspected;
* there are no fake provider integrations;
* there are no placeholder implementations;
* there are no TODO/FIXME gaps standing in for required current-scope functionality;
* no credentials or secrets were fabricated;
* no unrelated future domain was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement analytics infrastructure, complete web/mobile applications, production cloud provisioning, or unrelated future-domain functionality during this media, notification, moderation, and administration backend milestone.
