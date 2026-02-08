#!/bin/sh
#
# Python Development Setup
#
# Installs Python LSPs and dev tools via uv
# Prerequisites: Python runtime and uv (managed by mise)

set -e

if ! command -v uv >/dev/null 2>&1; then
  echo "  ⚠ uv not found. Install via mise first."
  exit 1
fi

echo "› Installing Python language servers and tools..."

# Pyright - TypeScript/Python LSP
echo "  Installing pyright..."
uv tool install pyright

# Ruff - Python linter/formatter (owned by ruff topic but can be upgraded here)
# This ensures you have the LSP version even if ruff topic install was skipped
if ! command -v ruff >/dev/null 2>&1; then
  echo "  Installing ruff..."
  uv tool install ruff
fi

echo "✓ Python LSPs installed!"
