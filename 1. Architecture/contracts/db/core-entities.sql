-- Foundational entity DDL for the Mapping & Navigation Platform.
-- See docs/architecture/10-database-postgis-architecture.md and
-- docs/architecture/04-data-ownership-matrix.md for the ownership and
-- design rationale behind every table below.
--
-- This file establishes the CANONICAL entity shapes referenced across the
-- architecture package. It is deliberately limited to the foundational
-- entities needed to prevent independently generated implementation
-- prompts from inventing incompatible models -- it is not a complete
-- production schema (indexes beyond the primary spatial/FK ones,
-- additional domain-specific columns, and full partitioning DDL for
-- traffic/telemetry tables are implementation-prompt responsibilities
-- building on these foundations).
--
-- Validated by contracts/scripts/validate.py against a disposable
-- PostgreSQL/PostGIS instance.

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- =============================================================
-- schema: identity
-- =============================================================
CREATE SCHEMA IF NOT EXISTS identity;

CREATE TABLE identity.user_account (
    id              CHAR(26) PRIMARY KEY,               -- ULID
    email           TEXT NOT NULL UNIQUE,
    status          TEXT NOT NULL DEFAULT 'active'
                        CHECK (status IN ('active', 'suspended', 'deleted')),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at      TIMESTAMPTZ
);

