# 12 — Map-Tile Architecture

## Pipeline

```text
geodata.GeographicFeature / RoadSegment / AdministrativeRegion (MapDataVersion N)
        │
        ▼
Vector tile build job (geodata-pipeline, offline/batch — e.g., Tippecanoe-style
        │                mvt generation from canonical PostGIS data)
        ▼
Tile artifacts (.pbf per z/x/y), written to object storage, grouped as a
        │  versioned TileSet tied to MapDataVersion N
        ▼
TileVersion record published (tiles schema) + TileVersionPublished event
        │
        ▼
CDN origin pull / push publish of the new TileSet
        │
        ▼
Client requests /v1/tiles/{z}/{x}/{y}.pbf → CDN (cache hit) → origin (Map-tile
        service) only on cache miss
```

## Tile schema and layers

- **Format:** Mapbox Vector Tile (MVT) spec, `.pbf` per tile.
- **Zoom levels:** 0–18 for base layers (roads, administrative boundaries, landmarks); POI layer active from zoom 12+ (avoids overwhelming low-zoom tiles with point density).
- **Layers (initial set):** `boundaries` (administrative regions), `roads` (road segments, with a `class`/`ref` attribute for styling), `water`/`landuse` (if sourced), `places` (POI points, only zoom 12+), `traffic` (optional overlay layer — see below).
- **Style configuration:** a separate style specification (Mapbox GL/MapLibre style JSON) references these layer names; style JSON is served from `/v1/tiles/styles/{styleId}` and versioned independently from the tile data itself (a style change does not require a tile rebuild, and vice versa).

## Versioning

- Every published `TileSet` carries a `version` (monotonic integer) and a `source_map_data_version` reference (the `MapDataVersion` it was built from — see `09-...md`).
- Tile URLs are **not** version-namespaced in the path by default (`/v1/tiles/{z}/{x}/{y}.pbf` stays stable); version transitions happen via CDN cache invalidation plus `ETag`/`Cache-Control` revalidation, so clients don't need to know the version number to stay current. An explicit versioned path (`/v1/tiles/{version}/{z}/{x}/{y}.pbf`) is additionally available for clients that want to pin a specific version (e.g., an offline-map-download feature needing a stable snapshot) — both are part of the contract.
- Rollback: reverting to `TileVersion N-1` is a metadata pointer change plus CDN cache invalidation, not a rebuild, as long as `N-1`'s artifacts are still retained (see retention below).

## CDN and caching

- `Cache-Control: public, max-age=86400, stale-while-revalidate=604800` (illustrative default — exact values are config, not hardcoded) on tile responses, since tile content changes infrequently and staleness is tolerable within the map-data update cadence.
- Cache invalidation on new `TileVersion` publish: either (a) CDN path-based invalidation across the tile prefix, or (b) reliance on `ETag`/`Last-Modified` revalidation without hard invalidation, depending on the CDN's cost/latency tradeoffs for invalidation at scale — this is an infrastructure-layer decision documented in `19-...md`, not a client-visible contract change.
- Regional data partitioning: tile build jobs may be parallelized/partitioned by geographic region (e.g., per country/continent shard) purely as a build-performance optimization; the served tile scheme (`z/x/y`) is a single global scheme regardless of how the build was partitioned.

## Freshness and fallback

- Map data freshness for tiles follows `MapDataVersion` publication cadence (see `09-...md`) — tiles are not expected to reflect sub-minute changes; a moderation-hidden place is removed from the *next* tile build, not instantaneously (the POI layer at zoom 12+ is a cartographic convenience, not the authoritative place detail source — clients get authoritative live place status from `/v1/places/{id}`, not from tile content).
- If the CDN/origin cannot serve a requested tile (build gap, regional data absence), the client receives a `404` for that specific tile (empty/no-data tile), not a `500` — an absent tile at the edge of covered data is an expected, not exceptional, condition.
- Abuse prevention/rate limiting on the tile origin (not the CDN edge, which absorbs the vast majority of traffic): per-IP/per-key request-rate limits on **origin** requests specifically, since a legitimate CDN cache hit never reaches the origin and shouldn't be rate-limited at all.

## Security boundary

- The Map-tile service (origin) has **read-only** access to `geodata` schema replicas/derived artifacts — it never has write access to any authoritative table, and it never proxies arbitrary database queries to clients. Clients receive only pre-built tile artifacts, never live query access to `geodata`.
- Tile-generation pipeline (offline batch) and tile-serving origin are separate deployables/processes (per `02-component-architecture.md`) so that a build-time failure cannot directly impact serving of the currently-published version.

## Traffic overlay layer (optional, cross-reference)

- A `traffic` vector tile layer, if enabled, is generated far more frequently than base layers (e.g., every 1–5 minutes) from `traffic.traffic_snapshot` aggregates (see `13-...md`), as a **separate, independently-versioned TileSet** from the base map layers — this keeps the expensive, infrequent base-map rebuild decoupled from the cheap, frequent traffic-layer refresh.
