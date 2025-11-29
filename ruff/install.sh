#!/bin/sh
#
# Ruff
#
# Installs Ruff linter and sets up configuration and shell completions

if test ! $(which ruff)
then
  echo "  Installing Ruff for you."
  curl -LsSf https://astral.sh/ruff/install.sh | sh
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
