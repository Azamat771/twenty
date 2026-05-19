#!/usr/bin/env bash
# Russian view names. Requires WORKSPACE_ID env var.
# View name "All {objectLabelPlural}" is a template — resolved at render time.

set -euo pipefail

: "${WORKSPACE_ID:?WORKSPACE_ID env var required}"

docker exec -i twenty-db-1 psql -U postgres -d default <<SQL
BEGIN;
UPDATE core.view SET name = 'Все {objectLabelPlural}'
  WHERE "workspaceId" = '${WORKSPACE_ID}' AND name = 'All {objectLabelPlural}';
UPDATE core.view SET name = 'Назначено мне'
  WHERE "workspaceId" = '${WORKSPACE_ID}' AND name = 'Assigned to Me';
UPDATE core.view SET name = 'По этапам'
  WHERE "workspaceId" = '${WORKSPACE_ID}' AND name = 'By Stage';
UPDATE core.view SET name = 'По статусу'
  WHERE "workspaceId" = '${WORKSPACE_ID}' AND name = 'By Status';
UPDATE core.view SET name = 'Запуски'
  WHERE "workspaceId" = '${WORKSPACE_ID}' AND name = 'Runs';
UPDATE core.view SET name = 'Версии'
  WHERE "workspaceId" = '${WORKSPACE_ID}' AND name = 'Versions';
COMMIT;
SQL
