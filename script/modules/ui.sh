#!/usr/bin/env bash
#
# UI Module - Color output and user interaction functions
#

# Color output functions
info() {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

success() {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n" 
}

warn() {
    printf "\r\033[2K  [ \033[0;33mWARN\033[0m ] $1\n"
}

fail() {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit 1
}

user() {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

# Prompt user for overwrite action
prompt_overwrite() {
    local dst=$1
    local src=$2
    
    user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
    read -n 1 action
    echo "$action"
}