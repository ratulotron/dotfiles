#!/bin/sh
#
# Node.js Development Setup
#
# Installs JavaScript/TypeScript LSPs and dev tools via npm
# Prerequisites: Node.js and npm (managed by mise)

set -e

if ! command -v npm >/dev/null 2>&1; then
  echo "  ⚠ npm not found. Install Node.js via mise first."
  exit 1
fi

echo "› Installing JavaScript/TypeScript language servers..."

npm install -g \
    typescript \
    typescript-language-server \
    vscode-langservers-extracted \
    @vscode/emmet-helper \
    emmet-ls \
    @eslint/language-server \
    || true

echo "✓ JavaScript/TypeScript LSPs installed!"
