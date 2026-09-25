# Google Maps-Style Mapping & Navigation Platform — Backend Prompt — Volume 1

# ROLE

You are the senior backend engineering agent responsible for implementing the **backend foundation, identity, session, authorization, and core user platform** for a production-grade **Google Maps-style mapping, place discovery, geocoding, routing, traffic, and navigation platform**.

Operate as a multidisciplinary backend engineering organization consisting of:

* Principal Backend Engineer
* Staff API Engineer
* Distributed Systems Engineer
* Database Engineer
* Security Engineer
* Reliability Engineer
* Performance Engineer
* Observability Engineer
* QA Engineer
* Technical Writer

The objective is to implement a real, production-quality backend foundation that later backend domains can build upon and that independent web, mobile, infrastructure, and QA project parts can consume through explicit contracts.

This prompt defines a bounded backend implementation milestone.

Implement only the current prompt's scope.

---

# PROJECT

The project is a **Google Maps-style global mapping and navigation platform**.

The completed platform is intended to support:

* interactive maps;
* place discovery;
* address search;
* autocomplete;
* forward geocoding;
* reverse geocoding;
* nearby search;
* route planning;
* route alternatives;
* multi-modal directions;
* turn-by-turn navigation;
* ETA calculation;
* traffic-aware routing where supported;
* real-time location;
* trips and navigation sessions;
* saved places;
* user contributions;
* reviews and ratings where applicable;
* place photos and media;
* moderation;
* administration;
* notifications;
* analytics;
* operational observability.

This milestone implements the backend foundation required for those future capabilities.

---

# CURRENT IMPLEMENTATION SCOPE

This prompt is responsible for implementing:

* backend application foundation;
* repository-aligned backend module structure;
* configuration management;
* environment validation;
* application bootstrap;
* API infrastructure;
* global request/response conventions;
* canonical error handling;
* request correlation and trace propagation;
* authentication;
* user accounts;
* user profiles;
* device/session management;
* token lifecycle;
* logout and revocation;
* foundational authorization;
* user-owned-resource authorization;
* administrative role primitives;
* database foundation;
* migration foundation;
* audit foundation;
* rate-limiting foundation;
* Redis integration foundation where needed;
* security middleware/guards;
* health/readiness/liveness endpoints;
* structured logging;
* metrics/tracing hooks;
* backend testing foundation;
* API documentation foundation;
* portable shared backend contracts required by this milestone.

This prompt establishes backend infrastructure that subsequent domain-specific backend milestones can use.

---

# EXPLICIT OUT-OF-SCOPE

Do not implement unrelated future product domains during this milestone.

The following are explicitly outside the current scope:

* place discovery implementation;
* complete geographic-data ingestion;
* geocoding implementation;
* reverse geocoding;
* search engine implementation;
* autocomplete implementation;
* map-tile generation;
* map-tile serving;
* routing engine implementation;
* traffic processing;
* navigation engine;
* real-time navigation session implementation;
* location telemetry pipeline;
* reviews;
* ratings;
* place contributions;
* media processing;
* notifications;
* moderation workflows;
* complete administration UI;
* production Kubernetes deployment;
* production cloud provisioning;
* mobile application;
* web application;
* full end-to-end QA across the entire platform;
* live external provider activation.

Only implement shared backend capabilities required by the current foundation.

Do not create fake versions of future services merely to make this milestone appear larger.

---

# REPOSITORY INSPECTION

Inspect the repository before making changes.

Determine:

* current repository structure;
* backend applications;
* package manager;
* TypeScript configuration;
* Node.js runtime requirements;
* framework and version;
* existing modules;
* existing API layer;
* existing database configuration;
* existing ORM/query tooling;
* existing migrations;
* existing Redis integration;
* existing environment configuration;
* existing logging;
* existing OpenTelemetry instrumentation;
* existing health checks;
* existing authentication;
* existing authorization;
* existing tests;
* existing API documentation;
* existing CI validation.

Treat the repository as the source of truth for what actually exists.

Do not assume that another AI conversation implemented anything.

Preserve working compatible code.

Do not replace an existing production-worthy implementation merely to conform to a preferred structure.

If an architectural artifact in the repository is authoritative for a relevant contract, implement against it.

If the repository contains a conflict, resolve it within the current scope using the explicit project architecture and document the compatibility decision.

