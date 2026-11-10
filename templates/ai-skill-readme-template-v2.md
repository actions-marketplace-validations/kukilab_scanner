# Шаблон README.md с динамическим бейджем безопасности KukiLab Scanner (v2)

Настоящее руководство и практический шаблон предназначены для авторов и разработчиков AI-навыков (AI Agent Skills), создающих расширения и инструкции для экосистем Claude Code, Cursor, AutoGPT и других агентов.

В версию **v2** добавлена инструкция по автоматической генерации и обновлению **динамического бейджа безопасности (Dynamic Security Badge)** через GitHub Actions. Бейдж автоматически переключает статус в README.md при каждом успешном или неудачном билде CI/CD пайплайна.

---

## 1. Варианты динамических бейджей безопасности для README.md

Вы можете использовать автоматический статус из вашего GitHub Actions workflow или интеграцию с динамическим эндпоинтом Shields.io.

### Вариант A: Автоматический бейдж статуса GitHub Actions (Рекомендуемый)

Данный бейдж отображает реальный результат последнего прогона проверки `kukilab-scan.yml` в вашей основной ветке (`main` или `master`).

#### Markdown-разметка:

```markdown
[![KukiLab Scanner Status](https://img.shields.io/github.com/actions/workflow/status/YOUR_USERNAME/YOUR_REPO/kukilab-scan.yml?branch=main&label=KukiLab%20Scanner&logo=github&style=flat-square)](https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/kukilab-scan.yml)
[![Unicode Sanitized](https://img.shields.io/badge/Unicode%20Sanitizer-PASSED-brightgreen?style=flat-square)](./SKILL.md)
[![Allowed Tools](https://img.shields.io/badge/Allowed%20Tools-VERIFIED-blue?style=flat-square)](./SKILL.md)
```

#### HTML-разметка с выравниванием по центру:

```html
<p align="center">
  <a href="https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/kukilab-scan.yml">
    <img src="https://img.shields.io/github.com/actions/workflow/status/YOUR_USERNAME/YOUR_REPO/kukilab-scan.yml?branch=main&label=KukiLab%20Scanner&logo=github&style=flat-square" alt="KukiLab Scanner Status">
  </a>
  <a href="./SKILL.md">
    <img src="https://img.shields.io/badge/Unicode%20Sanitizer-PASSED-brightgreen?style=flat-square" alt="Unicode Status">
  </a>
  <a href="./SKILL.md">
    <img src="https://img.shields.io/badge/Allowed%20Tools-VERIFIED-blue?style=flat-square" alt="Tool Scope">
  </a>
</p>
```

---

## 2. Настройка автоматической выдачи динамического бейджа в GitHub Actions

Чтобы бейдж динамически отражал вердикт сканера (`SAFE`, `CAUTION`, `BLOCK`), настройте обновление статуса в вашем workflow `.github/workflows/kukilab-scan.yml`:

### Шаг 1: Добавьте шаг формирования динамического JSON-эндпоинта

В рабочий процесс сканирования добавьте шаг, сохраняющий статус проверки:

```yaml
      - name: Update Dynamic Badge Status
        if: always()
        run: |
          VERDICT="${{ env.SCAN_VERDICT }}"
          if [ "$VERDICT" = "SAFE" ]; then
            COLOR="brightgreen"
            MESSAGE="SAFE (Passed)"
          elif [ "$VERDICT" = "CAUTION" ]; then
            COLOR="yellow"
            MESSAGE="CAUTION (Warnings)"
          else
            COLOR="red"
            MESSAGE="BLOCKED"
          fi

          echo "=== Badge Status ==="
          echo "Label: KukiLab Scanner"
          echo "Status: $MESSAGE"
          echo "Color: $COLOR"
```

### Шаг 2: Использование эндпоинта Shields.io (Shields JSON Endpoint)

Вы можете опубликовать JSON-файл статуса в Gist или на вашем сервере и запрашивать его через URL:
`https://img.shields.io/endpoint?url=https://YOUR_SERVER_OR_GIST/badge.json`

Формат `badge.json`:
```json
{
  "schemaVersion": 1,
  "label": "KukiLab Scanner",
  "message": "SAFE",
  "color": "brightgreen"
}
```

---

## 3. Готовый шаблон файла README.md для вашего AI-навыка

Скопируйте приведенную ниже структуру в корень вашего репозитория и замените `YOUR_USERNAME` и `YOUR_REPO` на реальные значения:

```markdown
# [Название вашего AI-навыка]

<p align="center">
  <a href="https://github.com/YOUR_USERNAME/YOUR_REPO/actions/workflows/kukilab-scan.yml">
    <img src="https://img.shields.io/github.com/actions/workflow/status/YOUR_USERNAME/YOUR_REPO/kukilab-scan.yml?branch=main&label=KukiLab%20Scanner&logo=github&style=flat-square" alt="Security Status">
  </a>
  <a href="./SKILL.md">
    <img src="https://img.shields.io/badge/Unicode%20Sanitizer-PASSED-brightgreen?style=flat-square" alt="Unicode Sanitizer">
  </a>
</p>

Краткое описание назначения навыка (1–2 предложения), объясняющее, какие задачи он выполняет для AI-агента.

## 🛡️ Автоматическая верификация безопасности (CI/CD Verification)

Данный навык непрерывно проверяется в автоматическом пайплайне **KukiLab Scanner** при каждом коммите:

| Этап проверки | Динамический статус | Описание автоматической инспекции |
| :--- | :--- | :--- |
| **Санитизация Unicode (Step 0)** | ✅ AUTO-CLEANED | Автоматическое удаление невидимых zero-width символов и NFC-нормализация при каждой сборке. |
| **Статический код (Step 1)** | ✅ PASSED | Проверка кода без ложного шума по объему файлов и без ошибочной блокировки AE4 на кириллицу. |
| **Семантический LLM-пасс (Step 2)** | ✅ PASSED | Нейросетевая проверка прозы на промт-инъекции, скрытые команды и размытие прав. |
| **Объявление прав (LP3)** | ✅ VERIFIED | Проверка декларации явного списка разрешенных инструментов (allowed-tools). |

## 🛠️ Объявленный доступ к инструментам (allowed-tools)

Согласно принципу наименьших привилегий, навык запрашивает доступ строго к следующим системным инструментам:

- `file_read`: Чтение файлов справки и конфигурации из каталога навыка.
- `file_write`: Запись сгенерированных отчетов во временный каталог.

## 🚀 Быстрая установка

```bash
# Установка навыка в рабочую среду агента
npx skills add YOUR-USERNAME/YOUR-REPO --skill your-skill-name
```

## 🔍 Локальная проверка сканером перед установкой

Любой пользователь может локально запустить гибридную проверку данного репозитория перед его интеграцией:

```bash
python kukilab_scanner.py path-to-repo
```

## 📄 Лицензия

Проект распространяется под лицензией MIT. Подробности см. в файле [LICENSE](./LICENSE).
```

---

## 4. Требования к репозиторию для сохранения зеленого статуса бейджа

Чтобы бейдж автоматической проверки всегда отображал зеленый статус (`passing` / `SAFE`):

1. **Контроль Pull Request-ов**: Включите обязательное успешное прохождение workflow `kukilab-scan.yml` в настройках защиты ветки `main` (Branch Protection Rules).
2. **Отсутствие вредоносных текстов**: Не добавляйте в прозу манифеста инструкции, имитирующие переопределение роли агента (P-01).
3. **Заполнение `allowed-tools`**: При добавлении новых возможностей вызова скриптов сразу вносите соответствующие инструменты в секцию `allowed-tools` файла `SKILL.md`.
