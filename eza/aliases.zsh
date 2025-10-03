# eza aliases - modern ls replacement
# Using more robust command detection
if (( $+commands[eza] )); then
  alias ls="eza --color=auto --icons"
  alias ll="eza -l --color=auto --icons --group-directories-first"
  alias la="eza -la --color=auto --icons --group-directories-first"
  alias l="eza -l --color=auto --icons"
  alias lt="eza --tree --level=3 --color=auto --icons"
  alias lsd="eza -D --color=auto --icons"  # directories only
  alias lsa="eza -la --color=auto --icons --group-directories-first"
else
  # Fallback to regular ls with colors if eza is not available
  alias ls="ls -G"
  alias ll="ls -alF"
  alias la="ls -A"
  alias l="ls -CF"
fi