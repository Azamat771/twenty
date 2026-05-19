#!/usr/bin/env bash
# Soft-delete Twenty's seeded demo data (sample opportunities, demo workflows).
# Workspace-specific — requires WORKSPACE_ID and matching schema name pattern.

set -euo pipefail

: "${WORKSPACE_ID:?WORKSPACE_ID env var required}"

# Twenty workspace schema name: workspace_<uuid-without-hyphens>
SCHEMA="workspace_${WORKSPACE_ID//-/}"

docker exec -i twenty-db-1 psql -U postgres -d default <<SQL
BEGIN;
UPDATE ${SCHEMA}."opportunity"
  SET "deletedAt" = NOW()
  WHERE name IN (
    'AI Model Training',
    'API Integration Deal',
    'Design Partnership',
    'Enterprise Plan Upgrade',
    'Platform Migration',
    'Workspace Expansion'
  ) AND "deletedAt" IS NULL;

UPDATE ${SCHEMA}."workflow"
  SET "deletedAt" = NOW()
  WHERE name IN ('Quick Lead', 'Create company when adding a new person')
    AND "deletedAt" IS NULL;
COMMIT;
SELECT 'opportunities_left', COUNT(*) FROM ${SCHEMA}."opportunity" WHERE "deletedAt" IS NULL;
SELECT 'workflows_left', COUNT(*) FROM ${SCHEMA}."workflow" WHERE "deletedAt" IS NULL;
SQL
