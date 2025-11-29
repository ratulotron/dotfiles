# FZF configuration
if command -v fzf >/dev/null 2>&1; then
  # Use fd for faster file finding if available
  if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi

  # Set up fzf key bindings and fuzzy completion
  if [ -n "$ZSH_VERSION" ]; then
    source <(fzf --zsh)
  fi
fi
