#!/usr/bin/env bash
# Bulk Russian labels for ALL field metadata + commandMenuItem (~250 rows).
# Discovered during QA-pass 2026-05-19 — many entries appeared after initial
# patches (related objects on standard entities, secondary command menu items).

set -euo pipefail

docker exec -i twenty-db-1 psql -U postgres -d default <<'SQL'
BEGIN;

------------------------------------------------------------------------------
-- fieldMetadata.label — common field names across all objects
------------------------------------------------------------------------------
UPDATE core."fieldMetadata" SET label='Имя'              WHERE label='Name';
UPDATE core."fieldMetadata" SET label='Название'         WHERE label='Title';
UPDATE core."fieldMetadata" SET label='Содержимое'       WHERE label='Body';
UPDATE core."fieldMetadata" SET label='Тема'             WHERE label='Subject';
UPDATE core."fieldMetadata" SET label='Описание'         WHERE label='Description';
UPDATE core."fieldMetadata" SET label='Связи'            WHERE label='Relations';
UPDATE core."fieldMetadata" SET label='Текст'            WHERE label='Text';
UPDATE core."fieldMetadata" SET label='Тип'              WHERE label='Type';
UPDATE core."fieldMetadata" SET label='Статус'           WHERE label='Status';
UPDATE core."fieldMetadata" SET label='Статусы'          WHERE label='Statuses';
UPDATE core."fieldMetadata" SET label='Этап'             WHERE label='Stage';
UPDATE core."fieldMetadata" SET label='Состояние'        WHERE label='State';
UPDATE core."fieldMetadata" SET label='Настройки'        WHERE label='Settings';
UPDATE core."fieldMetadata" SET label='Видимость'        WHERE label='Visibility';
UPDATE core."fieldMetadata" SET label='Роль'             WHERE label='Role';
UPDATE core."fieldMetadata" SET label='Аватар'           WHERE label='Avatar';
UPDATE core."fieldMetadata" SET label='Файл аватара'     WHERE label='Avatar File';
UPDATE core."fieldMetadata" SET label='URL аватара'      WHERE label='Avatar Url';
UPDATE core."fieldMetadata" SET label='Файл'             WHERE label='File';
UPDATE core."fieldMetadata" SET label='Категория файла'  WHERE label='File category';
UPDATE core."fieldMetadata" SET label='Полный путь'      WHERE label='Full path';
UPDATE core."fieldMetadata" SET label='Заметки'          WHERE label='Notes';
UPDATE core."fieldMetadata" SET label='Заметка'          WHERE label='Note';
UPDATE core."fieldMetadata" SET label='Цели заметок'     WHERE label='Note Targets';
UPDATE core."fieldMetadata" SET label='Задачи'           WHERE label='Tasks';
UPDATE core."fieldMetadata" SET label='Задача'           WHERE label='Task';
UPDATE core."fieldMetadata" SET label='Цели задач'       WHERE label='Task Targets';
UPDATE core."fieldMetadata" SET label='Цель'             WHERE label='Target';
UPDATE core."fieldMetadata" SET label='Вложения'         WHERE label='Attachments';
UPDATE core."fieldMetadata" SET label='Сделки'           WHERE label='Opportunities';
UPDATE core."fieldMetadata" SET label='Курируемые сделки' WHERE label='Owned opportunities';
UPDATE core."fieldMetadata" SET label='Контакты'         WHERE label='People';
UPDATE core."fieldMetadata" SET label='Контакт'          WHERE label='Person';
UPDATE core."fieldMetadata" SET label='Компания'         WHERE label='Company';
UPDATE core."fieldMetadata" SET label='Владелец'         WHERE label='Owner';
UPDATE core."fieldMetadata" SET label='Контактное лицо'  WHERE label='Point of Contact';
UPDATE core."fieldMetadata" SET label='Автоматизация'    WHERE label='Workflow';
UPDATE core."fieldMetadata" SET label='Версия автоматизации' WHERE label='Workflow version';
UPDATE core."fieldMetadata" SET label='Версии'           WHERE label='Versions';
UPDATE core."fieldMetadata" SET label='Запуски'          WHERE label='Runs';
UPDATE core."fieldMetadata" SET label='Статус версии'    WHERE label='Version status';
UPDATE core."fieldMetadata" SET label='Шаги версии'      WHERE label='Version steps';
UPDATE core."fieldMetadata" SET label='Триггер версии'   WHERE label='Version trigger';
UPDATE core."fieldMetadata" SET label='Автотриггеры'     WHERE label='Automated Triggers';
UPDATE core."fieldMetadata" SET label='Тип автотриггера' WHERE label='Automated Trigger Type';
UPDATE core."fieldMetadata" SET label='Завершён'         WHERE label='Workflow run ended at';
UPDATE core."fieldMetadata" SET label='В очереди'        WHERE label='Workflow run enqueued at';
UPDATE core."fieldMetadata" SET label='Запущен'          WHERE label='Workflow run started at';
UPDATE core."fieldMetadata" SET label='Статус запуска'   WHERE label='Workflow run status';
UPDATE core."fieldMetadata" SET label='Назначенные задачи' WHERE label='Assigned tasks';
UPDATE core."fieldMetadata" SET label='Исполнитель'      WHERE label='Assignee';
UPDATE core."fieldMetadata" SET label='Участник'         WHERE label IN ('Workspace Member','WorkspaceMember');
UPDATE core."fieldMetadata" SET label='Подключённый аккаунт' WHERE label='Connected Account';
UPDATE core."fieldMetadata" SET label='Подключённые аккаунты' WHERE label='Connected accounts';
UPDATE core."fieldMetadata" SET label='Чёрный список'    WHERE label='Blocklist';
UPDATE core."fieldMetadata" SET label='Email пользователя' WHERE label='User Email';
UPDATE core."fieldMetadata" SET label='ID пользователя'  WHERE label='User Id';
UPDATE core."fieldMetadata" SET label='Отображаемое имя' WHERE label='Display Name';
UPDATE core."fieldMetadata" SET label='Должность'        WHERE label='Job Title';
UPDATE core."fieldMetadata" SET label='Город'            WHERE label='City';
UPDATE core."fieldMetadata" SET label='Адрес'            WHERE label='Address';
UPDATE core."fieldMetadata" SET label='Телефоны'         WHERE label='Phones';
UPDATE core."fieldMetadata" SET label='Электронные письма' WHERE label='Emails';
UPDATE core."fieldMetadata" SET label='Сотрудники'       WHERE label='Employees';
UPDATE core."fieldMetadata" SET label='LinkedIn'         WHERE label='Linkedin';
UPDATE core."fieldMetadata" SET label='Сумма'            WHERE label='Amount';
UPDATE core."fieldMetadata" SET label='Дата закрытия'    WHERE label='Close date';
UPDATE core."fieldMetadata" SET label='Владелец аккаунта' WHERE label='Account Owner';
UPDATE core."fieldMetadata" SET label='Банк-Агент'       WHERE label='BankAgent';
UPDATE core."fieldMetadata" SET label='Создано'          WHERE label='Creation DateTime';
UPDATE core."fieldMetadata" SET label='Обновлено'        WHERE label='Update DateTime';
UPDATE core."fieldMetadata" SET label='События журнала'  WHERE label='Timeline Activities';
UPDATE core."fieldMetadata" SET label='Идентификатор'    WHERE label IN ('Handle','handle');
UPDATE core."fieldMetadata" SET label='Альтернативные идентификаторы' WHERE label='Handle Aliases';
UPDATE core."fieldMetadata" SET label='Внешний ID'       WHERE label='External ID';
UPDATE core."fieldMetadata" SET label='Формат даты'      WHERE label='Date format';
UPDATE core."fieldMetadata" SET label='Формат времени'   WHERE label='Time format';
UPDATE core."fieldMetadata" SET label='Часовой пояс'     WHERE label='Time zone';
UPDATE core."fieldMetadata" SET label='День начала недели' WHERE label='Start of the week';
UPDATE core."fieldMetadata" SET label='Формат числа'     WHERE label='Number format';
UPDATE core."fieldMetadata" SET label='Язык'             WHERE label='Language';
UPDATE core."fieldMetadata" SET label='Цветовая схема'   WHERE label='Color Scheme';
UPDATE core."fieldMetadata" SET label='Доменное имя'     WHERE label='Domain Name';

