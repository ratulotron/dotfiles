# zoxide init defines completions (compdef), so it must be loaded AFTER compinit.
# That's why this is in completion.zsh (loaded last) instead of init.zsh.
eval "$(zoxide init zsh)"