CREATE TABLE identity.credential (
    id              CHAR(26) PRIMARY KEY,
    user_id         CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    type            TEXT NOT NULL DEFAULT 'password' CHECK (type IN ('password', 'totp')),
    secret_hash     TEXT NOT NULL,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_credential_user_id ON identity.credential(user_id);

CREATE TABLE identity.device (
    id              CHAR(26) PRIMARY KEY,
    user_id         CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    platform        TEXT NOT NULL CHECK (platform IN ('web', 'ios', 'android')),
    display_name    TEXT,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_device_user_id ON identity.device(user_id);

CREATE TABLE identity.session (
    id                  CHAR(26) PRIMARY KEY,
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    device_id           CHAR(26) REFERENCES identity.device(id),
    refresh_token_hash  TEXT NOT NULL,
    roles               TEXT[] NOT NULL DEFAULT ARRAY['user'],
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_used_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    expires_at          TIMESTAMPTZ NOT NULL,
    revoked_at          TIMESTAMPTZ
);
CREATE INDEX idx_session_user_id ON identity.session(user_id);
CREATE INDEX idx_session_active ON identity.session(user_id) WHERE revoked_at IS NULL;

CREATE TABLE identity.user_profile (
    user_id             CHAR(26) PRIMARY KEY REFERENCES identity.user_account(id),
    display_name        TEXT NOT NULL,
    locale              TEXT NOT NULL DEFAULT 'en',
    unit_preference     TEXT NOT NULL DEFAULT 'metric' CHECK (unit_preference IN ('metric', 'imperial')),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- =============================================================
-- schema: geodata
-- =============================================================
CREATE SCHEMA IF NOT EXISTS geodata;

CREATE TABLE geodata.map_data_version (
    id                  CHAR(26) PRIMARY KEY,
    version_number      INTEGER NOT NULL UNIQUE,
    source_summary      JSONB NOT NULL,           -- [{source, license, fetched_at}, ...]
    is_current          BOOLEAN NOT NULL DEFAULT false,
    published_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX idx_map_data_version_current ON geodata.map_data_version(is_current) WHERE is_current;

CREATE TABLE geodata.administrative_region (
    id                  CHAR(26) PRIMARY KEY,
    map_data_version_id CHAR(26) NOT NULL REFERENCES geodata.map_data_version(id),
    external_ids        JSONB NOT NULL DEFAULT '{}'::jsonb,
    name                TEXT NOT NULL,
    admin_level         TEXT NOT NULL CHECK (admin_level IN ('country', 'region', 'locality', 'neighborhood')),
    parent_id           CHAR(26) REFERENCES geodata.administrative_region(id),
    geom                geometry(MultiPolygon, 4326) NOT NULL,
    source               TEXT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_admin_region_geom ON geodata.administrative_region USING GIST (geom);
CREATE INDEX idx_admin_region_parent ON geodata.administrative_region(parent_id);

CREATE TABLE geodata.road_segment (
    id                  CHAR(26) PRIMARY KEY,
    map_data_version_id CHAR(26) NOT NULL REFERENCES geodata.map_data_version(id),
    external_ids        JSONB NOT NULL DEFAULT '{}'::jsonb,
    road_class          TEXT NOT NULL,
    road_ref            TEXT,
    geom                geometry(LineString, 4326) NOT NULL,
    source              TEXT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_road_segment_geom ON geodata.road_segment USING GIST (geom);
CREATE INDEX idx_road_segment_version ON geodata.road_segment(map_data_version_id);

-- =============================================================
-- schema: places
-- =============================================================
CREATE SCHEMA IF NOT EXISTS places;

CREATE TABLE places.category (
    slug                TEXT PRIMARY KEY,
    label               TEXT NOT NULL,
    parent_slug         TEXT REFERENCES places.category(slug),
    deprecated          BOOLEAN NOT NULL DEFAULT false
);

CREATE TABLE places.place (
    id                  CHAR(26) PRIMARY KEY,
    name                TEXT NOT NULL,
    location            geography(Point, 4326) NOT NULL,
    address_formatted   TEXT,
    address_country     TEXT,
    address_locality    TEXT,
    status              TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active', 'moderated_hidden')),
    rating_average      NUMERIC(2,1),
    rating_count        INTEGER NOT NULL DEFAULT 0,
    version             INTEGER NOT NULL DEFAULT 1,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at          TIMESTAMPTZ
);
CREATE INDEX idx_place_location ON places.place USING GIST (location);
CREATE INDEX idx_place_name_trgm ON places.place USING GIN (name gin_trgm_ops);
CREATE INDEX idx_place_active ON places.place(id) WHERE deleted_at IS NULL;

CREATE TABLE places.place_category (
    place_id            CHAR(26) NOT NULL REFERENCES places.place(id),
    category_slug       TEXT NOT NULL REFERENCES places.category(slug),
    PRIMARY KEY (place_id, category_slug)
);

CREATE TABLE places.place_ownership (
    id                  CHAR(26) PRIMARY KEY,
    place_id            CHAR(26) NOT NULL REFERENCES places.place(id),
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    granted_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    revoked_at          TIMESTAMPTZ
);
CREATE INDEX idx_place_ownership_place ON places.place_ownership(place_id);

CREATE TABLE places.saved_place_list (
    id                  CHAR(26) PRIMARY KEY,
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    name                TEXT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE places.saved_place (
    id                  CHAR(26) PRIMARY KEY,
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    place_id            CHAR(26) NOT NULL REFERENCES places.place(id),
    list_id             CHAR(26) REFERENCES places.saved_place_list(id),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (user_id, place_id, list_id)
);
CREATE INDEX idx_saved_place_user ON places.saved_place(user_id);

CREATE TABLE places.contribution (
    id                  CHAR(26) PRIMARY KEY,
    place_id            CHAR(26) REFERENCES places.place(id),
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    type                TEXT NOT NULL CHECK (type IN ('create', 'update', 'correction')),
    proposed_changes    JSONB NOT NULL,
    status              TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'approved', 'rejected')),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    decided_at          TIMESTAMPTZ
);
CREATE INDEX idx_contribution_user ON places.contribution(user_id);
CREATE INDEX idx_contribution_status ON places.contribution(status);

CREATE TABLE places.review (
    id                  CHAR(26) PRIMARY KEY,
    place_id            CHAR(26) NOT NULL REFERENCES places.place(id),
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    rating              SMALLINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text         TEXT,
    status              TEXT NOT NULL DEFAULT 'visible' CHECK (status IN ('visible', 'hidden')),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    deleted_at          TIMESTAMPTZ,
    UNIQUE (place_id, user_id)
);
CREATE INDEX idx_review_place_created ON places.review(place_id, created_at);

-- =============================================================
-- schema: navigation
-- =============================================================
CREATE SCHEMA IF NOT EXISTS navigation;

CREATE TABLE navigation.navigation_session (
    id                  CHAR(26) PRIMARY KEY,
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    route_id            CHAR(26) NOT NULL,
    mode                TEXT NOT NULL CHECK (mode IN ('driving', 'walking', 'cycling', 'transit')),
    status              TEXT NOT NULL DEFAULT 'active'
                            CHECK (status IN ('active', 'paused', 'rerouting', 'completed', 'cancelled')),
    current_step_index  INTEGER NOT NULL DEFAULT 0,
    current_leg_index   INTEGER NOT NULL DEFAULT 0,
    last_known_location geography(Point, 4326),
    last_location_at    TIMESTAMPTZ,
    off_route           BOOLEAN NOT NULL DEFAULT false,
    version             INTEGER NOT NULL DEFAULT 1,
    started_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    ended_at            TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_nav_session_user ON navigation.navigation_session(user_id);
CREATE INDEX idx_nav_session_active ON navigation.navigation_session(user_id) WHERE status IN ('active', 'paused', 'rerouting');

-- location_update is a high-write, short-retention table; range-partitioned
-- by created_at per docs/architecture/10-database-postgis-architecture.md.
-- Partition creation/maintenance is an operational job, not shown here;
-- the parent table DDL establishes the canonical shape.
CREATE TABLE navigation.location_update (
    id                  CHAR(26) NOT NULL,
    session_id          CHAR(26) NOT NULL REFERENCES navigation.navigation_session(id),
    point                geography(Point, 4326) NOT NULL,
    heading             NUMERIC(5,2),
    speed_mps           NUMERIC(6,2),
    accuracy_m          NUMERIC(8,2),
    sequence            BIGINT NOT NULL,
    client_observed_at  TIMESTAMPTZ NOT NULL,
    server_received_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    clock_skew_suspected BOOLEAN NOT NULL DEFAULT false,
    implausible         BOOLEAN NOT NULL DEFAULT false,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);
CREATE INDEX idx_location_update_session ON navigation.location_update(session_id, sequence);

-- =============================================================
-- schema: traffic
-- =============================================================
CREATE SCHEMA IF NOT EXISTS traffic;

-- traffic_snapshot is range-partitioned by time_bucket per
-- docs/architecture/10-database-postgis-architecture.md.
CREATE TABLE traffic.traffic_snapshot (
    road_segment_id     CHAR(26) NOT NULL REFERENCES geodata.road_segment(id),
    time_bucket         TIMESTAMPTZ NOT NULL,
    congestion_level    TEXT NOT NULL CHECK (congestion_level IN ('free', 'light', 'moderate', 'heavy', 'severe')),
    average_speed_mps   NUMERIC(6,2),
    confidence          NUMERIC(3,2) NOT NULL CHECK (confidence BETWEEN 0 AND 1),
    sample_count        INTEGER NOT NULL CHECK (sample_count >= 1),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (road_segment_id, time_bucket)
) PARTITION BY RANGE (time_bucket);

CREATE TABLE traffic.incident (
    id                  CHAR(26) PRIMARY KEY,
    type                TEXT NOT NULL CHECK (type IN ('accident', 'closure', 'hazard', 'construction')),
    location            geography(Point, 4326) NOT NULL,
    road_segment_id     CHAR(26) REFERENCES geodata.road_segment(id),
    source              TEXT NOT NULL CHECK (source IN ('external_provider', 'user_report')),
    confidence          NUMERIC(3,2) NOT NULL DEFAULT 1.0 CHECK (confidence BETWEEN 0 AND 1),
    reported_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    resolved_at         TIMESTAMPTZ
);
CREATE INDEX idx_incident_location ON traffic.incident USING GIST (location);
CREATE INDEX idx_incident_active ON traffic.incident(id) WHERE resolved_at IS NULL;

-- =============================================================
-- schema: media
-- =============================================================
CREATE SCHEMA IF NOT EXISTS media;

CREATE TABLE media.media_asset (
    id                  CHAR(26) PRIMARY KEY,
    uploader_user_id    CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    context_type        TEXT NOT NULL CHECK (context_type IN ('place', 'review', 'contribution')),
    context_id          CHAR(26) NOT NULL,
    status              TEXT NOT NULL DEFAULT 'pending'
                            CHECK (status IN ('pending', 'processed', 'rejected', 'removed')),
    storage_key         TEXT NOT NULL,
    content_type        TEXT NOT NULL,
    size_bytes          BIGINT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    processed_at        TIMESTAMPTZ,
    removed_at          TIMESTAMPTZ
);
CREATE INDEX idx_media_asset_context ON media.media_asset(context_type, context_id);

CREATE TABLE media.media_derivative (
    id                  CHAR(26) PRIMARY KEY,
    media_asset_id      CHAR(26) NOT NULL REFERENCES media.media_asset(id),
    variant             TEXT NOT NULL,
    storage_key         TEXT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (media_asset_id, variant)
);

-- =============================================================
-- schema: notifications
-- =============================================================
CREATE SCHEMA IF NOT EXISTS notifications;

CREATE TABLE notifications.notification (
    id                  CHAR(26) PRIMARY KEY,
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    category            TEXT NOT NULL,
    title               TEXT NOT NULL,
    body                TEXT NOT NULL,
    read_at             TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_notification_user ON notifications.notification(user_id, created_at);

CREATE TABLE notifications.notification_preference (
    user_id             CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    category            TEXT NOT NULL,
    channel             TEXT NOT NULL CHECK (channel IN ('push', 'email', 'in_app')),
    enabled             BOOLEAN NOT NULL DEFAULT true,
    PRIMARY KEY (user_id, category, channel)
);

CREATE TABLE notifications.notification_delivery_attempt (
    id                  CHAR(26) PRIMARY KEY,
    notification_id     CHAR(26) NOT NULL REFERENCES notifications.notification(id),
    channel             TEXT NOT NULL CHECK (channel IN ('push', 'email', 'in_app')),
    status              TEXT NOT NULL CHECK (status IN ('pending', 'sent', 'failed', 'suppressed')),
    attempted_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    failure_reason      TEXT
);
CREATE INDEX idx_delivery_attempt_notification ON notifications.notification_delivery_attempt(notification_id);

-- =============================================================
-- schema: moderation
-- =============================================================
CREATE SCHEMA IF NOT EXISTS moderation;

CREATE TABLE moderation.report (
    id                  CHAR(26) PRIMARY KEY,
    reporter_user_id    CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    subject_type        TEXT NOT NULL CHECK (subject_type IN ('place', 'review', 'media', 'contribution', 'user')),
    subject_id          CHAR(26) NOT NULL,
    reason              TEXT NOT NULL,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE moderation.moderation_case (
    id                  CHAR(26) PRIMARY KEY,
    subject_type        TEXT NOT NULL CHECK (subject_type IN ('place', 'review', 'media', 'contribution', 'user')),
    subject_id          CHAR(26) NOT NULL,
    status              TEXT NOT NULL DEFAULT 'open' CHECK (status IN ('open', 'closed')),
    assigned_moderator_id CHAR(26) REFERENCES identity.user_account(id),
    decision            TEXT CHECK (decision IN ('approve', 'reject', 'escalate', 'request_more_info')),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    closed_at           TIMESTAMPTZ
);
CREATE INDEX idx_moderation_case_subject ON moderation.moderation_case(subject_type, subject_id);
CREATE INDEX idx_moderation_case_open ON moderation.moderation_case(id) WHERE status = 'open';

CREATE TABLE moderation.admin_action (
    id                  CHAR(26) PRIMARY KEY,
    actor_user_id       CHAR(26) NOT NULL REFERENCES identity.user_account(id),
    action_type         TEXT NOT NULL,
    target_type         TEXT NOT NULL,
    target_id           TEXT NOT NULL,
    reason              TEXT,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- audit_record is append-only: no UPDATE/DELETE grants issued to any
-- application role on this table (grants are an operational/deployment
-- concern, enforced outside this DDL file, per
-- docs/architecture/16-notifications-moderation-admin-architecture.md).
CREATE TABLE moderation.audit_record (
    id                  CHAR(26) PRIMARY KEY,
    actor_user_id       CHAR(26) REFERENCES identity.user_account(id),
    actor_type          TEXT NOT NULL CHECK (actor_type IN ('user', 'service', 'system')),
    action               TEXT NOT NULL,
    subject_type        TEXT NOT NULL,
    subject_id          TEXT NOT NULL,
    before_state         JSONB,
    after_state          JSONB,
    correlation_id       CHAR(26),
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_audit_record_subject ON moderation.audit_record(subject_type, subject_id);
CREATE INDEX idx_audit_record_created ON moderation.audit_record(created_at);