------------------------------------------------------------------------------
-- commandMenuItem.label & shortLabel
------------------------------------------------------------------------------
UPDATE core."commandMenuItem" SET label='Активировать автоматизацию' WHERE label='Activate Workflow';
UPDATE core."commandMenuItem" SET label='Добавить узел'              WHERE label='Add a Node';
UPDATE core."commandMenuItem" SET label='Добавить в избранное'       WHERE label='Add to Favorites';
UPDATE core."commandMenuItem" SET label='Спросить ИИ'                WHERE label='Ask AI';
UPDATE core."commandMenuItem" SET label='Отменить правку'            WHERE label='Cancel Edition';
UPDATE core."commandMenuItem" SET label='Написать письмо'            WHERE label='Compose Email';
UPDATE core."commandMenuItem"
   SET label='Создать ${capitalize(objectMetadataItem.labelSingular)}'
   WHERE label='Create new ${capitalize(objectMetadataItem.labelSingular)}';
UPDATE core."commandMenuItem" SET label='Создать представление'      WHERE label='Create View';
UPDATE core."commandMenuItem" SET label='Деактивировать автоматизацию' WHERE label='Deactivate Workflow';
UPDATE core."commandMenuItem"
   SET label='Удалить ${capitalize(objectMetadataLabel)}'
   WHERE label='Delete ${capitalize(objectMetadataLabel)}';
