# Homebrew path setup
# Note: Homebrew is now initialized early in zshrc.symlink before loading path files
# This file serves as a backup for direct sourcing or other shells

# Add Homebrew to the path (if not already done)
if ! command -v brew >/dev/null 2>&1; then
    if test "$(uname)" = "Darwin"; then
        eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null
    fi
fi