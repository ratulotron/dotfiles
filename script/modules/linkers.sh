#!/usr/bin/env bash
#
# Linkers Module - High-level linking functions for each use case
#

# Link home directory files (Use Case 1)
link_home_files() {
    local topic=$1
    local dry_run=$2
    local count=0
    
    local symlinks
    symlinks=$(find_home_symlinks "$topic")
    
    if [ -n "$symlinks" ]; then
        while IFS= read -r src; do
            [ -f "$src" ] || continue
            
            local dst=$(get_home_destination "$src")
            
            if [ "$dry_run" = "true" ]; then
                info "[DRY RUN] Would link: $src -> $dst"
            else
                link_file "$src" "$dst"
            fi
            count=$((count + 1))
        done <<< "$symlinks"
    fi
    
    echo $count
}

# Link config directory (Use Case 2)
link_config_directory() {
    local topic=$1
    local dry_run=$2
    local config_dir count=0
    
    config_dir=$(find_config_directory "$topic")
    if [ -n "$config_dir" ]; then
        local dst=$(get_config_dir_destination "$topic")
        
        if [ "$dry_run" = "true" ]; then
            info "[DRY RUN] Would link directory: $config_dir -> $dst"
        else
            mkdir -p "$(dirname "$dst")"
            link_file "$config_dir" "$dst"
        fi
        count=1
    fi
    
    echo $count
}

# Link single config file (Use Case 3)
link_config_file() {
    local topic=$1
    local dry_run=$2
    local config_file count=0
    
    config_file=$(find_config_file "$topic")
    if [ -n "$config_file" ]; then
        local dst=$(get_config_file_destination "$topic")
        
        if [ "$dry_run" = "true" ]; then
            info "[DRY RUN] Would link: $config_file -> $dst"
        else
            mkdir -p "$(dirname "$dst")"
            link_file "$config_file" "$dst"
        fi
        count=1
    fi
    
    echo $count
}

# Link bin files (Use Case 4)
link_bin_files() {
    local topic=$1
    local dry_run=$2
    local count=0
    
    local bin_files
    bin_files=$(find_bin_files "$topic")
    
    if [ -n "$bin_files" ]; then
        while IFS= read -r src; do
            [ -f "$src" ] || continue
            
            local dst=$(get_bin_destination "$src")
            
            if [ "$dry_run" = "true" ]; then
                info "[DRY RUN] Would link: $src -> $dst"
            else
                mkdir -p "$(dirname "$dst")"
                link_file "$src" "$dst"
            fi
            count=$((count + 1))
        done <<< "$bin_files"
    fi
    
    echo $count
}

# Run custom linking script (Use Case 5)
link_custom() {
    local topic=$1
    local dry_run=$2
    local script count=0
    
    script=$(find_custom_script "$topic")
    if [ -n "$script" ]; then
        if [ "$dry_run" = "true" ]; then
            info "[DRY RUN] Would execute: $script"
        else
            info "Running custom linking for $topic"
            (cd "$DOTFILES_ROOT/$topic" && ./link.sh)
        fi
        count=1
    fi
    
    echo $count
}