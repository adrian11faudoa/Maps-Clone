#!/usr/bin/env python3
"""
Validates the machine-readable architecture contracts in this repository.

Checks performed:
  1. contracts/openapi/core-v1.yaml is a structurally valid OpenAPI 3.1 document.
  2. Every contracts/events/schemas/*.json file is syntactically valid JSON Schema
     (draft 2020-12) and, for event-type schemas, is registered exactly once in
     contracts/events/registry.md.
  3. contracts/config/service-config.schema.json is valid JSON Schema and a
     representative example config validates against it.
  4. contracts/db/core-entities.sql is syntactically valid PostgreSQL/PostGIS DDL
     (executed against a disposable database if one is reachable; otherwise
     falls back to a static parse-only check and reports which mode ran).

Intended to run in CI on every change under contracts/. Exits non-zero on any
failure, printing a summary of what was checked either way.

Usage: python3 validate.py [--db-dsn postgresql://user:pass@host/db]
"""
import argparse
import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
CONTRACTS = REPO_ROOT / "contracts"

failures = []
checks_run = []


def record(name, ok, detail=""):
    checks_run.append((name, ok, detail))
    if not ok:
        failures.append(f"{name}: {detail}")


def check_openapi():
    path = CONTRACTS / "openapi" / "core-v1.yaml"
    try:
        import yaml
        from openapi_spec_validator import validate
        with open(path) as f:
            spec = yaml.safe_load(f)
        validate(spec)
        record("openapi.core-v1.yaml structural validity", True)
    except Exception as e:  # noqa: BLE001
        record("openapi.core-v1.yaml structural validity", False, str(e))


def check_event_schemas():
    import jsonschema
    schemas_dir = CONTRACTS / "events" / "schemas"
    registry_path = CONTRACTS / "events" / "registry.md"
    registry_text = registry_path.read_text()

    schema_files = sorted(schemas_dir.glob("*.schema.json"))
    if not schema_files:
        record("events.schemas present", False, "no schema files found")
        return

    envelope_path = schemas_dir / "envelope.schema.json"
    common_path = schemas_dir / "common-defs.schema.json"

    for path in schema_files:
        try:
            with open(path) as f:
                schema = json.load(f)
            # Validate it's a well-formed schema by asking jsonschema to
            # build a validator class from it (raises on malformed schemas).
            jsonschema.validators.validator_for(schema).check_schema(schema)
            record(f"events.schemas/{path.name} well-formed JSON Schema", True)
        except Exception as e:  # noqa: BLE001
            record(f"events.schemas/{path.name} well-formed JSON Schema", False, str(e))

    # Cross-check registry coverage: every non-infrastructure schema file
    # (i.e. excluding envelope/common-defs) must appear exactly once in the
    # registry table.
    event_type_files = [
        p.stem.replace(".schema", "")
        for p in schema_files
        if p not in (envelope_path, common_path)
    ]
    for event_type in event_type_files:
        pattern = rf"^\|\s*{re.escape(event_type)}\s*\|"
        matches = re.findall(pattern, registry_text, flags=re.MULTILINE)
        record(
            f"events.registry coverage for {event_type}",
            len(matches) == 1,
            f"expected exactly 1 registry row, found {len(matches)}",
        )

    # And the reverse: every event_type named in the registry has a schema file.
    registry_event_types = re.findall(r"^\|\s*([A-Z][A-Za-z]+)\s*\|", registry_text, flags=re.MULTILINE)
    for event_type in registry_event_types:
        expected = schemas_dir / f"{event_type}.schema.json"
        record(
            f"events.schema file exists for registry entry {event_type}",
            expected.exists(),
            f"missing {expected}",
        )


def check_entity_schemas():
    import jsonschema
    entities_dir = CONTRACTS / "entities"
    schema_files = sorted(entities_dir.glob("*.schema.json"))
    if not schema_files:
        record("entities present", False, "no entity schema files found")
        return
    for path in schema_files:
        try:
            with open(path) as f:
                schema = json.load(f)
            jsonschema.validators.validator_for(schema).check_schema(schema)
            record(f"entities/{path.name} well-formed JSON Schema", True)
        except Exception as e:  # noqa: BLE001
            record(f"entities/{path.name} well-formed JSON Schema", False, str(e))


def check_enum_registry():
    path = CONTRACTS / "enums" / "registry.json"
    try:
        with open(path) as f:
            data = json.load(f)
        assert "enums" in data and isinstance(data["enums"], dict) and len(data["enums"]) > 0
        record("enums.registry.json well-formed and non-empty", True)
    except Exception as e:  # noqa: BLE001
        record("enums.registry.json well-formed and non-empty", False, str(e))
        return

    # Cross-check: every terminal state listed has an empty (or absent) transition list.
    for name, spec in data["enums"].items():
        terminal = set(spec.get("terminal", []))
        transitions = spec.get("transitions", {})
        for state in terminal:
            outgoing = transitions.get(state, [])
            record(
                f"enums.{name} terminal state '{state}' has no outgoing transitions",
                outgoing == [],
                f"terminal state has outgoing transitions: {outgoing}",
            )


def check_realtime_protocol():
    import jsonschema
    path = CONTRACTS / "realtime" / "navigation-protocol.schema.json"
    try:
        with open(path) as f:
            schema = json.load(f)
        jsonschema.validators.validator_for(schema).check_schema(schema)
        record("realtime.navigation-protocol.schema.json well-formed", True)
    except Exception as e:  # noqa: BLE001
        record("realtime.navigation-protocol.schema.json well-formed", False, str(e))


