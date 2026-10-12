# 09 — Geospatial Data Architecture

## Pipeline overview

```text
External Geographic Sources (OSM extracts, licensed provider feeds, gov't open data)
        │  (batch/periodic ingestion — NOT a runtime request-path dependency)
        ▼
[1] Raw Source Snapshot           — immutable, stored as received, in object storage, tagged with source + fetch timestamp + license
        │
        ▼
[2] Normalization + Validation    — geometry validity checks (ST_IsValid), CRS reprojection to EPSG:4326,
        │                            deduplication, schema mapping to canonical model, provenance tagging
        ▼
[3] Canonical Geospatial Dataset  — PostgreSQL/PostGIS `geodata` schema: GeographicFeature, RoadSegment,
        │                            AdministrativeRegion, versioned as a new MapDataVersion
        │
        ├──────────────┬───────────────┬────────────────────┐
        ▼              ▼               ▼                    ▼
   [4a] Search      [4b] Tiles     [4c] Routing Graph    [4d] Analytics
   (OpenSearch       (vector tile   (engine-native graph   (warehouse
   documents)         build)         build, e.g. OSRM/       extract)
                                     Valhalla/GraphHopper
                                     .osrm/.gph artifacts)
```

## Stage responsibilities

| Stage | Owner (deployable) | Authoritative? | Trigger | Output |
|---|---|---|---|---|
| [1] Raw source snapshot | `geodata-pipeline` (ingestion job) | Yes — immutable record of what was received | Scheduled (e.g., nightly/weekly per source) or manual trigger for a licensed feed refresh | Object storage path + manifest (source, license, fetch time, checksum) |
| [2] Normalization + validation | `geodata-pipeline` (normalize job) | No (transformation stage) | New raw snapshot available | Validated staging tables, rejected-record report |
| [3] Canonical dataset | `geodata-pipeline` (publish job) → Geographic/Address Data domain | **Yes** | Validation passes quality gate | New `MapDataVersion`, `GeographicFeature`/`RoadSegment`/`AdministrativeRegion` rows |
| [4a] Search index | `search-api` (consumer) | No (derived) | `MapDataVersionPublished` event | OpenSearch documents |
| [4b] Tiles | `geodata-pipeline` (tile-build job) → Map Tiles domain | Yes for the artifact, no for content origin | `MapDataVersionPublished` event | Versioned vector tile set published to CDN origin |
| [4c] Routing graph | `geodata-pipeline` (graph-build job) → `routing-api`/`routing-engine` | No (derived, rebuildable) | `MapDataVersionPublished` event | Engine-native graph artifact, versioned |
| [4d] Analytics | `analytics-pipeline` (consumer) | No (derived) | `MapDataVersionPublished` event | Warehouse tables |

## Quality gate before publication (stage 2 → 3)

A normalized batch is promoted to a new `MapDataVersion` only if it passes:

- **Geometry validity:** 100% of geometries pass `ST_IsValid`; invalid geometries are attempted auto-repair (`ST_MakeValid`) and re-checked; still-invalid records are rejected and reported, not silently dropped from the report.
- **Referential integrity:** road segment endpoints resolve to intersection nodes; administrative region hierarchies have no cycles.
- **Delta sanity bounds:** the batch does not remove or relocate more than a configured percentage of existing features versus the previous version without manual confirmation (guards against a corrupted or partial source extract silently wiping the dataset).
- **License/provenance completeness:** every record traces to a source with a recorded license.

A batch failing the gate does not publish a new `MapDataVersion`; the previous version remains authoritative and serving, and the failure is surfaced via alerting (see `18-observability-reliability-architecture.md`).

## Versioning and rollback

- `MapDataVersion` is append-only and monotonically numbered. The "current" version is a pointer, not a mutation of prior data.
- Derived products (`4a`–`4d`) are tagged with the `MapDataVersion` they were built from, so a rollback of the current pointer to a previous version has well-defined derived-product implications (search/tiles/routing graph roll back to the corresponding previously-built artifact, or are rebuilt from the target version if no cached build exists).
- The platform retains at minimum the current and previous `MapDataVersion` plus their derived artifacts to support immediate rollback without a rebuild; older versions' raw/normalized snapshots may move to colder storage tiers per lifecycle policy while version *metadata* (lineage, what changed) is retained indefinitely.

## Coordinate/geometry conventions

See `05-identifier-time-coordinate-model.md` — EPSG:4326 canonical, `[lng, lat]` order, GeoJSON for transmission, PostGIS `geometry`/`geography` for storage (type choice detailed per table in `10-database-postgis-architecture.md`).

## Licensing and provenance discipline

- The architecture assumes but does not itself select or license a specific commercial dataset; `geodata-pipeline` source adapters are pluggable (OpenStreetMap extract adapter is the reference/default adapter assumed available under ODbL).
- Every canonical record retains a `source` field and the pipeline retains the manifest linking that source to its recorded license terms. The pipeline must refuse to publish data from a source with no recorded license.
- No implementation prompt under this architecture may assume unrestricted commercial redistribution rights for any dataset merely because it is technically retrievable — this is a licensing/legal decision that must be made explicitly per source, external to this architecture document.

## Failure handling

- If the ingestion pipeline cannot reach an external source, the platform continues serving the last successfully published `MapDataVersion` indefinitely — a source outage is never permitted to be interpreted as "delete the data."
- Partial/corrupted downloads are detected via checksum validation at stage [1] and rejected before entering normalization.
