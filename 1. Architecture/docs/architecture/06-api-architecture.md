# 06 — API Architecture

The full machine-readable contract for the resource families below lives in `../../contracts/openapi/core-v1.yaml`. This document is the prose companion explaining conventions the OpenAPI file encodes.

## Style and versioning

- **Style:** REST over HTTPS, JSON request/response bodies (`application/json; charset=utf-8`).
- **Versioning:** URL path major version prefix, `/v1/...`. Breaking changes require a new major version path (`/v2/...`); additive/backward-compatible changes (new optional fields, new endpoints) do not require a version bump. A deprecated version is supported for a documented minimum window (see `19-deployment-scalability-integration-architecture.md`) and returns a `Deprecation`/`Sunset` HTTP header once deprecation begins.
- **Base path per deployable:** each backend deployable (see `02-component-architecture.md`) is mounted behind the API edge under a stable prefix (e.g., `/v1/places`, `/v1/search`, `/v1/routes`, `/v1/navigation`) so that the deployable topology can change without changing the public URL contract.

## Resource naming and URL conventions

- Resource paths are plural nouns: `/v1/places`, `/v1/reviews`, `/v1/notifications`.
- Nesting is used only for genuine ownership/containment, max one level deep: `/v1/places/{placeId}/reviews`, not deeper chains. Cross-cutting lookups use query parameters instead of deep nesting (e.g., `/v1/reviews?placeId=...`).
- Actions that are not pure CRUD use a verb sub-resource on a noun: `/v1/navigation/sessions/{id}/reroute` (POST), `/v1/contributions/{id}/approve` (POST) — never verbs as the root resource.
- Path parameters are always the entity's ULID (or slug for `Category`), never an internal database row number.

## Request/response envelope

- **Success responses** return the resource(s) directly at the top level for single-resource endpoints (no extra `data` wrapper), and use the paginated envelope below for collections:

```json
{
  "items": [ { "...": "..." } ],
  "page": {
    "next_cursor": "01J...",
    "has_more": true,
    "limit": 20
  }
}
```

- **Collections always use cursor pagination** (`cursor` + `limit` query params, opaque cursor string derived from ULID ordering), never offset/limit, because the platform's primary identifier (ULID) is naturally sortable and offset pagination is unsafe over mutable, high-write datasets (places, reviews). `limit` default 20, max 100.
- **Filtering:** query parameters named after the field they filter, e.g., `?category=restaurant.italian&near=lng,lat&radius_m=1000`. Geo-bounded queries require either `near`+`radius_m` or a `bbox` (`minLng,minLat,maxLng,maxLat`) — an unbounded full-catalog scan is never a valid request shape (enforced by requiring one of these params on list endpoints over geospatial resources).
- **Sorting:** `?sort=field` / `?sort=-field` (leading `-` = descending). Default sort is documented per endpoint (usually relevance for search, distance for nearby, `created_at` descending otherwise).
- **Idempotency:** `Idempotency-Key` header required on `POST` endpoints that create a resource with side effects beyond simple upsert (contributions, reviews, media uploads, route computation billing-relevant cases). Server stores the key → response mapping for 24 hours; a repeated key with a different body is a `409 idempotency_key_conflict`.
- **Content negotiation:** `application/json` only in this volume; `Accept` header other than `application/json` or `*/*` returns `406`.
- **Localization:** `Accept-Language` header drives localized display strings (place names in local language where available, category labels). Canonical machine-usable fields (e.g., category slug) are never localized.
- **Units:** all API payloads use the canonical units from `05-identifier-time-coordinate-model.md` (meters, m/s, degrees). An optional `?units=imperial|metric` on client-facing display endpoints controls only a supplementary `display` block, never the canonical field values.

## Authentication requirements on the API

- Public/anonymous-accessible endpoints: place/search/geocoding/tile/route-computation reads.
- Authenticated-required endpoints: anything under `/v1/users/me/*`, `/v1/navigation/*`, `/v1/contributions`, `/v1/reviews` (write), `/v1/saved-places`.
- See `08-auth-architecture.md` for the token mechanics; the API layer's responsibility here is: every endpoint in the OpenAPI contract has an explicit `security` requirement (either `[]` for public or `[BearerAuth: []]`), with no endpoint left ambiguous.

## Rate limiting

- Enforced at the API edge, keyed by authenticated `user_id` where available, else by IP + device fingerprint for anonymous traffic.
- Standard response on limit exceeded: `429` with the error contract's `rate_limited` code (see `07-error-contract.md`) and a `Retry-After` header.
- Endpoint classes have documented default limits (e.g., search/autocomplete: high; route computation: moderate; media upload: low; contribution submission: low) — exact numeric defaults are an infrastructure/config concern (`../../contracts/config/service-config.schema.json`), not hardcoded in application code.

## Resource family contracts (summary — see OpenAPI for full detail)

| Family | Base path | Auth | Notes |
|---|---|---|---|
| Authentication | `/v1/auth` | Public (login/register), Bearer (refresh/logout) | See `08-auth-architecture.md` |
| User profile | `/v1/users` | Bearer (self), Public (limited fields by id) | |
| Places | `/v1/places` | Public read, Bearer write via Contributions | Direct place mutation reserved for admin |
| Place search | `/v1/search` | Public | Requires geo bound or explicit `unbounded=true` admin-only override |
| Autocomplete | `/v1/autocomplete` | Public | Low-latency SLO, see `11-...md` |
| Geocoding | `/v1/geocode`, `/v1/geocode/reverse` | Public | |
| Routes | `/v1/routes` | Public compute, Bearer for saved/history features | |
| Navigation sessions | `/v1/navigation/sessions` | Bearer | WebSocket sub-resource for live stream |
| Saved places | `/v1/users/me/saved-places` | Bearer | |
| Contributions | `/v1/contributions` | Bearer | |
| Reviews | `/v1/places/{id}/reviews`, `/v1/reviews/{id}` | Public read, Bearer write | |
| Media | `/v1/media` | Bearer (upload authorization), Public read (served via CDN with signed derivative URLs where private) | |
| Notifications | `/v1/users/me/notifications` | Bearer | |
| Reports | `/v1/reports` | Bearer | |
| Admin | `/v1/admin/*` | Bearer + admin/moderator claim | |
| Tiles | `/v1/tiles/{z}/{x}/{y}.pbf` | Public, rate-limited | Typically fronted by CDN |

## Cross-cutting response headers

| Header | Direction | Purpose |
|---|---|---|
| `X-Correlation-Id` | request + response | Echo/assign correlation ID (see `05-...md`) |
| `traceparent` | request + response | W3C trace context propagation |
| `X-RateLimit-Limit` / `-Remaining` / `-Reset` | response | Rate-limit visibility |
| `Idempotency-Key` | request | Client-supplied idempotency token |
| `ETag` / `If-None-Match` | response/request | Conditional GET for cacheable read endpoints (places, tiles, search results within short TTL) |
| `Deprecation` / `Sunset` | response | API version lifecycle signaling |

## Non-goals of this volume's API artifact

- The OpenAPI contract in this volume defines the **foundational and cross-cutting-critical** endpoint families concretely (auth, places core CRUD, search, geocoding, routes, navigation sessions, saved places, error responses) with full schemas. It intentionally leaves lower-priority endpoint bodies (e.g., full admin console surface, full notification-preference surface) as documented stubs with a `501`-style placeholder note in the OpenAPI `description` field rather than fully fleshed schemas, to be completed by the implementation prompt that owns that domain — this is a contract-completeness decision, not an implementation of those features.