UPDATE core."commandMenuItem" SET label='Отменить черновик'          WHERE label='Discard Draft';
UPDATE core."commandMenuItem" SET label='Дублировать дашборд'        WHERE label='Duplicate Dashboard';
UPDATE core."commandMenuItem" SET label='Дублировать автоматизацию'  WHERE label='Duplicate Workflow';
UPDATE core."commandMenuItem" SET label='Редактировать дашборд'      WHERE label='Edit Dashboard';
UPDATE core."commandMenuItem" SET label='Редактировать макет'        WHERE label='Edit Layout';
UPDATE core."commandMenuItem"
   SET label='Экспорт ${capitalize(objectMetadataLabel)}'
   WHERE label='Export ${capitalize(objectMetadataLabel)}';
UPDATE core."commandMenuItem" SET label='Экспорт в PDF'              WHERE label='Export to PDF';
UPDATE core."commandMenuItem" SET label='Экспорт представления'      WHERE label='Export View';
UPDATE core."commandMenuItem"
   SET label='Перейти к ${navigateToObjectMetadataItem.labelPlural}'
   WHERE label='Go to ${navigateToObjectMetadataItem.labelPlural}';
UPDATE core."commandMenuItem" SET label='Аккаунты — Настройки'       WHERE label='Go to Accounts Settings';
UPDATE core."commandMenuItem" SET label='Админ-панель — Настройки'   WHERE label='Go to Admin Panel Settings';
UPDATE core."commandMenuItem" SET label='ИИ — Настройки'             WHERE label='Go to AI Settings';
UPDATE core."commandMenuItem" SET label='API и вебхуки — Настройки'  WHERE label='Go to APIs & Webhooks Settings';
UPDATE core."commandMenuItem" SET label='Приложения — Настройки'     WHERE label='Go to Apps Settings';
UPDATE core."commandMenuItem" SET label='Оплата — Настройки'         WHERE label='Go to Billing Settings';
UPDATE core."commandMenuItem" SET label='Календари — Настройки'      WHERE label='Go to Calendars Settings';
UPDATE core."commandMenuItem" SET label='Модель данных — Настройки'  WHERE label='Go to Data Model Settings';
UPDATE core."commandMenuItem" SET label='Домены — Настройки'         WHERE label='Go to Domains Settings';
UPDATE core."commandMenuItem" SET label='Email — Настройки'          WHERE label='Go to Emails Settings';
UPDATE core."commandMenuItem" SET label='Опыт работы — Настройки'    WHERE label='Go to Experience Settings';
UPDATE core."commandMenuItem" SET label='Общие — Настройки'          WHERE label='Go to General Settings';
UPDATE core."commandMenuItem" SET label='Участники — Настройки'      WHERE label='Go to Members Settings';
UPDATE core."commandMenuItem" SET label='Роли — Настройки'           WHERE label='Go to Roles Settings';
UPDATE core."commandMenuItem" SET label='Безопасность — Настройки'   WHERE label='Go to Security Settings';
UPDATE core."commandMenuItem" SET label='Настройки'                  WHERE label='Go to Settings';
UPDATE core."commandMenuItem" SET label='Обновления — Настройки'     WHERE label='Go to Updates Settings';
UPDATE core."commandMenuItem"
   SET label='Скрыть удалённые ${capitalize(objectMetadataItem.labelPlural)}'
   WHERE label='Hide deleted ${capitalize(objectMetadataItem.labelPlural)}';