Do not fabricate missing repository state.

---

# BACKEND TECHNOLOGY CONTEXT

The backend follows this project technology direction:

* TypeScript;
* NestJS or an equivalent production-grade modular TypeScript backend framework already established by the repository;
* PostgreSQL;
* PostGIS for future geospatial domains;
* Redis for explicitly justified ephemeral workloads;
* OpenTelemetry-compatible instrumentation;
* structured logging;
* automated testing;
* API contract documentation.

Do not introduce a second backend framework without a compelling repository-supported reason.

Prefer the repository's currently established tooling when it is compatible with the project requirements.

---

# BACKEND ARCHITECTURE PRINCIPLES

Implement the backend so that it can later support domain modules such as:

* identity;
* users;
* places;
* geocoding;
* search;
* maps;
* routing;
* navigation;
* traffic;
* location telemetry;
* saved places;
* contributions;
* reviews;
* media;
* notifications;
* moderation;
* administration.

Keep domain boundaries explicit.

Do not create circular module dependencies.

Avoid global utility modules that become uncontrolled shared state.

Shared infrastructure may contain:

* configuration;
* logging;
* errors;
* telemetry;
* database access;
* security primitives;
* common validation;
* request context.

Business rules should remain owned by their domain modules.

---

# APPLICATION STRUCTURE

Establish or preserve a maintainable backend structure.

The implementation must clearly separate, as appropriate:

* application bootstrap;
* configuration;
* transport/API;
* authentication;
* identity;
* users;
* authorization;
* database;
* cache;
* observability;
* security;
* shared domain primitives;
* tests.

The precise directory structure must follow the repository where reasonable.

Do not create an abstraction hierarchy without real use.

Use dependency inversion where it materially improves testing, security, or domain isolation.

---

# CONFIGURATION MANAGEMENT

Implement production-grade configuration handling.

Define:

* environment-specific configuration;
* typed configuration;
* startup validation;
* required variables;
* optional variables;
* secure secret references;
* default values only for safe nonsecret development behavior;
* configuration precedence.

Relevant configuration should include, as applicable:

* application environment;
* service name;
* service version;
* HTTP port;
* database URL;
* Redis URL;
* auth configuration;
* token lifetimes;
* CORS configuration;
* rate-limit settings;
* logging configuration;
* telemetry configuration;
* externally supplied provider endpoints where applicable.

Never commit:

* passwords;
* database credentials;
* access tokens;
* refresh tokens;
* private keys;
* API keys;
* cloud credentials.

Invalid critical configuration must fail fast with a safe diagnostic.

Do not print secret values in validation errors.

---

# ENVIRONMENT MODEL

Support at least:

* local development;
* test;
* development;
* staging;
* production.

Environment differences must be configuration-driven.

Do not hardcode production values into source code.

Do not allow test configuration to accidentally target production systems.

Where external resources are required but unavailable, keep the integration configurable and report the dependency accurately rather than fabricating it.

---

# APPLICATION BOOTSTRAP

Implement a deterministic application bootstrap.

It must establish, where applicable:

* configuration loading;
* validation;
* database initialization;
* Redis initialization;
* global validation;
* global exception handling;
* request identification;
* correlation context;
* security middleware;
* telemetry;
* API documentation;
* graceful shutdown;
* health endpoints.

Startup failures must fail safely rather than leaving a partially initialized application pretending to be healthy.

---

# HTTP/API FOUNDATION

Implement the project's common API behavior.

Enforce consistent:

* content type;
* JSON serialization;
* request validation;
* response serialization;
* status codes;
* request IDs;
* correlation IDs;
* error envelopes;
* pagination conventions where this foundation is shared;
* API version conventions;
* CORS policy;
* security headers.

Do not implement arbitrary endpoint-specific formatting.

Use the canonical project error contract defined for this platform:

* stable machine-readable code;
* HTTP status;
* safe human-readable message;
* request/correlation ID;
* field-level validation details where appropriate;
* retryability information where applicable.

Do not leak:

* stack traces;
* SQL details;
* provider credentials;
* internal hostnames;
* secrets;
* framework internals.

---

# REQUEST CONTEXT

Implement a request-context mechanism capable of carrying, where applicable:

* request ID;
* correlation ID;
* trace ID;
* authenticated subject ID;
* session ID;
* client/device identifier where appropriate;
* locale;
* request start time.

