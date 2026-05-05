#!/bin/sh
#
# Mise
#
# Installs Mise and ensures the configured toolchain is present

set -e

export PATH="$HOME/.local/share/mise/bin:$HOME/.local/bin:$PATH"

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
REPO_MISE_CONFIG="$DOTFILES/mise/.config/mise/config.toml"

if [ -z "${MISE_GLOBAL_CONFIG_FILE:-}" ] && [ -f "$REPO_MISE_CONFIG" ]; then
  export MISE_GLOBAL_CONFIG_FILE="$REPO_MISE_CONFIG"
fi

if ! command -v mise >/dev/null 2>&1; then
  echo "  Installing Mise for you."
  curl https://mise.run | sh
  echo "  Mise installed successfully!"
else
  echo "  Mise is already installed."
fi

if command -v mise >/dev/null 2>&1; then
  echo "  Installing Mise toolchain..."
  mise install
else
  echo "  Mise could not be found on PATH after installation." >&2
  exit 1
fi

exit 0
