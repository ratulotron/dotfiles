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


# Install ZSH completion for ruff
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "  Installing ruff ZSH completion..."
    mkdir -p "$HOME/.oh-my-zsh/completions"
    ruff generate-shell-completion zsh > "$HOME/.oh-my-zsh/completions/_ruff"
    echo "  ruff ZSH completion installed!"
else
    echo "  Oh My ZSH not found, skipping ruff ZSH completion installation."
fi
