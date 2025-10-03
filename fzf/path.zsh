# Set up fzf key bindings and fuzzy completion
# Use the modern fzf --zsh command for automatic setup
if [ -n "$ZSH_VERSION" ] && command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi
