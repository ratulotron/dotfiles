# eza aliases

if command -v eza &> /dev/null; then
  alias ls="eza --grid --long"
  alias lt="eza --long --tree --level=3"
  alias l="ls"
  alias ll="eza --long"
  alias la='eza --long --all'
fi

# then
#   alias ls="eza --grid --long"
#   alias lt="eza --long --tree --level=3"
#   alias l="gls -lAh --color"
#   alias ll="gls -l --color"
#   alias la='gls -A --color'
# fi