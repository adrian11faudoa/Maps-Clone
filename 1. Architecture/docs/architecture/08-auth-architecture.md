# 08 — Authentication and Session Architecture

## Supported authentication mechanisms (this volume)

- **Email + password**, with credentials stored as a salted hash (Argon2id) — never reversible encryption, never plaintext.
- **Extension points** (not implemented in this volume, but the token/session model accommodates them without redesign): OAuth/OIDC federation (Google/Apple sign-in), MFA (TOTP), passkeys/WebAuthn.

## Token model

- **Access token:** short-lived JSON Web Token (JWT), signed with an asymmetric key (EdDSA or RS256) so that resource servers can validate signatures using a published public key without calling Identity synchronously on every request. Lifetime: 15 minutes.
- **Refresh token:** opaque, high-entropy random string (not a JWT), stored server-side (hashed) against the `Session`/`RefreshToken` record, rotated on every use (rotation-on-use with reuse detection — see below). Lifetime: 30 days sliding, capped at 180 days absolute.
- **Access token claims:** `sub` (user ID), `iat`, `exp`, `jti`, `session_id`, `roles` (array, e.g., `["user"]`, `["user","moderator"]`, `["user","admin"]`), `auth_strength` (`password`, `password+mfa`, reserved for future MFA). No PII beyond user ID is embedded in the token.
- **Token storage responsibility:**
  - Web client: access token in memory only (never `localStorage`); refresh token in an `HttpOnly`, `Secure`, `SameSite=Strict` cookie scoped to the auth domain.
  - Mobile client: access token in memory; refresh token in platform secure storage (Keychain/Keystore).
  - Neither client persists the access token to disk.

## Session lifecycle

1. `POST /v1/auth/login` → validates credentials → creates `Session` + `RefreshToken` record → issues access token + refresh token.
2. Resource servers validate the access token locally (signature + expiry + `session_id` presence) — no network call to Identity per request. A denylist check (see revocation below) is a fast Redis lookup keyed by `session_id`/`jti`, not a full Identity round trip.
3. `POST /v1/auth/refresh` → validates refresh token against stored hash → **rotates**: issues a new refresh token, invalidates the old one, issues a new access token. If a refresh token is presented that was already rotated out (reuse), the entire session family is revoked immediately and the user is required to re-authenticate (reuse-detection breach response).
4. `POST /v1/auth/logout` → revokes the current session's refresh token and adds its `session_id` to the short-TTL Redis denylist for the remaining life of any already-issued access token.
5. Session/device listing and remote revocation: `GET /v1/users/me/sessions`, `DELETE /v1/users/me/sessions/{id}` — lets a user revoke a session from another device.

## Revocation

- Revocation is authoritative in PostgreSQL (`Session.revoked_at`) and mirrored into a Redis denylist keyed by `session_id` with TTL equal to the remaining max access-token lifetime (15 minutes), so a revoked session cannot be used even with an unexpired access token already in a client's memory, while keeping the check O(1) and not requiring every access token validation to hit Postgres.
- Account-level revocation (e.g., password change, admin-forced logout, suspected compromise) revokes all sessions for the `user_id` in one operation and publishes `SessionRevoked` per affected session for downstream awareness (e.g., Navigation force-closing active sessions).

## Account recovery / credential reset

- Reset is via a single-use, short-lived (15 minute), signed reset token delivered by email (Notifications domain, `NotificationRequested` event with `channel: email`). Reset tokens are stored hashed, exactly like refresh tokens, and are invalidated on first use or expiry.
- Successful password reset revokes all existing sessions for the account (forces re-login everywhere), as a security default.

## MFA extension point

- The `auth_strength` claim and a reserved `Credential.type = "totp"` row shape are the only MFA-related decisions made in this volume, so that an MFA implementation prompt can add TOTP enrollment/verification without changing the token or session model. MFA is out of scope for implementation in this volume.

