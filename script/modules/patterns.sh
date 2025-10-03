#!/usr/bin/env bash
#
# Pattern Detection Module - Find and categorize linkable files
#

# Find all .symlink files for home directory
find_home_symlinks() {
    local topic=$1
    find "$DOTFILES_ROOT/$topic" -maxdepth 1 -name "*.symlink" -type f 2>/dev/null || true
}

# Find config directory (.symlink.d)
find_config_directory() {
    local topic=$1
    local config_dir="$DOTFILES_ROOT/$topic/config/$topic.symlink.d"
    [ -d "$config_dir" ] && echo "$config_dir"
}

# Find single config file (.symlink)
find_config_file() {
    local topic=$1
    local config_file="$DOTFILES_ROOT/$topic/config/$topic.symlink"
    [ -f "$config_file" ] && echo "$config_file"
}

# Find bin directory contents
find_bin_files() {
    local topic=$1
    local bin_dir="$DOTFILES_ROOT/$topic/bin"
    [ -d "$bin_dir" ] && find "$bin_dir" -maxdepth 1 -type f 2>/dev/null || true
}

# Find custom link script
find_custom_script() {
    local topic=$1
    local link_script="$DOTFILES_ROOT/$topic/link.sh"
    [ -f "$link_script" ] && echo "$link_script"
}

# Get destination path for home symlink
get_home_destination() {
    local src=$1
    local filename=$(basename "${src%.symlink}")
    echo "$HOME/.$filename"
}

# Get destination path for config directory
get_config_dir_destination() {
    local topic=$1
    echo "$HOME/.config/$topic"
}

# Get destination path for config file
get_config_file_destination() {
    local topic=$1
    echo "$HOME/.config/$topic.toml"
}

# Get destination path for bin file
get_bin_destination() {
    local src=$1
    local filename=$(basename "$src")
    echo "$HOME/.local/bin/$filename"
}