#!/bin/sh
#
# Oh My ZSH
#
# Installs Oh My ZSH for better shell experience


# Check if Oh My ZSH directory exists
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  Installing Oh My ZSH for you."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

