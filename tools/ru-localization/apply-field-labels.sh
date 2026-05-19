#!/usr/bin/env bash
# Russian labels for standard timestamp fields across all objects.
# Twenty API forbids modifying system fields, so we patch DB directly.
# Run on the Twenty server host (with access to twenty-db-1 container).

set -euo pipefail

docker exec -i twenty-db-1 psql -U postgres -d default <<'SQL'
BEGIN;

UPDATE core."fieldMetadata"
  SET label = 'Дата создания',
      description = 'Дата создания записи'
  WHERE name = 'createdAt';

UPDATE core."fieldMetadata"
  SET label = 'Последнее изменение',
      description = 'Дата последнего изменения'
  WHERE name = 'updatedAt';

UPDATE core."fieldMetadata"
  SET label = 'Кем создано',
      description = 'Кто создал запись'
  WHERE name = 'createdBy' AND label = 'Created by';

UPDATE core."fieldMetadata"
  SET label = 'Запущено',
      description = 'Кто запустил выполнение'
  WHERE name = 'createdBy' AND label = 'Executed by';

UPDATE core."fieldMetadata"
  SET label = 'Кем изменено',
      description = 'Кто последний изменил запись'
  WHERE name = 'updatedBy';

UPDATE core."fieldMetadata"
  SET label = 'Дата удаления',
      description = 'Когда запись удалена'
  WHERE name = 'deletedAt';

COMMIT;

SELECT name, label, COUNT(*) AS cnt
  FROM core."fieldMetadata"
  WHERE name IN ('createdAt','updatedAt','createdBy','updatedBy','deletedAt')
  GROUP BY name, label
  ORDER BY name, label;
SQL
