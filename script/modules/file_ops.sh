#!/usr/bin/env bash
#
# File Operations Module - Core symlink and file management
#

# Global state for user choices
overwrite_all=false
backup_all=false
skip_all=false

# Handle existing file/directory - returns action to take
handle_existing_file() {
    local src=$1 dst=$2
    local overwrite= backup= skip=
    
    # If target is already a symlink pointing to our source, skip silently
    if [ -L "$dst" ]; then
        local currentSrc="$(readlink "$dst")"
        if [ "$currentSrc" == "$src" ]; then
            return 10  # Already correctly linked - special return code
        fi
    fi

    # Only prompt if not already set globally
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
        local action=$(prompt_overwrite "$dst" "$src")
        
        case "$action" in
            o) overwrite=true ;;
            O) overwrite_all=true ;;
            b) backup=true ;;
            B) backup_all=true ;;
            s) skip=true ;;
            S) skip_all=true ;;
        esac
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
        rm -rf "$dst"
        success "removed $dst"
        return 0
    elif [ "$backup" == "true" ]; then
        if mv "$dst" "${dst}.backup" 2>/dev/null; then
            success "moved $dst to ${dst}.backup"
            return 0
        else
            fail "failed to backup $dst"
            return 1
        fi
    elif [ "$skip" == "true" ]; then
        success "skipped $src"
        return 2  # Special code for skip
    fi
    
    return 0
}

# Create a single symlink
create_symlink() {
    local src=$1 dst=$2
    
    # Create target directory if needed
    mkdir -p "$(dirname "$dst")"

    # Create the symlink
    if ln -s "$src" "$dst" 2>/dev/null; then
        success "linked $src to $dst"
        return 0
    else
        fail "failed to link $src to $dst"
        return 1
    fi
}

# Main function to link a single file/directory
link_file() {
    local src=$1 dst=$2
    
    # Handle existing files
    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
        handle_existing_file "$src" "$dst"
        local result=$?
        [ $result -eq 10 ] && return 0  # Already correctly linked
        [ $result -eq 2 ] && return 0   # Skip requested
        [ $result -ne 0 ] && return $result  # Error occurred
    fi
    
    create_symlink "$src" "$dst"
}