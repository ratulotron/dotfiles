#!/bin/sh
#
# Starship
#
# Installs Starship prompt

if test ! $(which starship)
then
  echo "  Installing Starship for you."
  curl -sS https://starship.rs/install.sh | sh
  echo "  Starship installed successfully!"
else
  echo "  Starship already installed."
fi

exit 0