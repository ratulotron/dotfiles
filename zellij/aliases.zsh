# Zellij aliases and functions

# Auto-start Zellij on terminal launch
# Attaches to existing session or creates new one
if command -v zellij >/dev/null 2>&1; then
    if [[ -z "$ZELLIJ" && -z "$INSIDE_EMACS" && -z "$VSCODE_INJECTION" ]]; then
        # Uncomment ONE of these options:

        # Option 1: Auto-attach to 'main' session (or create it)
        # zellij attach main 2>/dev/null || zellij -s main

        # Option 2: Always create a new session
        # zellij

        # Option 3: Attach to any existing session, or create new
        # zellij attach 2>/dev/null || zellij
        true
    fi
fi

# Quick session starters
alias zj='zellij'
alias zja='zellij attach'
alias zjl='zellij list-sessions'
alias zjk='zellij kill-session'
alias zjka='zellij kill-all-sessions'

# Layout shortcuts
alias zjd='zellij --layout dev'      # Development layout
alias zjw='zellij --layout work'     # Work layout

# Start or attach to a named session
zjs() {
    local session="${1:-main}"
    zellij attach "$session" 2>/dev/null || zellij -s "$session"
}

# Project session - uses current directory name
zjp() {
    local session="${PWD##*/}"
    zellij attach "$session" 2>/dev/null || zellij -s "$session" --layout dev
}
