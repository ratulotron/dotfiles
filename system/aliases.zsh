# eza aliases - consolidated from multiple files
if command -v eza &> /dev/null; then
  alias ls="eza --color=always"
  alias ll="eza -l --color=always"
  alias la="eza -la --color=always"
  alias l="eza -l --color=always"
  alias lt="eza --long --tree --level=3"
  alias lsd="eza -l --color=always --group-directories-first"
  alias lsa="eza -la --color=always --group-directories-first"
fi