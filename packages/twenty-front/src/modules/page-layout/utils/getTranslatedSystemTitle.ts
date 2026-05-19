import { i18n } from '@lingui/core';
import { msg } from '@lingui/core/macro';

/**
 * System tab / widget titles used in default page-layout constants
 * (DefaultCompanyRecordPageLayout, DefaultPersonRecordPageLayout, etc.).
 *
 * These titles are stored as plain English strings inside seeded
 * page-layout records in the database, so they bypass the regular Lingui
 * extraction. This helper maps the well-known English keys to translatable
 * Lingui messages so that record-page UI honours the active user locale.
 *
 * User-renamed custom titles fall through unchanged.
 */
const SYSTEM_TITLE_MESSAGES = {
  Home: msg`Home`,
  Timeline: msg`Timeline`,
  Notes: msg`Notes`,
  Tasks: msg`Tasks`,
  Files: msg`Files`,
  Emails: msg`Emails`,
  Calendar: msg`Calendar`,
  Note: msg`Note`,
  Fields: msg`Fields`,
} as const;

type SystemTitleKey = keyof typeof SYSTEM_TITLE_MESSAGES;

const isSystemTitleKey = (value: string): value is SystemTitleKey =>
  Object.prototype.hasOwnProperty.call(SYSTEM_TITLE_MESSAGES, value);

export const getTranslatedSystemTitle = (title: string): string => {
  if (!isSystemTitleKey(title)) {
    return title;
  }
  return i18n._(SYSTEM_TITLE_MESSAGES[title]);
};