UPDATE core."commandMenuItem"
   SET label='Импорт ${capitalize(objectMetadataItem.labelPlural)}'
   WHERE label='Import ${capitalize(objectMetadataItem.labelPlural)}';
UPDATE core."commandMenuItem"
   SET label='Объединить ${capitalize(objectMetadataItem.labelPlural)}'
   WHERE label='Merge ${capitalize(objectMetadataItem.labelPlural)}';
UPDATE core."commandMenuItem"
   SET label='Следующий ${capitalize(objectMetadataItem.labelSingular)}'
   WHERE label='Navigate to next ${capitalize(objectMetadataItem.labelSingular)}';
UPDATE core."commandMenuItem"
   SET label='Предыдущий ${capitalize(objectMetadataItem.labelSingular)}'
   WHERE label='Navigate to previous ${capitalize(objectMetadataItem.labelSingular)}';
UPDATE core."commandMenuItem"
   SET label='Удалить навсегда ${capitalize(objectMetadataLabel)}'
   WHERE label='Permanently destroy ${capitalize(objectMetadataLabel)}';
UPDATE core."commandMenuItem" SET label='Быстрый лид'                WHERE label='Quick Lead';
UPDATE core."commandMenuItem" SET label='Убрать из избранного'       WHERE label='Remove from Favorites';
UPDATE core."commandMenuItem" SET label='Ответить'                   WHERE label='Reply';
UPDATE core."commandMenuItem"
   SET label='Восстановить ${capitalize(objectMetadataLabel)}'
   WHERE label='Restore ${capitalize(objectMetadataLabel)}';
UPDATE core."commandMenuItem" SET label='Сохранить дашборд'          WHERE label='Save Dashboard';
UPDATE core."commandMenuItem" SET label='Поиск'                      WHERE label='Search';
UPDATE core."commandMenuItem"
   SET label='Обновить ${capitalize(objectMetadataItem.labelPlural)}'
   WHERE label='Update ${capitalize(objectMetadataItem.labelPlural)}';
UPDATE core."commandMenuItem" SET label='Активная версия'            WHERE label='See Active Version';
UPDATE core."commandMenuItem" SET label='Запуски'                    WHERE label='See Runs';
UPDATE core."commandMenuItem" SET label='Версия'                     WHERE label='See Version';
UPDATE core."commandMenuItem" SET label='История версий'             WHERE label='See Versions History';
UPDATE core."commandMenuItem" SET label='Автоматизация'              WHERE label='See Workflow';
UPDATE core."commandMenuItem" SET label='Отправить письмо'           WHERE label='Send Email';
UPDATE core."commandMenuItem" SET label='Остановить'                 WHERE label='Stop';
UPDATE core."commandMenuItem" SET label='Привести автоматизацию в порядок' WHERE label='Tidy up Workflow';
UPDATE core."commandMenuItem" SET label='Использовать как черновик'  WHERE label='Use as Draft';
UPDATE core."commandMenuItem" SET label='Прошлые чаты с ИИ'          WHERE label='View Previous AI Chats';

