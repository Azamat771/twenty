# Russian localization scripts (для production workspace)

При создании нового prod-workspace в Twenty эти скрипты накатывают русские
labels на metadata, поля, page-layout, views, и удаляют demo data.

**ВАЖНО:** скрипты привязаны к конкретному `workspaceId`. Перед использованием
заменить UUID на новый из вашего workspace (`SELECT id FROM core.workspace`).

## Порядок применения

1. **БД-патч системных полей** (тribute labels — `Дата создания`, `Кем создано`, etc):
   ```bash
   bash apply-field-labels.sh
   ```

2. **БД-патч page-layout (табы + виджеты карточки):**
   ```bash
   bash apply-page-layouts.sh
   ```

3. **БД-патч view names:**
   ```bash
   WORKSPACE_ID=<new-workspace-uuid> bash apply-views.sh
   ```

4. **GraphQL-патч системных объектов (workflowRun, message, etc):**
   ```bash
   TWENTY_API_KEY=<workspace-api-key> python3 patch-system-objects.py
   ```

5. **(Опционально) Удалить Twenty demo-данные:**
   ```bash
   WORKSPACE_ID=<new-workspace-uuid> bash cleanup-demo-data.sh
   ```

## Источник

Использовалось при русификации test workspace 2026-05-19 (см. vault:
`Проекты/posrednik-bg-twenty/Русификация-2026-05-19.md`).