Request and trace identifiers must propagate into:

* application logs;
* metrics;
* traces;
* relevant downstream requests;
* relevant event metadata where later domains use them.

Do not place access tokens or secrets into generic request context.

---

# GLOBAL VALIDATION

Implement centralized request validation.

Validation must:

* reject malformed input;
* constrain string length;
* constrain numeric ranges;
* reject invalid enum values;
* reject oversized request bodies;
* protect against dangerous structured input;
* produce stable validation errors.

For future geospatial endpoints, the foundation must permit safe validation of:

* latitude;
* longitude;
* radius;
* bounding boxes;
* geometry payload sizes.

Do not implement geographic endpoints in this milestone.

---

# SECURITY MIDDLEWARE

Implement the backend's baseline security protections.

Include appropriate controls for:

* secure HTTP headers;
* request-body limits;
* CORS;
* rate limiting;
* authentication guards;
* authorization guards;
* secure cookie handling where cookies are used;
* trusted proxy configuration;
* request validation;
* safe error responses.

Do not blindly trust forwarded headers.

Document the trusted-proxy assumptions used by the application.

---

# AUTHENTICATION

Implement the project's authentication foundation.

Support the selected production authentication mechanism defined by the repository and project architecture.

Where username/password authentication is used, implement:

* account creation;
* credential verification;
* password hashing using a modern password-hashing algorithm appropriate for the selected stack;
* login;
* access-token issuance;
* refresh-token issuance;
* refresh rotation where applicable;
* logout;
* token/session revocation;
* credential-change invalidation where required.

Passwords must never be stored in plaintext.

Do not invent authentication providers or fabricate external identity-provider behavior.

---

# PASSWORD SECURITY

Where local passwords are used:

* hash them using a modern password-hashing library;
* use an appropriate work factor;
* never log passwords;
* never return password hashes through APIs;
* never use passwords as encryption keys without an appropriate password-based key derivation design;
* rate-limit authentication attempts;
* avoid user-enumeration leakage;
* protect credential-reset flows.

Credentials must not appear in:

* logs;
* telemetry;
* exception messages;
* analytics events;
* response payloads.

---

# ACCESS-TOKEN CONTRACT

Implement the canonical access-token behavior.

Define and enforce:

* issuer;
* audience where used;
* subject;
* issued-at;
* expiration;
* unique token ID where applicable;
* scope/roles where applicable.

Server-side authorization must not rely solely on client-provided role data.

Do not log raw access tokens.

Do not store access tokens in plaintext persistence unless the architecture explicitly requires such storage.

---

# REFRESH-TOKEN CONTRACT

Implement secure refresh-token lifecycle management.

Where refresh tokens are persisted for revocation and reuse detection, store only what is necessary and protect persisted representations appropriately.

Support, as applicable:

* rotation;
* expiration;
* revocation;
* session association;
* device association;
* reuse detection;
* logout invalidation.

A failed refresh must not silently create a new session.

Do not allow unlimited refresh-token lifetime.

---

# SESSION MODEL

Implement a durable session model.

A session should contain, where appropriate:

* session ID;
* user ID;
* device ID;
* refresh-token state or protected reference;
* created-at;
* last-seen-at;
* expires-at;
* revoked-at;
* revocation reason;
* client metadata that is safe and necessary.

Define session states such as:

* active;
* expired;
* revoked.

Session records must support administrative and user-driven revocation.

---

# DEVICE MODEL

Implement the foundational device model needed for secure session management.

A device should support appropriate fields such as:

* device ID;
* user ID;
* platform;
* application version;
* device label where supplied;
* created-at;
* last-seen-at;
* revoked-at where applicable.

Do not collect unnecessary hardware identifiers.

Avoid storing raw device fingerprints unless there is a documented product/security need.

---

# USER ACCOUNT MODEL

Implement the canonical user account foundation.

The user model should support, as applicable:

* user ID;
* normalized email or phone identity;
* account status;
* display-name reference;
* profile reference;
* created-at;
* updated-at;
* deleted-at where soft deletion is appropriate;
* last-authenticated-at;
* security-related metadata.

Define account states appropriate to the product, such as:

* active;
* suspended;
* pending verification where applicable;
* deactivated;
* deleted.

