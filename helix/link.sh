mkdir -p ~/.config
echo "Creating symlink for ~/.dotfiles/helix -> ~/.config/helix"
rm -rf ~/.config/helix
ln -sf ~/.dotfiles/helix ~/.config/helix