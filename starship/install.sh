#!/bin/sh
#
# Starship
#
# Installs Starship prompt

if test ! $(which starship)
then
  curl -sS https://starship.rs/install.sh | sh
fi