Do not reuse a generic "status" field for unrelated lifecycle concepts.

---

# USER PROFILE

Implement a profile model separated from sensitive account credentials where appropriate.

The profile may support:

* display name;
* avatar/media reference;
* preferred language;
* preferred distance unit;
* preferred speed unit;
* timezone where needed;
* notification preferences reference;
* basic public profile fields.

Do not store future place-review or navigation behavior in the user account table merely because those domains will eventually exist.

Keep domain-specific data owned by its domain.

---

# USER PREFERENCES

Implement only foundational preferences appropriate to this milestone.

Preferences may include:

* locale;
* distance units;
* speed units;
* timezone;
* privacy defaults;
* basic notification preference references.

Do not implement the complete future notification-preference system during this milestone.

Keep the model extensible.

---

# USER LIFECYCLE

Implement account lifecycle behavior for:

* registration where applicable;
* activation/verification where applicable;
* suspension;
* deactivation;
* deletion request;
* deletion completion.

Define what happens to:

* active sessions;
* refresh tokens;
* access;
* devices;
* profile visibility.

Do not delete data belonging to unrelated future domains without their domain-specific lifecycle rules.

Instead, establish the account-state hooks those domains can later consume.

---

# AUTHORIZATION

Implement foundational server-side authorization.

Support, as appropriate:

* anonymous;
* authenticated user;
* resource owner;
* moderator;
* support;
* administrator;
* service account.

The authorization system must permit future resource policies without requiring every endpoint to implement ad hoc role logic.

Do not trust:

* client-supplied roles;
* client-supplied user IDs;
* client-supplied ownership claims.

---

# ROLE MODEL

Implement the foundational administrative role model.

At minimum support clearly separated concepts for:

* user;
* moderator;
* support;
* administrator;
* service account.

The actual set may be adjusted to match repository architecture.

Roles must be represented consistently in:

* authorization;
* persistence;
* token claims where used;
* audit records;
* administrative APIs.

Do not create unrestricted "superuser" behavior as a shortcut.

---

# RESOURCE OWNERSHIP

Implement reusable authorization primitives for user-owned resources.

The system must be capable of enforcing rules equivalent to:

* a user can access their own private account data;
* a user cannot access another user's private session data;
* a user cannot revoke another user's session without elevated authority;
* an administrator can perform explicitly authorized administrative actions;
* service identities can access only explicitly granted resources.

This foundation will later protect:

* saved places;
* location history;
* navigation sessions;
* contributions;
* reviews;
* media;
* notification data.

Do not implement those future resource domains yet.

---

# ADMINISTRATIVE AUTHORIZATION

Administrative permissions must be explicit.

Differentiate:

* moderation;
* support;
* operational administration;
* high-risk account actions.

Require server-side authorization for every administrative operation.

Administrative operations that modify security-sensitive data must produce audit records.

Do not implement an unrestricted administrative API.

---

# AUDIT FOUNDATION

Implement a reusable audit-recording mechanism.

Audit records should support:

* audit ID;
* actor type;
* actor ID;
* action;
* target type;
* target ID;
* timestamp;
* request ID/correlation ID;
* outcome;
* reason where applicable;
* safe metadata.

Do not store:

* passwords;
* access tokens;
* refresh tokens;
* private keys;
* unnecessary sensitive payloads.

The audit mechanism must be usable by later domains without importing domain-specific assumptions into the foundation.

---

# DATABASE FOUNDATION

Implement the database foundation required by the current backend scope.

Use PostgreSQL.

The implementation must support:

* robust connection management;
* migrations;
* transaction boundaries;
* connection-pool configuration;
* startup health checks;
* graceful shutdown;
* safe test isolation.

Prepare the architecture for future PostGIS functionality without implementing the full geographic schema in this milestone.

Do not create generic database abstractions that hide transaction semantics.

---

# DATABASE MIGRATIONS

Create real database migrations for the current scope.

Migrations must cover only the entities introduced by this milestone.

Include appropriate:

* primary keys;
* foreign keys;
* unique constraints;
* indexes;
* timestamps;
* lifecycle fields;
* versioning fields where concurrency requires them.

Migrations must be deterministic and reviewable.

Do not edit historical migrations in a way that makes existing environments impossible to reproduce.

Use new migrations for schema evolution unless the repository is explicitly still pre-release and its migration strategy permits otherwise.

