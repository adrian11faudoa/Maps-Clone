# 17 — Security and Privacy Architecture

## Trust zones

```text
Zone 0 — Public internet (untrusted)
   │  TLS-terminated at edge, WAF/DDoS mitigation
   ▼
Zone 1 — API edge / gateway (semi-trusted: validates token signature,
   │       enforces rate limits, does NOT make authorization decisions)
   ▼
Zone 2 — Application services (core-api, search-api, routing-api,
   │       navigation-api, traffic-service, media-service — trusted,
   │       mutual-TLS internal network, service-identity JWTs)
   ▼
Zone 3 — Data plane (PostgreSQL, Redis, OpenSearch, Kafka, object storage —
           highest trust, reachable only from Zone 2, never directly from
           Zone 0/1, credentials scoped per-service per 10-database-...md)
```

External providers (traffic feed, notification providers, geographic data sources) are accessed **from Zone 2 outward**, through explicit adapters (`19-...md`) — Zone 3 never makes outbound calls to external providers directly (prevents a compromised data-layer credential from being usable to reach the internet; also prevents SSRF pivoting).

## Threat coverage

| Threat | Primary mitigation | Where enforced |
|---|---|---|
| Authentication bypass | Signed JWT validation at every resource server (not just the edge), short-lived access tokens, rotation-on-use refresh tokens with reuse detection | `08-auth-architecture.md` |
| Authorization bypass / IDOR | Server-derived resource ownership filters, never client-asserted `user_id`; ULID (non-enumerable) identifiers as defense-in-depth | `08-auth-architecture.md`, every domain's resource-level rules |
| Privilege escalation | Roles sourced only from validated JWT claims issued by Identity, never client-settable; step-up/short session lifetime for admin | `08-auth-architecture.md` |
| Injection (SQL) | Parameterized queries/ORM only, no string-concatenated SQL anywhere, least-privilege DB roles per schema | `10-database-postgis-architecture.md` |
| XSS | API returns data, not rendered HTML; clients (web) apply standard output-encoding/CSP — a client-layer concern informed by, but not solved in, this backend architecture | Client implementation prompts |
| CSRF | Bearer-token auth (not ambient cookie auth) for API calls minimizes classic CSRF exposure; the refresh-token cookie is `SameSite=Strict` + `HttpOnly` specifically to resist cross-site submission | `08-auth-architecture.md` |
| SSRF | Media scanning/processing and any URL-fetching feature (none in this volume) run in an isolated, egress-restricted execution context with an allowlist of reachable hosts; Zone 3 has no outbound internet path (see trust zones above) | `15-storage-media-architecture.md`, `19-...md` |
| Malicious media uploads | Pre-signed, scoped, short-lived upload URLs; actual content-type sniffing; malware scanning before any processing/exposure; EXIF stripped from public derivatives | `15-storage-media-architecture.md` |
| Credential stuffing / brute force | Login endpoint rate-limited per-IP and per-account-identifier independently; Argon2id hashing (slow by design); account lockout/backoff on repeated failures | `08-auth-architecture.md`, `06-api-architecture.md` (rate limiting) |
| Token theft | Access tokens never persisted to disk client-side; short lifetime bounds exposure window; refresh-token rotation with reuse detection revokes the whole session family on detected theft | `08-auth-architecture.md` |
| Replay | `Idempotency-Key` for unsafe writes; JWT `jti`/`exp` bound the replay window for tokens; navigation location updates use a monotonic `sequence` to reject stale replays | `06-...md`, `08-...md`, `13-...md`, `05-...md` |
| Abusive API clients / scraping | Rate limiting per principal/IP/device fingerprint; geo-bounded query requirement on list endpoints prevents full-catalog scraping via unbounded pagination | `06-api-architecture.md` |
| WebSocket abuse | Navigation WebSocket connections are authenticated (token on connect), per-connection rate/size limits on inbound location-update frequency, server-authoritative state prevents a malicious client from forging session progress | `13-routing-navigation-traffic-architecture.md` |
| Route-query abuse | Rate limiting + Redis-backed dedup/caching absorbs burst/duplicate query patterns cheaply before they reach the routing engine | `13-...md`, `14-...md` |
| Location-data exposure | Owner-only access to `NavigationSession`/`LocationEvent`; Traffic only ever consumes aggregated/anonymized telemetry, never raw per-user traces; minimum-sample-count floor before publishing a traffic aggregate cell | This document (Privacy section), `13-...md` |
| Secret leakage | No secrets in code/config files in the repository; secrets manager only (see `19-...md`); error responses never include internal detail (`07-error-contract.md`); logging redaction rules below | `19-...md`, `07-...md`, `18-...md` |
| Denial of service | Edge-level rate limiting, CDN absorption for tile/media traffic, autoscaling on stateless services, bounded queue/consumer concurrency to prevent retry storms | `18-observability-reliability-architecture.md`, `19-...md` |

