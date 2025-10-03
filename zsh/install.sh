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
  echo "  Oh My ZSH installed successfully!"
else
  echo "  Oh My ZSH already installed."
fi

# Install useful Oh My ZSH plugins (check separately from Oh My ZSH installation)
echo "  Installing Oh My ZSH plugins..."

# zsh-autosuggestions
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  echo "  Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  echo "  zsh-autosuggestions installed!"
else
  echo "  zsh-autosuggestions already installed."
fi

# zsh-syntax-highlighting
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  echo "  Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  echo "  zsh-syntax-highlighting installed!"
else
  echo "  zsh-syntax-highlighting already installed."
fi

echo "  Oh My ZSH plugins check complete!"

