#!/bin/sh
#
# Atuin
#
# Installs Atuin for better search history

# Check for Homebrew
if test ! $(which atuin)
then
  curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
fi

exit 0