## Privacy data classification

| Class | Examples | Minimum collection | Retention | Access control | Aggregation/anonymization |
|---|---|---|---|---|---|
| Account information | Email, hashed credential, profile display name | Only fields required for the stated product purpose | Account lifetime + legal-hold window | Owner + admin (with audit) | N/A |
| Approximate/public location | A place's canonical coordinates, a public review's associated place | N/A (not personal data about the acting user) | Indefinite (business data) | Public | N/A |
| Precise private location | `LocationEvent`, `NavigationLocationUpdate`, `NavigationSession.last_known_location` | Only while an active navigation/telemetry purpose exists | Short, explicit window (see below) — never indefinite | Owner only; no other user, and no internal role beyond narrowly-scoped support/security-incident access with its own audit trail, may read another user's precise location history | Required before any cross-user or public use (Traffic) |
| Navigation history | Past `NavigationSession` records | Only as long as needed for the stated product purpose (trip history feature, if enabled) or a short default | Bounded (e.g., 90 days default, user-configurable/deletable) | Owner only | N/A |
| Saved places | `SavedPlace`, `PlaceList` | User-initiated only | Account lifetime | Owner only (lists can be user-shared, an explicit opt-in action, not default) | N/A |
| Reviews / contributions | `Review`, `Contribution` | User-initiated only | Indefinite (public content, tombstoned not purged on deletion, for integrity/audit) | Public (content), owner+moderator (moderation metadata) | N/A |
| Media | Uploaded photos | User-initiated only | Per `15-...md` lifecycle | Public derivatives / owner+moderator for originals | EXIF stripped from public derivatives |
| Administrative data | `AuditRecord`, `AdminAction` | Operationally necessary only | Indefinite/compliance-driven | Admin only | N/A |
| Telemetry (raw location events) | `LocationEvent` | Only what's needed for the active session/aggregation purpose | Short, explicit — deleted after aggregation into `TrafficSnapshot` or session end, whichever governs, within a bounded window (e.g., raw events purged within 24–72 hours of ingestion) | System-internal only (not directly user- or admin-browsable as a raw feed) | Aggregated into Traffic; never re-identified afterward |
| Analytics/operational telemetry | Aggregated product metrics | Minimized; avoid unnecessary personal data by design (aggregate counts, not per-user location traces) | Per analytics retention policy | Internal, role-scoped | Aggregated by design |

### Retention rule (binding)

**No row classified as "Precise private location" or raw "Telemetry" may have a retention policy of "indefinite."** This is enforced structurally: `navigation.location_update` and the raw `LocationEvent` buffer are both range-partitioned by time specifically so that partition-drop is the purge mechanism (see `10-database-postgis-architecture.md`), making indefinite retention operationally impossible to silently drift into, not merely policy-forbidden.

### Consent and purpose limitation

- Background/continuous location collection (mobile) requires an explicit, purpose-specific permission grant at the client layer; the server-side contract never assumes location access — every telemetry-ingesting endpoint requires an active `NavigationSession` or equivalent explicit product context (no ambient/always-on location harvesting endpoint exists in this contract).
- Data collected for one purpose (e.g., active-navigation map matching) is not repurposed for an unrelated purpose (e.g., ad targeting — out of scope/not a capability of this platform) without a separate, explicit product decision outside this architecture's current scope.

### User access and deletion

- Users can request their own account deletion; this cascades: hard-delete of credentials/sessions/precise-location data, soft-delete-with-tombstone of public contributions/reviews (integrity of other users' derived context, e.g., a review thread, is preserved with an anonymized attribution rather than full historical rewrite), removal of saved places/lists.
- The deletion cascade is itself an auditable `AdminAction`-equivalent internal operation (self-service deletion still produces an `AuditRecord`), consistent with the moderation/admin auditability rule in `16-...md`.

## Logging redaction rules

Never logged, in any service, at any log level: passwords (even hashed, outside the credential store itself), access/refresh tokens, session secrets, API keys, other credential material, full precise location history outside the narrowly-scoped operational need of the owning service's own debug logs (and even then, coordinate precision in logs is truncated more aggressively than the API precision ceiling where feasible), and any field explicitly marked sensitive in the data classification table above beyond what's operationally necessary at `INFO` level. `DEBUG`-level logs in non-production environments may include more detail but are never enabled by default in production, and production log pipelines apply the same redaction rules regardless of level as a backstop (see `18-observability-reliability-architecture.md`).
