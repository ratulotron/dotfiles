#!/bin/sh
#
# GhosTTY
#
# Links GhosTTY configuration to ~/.config/

DIRNAME=ghostty

SOURCE=~/.dotfiles/$DIRNAME
TARGET=~/.config/$DIRNAME

mkdir -p ~/.config
echo "Creating symlink for $SOURCE -> $TARGET"
rm -rf $TARGET
ln -sf $SOURCE $TARGET
