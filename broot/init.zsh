# Broot shell function
# This function lets you navigate with broot and cd to the selected directory

# br function - cd to directory selected in broot
if command -v broot >/dev/null 2>&1; then
    function br {
        local cmd_file
        cmd_file=$(mktemp)
        if broot --outcmd "$cmd_file" "$@"; then
            local cmd
            cmd=$(<"$cmd_file")
            rm -f "$cmd_file"
            eval "$cmd"
        else
            rm -f "$cmd_file"
            return 1
        fi
    }
fi
