# Интеграция SARIF в KukiLab Scanner

Модуль выгрузки отчетов в формате **SARIF 2.1.0** позволяет интегрировать **KukiLab Scanner** с панелями безопасности **GitHub Security (Code Scanning Alerts)**.

## 1. Скрипт экспортёра SARIF (sarif_exporter.py)

Модуль формирует JSON-структуру SARIF 2.1.0 для передачи результатов санитизации и проверки в GitHub Security.

## 2. GitHub Actions Workflow

Использование действия github/codeql-action/upload-sarif@v3 обеспечивает автоматическое отображение предупреждений в интерфейсе GitHub.

## 3. Преимущества SARIF

* Отображение аномалий во вкладке Security -> Code Scanning.
* Автоматическая блокировка PR при наличии критических замечаний.
* Отслеживание статуса исправлений.
