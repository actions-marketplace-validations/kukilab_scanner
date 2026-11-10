# KukiLab Scanner - One-Click Setup Script (Windows PowerShell)
$ErrorActionPreference = "Stop"
Write-Host "=== 🛡️ KukiLab Scanner: One-Click Setup (Windows) ===" -ForegroundColor Cyan
$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) { Write-Host "❌ Python is not installed or not found in PATH." -ForegroundColor Red; exit 1 }
$pyVersion = & python --version
Write-Host "--> Found Python: $pyVersion" -ForegroundColor Green
if (-not (Test-Path -Path "venv")) { Write-Host "--> Creating virtual environment in .\venv ..." -ForegroundColor Yellow; python -m venv venv } else { Write-Host "--> Virtual environment .\venv already exists." -ForegroundColor Green }
Write-Host "--> Activating virtual environment..." -ForegroundColor Yellow
& .\venv\Scripts\Activate.ps1
Write-Host "--> Installing dependencies (pyyaml, requests)..." -ForegroundColor Yellow
pip install --upgrade pip --quiet
pip install -r requirements.txt --quiet
Write-Host ""; Write-Host "=== ✅ Setup Completed Successfully! ===" -ForegroundColor Green; Write-Host ""
Write-Host "To activate the environment in PowerShell, run:" -ForegroundColor Cyan; Write-Host "    .\venv\Scripts\Activate.ps1" -ForegroundColor White; Write-Host ""
Write-Host "To run the scanner:" -ForegroundColor Cyan; Write-Host "    python src/kukilab_scanner.py \path\to\target-skill" -ForegroundColor White
Write-Host "To run with auto-fix:" -ForegroundColor Cyan; Write-Host "    python src/kukilab_scanner.py \path\to\target-skill --fix" -ForegroundColor White; Write-Host ""
