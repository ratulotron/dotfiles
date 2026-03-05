# Productivity aliases and functions inspired by popular dotfiles

# Quick shortcuts
alias reload!='source ~/.zshrc'
alias cls='clear'
alias h='history'
alias hgrep="fc -El 0 | grep"

# Better file operations with safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~="cd ~"
alias -- -="cd -"

# System monitoring
alias top='bottom'           # Use bottom instead of top
alias ps='procs'            # Use procs instead of ps
alias du='dust'             # Use dust instead of du
alias df='duf'              # Use duf instead of df

# Developer productivity
alias serve='python3 -m http.server'    # Quick HTTP server
alias myip='curl ifconfig.me'           # Get public IP

# File operations
# alias cat='bat'              # Better cat with syntax highlighting
# alias find='fd'              # Better find
# alias grep='rg'              # Better grep

# Global aliases for common pipes (from Oh My Zsh)
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

# Functions
# Extract function from holman's dotfiles (enhanced)
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar -jxvf "$1"    ;;
            *.tar.gz)    tar -zxvf "$1"    ;;
            *.bz2)       bunzip2 "$1"      ;;
            *.rar)       unrar x "$1"      ;;
            *.gz)        gunzip "$1"       ;;
            *.tar)       tar -xvf "$1"     ;;
            *.tbz2)      tar -jxvf "$1"    ;;
            *.tgz)       tar -zxvf "$1"    ;;
            *.zip)       unzip "$1"        ;;
            *.Z)         uncompress "$1"   ;;
            *.7z)        7z x "$1"         ;;
            *.dmg)       hdiutil mount "$1" ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick todo system (from holman's dotfiles)
todo() {
    if [ $# -eq 0 ]; then
        ls ~/Desktop/*.todo 2>/dev/null || echo "No todos found"
    else
        touch ~/Desktop/"$*".todo
        echo "Created todo: $*"
    fi
}

# Weather function
weather() {
    curl -s "wttr.in/${1:-}"
}

# Create a quick backup of a file
backup() {
    cp "$1"{,.bak}
}

# Find largest files in current directory
largest() {
    du -ah . | sort -rh | head -${1:-10}
}

# Process viewer with grep
psgrep() {
    ps aux | head -1
    ps aux | grep -v grep | grep "$@" -i --color=always
}

# Network utilities
alias ports='netstat -tulanp'
alias listening='lsof -i -P | grep LISTEN'

# Quick server for current directory
alias server='python3 -m http.server 8000'

# JSON pretty print
alias json='python3 -m json.tool'

# URL encode/decode
urlencode() {
    python3 -c "import urllib.parse; print(urllib.parse.quote('$1'))"
}

urldecode() {
    python3 -c "import urllib.parse; print(urllib.parse.unquote_plus('$1'))"
}
