#!/bin/sh
#
# Atuin
#
# Links Atuin configuration to ~/.config/

DIRNAME=atuin

SOURCE=~/.dotfiles/$DIRNAME
TARGET=~/.config/$DIRNAME

mkdir -p ~/.config
echo "Creating symlink for $SOURCE -> $TARGET"
rm -rf $TARGET
ln -sf $SOURCE $TARGET