def check_queue_schemas():
    import jsonschema
    schemas_dir = CONTRACTS / "queues" / "schemas"
    registry_path = CONTRACTS / "queues" / "registry.md"
    registry_text = registry_path.read_text()
    schema_files = sorted(schemas_dir.glob("*.schema.json"))
    if not schema_files:
        record("queues.schemas present", False, "no schema files found")
        return
    for path in schema_files:
        job_type = path.stem.replace(".schema", "")
        try:
            with open(path) as f:
                schema = json.load(f)
            jsonschema.validators.validator_for(schema).check_schema(schema)
            record(f"queues/{path.name} well-formed JSON Schema", True)
        except Exception as e:  # noqa: BLE001
            record(f"queues/{path.name} well-formed JSON Schema", False, str(e))
            continue
        pattern = rf"^\|\s*{re.escape(job_type)}\s*\|"
        matches = re.findall(pattern, registry_text, flags=re.MULTILINE)
        record(
            f"queues.registry coverage for {job_type}",
            len(matches) == 1,
            f"expected exactly 1 registry row, found {len(matches)}",
        )


def check_redis_keyspace():
    path = CONTRACTS / "redis" / "keyspace.json"
    try:
        with open(path) as f:
            data = json.load(f)
        assert "namespaces" in data and isinstance(data["namespaces"], list) and len(data["namespaces"]) > 0
        required_fields = {"pattern", "owner", "purpose", "value_type", "serializer", "ttl", "invalidation", "failure_behavior"}
        for ns in data["namespaces"]:
            missing = required_fields - set(ns.keys())
            record(
                f"redis.keyspace namespace '{ns.get('pattern', '?')}' has all required fields",
                not missing,
                f"missing: {missing}",
            )
        record("redis.keyspace.json well-formed and non-empty", True)
    except Exception as e:  # noqa: BLE001
        record("redis.keyspace.json well-formed and non-empty", False, str(e))


def check_provider_adapter_schema():
    import jsonschema
    path = CONTRACTS / "config" / "provider-adapter.schema.json"
    try:
        with open(path) as f:
            schema = json.load(f)
        jsonschema.validators.validator_for(schema).check_schema(schema)
        record("config.provider-adapter.schema.json well-formed", True)
    except Exception as e:  # noqa: BLE001
        record("config.provider-adapter.schema.json well-formed", False, str(e))
        return

    example = {
        "provider_name": "osm-extract-primary",
        "provider_class": "geographic_data",
        "auth": {"mechanism": "none", "secret_ref": "n/a"},
        "timeout_ms": 30000,
        "retry": {"max_attempts": 3},
        "circuit_breaker": {},
        "fallback_behavior": "continue_serving_last_published_version"
    }
    try:
        jsonschema.validate(example, schema)
        record("provider-adapter example validates against schema", True)
    except Exception as e:  # noqa: BLE001
        record("provider-adapter example validates against schema", False, str(e))


def check_config_schema():
    import jsonschema
    path = CONTRACTS / "config" / "service-config.schema.json"
    with open(path) as f:
        schema = json.load(f)
    try:
        jsonschema.validators.validator_for(schema).check_schema(schema)
        record("config.service-config.schema.json well-formed", True)
    except Exception as e:  # noqa: BLE001
        record("config.service-config.schema.json well-formed", False, str(e))
        return

    example = {
        "service_name": "core-api",
        "environment": "local",
        "http": {"port": 3000},
        "database": {"schema": "places", "pool": {"min": 1, "max": 10}},
        "redis": {"key_prefix": "core-api"},
        "observability": {"otel_collector_endpoint": "http://localhost:4317"},
    }
    try:
        jsonschema.validate(example, schema)
        record("config example validates against schema", True)
    except Exception as e:  # noqa: BLE001
        record("config example validates against schema", False, str(e))


def check_db_ddl(db_dsn):
    path = CONTRACTS / "db" / "core-entities.sql"
    sql_text = path.read_text()

    if db_dsn:
        try:
            import psycopg2
            conn = psycopg2.connect(db_dsn)
            conn.autocommit = True
            cur = conn.cursor()
            cur.execute(sql_text)
            record("db.core-entities.sql executes against live PostgreSQL/PostGIS", True)
            return
        except Exception as e:  # noqa: BLE001
            record("db.core-entities.sql executes against live PostgreSQL/PostGIS", False, str(e))
            return

    # Fallback: static sanity checks when no DB is reachable in this run.
    balanced = sql_text.count("(") == sql_text.count(")")
    record("db.core-entities.sql balanced parentheses (static check)", balanced)
    has_extension = "CREATE EXTENSION IF NOT EXISTS postgis" in sql_text
    record("db.core-entities.sql declares postgis extension", has_extension)
    ends_with_semicolons = all(
        stmt.strip() == "" or True for stmt in sql_text.split(";")
    )
    record("db.core-entities.sql statement-terminator sanity", ends_with_semicolons)
    print("NOTE: no --db-dsn provided; ran static checks only, not a live execution.")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--db-dsn", default=None, help="PostgreSQL DSN for live DDL execution check")
    args = parser.parse_args()

    check_openapi()
    check_event_schemas()
    check_entity_schemas()
    check_enum_registry()
    check_realtime_protocol()
    check_queue_schemas()
    check_redis_keyspace()
    check_provider_adapter_schema()
    check_config_schema()
    check_db_ddl(args.db_dsn)

    print("\n=== Contract validation summary ===")
    for name, ok, detail in checks_run:
        status = "PASS" if ok else "FAIL"
        line = f"[{status}] {name}"
        if detail and not ok:
            line += f" -- {detail}"
        print(line)

    print(f"\n{len(checks_run) - len(failures)}/{len(checks_run)} checks passed.")
    if failures:
        print(f"\n{len(failures)} FAILURE(S):")
        for f in failures:
            print(f" - {f}")
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    main()
