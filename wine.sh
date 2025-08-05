#!/bin/bash
# This file is part of wine-locker
# Copyright (C) 2025 theamanullahdev
# Licensed under the GNU GPLv3

# Paths to internal scripts
LOCK_SCRIPT="/usr/local/bin/wine-lock"
UNLOCK_SCRIPT="/usr/local/bin/wine-unlock"

# Usage help
show_help() {
  echo "WINE ACCESS CONTROL SYSTEM 🍷🔐"
  echo "Usage: wine [lock|unlock [seconds]|stats]"
  echo
  echo "  lock               → Disable Wine for non-root users"
  echo "  unlock             → Enable Wine"
  echo "  unlock [seconds]   → Enable Wine for limited time"
  echo "  stats              → Show current lock status"
  echo
}

# Main logic
case "$1" in
  lock)
    "$LOCK_SCRIPT"
    ;;
  unlock)
    if [[ -n "$2" && "$2" =~ ^[0-9]+$ ]]; then
      "$UNLOCK_SCRIPT" "$2"
    else
      "$UNLOCK_SCRIPT"
    fi
    ;;
  stats)
    wine_bin="$(readlink -f /usr/bin/wine 2>/dev/null)"
    if [[ -z "$wine_bin" || ! -x "$wine_bin" ]]; then
      echo "Wine binary not found or not executable."
      exit 1
    fi
    perms=$(stat -c "%A" "$wine_bin")
    echo "Wine Binary: $wine_bin"
    echo "Permissions: $perms"

    if [[ "$perms" == "-rwx------" ]]; then
      echo "🔒 Status: LOCKED (only root can run Wine)"
    elif [[ "$perms" == "-rwxr-xr-x" ]]; then
      echo "🍻 Status: UNLOCKED (all users can run Wine)"
    else
      echo "⚠️ Status: UNKNOWN (non-standard permissions)"
    fi
    ;;
  *)
    show_help
    ;;
esac
