#!/bin/bash
# This file is part of wine-locker
# Copyright (C) 2025 theamanullahdev
# Licensed under the GNU GPLv3

WINE_PATHS=(
  "$(readlink -f /usr/bin/wine)"
  "$(readlink -f /usr/bin/wine64 2>/dev/null)"
)

unlock_wine() {
  echo "🍻 Unlocking Wine for all users..."
  for path in "${WINE_PATHS[@]}"; do
    if [[ -f "$path" ]]; then
      sudo chmod 755 "$path"
      echo "✔️ Unlocked: $path"
    else
      echo "⚠️ Not found: $path"
    fi
  done
  echo "✅ Wine is now UNLOCKED (anyone can run it)"
}

lock_after_delay() {
  delay="$1"
  if [[ "$delay" =~ ^[0-9]+$ ]]; then
    echo "⏳ Will auto-lock in $delay seconds..."
    sleep "$delay"
    echo "⏱️  Time's up! Re-locking Wine..."
    exec "$(dirname "$0")/wine-lock.sh"
  else
    echo "❌ Invalid delay: '$delay'"
    exit 1
  fi
}

# Main flow
if [[ -n "$1" ]]; then
  unlock_wine
  lock_after_delay "$1"
else
  unlock_wine
fi
