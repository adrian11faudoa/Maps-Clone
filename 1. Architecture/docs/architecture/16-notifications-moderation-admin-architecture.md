# 16 — Notifications, Moderation, and Administration Architecture

## Notifications

### Separation of concerns

- **Intent vs. delivery:** any domain that determines "a user should be told something" publishes a `NotificationRequested` event (intent) — it never calls a push/email provider directly. The Notifications domain owns all delivery-provider interaction. This means a domain's core transaction (e.g., a contribution being approved) never blocks on, or fails because of, a third-party notification provider being slow or down (see `01-system-context.md` failure-isolation principle).
- `NotificationRequested` payload: `{ user_id, category (e.g., "navigation", "account", "moderation", "contribution"), template_id, template_data, channels_requested: ["push","email","in_app"], priority }`. The Notifications domain resolves `channels_requested` against the user's actual `NotificationPreference` before dispatch — a request is a request, not a guarantee of delivery on every requested channel.

### Channels

| Channel | Provider boundary | Notes |
|---|---|---|
| Push | APNs (iOS) / FCM (Android) adapters, unified behind one internal interface | Used for navigation-critical (reroute, arrival) and time-sensitive account/moderation notifications |
| Email | Pluggable transactional email provider adapter | Account, contribution/review-outcome, digest-style notifications |
| In-app | `notifications` schema + client poll/fetch of `GET /v1/users/me/notifications` | Always recorded regardless of push/email success, serving as the durable record of "what was this user told" |

### Delivery, retry, preferences

- Each `(notification, channel)` pair has its own `NotificationDeliveryAttempt` record with `status` (`pending|sent|failed|suppressed`). `suppressed` covers cases where the user's preference opted out of that channel for that category — recorded, not silently dropped, for support/debuggability.
- Delivery retries follow the queue retry policy in `14-event-queue-architecture.md`; navigation-critical notifications (e.g., "you are off route," "arrived") use a high-priority queue lane with tighter timeout/retry parameters than digest-style notifications.
- `NotificationPreference` is per-user, per-category, per-channel (opt-in/opt-out), defaulting to a documented sane default (e.g., push+in-app on for navigation/account, email on for account/moderation outcomes, off by default for lower-priority digest categories) — never defaulting to "all channels on" without the user's own configuration, respecting `08-auth-architecture.md`'s owner-only access to the preference resource.

## Moderation

### Workflow

```text
Trigger (ReportSubmitted | ContributionSubmitted | ReviewCreated | MediaUploaded)
        │
        ▼
ModerationCase created (status: open), linked to the subject entity
        │
        ▼
Assigned/claimed by a moderator (or auto-triaged by a rules/ML signal —
        │   out of scope for implementation in this volume, boundary reserved)
        │
        ▼
Moderator decision: approve | reject | escalate | request_more_info
        │
        ▼
ModerationDecisionMade event published, ModerationCase status: closed
        │
        ▼
Subject domain (Places/Reviews/Media/Contributions) applies the decision
   to its own canonical data via its own consumer, publishing its own
   resulting domain event (e.g., ContributionApproved → Places applies it)
```

- **Every object type funnels through the same `ModerationCase`/`AuditRecord` machinery** — see `03-domain-boundaries.md` boundary justification. A `ModerationCase.subject_type` enum (`place`, `review`, `media`, `contribution`, `user`) distinguishes what's being moderated without needing a separate case-management implementation per type.
- **Reports:** any authenticated user can `POST /v1/reports` against any moderatable subject; a report creates or attaches to an existing open `ModerationCase` for that subject (deduplicated, not one case per report).
- **Moderator authorization:** enforced per `08-auth-architecture.md`'s `moderator`/`admin` roles; a moderator's own content can still be reported/moderated by another moderator or admin (no self-exemption).

### Administration

- **Admin actions** (role grants, configuration changes, direct data overrides, account suspension) are distinct from moderation decisions (which act on user-generated-content-adjacent subjects) — both flow through the same `AuditRecord` mechanism but `AdminAction` and `ModerationCase` are separate entity types because admin actions often have no "case" lifecycle (they're a direct, immediate action, not an open/triage/decide workflow).
- Every admin action requires: actor identity (from the validated token, never client-asserted), action type (closed enum), target entity, timestamp, and — for the more sensitive action types (role grants, account suspension, direct data override) — a required `reason` free-text field.
- Admin tooling **never bypasses the standard authorization layer** — an admin console request still goes through the same `08-auth-architecture.md` token validation and role check as any other request; there is no backdoor/service-account shortcut used to fulfill admin UI requests.

### Auditability

- `AuditRecord` is append-only (no `UPDATE`/`DELETE` grants on that table for any application role — enforced at the database privilege level, not just application logic) and captures: actor, action, subject, before/after state summary where applicable, timestamp, correlation ID.
- `AuditRecord` itself is access-controlled: readable only by `admin` (and `support` for the narrow subset relevant to a support case, if that distinction is implemented), never publicly exposed, and never itself subject to moderation/deletion by any role including `admin` through normal application paths (a genuine compliance-driven purge, if ever required, is an out-of-band operational procedure, not an application feature).

## Cross-cutting rule

Moderation and Administration act on other domains **only** through those domains' own APIs or by publishing `ModerationDecisionMade`/consuming domains applying it themselves — never via direct write access to another domain's schema, preserving the ownership rule in `03-domain-boundaries.md` even for the platform's highest-privilege actors.