-- commandMenuItem.shortLabel
UPDATE core."commandMenuItem" SET "shortLabel"='Аккаунты'       WHERE "shortLabel"='Accounts';
UPDATE core."commandMenuItem" SET "shortLabel"='Активировать'   WHERE "shortLabel"='Activate';
UPDATE core."commandMenuItem" SET "shortLabel"='Добавить узел'  WHERE "shortLabel"='Add a Node';
UPDATE core."commandMenuItem" SET "shortLabel"='Админ-панель'   WHERE "shortLabel"='Admin Panel';
UPDATE core."commandMenuItem" SET "shortLabel"='ИИ'             WHERE "shortLabel"='AI';
UPDATE core."commandMenuItem" SET "shortLabel"='API и вебхуки'  WHERE "shortLabel"='APIs & Webhooks';
UPDATE core."commandMenuItem" SET "shortLabel"='Приложения'     WHERE "shortLabel"='Apps';
UPDATE core."commandMenuItem" SET "shortLabel"='Спросить ИИ'    WHERE "shortLabel"='Ask AI';
UPDATE core."commandMenuItem" SET "shortLabel"='Оплата'         WHERE "shortLabel"='Billing';
UPDATE core."commandMenuItem" SET "shortLabel"='Календари'      WHERE "shortLabel"='Calendars';
UPDATE core."commandMenuItem" SET "shortLabel"='Отмена'         WHERE "shortLabel"='Cancel';
UPDATE core."commandMenuItem" SET "shortLabel"='Написать'       WHERE "shortLabel"='Compose';
UPDATE core."commandMenuItem" SET "shortLabel"='Создать представление' WHERE "shortLabel"='Create View';
UPDATE core."commandMenuItem" SET "shortLabel"='Модель данных'  WHERE "shortLabel"='Data Model';
UPDATE core."commandMenuItem" SET "shortLabel"='Деактивировать' WHERE "shortLabel"='Deactivate';
UPDATE core."commandMenuItem" SET "shortLabel"='Удалить'        WHERE "shortLabel"='Delete';
UPDATE core."commandMenuItem" SET "shortLabel"='Уничтожить'     WHERE "shortLabel"='Destroy';
UPDATE core."commandMenuItem" SET "shortLabel"='Отменить'       WHERE "shortLabel"='Discard Draft';
UPDATE core."commandMenuItem" SET "shortLabel"='Домены'         WHERE "shortLabel"='Domains';
UPDATE core."commandMenuItem" SET "shortLabel"='Дублировать'    WHERE "shortLabel"='Duplicate';
UPDATE core."commandMenuItem" SET "shortLabel"='Изменить'       WHERE "shortLabel"='Edit';
UPDATE core."commandMenuItem" SET "shortLabel"='Изменить макет' WHERE "shortLabel"='Edit Layout';
UPDATE core."commandMenuItem" SET "shortLabel"='Email'          WHERE "shortLabel"='Emails';
UPDATE core."commandMenuItem" SET "shortLabel"='Опыт работы'    WHERE "shortLabel"='Experience';
UPDATE core."commandMenuItem" SET "shortLabel"='Экспорт'        WHERE "shortLabel"='Export';
UPDATE core."commandMenuItem" SET "shortLabel"='Общие'          WHERE "shortLabel"='General';
UPDATE core."commandMenuItem" SET "shortLabel"='Скрыть удалённые' WHERE "shortLabel"='Hide deleted';
UPDATE core."commandMenuItem" SET "shortLabel"='Импорт'         WHERE "shortLabel"='Import';
UPDATE core."commandMenuItem" SET "shortLabel"='Объединить'     WHERE "shortLabel"='Merge';
UPDATE core."commandMenuItem" SET "shortLabel"='Назад'          WHERE "shortLabel"='Previous';
UPDATE core."commandMenuItem" SET "shortLabel"='Далее'          WHERE "shortLabel"='Next';
UPDATE core."commandMenuItem"
   SET "shortLabel"='Новый ${capitalize(objectMetadataItem.labelSingular)}'
   WHERE "shortLabel"='New ${capitalize(objectMetadataItem.labelSingular)}';
