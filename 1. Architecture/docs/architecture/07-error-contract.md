# 07 — Error Contract

## Envelope

Every non-2xx API response uses this exact JSON shape (also formalized in `../../contracts/openapi/core-v1.yaml#/components/schemas/Error`):

```json
{
  "error": {
    "code": "validation_failed",
    "message": "The 'near' parameter must be a valid [lng,lat] pair.",
    "status": 422,
    "correlation_id": "01J8X7Z8K9QANM3E7B5T6R2F4C",
    "retryable": false,
    "details": [
      { "field": "near", "issue": "invalid_format" }
    ],
    "doc_url": "https://docs.platform.internal/errors/validation_failed"
  }
}
```

| Field | Required | Notes |
|---|---|---|
| `code` | yes | Stable machine-readable snake_case string; see catalog below. Never changes meaning once shipped. |
| `message` | yes | Human-readable, safe to display; never contains stack traces, internal hostnames, SQL, or secrets. |
| `status` | yes | Duplicates the HTTP status for consumers that inspect the body only. |
| `correlation_id` | yes | Always present — see `05-identifier-time-coordinate-model.md`. Required for support/debugging correlation. |
| `retryable` | yes | Boolean. Tells clients whether a retry (with backoff) is appropriate. |
| `details` | no | Array of field-level validation issues; only present for `validation_failed` and similar. |
| `doc_url` | no | Optional link to error documentation. |

## Error code catalog

| Code | HTTP status | Category | Retryable | Meaning |
|---|---|---|---|---|
| `unauthenticated` | 401 | Authentication | no | Missing/invalid/expired credentials |
| `invalid_token` | 401 | Authentication | no | Token malformed or signature invalid |
| `session_revoked` | 401 | Authentication | no | Session/refresh token was revoked |
| `forbidden` | 403 | Authorization | no | Authenticated but not authorized for this resource/action |
| `resource_owner_mismatch` | 403 | Authorization | no | Specific IDOR-prevention case: resource exists but is not owned by caller |
| `validation_failed` | 422 | Validation | no | Request body/params fail schema or business validation |
| `geospatial_bounds_required` | 422 | Validation | no | A geo query was submitted without a required bounding constraint |
| `not_found` | 404 | Not found | no | Resource does not exist or caller lacks visibility into its existence |
| `conflict` | 409 | Conflict | no | Generic state conflict (e.g., duplicate unique field) |
| `idempotency_key_conflict` | 409 | Conflict | no | Same idempotency key reused with a different request body |
| `navigation_session_conflict` | 409 | Conflict | no | Navigation-state-specific: action invalid for current session state |
| `rate_limited` | 429 | Rate limiting | yes (after `Retry-After`) | Caller exceeded rate limit |
| `dependency_unavailable` | 502 | Dependency failure | yes | A required upstream dependency (search, routing engine, etc.) failed or timed out |
| `routing_engine_unavailable` | 502 | Dependency failure | yes | Routing-specific dependency failure variant |
| `service_unavailable` | 503 | Service unavailable | yes | This service is shedding load / in maintenance |
| `timeout` | 504 | Timeout | yes | Request exceeded its processing deadline |
| `route_not_found` | 422 | Routing failure | no | No viable route exists for the given constraints |
| `geocoding_ambiguous` | 200 (not an error status; see note) | Geospatial | n/a | Not an HTTP error — represented as a structured ambiguous result, see `11-...md` |
| `internal_error` | 500 | Uncategorized | yes (cautiously) | Unexpected server fault; message is generic, details never leaked |

Note on `geocoding_ambiguous`: ambiguity is a valid, expected outcome of geocoding, not a failure — it is returned as HTTP `200` with a structured `candidates` array rather than as an error code. It is listed here only to make explicit that implementers must not model it as an error.

## Category-to-status mapping rule

Categories map to HTTP status **deterministically**, never chosen ad hoc per endpoint:

- Authentication → `401`
- Authorization → `403`
- Validation → `422` (not `400` — reserved for malformed request syntax, e.g., unparsable JSON, which uses `400` with code `malformed_request`)
- Not found → `404`
- Conflict → `409`
- Rate limiting → `429`
- Dependency failure → `502`
- Service unavailable → `503`
- Timeout → `504`
- Uncategorized → `500`

## Safety rules

- Public error `message` fields never include: SQL fragments, stack traces, internal hostnames/IPs, internal file paths, dependency version strings, or any other implementation detail an attacker could use for reconnaissance.
- `internal_error` responses always log the full internal detail server-side keyed by `correlation_id`, and return only the generic message to the client — the correlation ID is the bridge between the two for support/debugging.
- Validation `details[].issue` values come from a closed enum (`required`, `invalid_format`, `invalid_type`, `out_of_range`, `too_long`, `too_short`, `not_allowed_value`), never free-text derived from internal validator library output verbatim.

## Consistency requirement

This catalog is the single source of truth for error `code` values across every backend deployable. A deployable must not invent a new `code` outside this catalog without adding it here first (this file, plus the OpenAPI `Error.properties.code.enum` list, must be updated together).