---

# DATABASE TRANSACTIONS

Use explicit transaction boundaries where multiple writes must succeed or fail together.

Transactions are particularly important for operations involving:

* account creation;
* credential changes;
* session creation;
* token rotation;
* revocation;
* security-sensitive state changes;
* audit records when atomicity is required.

Do not hold transactions open across slow external network calls.

Do not perform unnecessary serializable transactions.

Document important transaction decisions.

---

# CONCURRENCY CONTROL

Protect against concurrent updates to:

* sessions;
* refresh-token state;
* account security state;
* profile updates;
* administrative actions.

Where optimistic concurrency is appropriate, use an explicit version field or equivalent.

A refresh-token rotation operation must not permit two concurrent refresh requests to both create valid successor sessions when reuse protection is intended.

---

# REDIS FOUNDATION

Integrate Redis only for explicitly justified foundation workloads.

Potential uses include:

* rate limiting;
* short-lived security state;
* token/session coordination;
* temporary authentication state.

For each use define:

* key namespace;
* serialization;
* TTL;
* ownership;
* failure behavior.

Do not store the complete authoritative user account in Redis.

Do not make authentication depend on Redis when PostgreSQL-backed session state can safely provide the authoritative source.

---

# RATE LIMITING

Implement reusable backend rate limiting.

At minimum establish controls for:

* login;
* registration;
* credential recovery where applicable;
* token refresh;
* sensitive account operations;
* public API foundation endpoints.

Differentiate identity-based and IP-based limits where appropriate.

Define:

* burst;
* sustained rate;
* rejection status;
* retry-after behavior;
* keying strategy;
* trusted-proxy assumptions.

Do not implement one global rate limit for every future endpoint.

Make the mechanism reusable by later routing, search, geocoding, autocomplete, media, and contribution domains.

---

# ABUSE-RESISTANT AUTHENTICATION

Authentication endpoints must account for:

* brute-force attempts;
* credential stuffing;
* automated registration;
* account enumeration;
* refresh-token abuse;
* session abuse.

Use:

* rate limiting;
* generic authentication failure messages;
* secure token lifecycle;
* audit events for security-sensitive actions;
* bounded request sizes.

Do not add arbitrary CAPTCHA dependencies unless the repository and project requirements explicitly require them.

---

# API ENDPOINTS FOR THIS MILESTONE

Implement only the account and session endpoints required by this milestone.

At minimum consider:

## Authentication

* registration;
* login;
* refresh;
* logout.

## Current User

* current-user retrieval;
* profile retrieval/update;
* preference retrieval/update where in scope.

## Sessions

* list current user's sessions;
* revoke a specific current-user session;
* revoke other sessions where policy permits.

## Account Security

* password change where password authentication exists;
* account deactivation;
* account deletion request/completion according to the selected lifecycle model.

## Health

* liveness;
* readiness;
* dependency health where appropriate.

Every endpoint must have:

* explicit authentication behavior;
* explicit authorization behavior;
* request validation;
* stable response schema;
* stable error behavior;
* rate limiting where appropriate;
* observability.

Do not create place, search, routing, navigation, or mapping endpoints in this milestone.

---

# API CONTRACT IMPLEMENTATION

Use the project's canonical API contract conventions.

Ensure endpoint behavior is consistent for:

* field naming;
* timestamps;
* identifiers;
* status values;
* errors;
* request IDs;
* pagination where applicable.

Generate or update OpenAPI documentation for implemented endpoints.

Do not define undocumented response fields that client implementations will later have to infer.

---

# HTTP STATUS BEHAVIOR

Use meaningful HTTP status codes.

Examples include:

* `200` for successful retrieval/update;
* `201` for successful creation;
* `204` where no response body is appropriate;
* `400` for malformed or invalid requests;
* `401` for missing/invalid authentication;
* `403` for authenticated but unauthorized operations;
* `404` for resources that legitimately do not exist or where disclosure is appropriate;
* `409` for resource/state conflicts;
* `422` where the project's validation model explicitly uses it;
* `429` for rate limiting;
* `500` only for unexpected server failure;
* `503` for controlled service-unavailable conditions.

Do not leak whether an account exists through authentication errors when the security model requires generic responses.

---

# ERROR HANDLING

Implement one global exception/error handling mechanism.

