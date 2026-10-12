# 15 — Storage and Media Architecture

## Lifecycle

```text
Client
  │  1. POST /v1/media/uploads  (authenticated; declares intended attachment
  │      context: place_id | review_id | contribution_id, declared content-type,
  │      declared size)
  ▼
Media service — authorizes (is caller permitted to attach media to that
  │      context? see 08-auth-architecture.md), issues a short-lived,
  │      size-and-type-constrained pre-signed upload URL scoped to a specific
  │      object key (never a general-purpose bucket-write credential)
  ▼
Client uploads binary directly to Object Storage via the pre-signed URL
  ▼
Object Storage → upload-complete notification (S3 event or client-confirmed
  │      completion call) → Media service
  ▼
Validation — actual content-type sniffing (not trusting the declared
  │      content-type), size re-check, malware/content scanning via a
  │      pluggable scanning provider, image-specific structural validation
  ▼
  ├── fails validation → asset marked `rejected`, original deleted, no
  │      derivative generated, `MediaUploaded` still published for audit
  │      with `status: rejected`
  ▼ passes
Processing — derivative generation (thumbnail, web-optimized, mobile-optimized
  │      variants; EXIF stripped from all public derivatives; original
  │      retained under stricter access for audit/moderation only)
  ▼
Metadata persisted (`MediaAsset`, `MediaDerivative` — `media` schema)
  ▼
CDN delivery of public derivatives; signed URLs for any non-public derivative
  │      or the original
  ▼
`MediaProcessed` event published
```

## Ownership and authorization

- Upload authorization is checked **before** issuing the pre-signed URL: the caller must be authenticated and the target attachment context (`place_id`/`review_id`/`contribution_id`) must be one they're permitted to attach media to (owner of the review/contribution, or `contributor`+ role for direct place photo submission — see `08-...md`).
- The pre-signed URL is scoped to exactly one object key, a declared content-type constraint, and a maximum size, with a short expiry (minutes) — it is never a reusable or broadly-scoped credential, and the client never receives permanent storage credentials.

## Validation

- **Declared vs. actual content-type:** the declared `Content-Type` at upload-authorization time is advisory only; the Media service always re-verifies actual file content via signature/magic-byte sniffing after upload, before proceeding to processing. A mismatch is treated as a validation failure (rejected), not silently corrected.
- **Size limits:** enforced both at pre-signed-URL issuance (constrains what the storage provider will accept) and re-verified post-upload.
- **Scanning:** a pluggable malware/content-scanning provider boundary (see `19-...md`) is invoked before any derivative generation or public exposure; scanning failure or a positive detection results in `status: rejected` and the object is deleted from storage, not merely hidden.
- **Image-specific structural validation:** decodability, dimension sanity bounds, rejection of malformed/zip-bomb-style image files.

## Storage and derivatives

- Originals are retained in a storage tier with **restricted access** (not publicly served directly) — public traffic is always served a processed derivative, never the raw original, both for security (stripped metadata/EXIF, no embedded scripts in the delivered format) and for performance (right-sized images).
- Derivative variants are generated for documented target use cases (e.g., `thumbnail`, `card`, `full`) with deterministic naming so consuming domains (Places, Reviews) can construct predictable derivative URLs from a `MediaAsset.id` without an extra lookup for the common case, while still calling the Media service for anything beyond the documented default set.
- Object storage keys follow a namespace convention: `{domain}/{aggregate_id}/{asset_id}/{variant}.{ext}` (e.g., `places/01J.../01K.../thumbnail.webp`), never a flat/guessable-sequential key space.

## Access control

- Public derivatives (attached to a public, non-moderated-hidden place/review) are served via CDN with long cache lifetimes.
- Derivatives attached to content that is moderation-hidden, or belonging to a private context (none defined in this volume, but the mechanism is generic), are served via short-lived signed CDN/storage URLs, re-issued per request, never permanently cacheable-and-public.
- Originals are never directly link-shareable; access (e.g., for a moderator reviewing a reported photo) goes through a Media service endpoint that issues a short-lived signed URL after an authorization check.

## Deletion and lifecycle

- `DELETE` (uploader or moderator/admin) marks `MediaAsset.status = removed`, immediately revokes any signed-URL issuance for it, and schedules the underlying objects (original + all derivatives) for hard deletion from storage within a short operational window (not instantaneous, to allow a brief safety window for accidental-deletion recovery via an internal-only undo, but bounded — not indefinite retention of "deleted" media).
- Orphaned uploads (a pre-signed URL was issued but never used, or upload-complete notification never arrived) are garbage-collected by a scheduled cleanup job after a bounded window (e.g., 24 hours), preventing uncontrolled storage growth from abandoned upload flows.
- `MediaRemoved` event published on both user-initiated and moderation-initiated removal, letting referencing domains (Places, Reviews) clean up their reference without needing direct storage access.

## Security boundary

- No component other than Media ever receives permanent, broadly-scoped object-storage credentials. All other components that need to reference media do so by `MediaAsset.id` and, when they need a display URL, either use the documented deterministic public-derivative URL pattern (for public content) or call the Media service for a signed URL (for restricted content) — never holding their own storage credentials.
