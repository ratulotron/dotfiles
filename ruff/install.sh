#!/bin/sh
#
# Ruff
#
# Installs Ruff linter via uv and sets up shell completions
# Prerequisites: uv (managed by mise)

if ! command -v uv >/dev/null 2>&1; then
  echo "  ⚠ uv not found. Install via mise first."
  exit 1
fi

if ! command -v ruff >/dev/null 2>&1; then
  echo "  Installing Ruff via uv..."
  uv tool install ruff
  echo "  Ruff installed successfully!"
else
  echo "  Ruff already installed."
fi

# Install ZSH completion for ruff into the dotfiles repo (stowed to ~/.config/zsh/completions)
DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
COMPLETIONS_DIR="$DOTFILES/ruff/.config/zsh/completions"
if command -v ruff >/dev/null 2>&1; then
    echo "  Installing ruff ZSH completion..."
    mkdir -p "$COMPLETIONS_DIR"
    ruff generate-shell-completion zsh > "$COMPLETIONS_DIR/_ruff"
    echo "  ruff ZSH completion installed to $COMPLETIONS_DIR/_ruff"
else
    echo "  Ruff not found, skipping ZSH completion generation."
fi