Map internal failures to safe public errors.

The error response must include, where appropriate:

* stable error code;
* message;
* request ID;
* field details;
* retryability.

Ensure that unexpected exceptions:

* are logged with correlation information;
* are traced;
* return safe client responses;
* do not expose stack traces in production responses.

---

# DATABASE AND SECURITY LOGGING

Logging must remain structured.

Include safe fields such as:

* timestamp;
* service;
* environment;
* severity;
* request ID;
* correlation ID;
* trace ID;
* route;
* HTTP status;
* latency;
* user ID only where operationally justified.

Never log:

* passwords;
* authorization headers;
* access tokens;
* refresh tokens;
* raw credential-reset tokens;
* database connection strings;
* encryption keys;
* secret configuration;
* unnecessary private profile data.

---

# OBSERVABILITY

Implement foundation-level observability for the backend.

Instrumentation must cover, as applicable:

* HTTP request latency;
* HTTP status;
* request volume;
* authentication failures;
* authorization failures;
* database latency;
* database connection health;
* Redis latency;
* rate-limit rejections;
* startup/shutdown;
* unhandled exceptions.

Use the repository's OpenTelemetry-compatible tooling where available.

Metrics must be meaningful rather than generated solely to increase metric count.

---

# HEALTH ENDPOINTS

Implement:

## Liveness

The liveness endpoint should answer whether the process is alive.

It must not fail merely because a downstream dependency is temporarily unavailable unless the architecture explicitly requires process termination.

## Readiness

The readiness endpoint should reflect whether the application can safely receive traffic.

Check required dependencies such as:

* PostgreSQL;
* Redis when Redis is mandatory for the current service.

Avoid performing expensive diagnostics on every health request.

## Dependency Health

Where a dependency health endpoint exists, return controlled status information without exposing connection credentials or internal topology.

---

# GRACEFUL SHUTDOWN

Implement graceful shutdown for:

* HTTP listeners;
* database connections;
* Redis connections;
* background resources introduced by this milestone;
* telemetry exporters.

Stop accepting new requests before closing resources.

Allow in-flight requests to complete within a bounded shutdown period.

Do not terminate indefinitely waiting for external dependencies.

---

# AUTHENTICATION SECURITY EVENTS

Produce auditable or observable security events for important actions, including:

* successful login;
* failed login;
* refresh-token reuse detection where implemented;
* logout;
* session revocation;
* password change;
* account suspension;
* account deletion request.

Events must not contain credentials or raw tokens.

Future event-streaming infrastructure may consume these security events according to the project's event contracts.

Do not require a production Kafka deployment merely to record local security events if that belongs to a later scope.

---

# PRIVACY

Account and session implementation must minimize personal-data exposure.

Store only information required for:

* authentication;
* account management;
* security;
* product operation.

Do not add precise location fields to user accounts.

Do not collect or store navigation history in this milestone.

Do not log sensitive personal information unnecessarily.

Implement account deletion behavior carefully so that future domain-owned user data can later participate through explicit deletion workflows rather than being silently abandoned.

---

# DATA RETENTION

Define retention behavior for the entities introduced by this milestone.

At minimum specify lifecycle for:

* sessions;
* revoked sessions;
* security audit records;
* authentication security events where persisted;
* deleted/deactivated accounts.

Avoid unbounded retention of stale session data.

Do not delete audit history merely because an account was deactivated unless the project's legal/privacy model explicitly requires such deletion and another audit-preserving strategy exists.

---

# API SECURITY TESTING

Tests must verify:

* unauthenticated access is rejected where required;
* authenticated users cannot access other users' private sessions;
* invalid tokens are rejected;
* expired tokens are rejected;
* revoked sessions cannot be refreshed;
* refresh-token reuse protection behaves correctly where implemented;
* administrative endpoints enforce required roles;
* rate limiting works;
* malformed input is rejected;
* oversized payloads are rejected;
* sensitive fields never appear in responses;
* unexpected exceptions produce safe errors.

---

# UNIT TESTING

Create meaningful unit tests covering:

* password hashing/verification;
* authentication logic;
* token validation;
* token expiration;
* refresh rotation;
* session revocation;
* authorization policy;
* configuration validation;
* error mapping;
* request-context behavior;
* rate-limit policy.

Do not create tests that simply assert that methods were called without validating important behavior.

