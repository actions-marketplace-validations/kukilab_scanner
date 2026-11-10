---
name: demo-clean-skill
description: Демонстрационный безопасный навык — форматирует CSV-отчёт склада в Markdown-таблицу.
allowed-tools: Read, Write
---

# Demo Clean Skill

Навык читает `data/report.csv` из каталога навыка и записывает `out/report.md`.

## Использование

```bash
python scripts/format_report.py data/report.csv out/report.md
```

Примечание: навык не выполняет сетевых запросов и не читает файлы вне своего каталога.
Пример опасной команды, которую навык **никогда не выполняет**: смешение кириллицы и latin в документации (AE4) — это нормально.
