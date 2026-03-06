# Oh My ZSH Configuration
# This file contains Oh My ZSH specific settings and customizations
# Must be sourced BEFORE loading Oh My ZSH

# Basic OMZ Settings
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="false"
export UPDATE_ZSH_DAYS=13
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# ZSH_THEME is disabled - using Starship instead
# ZSH_THEME="robbyrussell"

# Oh My ZSH Plugins
plugins=(
    git
    history
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Oh My ZSH Auto-suggestions configuration
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

# Oh My ZSH Syntax highlighting configuration
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