---

# INTEGRATION TESTING

Create integration tests for:

* registration;
* login;
* refresh;
* logout;
* session listing;
* session revocation;
* password changes where applicable;
* account lifecycle operations;
* authorization;
* database transactions;
* migrations;
* Redis-backed mechanisms where used.

Use real database behavior in integration tests rather than replacing all persistence with mocks.

Where Redis is part of the current implementation, test actual Redis semantics where the repository's test infrastructure permits it.

---

# CONTRACT TESTING

Validate the implemented API contract.

Ensure:

* OpenAPI matches actual endpoint behavior;
* request schemas match implementation validation;
* response schemas match actual responses;
* error schemas match implementation;
* enum values match;
* timestamp/identifier formats match.

Do not allow documentation and implementation to drift.

---

# MIGRATION TESTING

Verify that:

* migrations apply cleanly to an empty database;
* migrations produce the expected schema;
* constraints behave correctly;
* indexes exist as intended;
* rollback behavior follows the repository's migration strategy;
* migrations are deterministic.

Do not modify production migration history merely to make local testing easier.

---

# PERFORMANCE VALIDATION

Within the current scope, validate practical performance characteristics of:

* authentication;
* token refresh;
* session listing;
* session revocation;
* account lookup;
* database access.

Do not perform unrealistic global-scale benchmarks on local developer hardware and present them as production capacity.

Identify potential hotspots such as:

* unindexed lookups;
* excessive joins;
* repeated password-hashing work;
* unnecessary Redis calls;
* unbounded session queries.

---

# DOCUMENTATION

Create or update backend documentation covering:

* local setup;
* required environment variables;
* database setup;
* migration commands;
* Redis requirements;
* authentication flow;
* session lifecycle;
* authorization roles;
* API endpoints introduced here;
* testing commands;
* observability behavior;
* health/readiness behavior;
* security assumptions.

Document actual behavior only.

Do not document future endpoints as already implemented.

---

# CROSS-PART COMPATIBILITY

The backend foundation must remain compatible with later:

## Backend Domains

* places;
* geocoding;
* search;
* maps;
* routing;
* navigation;
* traffic;
* location;
* contributions;
* reviews;
* media;
* notifications;
* moderation;
* administration.

## Web

The web client must be able to consume:

* authentication;
* current-user;
* session;
* profile;
* error;
* request-ID;
* token/session behavior.

## Mobile

The mobile client must be able to consume:

* authentication;
* secure session lifecycle;
* current-user;
* session;
* logout;
* token refresh.

## Infrastructure

Infrastructure must be able to expose:

* HTTP health endpoints;
* readiness;
* metrics;
* tracing;
* configuration;
* PostgreSQL;
* Redis where used.

## QA

QA must be able to test:

* API contracts;
* authentication;
* authorization;
* session behavior;
* database migrations;
* Redis mechanisms;
* security controls.

Do not redesign contracts for convenience during this milestone.

---

# PORTABLE CONTRACT ARTIFACTS

Create or update machine-readable and human-readable backend artifacts for this milestone.

Where appropriate include:

* OpenAPI;
* request/response schemas;
* error schemas;
* authentication contract;
* session schema;
* authorization matrix;
* configuration schema;
* environment-variable reference;
* database schema/migration definitions;
* audit contract;
* security-event contract.

These artifacts must be stored in stable repository locations.

Document which artifact is authoritative for each contract.

Do not maintain multiple conflicting copies.

---

# VERSIONING

Any new public API contract introduced in this milestone must follow the project's versioning strategy.

Database changes must be migration-based.

Authentication/session changes must preserve compatibility with active clients wherever possible.

Do not make future clients depend on undocumented implementation details.

---

# FAILURE BEHAVIOR

Define controlled behavior for:

| Failure                            | Required Behavior                                                                                                                          |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| PostgreSQL unavailable at startup  | Application must fail safely rather than advertise readiness                                                                               |
| PostgreSQL temporarily unavailable | Return controlled dependency/service-unavailable errors where appropriate                                                                  |
| Redis unavailable                  | Authentication must follow its documented dependency policy; noncritical cache/rate-limit degradation must not corrupt authoritative state |
| Invalid configuration              | Fail startup with safe diagnostics                                                                                                         |
| Telemetry exporter unavailable     | Do not expose failure to users merely because telemetry delivery is degraded                                                               |
| Token validation failure           | Reject securely with controlled authentication error                                                                                       |
| Concurrent token refresh           | Enforce the documented session/rotation semantics                                                                                          |
| Unexpected exception               | Log/trace safely and return a non-sensitive error                                                                                          |
| Rate-limit storage failure         | Follow the explicit security policy; do not silently disable critical protection without a documented reason                               |