UPDATE core."commandMenuItem" SET "shortLabel"='Восстановить'   WHERE "shortLabel"='Restore';
UPDATE core."commandMenuItem" SET "shortLabel"='Сохранить'      WHERE "shortLabel"='Save';
UPDATE core."commandMenuItem" SET "shortLabel"='Поиск'          WHERE "shortLabel"='Search';
UPDATE core."commandMenuItem" SET "shortLabel"='Активная версия' WHERE "shortLabel"='See Active Version';
UPDATE core."commandMenuItem" SET "shortLabel"='Удалённые'      WHERE "shortLabel"='See deleted';
UPDATE core."commandMenuItem" SET "shortLabel"='Запуски'        WHERE "shortLabel"='See Runs';
UPDATE core."commandMenuItem" SET "shortLabel"='Версия'         WHERE "shortLabel"='See Version';
UPDATE core."commandMenuItem" SET "shortLabel"='Версии'         WHERE "shortLabel"='See Versions';
UPDATE core."commandMenuItem" SET "shortLabel"='История версий' WHERE "shortLabel"='See Versions History';
UPDATE core."commandMenuItem" SET "shortLabel"='Автоматизация'  WHERE "shortLabel"='See Workflow';
UPDATE core."commandMenuItem" SET "shortLabel"='Отправить'      WHERE "shortLabel" IN ('Send','Send Email');
UPDATE core."commandMenuItem" SET "shortLabel"='Настройки'      WHERE "shortLabel"='Settings';
UPDATE core."commandMenuItem" SET "shortLabel"='Безопасность'   WHERE "shortLabel"='Security';
UPDATE core."commandMenuItem" SET "shortLabel"='Участники'      WHERE "shortLabel"='Members';
UPDATE core."commandMenuItem" SET "shortLabel"='Роли'           WHERE "shortLabel"='Roles';
UPDATE core."commandMenuItem" SET "shortLabel"='Обновления'     WHERE "shortLabel"='Updates';
UPDATE core."commandMenuItem" SET "shortLabel"='Остановить'     WHERE "shortLabel"='Stop';
UPDATE core."commandMenuItem" SET "shortLabel"='Тест'           WHERE "shortLabel"='Test';
UPDATE core."commandMenuItem" SET "shortLabel"='Привести в порядок' WHERE "shortLabel" IN ('Tidy up','Tidy up Workflow');
UPDATE core."commandMenuItem" SET "shortLabel"='Обновить'       WHERE "shortLabel"='Update';
UPDATE core."commandMenuItem" SET "shortLabel"='Использовать как черновик' WHERE "shortLabel"='Use as Draft';
UPDATE core."commandMenuItem" SET "shortLabel"='Прошлые чаты'   WHERE "shortLabel" IN ('View Previous AI Chats','Previous AI Chats');
UPDATE core."commandMenuItem" SET "shortLabel"='Ответить'       WHERE "shortLabel"='Reply';
UPDATE core."commandMenuItem" SET "shortLabel"='Перейти'        WHERE "shortLabel"='Go to ${navigateToObjectMetadataItem.labelPlural}';
UPDATE core."commandMenuItem"
   SET "shortLabel"='Удалённые ${capitalize(objectMetadataItem.labelPlural)}'
   WHERE "shortLabel"='Deleted ${capitalize(objectMetadataItem.labelPlural)}';
UPDATE core."commandMenuItem" SET "shortLabel"='Быстрый лид'    WHERE "shortLabel"='Quick Lead';

COMMIT;
SQL
