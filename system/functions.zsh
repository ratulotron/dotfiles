# Advanced functions for developer productivity

# Git functions
gclone() {
    if [[ $1 == *"/"* ]]; then
        # Full repo path provided
        git clone "https://github.com/$1.git"
    else
        echo "Usage: gclone username/repository"
    fi
}

# Enhanced git status with branch info (renamed to avoid conflict with Oh My Zsh alias)
# gsts() {
#     git status --short --branch "$@"
# }

# Commit with conventional format
gcommit() {
    if [ $# -eq 0 ]; then
        echo "Usage: gcommit <type> <message>"
        echo "Types: feat, fix, docs, style, refactor, test, chore"
        return 1
    fi

    local type="$1"
    shift
    local message="$*"

    git add -A && git commit -m "${type}: ${message}"
}

# Project navigation (inspired by holman's c function)
p() {
    if [ $# -eq 0 ]; then
        # List projects
        find ~/Projects ~/Code ~ -maxdepth 1 -type d 2>/dev/null | grep -v "^$HOME$" | sort
    else
        # Try different common project directories
        for dir in ~/Projects ~/Code ~; do
            if [ -d "$dir/$1" ]; then
                cd "$dir/$1" || return
                return 0
            fi
        done
        echo "Project '$1' not found"
        return 1
    fi
}

# # Enhanced directory listing with tree view
# lt() {
#     if command -v tree >/dev/null 2>&1; then
#         tree -L ${1:-2} -a -I '.git|.DS_Store|node_modules'
#     else
#         find . -maxdepth ${1:-2} -type d | sed -e 's/[^-][^\/]*\//  /g' -e 's/^  //' -e 's/-/|/'
#     fi
# }

# Database quick connect functions
pgconnect() {
    if [ $# -eq 0 ]; then
        echo "Usage: pgconnect <database_url_or_name>"
        return 1
    fi

    if [[ $1 == postgresql://* ]] || [[ $1 == postgres://* ]]; then
        psql "$1"
    else
        psql -d "$1"
    fi
}

# Docker helper functions
drun() {
    docker run -it --rm "$@"
}

dexec() {
    if [ $# -eq 0 ]; then
        echo "Usage: dexec <container> [command]"
        return 1
    fi

    local container="$1"
    shift
    docker exec -it "$container" "${@:-/bin/bash}"
}

# Clean up docker
dcleanup() {
    echo "Cleaning up Docker..."
    docker system prune -f
    docker volume prune -f
    docker image prune -a -f
}

# Development server shortcuts
dev() {
    case "$1" in
        "node"|"npm")
            npm run dev || npm start || node server.js
            ;;
        "python"|"py")
            if [ -f "manage.py" ]; then
                python manage.py runserver
            elif [ -f "app.py" ]; then
                python app.py
            elif [ -f "main.py" ]; then
                python main.py
            else
                echo "No recognized Python server file found"
            fi
            ;;
        "rust"|"cargo")
            cargo run
            ;;
        *)
            echo "Usage: dev [node|python|rust]"
            ;;
    esac
}

# Quick file search
search() {
    if [ $# -eq 0 ]; then
        echo "Usage: search <pattern> [path]"
        return 1
    fi

    local pattern="$1"
    local path="${2:-.}"

    if command -v rg >/dev/null 2>&1; then
        rg "$pattern" "$path"
    else
        grep -r "$pattern" "$path"
    fi
}

# Process management
killport() {
    if [ $# -eq 0 ]; then
        echo "Usage: killport <port>"
        return 1
    fi

    local port="$1"
    local pid=$(lsof -ti:$port)

    if [ -n "$pid" ]; then
        echo "Killing process $pid on port $port"
        kill -9 $pid
    else
        echo "No process found on port $port"
    fi
}

# Environment management
envshow() {
    env | grep -i "${1:-}" | sort
}

# Network utilities
myips() {
    echo "Internal IP:"
    ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'
    echo ""
    echo "External IP:"
    curl -s ifconfig.me
    echo ""
}

# Log viewer
logs() {
    if [ $# -eq 0 ]; then
        echo "Usage: logs <service|file>"
        return 1
    fi

    case "$1" in
        "docker")
            docker logs -f "${2:-$(docker ps -q | head -1)}"
            ;;
        "system")
            if [[ "$OSTYPE" == "darwin"* ]]; then
                log stream --predicate 'eventMessage contains "'${2:-error}'"'
            else
                journalctl -f
            fi
            ;;
        *)
            if [ -f "$1" ]; then
                tail -f "$1"
            else
                echo "File or service '$1' not found"
            fi
            ;;
    esac
}

# Code stats
stats() {
    if command -v tokei >/dev/null 2>&1; then
        tokei
    elif command -v cloc >/dev/null 2>&1; then
        cloc .
    else
        find . -type f -name "*.py" -o -name "*.js" -o -name "*.rs" -o -name "*.go" | wc -l | xargs echo "Code files:"
    fi
}

# Quick benchmark
bench() {
    if [ $# -eq 0 ]; then
        echo "Usage: bench <command>"
        return 1
    fi

    if command -v hyperfine >/dev/null 2>&1; then
        hyperfine "$@"
    else
        time "$@"
    fi
}

# Create and open file in editor
edit() {
    if [ $# -eq 0 ]; then
        ${EDITOR:-code} .
    else
        touch "$1"
        ${EDITOR:-code} "$1"
    fi
}

# System information
sysinfo() {
    echo "=== System Information ==="
    echo "OS: $(uname -s -r)"
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime)"
    echo "User: $(whoami)"
    echo "Shell: $SHELL"
    echo "Terminal: $TERM"
    echo ""
    echo "=== Hardware ==="
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
        echo "Memory: $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) GB"
    else
        echo "CPU: $(grep 'model name' /proc/cpuinfo | head -1 | cut -d':' -f2 | xargs)"
        echo "Memory: $(free -h | grep Mem | awk '{print $2}')"
    fi
}
