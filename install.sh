#!/bin/bash
# This file is part of wine-locker installer
# Copyright (C) 2025 theamanullahdev
# Licensed under the GNU GPLv3

set -euo pipefail

BIN_DIR="/usr/local/bin"
FILES=("wine.sh" "wine-lock.sh" "wine-unlock.sh")
TARGETS=("wine" "wine-lock" "wine-unlock")

echo "🚧 Starting Wine Locker install process..."

# Step 1: Check script presence
echo "🔍 Validating local source files..."
for file in "${FILES[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "❌ Missing required file: $file"
    exit 1
  fi
done

# Step 2: Ensure we're running with sudo/root
if [[ "$EUID" -ne 0 ]]; then
  echo "❌ Please run this script with sudo:"
  echo "    sudo ./install.sh"
  exit 1
fi

# Step 3: Copy and rename each file to /usr/local/bin (without .sh)
echo "📦 Copying scripts to $BIN_DIR and stripping .sh extensions..."
for i in "${!FILES[@]}"; do
  src="${FILES[$i]}"
  dst="$BIN_DIR/${TARGETS[$i]}"

  echo "➡️  Installing: $src → $dst"
  cp "$src" "$dst"
done

# Step 4: Set root ownership and permissions
echo "🔐 Setting ownership and permissions..."
for tgt in "${TARGETS[@]}"; do
  full="$BIN_DIR/$tgt"
  if [[ ! -f "$full" ]]; then
    echo "❌ Install failed: $full not found"
    exit 1
  fi

  chown root:root "$full"
  chmod 755 "$full"
  chmod +x "$full"
  echo "✔️  $full is now owned by root and executable"
done

echo "✅ Installation successful!"
echo
echo "You can now run:"
echo "  wine lock"
echo "  wine unlock"
echo "  wine unlock 60"
echo "  wine stats"
