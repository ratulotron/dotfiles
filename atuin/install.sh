#!/bin/sh
#
# Atuin
#
# Installs Atuin for better search history and sets up themes

if test ! $(which atuin)
then
  echo "  Installing Atuin for you."
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  echo "  Atuin installed successfully!"
else
  echo "  Atuin already installed."
fi

# Note: Config directory and themes are now handled automatically by script/link

exit 0
