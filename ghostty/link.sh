mkdir -p ~/.config
echo "Creating symlink for ~/.dotfiles/ghostty -> ~/.config/ghostty"
rm -rf ~/.config/ghostty
ln -sf ~/.dotfiles/ghostty ~/.config/ghostty