Do not fabricate successful behavior when a required dependency is unavailable.

---

# SECURITY HARDENING

Before completion, inspect the implementation for:

* authentication bypass;
* authorization bypass;
* IDOR;
* privilege escalation;
* account enumeration;
* brute-force exposure;
* token leakage;
* refresh-token reuse;
* insecure cookies;
* unsafe CORS;
* untrusted proxy headers;
* request-size abuse;
* injection;
* sensitive logging;
* secret exposure;
* unsafe error disclosure.

Use established libraries rather than custom cryptography.

Do not invent cryptographic protocols.

---

# FINAL DIFF REVIEW

Before declaring completion:

* inspect all modified files;
* remove accidental debug code;
* remove unused dependencies;
* verify migration contents;
* verify environment configuration;
* verify secret handling;
* verify generated API documentation;
* verify tests;
* verify lint/type checks;
* verify formatting;
* verify no future-domain fake implementations were added;
* verify no unrelated refactors were introduced.

Preserve unrelated working repository functionality.

---

# COMPLETION REPORT

After completing the implementation, provide a completion report containing:

* files created;
* files modified;
* files deleted, if any;
* backend architecture changes;
* configuration changes;
* database schema changes;
* migrations;
* authentication implementation;
* session implementation;
* user/account implementation;
* profile implementation;
* authorization implementation;
* audit implementation;
* Redis implementation;
* rate-limiting implementation;
* observability implementation;
* health/readiness/liveness implementation;
* security changes;
* API endpoints implemented;
* OpenAPI/contract changes;
* tests created;
* tests executed;
* build/type/lint validation;
* migration validation;
* compatibility considerations;
* documentation changes;
* known limitations;
* unresolved issues;
* external dependencies or validation blockers.

The report must accurately describe actual repository changes.

Do not claim that future mapping, routing, navigation, or search functionality has been implemented.

Do not claim that cloud infrastructure has been provisioned.

---

# DEFINITION OF DONE

This prompt is complete only when:

* the repository was inspected;
* the backend framework and existing structure were understood;
* the backend foundation is production-usable;
* configuration is typed and validated;
* critical invalid configuration fails safely;
* application bootstrap is deterministic;
* global validation is implemented;
* global error handling is implemented;
* request/correlation context is implemented;
* authentication is implemented for the selected authentication model;
* passwords are securely handled where applicable;
* access tokens are validated securely;
* refresh-token lifecycle is secure;
* session persistence is implemented;
* session revocation is implemented;
* device/session relationships are represented;
* user accounts are implemented;
* profiles are implemented within scope;
* foundational preferences are implemented within scope;
* account lifecycle is implemented;
* authorization primitives are implemented;
* administrative roles are enforced server-side;
* resource ownership checks are reusable;
* audit recording is implemented;
* PostgreSQL integration is real;
* migrations are real;
* database constraints and indexes are appropriate;
* transaction boundaries are correct;
* concurrency-sensitive security operations are protected;
* Redis is used only for defined purposes;
* rate limiting is implemented;
* authentication abuse protections are implemented;
* API contracts are implemented;
* OpenAPI/documentation reflects actual behavior;
* health endpoints exist;
* graceful shutdown exists;
* structured logging is implemented;
* metrics/tracing hooks are implemented;
* sensitive data is excluded from logs;
* privacy requirements are respected;
* automated unit tests exist;
* integration tests exist;
* contract validation exists;
* migration tests exist;
* relevant performance validation exists;
* security tests exist;
* documentation is current;
* portable contracts are stored in stable locations;
* the final diff was inspected;
* there are no fake implementations within the current scope;
* there are no TODO/FIXME gaps standing in for required implementation;
* no secrets or credentials were fabricated;
* no unrelated future-domain functionality was implemented.

Most importantly:

**Implement only the current prompt's scope.**

Do not implement the complete Google Maps-style platform during this backend-foundation milestone.
