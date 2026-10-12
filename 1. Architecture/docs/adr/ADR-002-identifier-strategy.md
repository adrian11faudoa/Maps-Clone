# ADR-002: ULID as the Primary Identifier Strategy

## Context

The platform needs a globally unique, coordination-free identifier scheme usable consistently across PostgreSQL, events, APIs, and caches, that supports efficient pagination and doesn't leak sequential-enumeration information.

## Decision

Use ULID (26-char Crockford base32, lexicographically sortable by creation time) as the primary identifier for all canonical entities, with two documented exceptions: `Category` uses a stable slug string; `MapDataVersion`/`TileVersion` additionally carry a monotonic integer `version` alongside their ULID `id`.

## Alternatives considered

- **Auto-increment integers.** Rejected: leaks record counts/enumeration (IDOR reconnaissance risk), requires central sequence coordination that complicates future sharding, not portable across independently-generated project parts without a shared sequence authority.
- **UUID v4.** Rejected as the *sole* scheme: not sortable by creation time, which is useful for cursor pagination and debugging; ULID is a strict improvement for this platform's access patterns while remaining a 128-bit-equivalent unique value.
- **Snowflake-style IDs (Twitter-style 64-bit).** Rejected: requires coordinated worker-ID allocation across services, adding operational complexity ULID avoids; ULID's larger size (26 chars vs. ~19 digits) is an acceptable tradeoff given this platform's read/write volumes.

## Consequences

- Pagination cursors derive directly from primary keys for the common case (see `06-api-architecture.md`), avoiding a separate sort-key index in most tables.
- IDs are non-enumerable, contributing defense-in-depth against IDOR probing (see `17-security-privacy-architecture.md`), though authorization checks remain the primary control, not ID obscurity.
- All independently generated project parts (backend, web, mobile) must use a conformant ULID library rather than inventing per-part ID generation, to preserve cross-part identifier compatibility (`21-cross-part-integration-matrix.md`).
