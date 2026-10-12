# ADR-001: Modular Monolith Groupings Over One-Service-Per-Domain

## Context

The platform has ~19 bounded domains (`03-domain-boundaries.md`). A naive interpretation of "microservices architecture" would deploy one service per domain from day one. The Master Prompt explicitly warns against creating a separate microservice merely because a domain exists, and against introducing distributed infrastructure with no demonstrated architectural purpose.

## Decision

Group domains into a small number of independently deployable applications (`02-component-architecture.md`), splitting out a domain as its own deployable only where a concrete scaling, runtime, or security-boundary justification exists today (Search, Routing, Navigation, Traffic, Media, geospatial pipeline, notification delivery). All other domains (Identity, Users, Places, Saved Places, Contributions, Reviews, Moderation & Administration) start as modules within `core-api`.

## Alternatives considered

- **One service per domain (~19 services) from day one.** Rejected: multiplies operational overhead (19 deployment pipelines, 19 sets of health checks/dashboards, 19 network policies) with no corresponding benefit for domains that share scaling/security profile and are typically deployed/scaled together in practice at this stage.
- **Single monolith with no service splits at all.** Rejected: Search, Routing, Navigation, Traffic, and Media have genuinely different scaling profiles, runtime requirements (routing engine), or security postures (Media's untrusted-input boundary) that justify isolation now, not as a future migration.

## Rationale

Module boundaries within `core-api` are enforced at the code-organization and database-schema-grant level (per-schema PostgreSQL roles, `10-...md`) identically to how they would be enforced across a network boundary, so extraction later is a deployment change, not a redesign — the domain boundaries themselves (`03-...md`) are the actual source of truth, independent of deployment topology.

## Consequences

- Faster initial delivery, fewer moving operational parts.
- Extraction triggers are documented (`02-component-architecture.md` decision table) so the decision to split is evidence-driven, not deferred indefinitely by default either.
- Requires discipline: a module in `core-api` must not take a shortcut and directly query another module's schema just because they're in the same process — the same API/event-only cross-domain access rule applies regardless of deployment topology.

## Operational implications

`core-api` scales as one unit; if one contained module (e.g., Contributions during a moderation surge) needs independent scaling before a full extraction is justified, the interim mitigation is resource allocation/autoscaling tuning for the whole `core-api` deployment, not a workaround that breaks the schema/API boundary discipline.
