#!/usr/bin/env python3
"""Rename system metadata objects to Russian via Twenty's /metadata GraphQL.

Standard objects (workflowRun, message, attachment, ...) ship with English
labels in Twenty 2.6.1. Only opportunity/company/note/person/task/workflow/
dashboard have standardOverrides for ru. We add labels for the rest.

Usage:
  TWENTY_BASE_URL=https://crm.center-guarantee.ru \
  TWENTY_API_KEY=eyJ... \
  python3 patch-system-objects.py
"""
import json
import os
import ssl
import sys
import urllib.request

TOKEN = os.environ.get("TWENTY_API_KEY")
BASE = os.environ.get("TWENTY_BASE_URL", "https://crm.center-guarantee.ru")
if not TOKEN:
    sys.exit("TWENTY_API_KEY env var required")

URL_METADATA = f"{BASE}/metadata"
URL_REST_OBJECTS = f"{BASE}/rest/metadata/objects"

CTX = ssl.create_default_context()
CTX.check_hostname = False
CTX.verify_mode = ssl.CERT_NONE

RENAMES = {
    "workflowVersion":          ("Версия автоматизации",    "Версии автоматизаций"),
    "workflowAutomatedTrigger": ("Триггер автоматизации",   "Триггеры автоматизаций"),
    "workflowRun":              ("Запуск автоматизации",    "Запуски автоматизаций"),
    "calendarEvent":            ("Событие календаря",       "События календарей"),
    "calendarEventParticipant": ("Участник события",        "Участники событий"),
    "calendarChannel":          ("Канал календаря",         "Каналы календарей"),
    "message":                  ("Сообщение",               "Сообщения"),
    "messageThread":            ("Цепочка сообщений",       "Цепочки сообщений"),
    "messageFolder":            ("Папка сообщений",         "Папки сообщений"),
    "messageChannel":           ("Канал сообщений",         "Каналы сообщений"),
    "messageParticipant":       ("Участник сообщения",      "Участники сообщений"),
    "attachment":               ("Вложение",                "Вложения"),
    "connectedAccount":         ("Подключённый аккаунт",    "Подключённые аккаунты"),
    "workspaceMember":          ("Участник рабочей области", "Участники рабочей области"),
    "blocklist":                ("Чёрный список",           "Чёрные списки"),
    "timelineActivity":         ("Событие журнала",         "События журнала"),
}

MUTATION = (
    "mutation($input:UpdateOneObjectInput!){"
    "updateOneObject(input:$input){id labelSingular labelPlural}}"
)


def post(url, body):
    req = urllib.request.Request(
        url,
        data=json.dumps(body).encode(),
        headers={
            "Authorization": f"Bearer {TOKEN}",
            "Content-Type": "application/json",
        },
    )
    with urllib.request.urlopen(req, context=CTX, timeout=30) as r:
        return json.loads(r.read())


def get(url):
    req = urllib.request.Request(
        url, headers={"Authorization": f"Bearer {TOKEN}"}
    )
    with urllib.request.urlopen(req, context=CTX, timeout=30) as r:
        return json.loads(r.read())


def main():
    objs = get(URL_REST_OBJECTS)
    objs = objs if isinstance(objs, list) else objs.get("data", [])
    patched = 0
    for o in objs:
        n = o["nameSingular"]
        if n not in RENAMES:
            continue
        s, p = RENAMES[n]
        res = post(
            URL_METADATA,
            {
                "query": MUTATION,
                "variables": {
                    "input": {"id": o["id"], "update": {"labelSingular": s, "labelPlural": p}}
                },
            },
        )
        if "errors" in res:
            print(f"  ERROR {n}: {res['errors']}", file=sys.stderr)
        else:
            print(f"  OK {n}: {s} / {p}")
            patched += 1
    print(f"\nPatched: {patched}")


if __name__ == "__main__":
    main()
