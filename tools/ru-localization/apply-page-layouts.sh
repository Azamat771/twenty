#!/usr/bin/env bash
# Russian labels for page-layout tabs and widgets.
# These are stored in core."pageLayoutTab"/core."pageLayoutWidget" as plain
# text and used as-is at render time, bypassing Lingui i18n. We patch DB.

set -euo pipefail

docker exec -i twenty-db-1 psql -U postgres -d default <<'SQL'
BEGIN;

-- pageLayoutTab
UPDATE core."pageLayoutTab" SET title = 'Главная'    WHERE title = 'Home';
UPDATE core."pageLayoutTab" SET title = 'Лента'      WHERE title = 'Timeline';
UPDATE core."pageLayoutTab" SET title = 'Задачи'     WHERE title = 'Tasks';
UPDATE core."pageLayoutTab" SET title = 'Заметки'    WHERE title = 'Notes';
UPDATE core."pageLayoutTab" SET title = 'Файлы'      WHERE title = 'Files';
UPDATE core."pageLayoutTab" SET title = 'Письма'     WHERE title = 'Emails';
UPDATE core."pageLayoutTab" SET title = 'Календарь'  WHERE title = 'Calendar';
UPDATE core."pageLayoutTab" SET title = 'Заметка'    WHERE title = 'Note';
UPDATE core."pageLayoutTab" SET title = 'Процесс'    WHERE title = 'Flow';
UPDATE core."pageLayoutTab" SET title = 'Вкладка 1'  WHERE title = 'Tab 1';

-- pageLayoutWidget — core
UPDATE core."pageLayoutWidget" SET title = 'Поля'         WHERE title = 'Fields';
UPDATE core."pageLayoutWidget" SET title = 'Календарь'    WHERE title = 'Calendar';
UPDATE core."pageLayoutWidget" SET title = 'Заметка'      WHERE title = 'Note';
UPDATE core."pageLayoutWidget" SET title = 'Заметки'      WHERE title = 'Notes';
UPDATE core."pageLayoutWidget" SET title = 'Задача'       WHERE title = 'Task';
UPDATE core."pageLayoutWidget" SET title = 'Задачи'       WHERE title = 'Tasks';
UPDATE core."pageLayoutWidget" SET title = 'Файлы'        WHERE title = 'Files';
UPDATE core."pageLayoutWidget" SET title = 'Письма'       WHERE title = 'Emails';
UPDATE core."pageLayoutWidget" SET title = 'Процесс'      WHERE title = 'Flow';
UPDATE core."pageLayoutWidget" SET title = 'Сделки'       WHERE title = 'Opportunities';
UPDATE core."pageLayoutWidget" SET title = 'Контакты'     WHERE title = 'People';
UPDATE core."pageLayoutWidget" SET title = 'Компания'     WHERE title = 'Company';
UPDATE core."pageLayoutWidget" SET title = 'Владелец'     WHERE title = 'Owner';
UPDATE core."pageLayoutWidget" SET title = 'Контактное лицо' WHERE title = 'Point of Contact';
UPDATE core."pageLayoutWidget" SET title = 'Цепочка'      WHERE title = 'Thread';
UPDATE core."pageLayoutWidget" SET title = 'Хронология'   WHERE title = 'Timeline';
UPDATE core."pageLayoutWidget" SET title = 'Без названия' WHERE title = 'Untitled Rich Text';
UPDATE core."pageLayoutWidget" SET title = 'Автоматизация' WHERE title = 'Workflow';

-- pageLayoutWidget — dashboards
UPDATE core."pageLayoutWidget" SET title = 'Сделки по компаниям'    WHERE title = 'Deals by Company';
UPDATE core."pageLayoutWidget" SET title = 'Сделки за месяц'        WHERE title = 'Deals created this month';
UPDATE core."pageLayoutWidget" SET title = 'Сумма сделок за месяц'  WHERE title = 'Deal value created this month';
UPDATE core."pageLayoutWidget" SET title = 'Сделки по владельцу'    WHERE title = 'Opportunities by Owner';
UPDATE core."pageLayoutWidget" SET title = 'Воронка по этапам'      WHERE title = 'Pipeline Value by Stage';
UPDATE core."pageLayoutWidget" SET title = 'Выручка по времени'     WHERE title = 'Revenue Timeline';
UPDATE core."pageLayoutWidget" SET title = 'Курсы валют'            WHERE title = 'Stock market (Iframe)';

COMMIT;
SQL
