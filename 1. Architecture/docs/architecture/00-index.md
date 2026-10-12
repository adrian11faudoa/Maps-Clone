# Architecture Package Index — Google Maps-Style Mapping & Navigation Platform

**Volumes:** Volume 1 — Foundational Architecture & Portable Contracts (docs 01–21, ADR-001 to ADR-011). Volume 2 — Implementation-Ready Contract, Schema, Protocol, and Operational Architecture (docs 22–26, ADR-012 to ADR-015, `contracts/entities/`, `contracts/enums/`, `contracts/realtime/`, `contracts/queues/`, `contracts/redis/`, `contracts/config/provider-adapter.schema.json`).
**Status:** Foundational architecture and implementation-ready contracts complete. No application features, controllers, screens, or infrastructure are implemented in this package.
**Repository state at time of Volume 1 authoring:** empty repository. Volume 2 was authored against the Volume 1 repository state — no application code existed at either point; Volume 2 deepened and cross-referenced Volume 1's artifacts rather than replacing any of them.

## Purpose

This package is the authoritative, portable contract set that independently generated backend, web, mobile, infrastructure, and QA implementation prompts (run in separate conversations, potentially by different agents) must consume without relying on hidden context. It is also the artifact set a final integration environment ("Codex" or equivalent) uses to reconcile independently produced project parts into one coherent system.

Nothing in this package is authorization to implement application functionality. Implementation prompts implement only their own bounded scope, against these contracts.

## How to use this package

- **Backend implementation prompts** must conform to: `06-api-architecture.md`, `07-error-contract.md`, `08-auth-architecture.md`, `10-database-postgis-architecture.md`, `14-event-queue-architecture.md`, `22-canonical-entities-and-enums.md`, `23-realtime-navigation-protocol.md`, `24-queue-and-redis-keyspace-contracts.md`, `25-compatibility-versioning-deployment-order.md`, `../../contracts/openapi/core-v1.yaml`, `../../contracts/events/schemas/*.json`, `../../contracts/entities/*.schema.json`, `../../contracts/enums/registry.json`, `../../contracts/realtime/navigation-protocol.schema.json`, `../../contracts/queues/schemas/*.schema.json`, `../../contracts/redis/keyspace.json`, `../../contracts/db/core-entities.sql`.
- **Web/mobile implementation prompts** must conform to: `06-api-architecture.md`, `07-error-contract.md`, `08-auth-architecture.md`, `12-map-tile-architecture.md`, `13-routing-navigation-traffic-architecture.md`, `23-realtime-navigation-protocol.md`, the OpenAPI contract, and `../../contracts/realtime/navigation-protocol.schema.json`.
- **Infrastructure prompts** must conform to: `19-deployment-scalability-integration-architecture.md`, `09-geospatial-data-architecture.md`, `12-map-tile-architecture.md`, `18-observability-reliability-architecture.md`, `24-queue-and-redis-keyspace-contracts.md`, `../../contracts/config/service-config.schema.json`, `../../contracts/config/provider-adapter.schema.json`.
- **QA prompts** must conform to all of the above plus `21-cross-part-integration-matrix.md` and `26-cross-part-implementation-matrix-v2.md`, which together enumerate what must be contract-tested.

Any implementation prompt that needs to deviate from a contract in this package must update the contract here first (via a new ADR and a version bump), not silently diverge in a downstream repository.

## Document set