## Service-to-service authentication

- Internal service-to-service calls (e.g., `navigation-api` → `traffic-service`) use short-lived JWTs issued by a platform-internal token-issuing mechanism (mTLS-authenticated service identity → token), signed by the same key infrastructure, with a `sub` naming the calling service (e.g., `svc:navigation-api`) and a `roles: ["service"]` claim. Resource servers distinguish user-principal tokens from service-principal tokens by the `sub` prefix and apply service-appropriate authorization (see `09` below and `17-security-privacy-architecture.md`).
- Service-to-service calls additionally run over mutual TLS within the private network (see `19-deployment-scalability-integration-architecture.md`), so the JWT is a second, independent authorization factor layered on top of network-level trust — not a substitute for it.

## Administrative authentication

- Administrators and moderators authenticate through the same login flow and token model as regular users; elevated access is expressed entirely through the `roles` claim, not a separate credential system. This avoids a second, parallel identity stack.
- Administrative sessions have a **shorter** access-token lifetime (5 minutes) and refresh-token lifetime (8 hours, non-sliding) than regular user sessions, reflecting the higher blast radius of a compromised admin session.
- Step-up requirements (e.g., requiring recent re-authentication for the most sensitive admin actions such as granting admin role) are a policy the Moderation & Administration domain enforces at the authorization layer (below), not a separate authentication mechanism.

## Authorization model

### Principal classes

| Class | `roles` claim contains | Example capability |
|---|---|---|
| Anonymous | (no token) | Public reads only |
| Authenticated user | `user` | Owns saved places, submits contributions/reviews |
| Contributor | `user`, `contributor` | Elevated contribution auto-apply thresholds (still moderation-eligible) |
| Moderator | `user`, `moderator` | Approve/reject contributions, moderate reviews/media, resolve reports |
| Support | `user`, `support` | Read account/trip data for support purposes, cannot mutate business data |
| Administrator | `user`, `admin` | Full administrative surface, role grants, configuration |
| Service | `service` (no `user`) | Internal-only endpoints |

### Resource-level authorization rules

| Resource | Rule |
|---|---|
| `UserProfile`, `SavedPlace`, `PlaceList`, `Notification`, `NavigationSession`, `LocationEvent` | Owner-only (`resource.user_id == token.sub`), enforced server-side on every read/write — never inferred from a client-supplied user ID in the payload |
| `Place` (read) | Public |
| `Place` (write) | Direct write: `admin` only. Proposed write: any authenticated user via `Contribution`, applied only on `moderator`/`admin` approval |
| `Review`/`Rating` (write) | Owner-only for edit/delete of own review; `moderator`/`admin` can hide/remove any |
| `Contribution` (approve/reject) | `moderator`/`admin` only |
| `Report` (create) | Any authenticated user |
| `Report`/`ModerationCase` (read/act) | `moderator`/`admin` only |
| `Media` (upload) | Any authenticated user, scoped to an entity they're permitted to attach media to (own review, own contribution, or a place if `contributor`+) |
| `Media` (delete) | Uploader, or `moderator`/`admin` |
| Admin configuration endpoints | `admin` only |
| Internal service endpoints (e.g., internal reindex trigger) | `service` role only, never reachable with a user-principal token |

### IDOR / privilege-escalation prevention

- Every resource-owning query includes the authenticated principal's ID as a **server-derived** filter, never trusts a client-supplied `user_id`/`owner_id` field in the request body for authorization purposes (a client-supplied `user_id` in a body, if present at all for admin tooling, is only ever used for `admin`-role requests and is itself authorized against the `admin` role, not treated as self-assertion).
- Role/claim values come only from the validated JWT, never from a request body or a client-settable header.
- Numeric/sequential identifiers are avoided in favor of ULIDs precisely to prevent enumeration-based IDOR reconnaissance (see `05-...md`); this is a defense-in-depth measure, not a substitute for the authorization checks above.
