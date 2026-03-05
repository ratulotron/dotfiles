#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

# Check for Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "  Installing Homebrew for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "  Homebrew installed successfully!"
else
  echo "  Homebrew already installed."
fi

# Install cross-platform packages
if [ -f "$DOTFILES/Brewfile" ]; then
  echo "  Installing Homebrew packages..."
  brew bundle --file="$DOTFILES/Brewfile"
fi

# Install macOS casks (only on macOS)
if [ "$(uname)" = "Darwin" ] && [ -f "$DOTFILES/Mac.Brewfile" ]; then
  echo "  Installing macOS casks..."
  brew bundle --file="$DOTFILES/Mac.Brewfile"
fi

exit 0