| # | Document | Covers |
|---|---|---|
| 01 | `01-system-context.md` | External actors, external systems, system boundary |
| 02 | `02-component-architecture.md` | Logical components, deployment shape (service vs. module) |
| 03 | `03-domain-boundaries.md` | Bounded contexts, per-domain responsibilities |
| 04 | `04-data-ownership-matrix.md` | Canonical entity ownership, storage, consumers |
| 05 | `05-identifier-time-coordinate-model.md` | IDs, timestamps, coordinates, units |
| 06 | `06-api-architecture.md` | REST conventions, resource families, contract | 
| 07 | `07-error-contract.md` | Error envelope, codes, retryability |
| 08 | `08-auth-architecture.md` | AuthN, sessions, tokens, AuthZ model |
| 09 | `09-geospatial-data-architecture.md` | Source → canonical → derived data pipeline |
| 10 | `10-database-postgis-architecture.md` | PostgreSQL/PostGIS ownership, foundational entities |
| 11 | `11-search-geocoding-autocomplete-architecture.md` | Search, geocoding, autocomplete boundaries |
| 12 | `12-map-tile-architecture.md` | Vector tile pipeline, CDN, versioning |
| 13 | `13-routing-navigation-traffic-architecture.md` | Routing, navigation sessions, traffic |
| 14 | `14-event-queue-architecture.md` | Event envelope, domain events, queues, Redis |
| 15 | `15-storage-media-architecture.md` | Media upload/processing/CDN lifecycle |
| 16 | `16-notifications-moderation-admin-architecture.md` | Notifications, moderation, admin, audit |
| 17 | `17-security-privacy-architecture.md` | Threat model, trust zones, privacy classes |
| 18 | `18-observability-reliability-architecture.md` | Telemetry, SLOs, failure isolation |
| 19 | `19-deployment-scalability-integration-architecture.md` | Environments, scaling, external providers |
| 20 | ADRs in `../adr/` | Material technology/boundary decisions |
| 21 | `21-cross-part-integration-matrix.md` | Contract → consumer matrix (boundary-level, Volume 1) |
| 22 | `22-canonical-entities-and-enums.md` | Canonical entity field contracts and enum registry (Volume 2) |
| 23 | `23-realtime-navigation-protocol.md` | WebSocket navigation protocol, SLOs, failure/degradation matrix (Volume 2) |
| 24 | `24-queue-and-redis-keyspace-contracts.md` | Queue envelopes, Redis keyspace, idempotency, concurrency, filtering/sorting (Volume 2) |
| 25 | `25-compatibility-versioning-deployment-order.md` | Cross-artifact compatibility rules, expand/contract sequencing (Volume 2) |
| 26 | `26-cross-part-implementation-matrix-v2.md` | Contract → consumer matrix (implementation-grade, Volume 2) |

## Machine-readable contracts

| Artifact | Location | Format | Consumers |
|---|---|---|---|
| Core REST API contract | `../../contracts/openapi/core-v1.yaml` | OpenAPI 3.1 | Backend, web, mobile, QA |
| Domain event schemas | `../../contracts/events/schemas/*.json` | JSON Schema (draft 2020-12) | Backend, QA |
| Event registry | `../../contracts/events/registry.md` | Markdown table | All |
| Canonical entity schemas | `../../contracts/entities/*.schema.json` | JSON Schema + `x-*` metadata | Backend, web, mobile, QA |
| Enum registry | `../../contracts/enums/registry.json` | JSON (values + transitions) | Backend, web, mobile, DB, QA |
| Realtime navigation protocol | `../../contracts/realtime/navigation-protocol.schema.json` | JSON Schema (draft 2020-12) | Backend (`navigation-api`), web, mobile, QA |
| Queue job schemas | `../../contracts/queues/schemas/*.schema.json` | JSON Schema (draft 2020-12) | Backend, Infra, QA |
| Queue registry | `../../contracts/queues/registry.md` | Markdown table | All |
| Redis keyspace registry | `../../contracts/redis/keyspace.json` | JSON | Backend, Infra, QA |
| Service config schema | `../../contracts/config/service-config.schema.json` | JSON Schema | Backend, Infra |
| Provider adapter config schema | `../../contracts/config/provider-adapter.schema.json` | JSON Schema | Backend, Infra |
| Foundational entity DDL | `../../contracts/db/core-entities.sql` | PostgreSQL/PostGIS DDL | Backend, Infra, QA |
| Validation scripts | `../../contracts/scripts/validate.py` | Python | CI, all prompts |

All machine-readable artifacts were validated at authoring time — see the completion report for this prompt for the exact validation commands and output.

## Versioning of this package

This is **Architecture Package v2.0.0** (Volume 1 was v1.0.0; Volume 2 is additive/deepening, not a breaking replacement of any Volume 1 decision — see `25-compatibility-versioning-deployment-order.md`). Contracts in this package use their own independent version fields (API version `v1`, event `schema_version` per event type, job `job_version` per job type, config schema `$id` version). Breaking changes to any contract require a new ADR and a version increment; additive, backward-compatible changes may increment a minor/patch version without an ADR but must still be recorded in the relevant document's changelog section.

## Repository layout established by this package

```text
mapping-platform/
  docs/
    architecture/        # this package (01-26)
    adr/                 # architecture decision records (ADR-001 to ADR-015)
  contracts/
    openapi/             # REST API contract
    events/               # event schemas + registry
    entities/             # canonical entity JSON Schemas (Volume 2)
    enums/                 # canonical enum registry (Volume 2)
    realtime/              # WebSocket navigation protocol schema (Volume 2)
    queues/                # queue job schemas + registry (Volume 2)
    redis/                 # Redis keyspace registry (Volume 2)
    config/               # service + provider-adapter configuration schemas
    db/                   # foundational PostGIS DDL
    scripts/               # contract validation scripts
```

No `apps/`, `services/`, `infra/`, or `packages/` implementation directories are created by this package. Those belong to their own implementation prompts and should be added as siblings of `docs/` and `contracts/` in this same repository so that architecture and implementation stay co-located and versioned together.
