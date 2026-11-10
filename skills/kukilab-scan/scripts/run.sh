#!/usr/bin/env bash
# KukiLab Scan — запуск движка по закреплённой версии.
# Движок не хранится в навыке: он клонируется из github.com/kukilab/scanner (тег $KUKILAB_VERSION, по умолчанию v1)
# в .kukilab/engine рядом с проверяемым проектом и переиспользуется при следующих запусках.
set -euo pipefail
TAG="${KUKILAB_VERSION:-v1}"
ENGINE_DIR="${KUKILAB_ENGINE_DIR:-$PWD/.kukilab/engine}"
if [ ! -f "$ENGINE_DIR/src/kukilab_scanner.py" ]; then
  mkdir -p "$(dirname "$ENGINE_DIR")"
  git clone --quiet --depth 1 --branch "$TAG" https://github.com/kukilab/scanner.git "$ENGINE_DIR"
fi
exec python3 "$ENGINE_DIR/src/kukilab_scanner.py" "$@"
