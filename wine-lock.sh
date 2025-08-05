#!/bin/bash
# This file is part of wine-locker
# Copyright (C) 2025 theamanullahdev
# Licensed under the GNU GPLv3

WINE_PATHS=(
  "$(readlink -f /usr/bin/wine)"
  "$(readlink -f /usr/bin/wine64 2>/dev/null)"
)

echo "🔒 Locking Wine for non-root users..."

for path in "${WINE_PATHS[@]}"; do
  if [[ -f "$path" ]]; then
    chmod 700 "$path"
    echo "✔️ Locked: $path"
  else
    echo "⚠️ Not found: $path"
  fi
done

echo "✅ Wine is now LOCKED (only root can run it)"
