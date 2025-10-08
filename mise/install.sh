#!/bin/sh
#
# Mise
#
# Installs Mise for you

if test ! $(which mise)
then
  echo "  Installing Mise for you."
  curl https://mise.run | sh
  echo "  Mise installed successfully!"
else
  echo "  Mise is already installed."
fi

exit 0