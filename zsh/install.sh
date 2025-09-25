#!/bin/sh
#
# Oh My ZSH
#
# Installs Oh My ZSH for better shell experience

# Check if Oh My ZSH directory exists
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "  Installing Oh My ZSH for you."
  # Use unattended installation to avoid interactive prompts
  RUNZSH=no CHSH=no /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  
  # Install useful Oh My ZSH plugins
  echo "  Installing Oh My ZSH plugins..."
  
  # zsh-autosuggestions
  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi
  
  # zsh-syntax-highlighting
  if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi
  
  echo "  Oh My ZSH and plugins installed successfully!"
else
  echo "  Oh My ZSH already installed."
fi

