# 11 — Search, Geocoding, and Autocomplete Architecture

These are three distinct contracts sharing infrastructure (OpenSearch), owned by the `search-api` deployable (see `02-...md`).

## Search (free-text + geo place discovery)

- **Source of truth:** `places.place` (Places domain) + `geodata.geographic_feature`/`administrative_region` (for locality/landmark search), never the index itself.
- **Search document structure** (`SearchDocument`, per `04-data-ownership-matrix.md`):

```json
{
  "id": "place_id or feature_id",
  "type": "place | administrative_region | landmark",
  "name": "string (primary, localized variants in name_i18n)",
  "name_i18n": { "en": "...", "es": "..." },
  "aliases": ["string", "..."],
  "categories": ["restaurant.italian", "..."],
  "location": { "type": "Point", "coordinates": [lng, lat] },
  "administrative_path": ["country", "region", "locality"],
  "popularity_signal": 0.0,
  "quality_signal": 0.0,
  "status": "active | moderated_hidden",
  "source_version": "map_data_version or place.version",
  "indexed_at": "RFC3339 timestamp"
}
```

- **Indexing events:** `PlaceCreated`, `PlaceUpdated`, `PlaceDeleted`, `PlaceModerated`, `MapDataVersionPublished` — each consumed idempotently (upsert-by-`id`, delete-by-`id`) by a dedicated indexing consumer, never a synchronous write from Places into OpenSearch (preserves failure isolation: a Search/OpenSearch outage cannot block a place write).
- **Ranking inputs:** text relevance (BM25-family default scoring), geographic proximity to the request's bias point (`near`), `popularity_signal` (derived from aggregate saved-place counts and review volume, recomputed periodically, not real-time), `quality_signal` (derived from moderation status and data completeness). Ranking weights are configuration (`../../contracts/config/service-config.schema.json`), not hardcoded, so they can be tuned without a redeploy of ranking logic.
- **Freshness:** target indexing latency from canonical write to searchable is seconds-to-low-minutes (event-consumer lag dependent); this is a best-effort near-real-time guarantee, not a synchronous read-your-writes guarantee — a client that just created a place should not assume it is immediately present in search results (the Places domain's own `GET /v1/places/{id}` is immediately consistent; search is not).
- **Deletion:** `PlaceDeleted`/moderation-hide removes or status-flags the document; a moderation-hidden place is excluded from public search results but retained in the index (not deleted) for fast reinstatement and audit.
- **Reindexing/rebuild:** the entire index is rebuildable from canonical Places + Geographic data at any time via an internal/admin-triggered batch job (`SearchIndexRebuildRequested`), writing to a new index alias and cutting over atomically (blue/green alias swap) — never reindexing in place against the serving alias.
- **Fallback behavior:** if OpenSearch is unavailable, `search-api` returns `503 service_unavailable` (`dependency_unavailable` in the error catalog) for free-text search, but Geocoding's structured-address path (below) degrades to Postgres-only lookups where feasible rather than failing outright, since geocoding has a narrower, more structured query shape.
- **Caching:** short-TTL (seconds) response caching in Redis keyed by normalized `(query, near, filters)` tuple, to absorb duplicate/typeahead-adjacent request bursts.

## Autocomplete

- **Distinct contract from Search:** optimized for prefix/partial-input latency (target p99 well under general search latency), returns lightweight result shapes (`id`, `name`, `type`, `primary_category`) — never the full place detail payload.
- **Candidate generation:** OpenSearch edge n-gram / search-as-you-type field mapping on `name`/`aliases`, geographically biased toward the request's `near` point, with a smaller candidate set (default limit 5–10) than general search.
- **Typo tolerance:** fuzzy matching (bounded edit distance, e.g., `fuzziness: AUTO`) on the prefix-matched field.
- **Caching:** aggressively cached (short TTL, Redis) given high repeat-prefix request volume during typing.

## Geocoding (forward and reverse)

- **Forward geocoding** (`POST /v1/geocode`): structured or free-text address string → ranked candidate coordinates.
  - **Candidate generation:** address-component parsing/normalization → structured match against `geodata.administrative_region`/road-segment-derived address ranges → fallback to Search's index for POI-level "geocode a business name" cases.
  - **Confidence:** every candidate returns a `confidence` (`0.0`–`1.0`) and a `match_level` enum (`exact_address`, `street`, `locality`, `region`, `approximate`) — the API never silently picks the top candidate as if it were certain; callers must inspect confidence/match_level, and UIs are expected to disambiguate below a documented confidence threshold rather than auto-navigate.
  - **Ambiguity:** genuinely ambiguous input (e.g., a common street name in multiple cities with no other disambiguating context) returns multiple candidates with comparable confidence rather than an arbitrary single pick — see `geocoding_ambiguous` note in `07-error-contract.md`.
- **Reverse geocoding** (`POST /v1/geocode/reverse`): coordinate → nearest address/administrative context, using spatial containment/nearest-neighbor queries against `geodata` tables (not OpenSearch — this is a structured spatial query, PostGIS is the right tool).
- **Localization:** candidate `formatted_address` respects `Accept-Language`; underlying structured components are always returned in a locale-neutral structured form as well.
- **Source provenance:** every candidate carries `source` (which `MapDataVersion`/dataset it derived from).
- **Precision claims:** geocoding never returns a coordinate with a false precision beyond what its `match_level` supports (e.g., a `locality`-level match returns the locality centroid with `match_level: locality`, not a fabricated street-level point).

## Boundary discipline

- Autocomplete and Search share the OpenSearch cluster and much of the document schema but remain separate API contracts with separate latency SLOs and separate response shapes — collapsing them into "autocomplete is just search with a small limit" is explicitly rejected because their caching, ranking-weight, and candidate-generation tuning diverge in practice.
- Geocoding is not "search with a filter" — it has a fundamentally different success contract (confidence-scored coordinate resolution vs. relevance-ranked discovery) and partially different data path (structured PostGIS queries in addition to the search index).
