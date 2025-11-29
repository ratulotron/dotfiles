# ratul does dotfiles

Modern dotfiles with a clean convention-over-configuration approach.

Fork of [Zach Holman's dotfiles](http://github.com/holman/dotfiles) with modern CLI tools, Oh My Zsh, and Tokyo Night theming.

## quick start

```sh
git clone https://github.com/ratulotron/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/install
```

## file naming convention

Simple patterns for automatic symlinking:

### **Home Directory Files**

```
topic/[filename].symlink → ~/.filename
```

- `git/gitconfig.symlink` → `~/.gitconfig`
- `zsh/zshrc.symlink` → `~/.zshrc`

### **Config Directories**

```
topic/config/[topic].symlink.d/ → ~/.config/[topic]/
```

- `atuin/config/atuin.symlink.d/` → `~/.config/atuin/`
- `helix/config/helix.symlink.d/` → `~/.config/helix/`

### **Single Config Files**

```
topic/config/[filename].symlink → ~/.config/[filename]
```

- `starship/config/starship.toml.symlink` → `~/.config/starship.toml`

### **Executables**

Files in `bin/` are added directly to `$PATH`.

### **Custom Linking**

```
topic/link.sh → custom linking logic
```

## management

```sh
# Main operations
dot                        # Update everything
dot install               # Full installation
dot link                  # Create symlinks only
dot link --dry-run        # Preview symlinks

# Maintenance
dot list                  # Show managed files
dot clean                 # Remove broken symlinks
dot backup                # Create backup
```

## what's different

- **Modern CLI tools**: `bat`, `fd`, `ripgrep`, `eza`, `delta`, `zoxide` replacing old Unix utilities
- **Development setup**: Node.js, Python, Rust, Go, Docker, PostgreSQL
- **macOS optimized**: Ghostty terminal, Raycast, Rectangle, developer-friendly system defaults
- **Shell enhancements**: Oh My Zsh, Atuin history sync, 50+ aliases, smart completions
- **Tokyo Night theming**: Consistent colors across all tools

## tool installation priority

Tools are installed in this order of preference:

1. **[Mise](https://mise.jdx.dev/)** - Primary for development tools with version management
2. **[Homebrew](https://brew.sh/)** - For system utilities and GUI applications
3. **Curl install scripts** - Last resort for tools not available elsewhere

Development tools like `node`, `python`, `rust`, `go`, and CLI utilities like `bat`, `jq`, `gh` are managed by Mise for better version control and project isolation.

## troubleshooting

```sh
./script/link --dry-run   # Preview symlinks
dot list                  # Show managed files
dot help                  # Show all available commands
```

Common fixes:

- Broken symlinks: `dot clean && dot link`
- Missing packages: `dot install`
- Outdated system: `dot update`

## license

MIT License. Fork it, use it, improve it.
## install

```sh
git clone https://github.com/minhazratul/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
make stow
```

## update

```sh
dot update
# or
cd ~/.dotfiles && make update
```

## structure

- **bin/**: global scripts (including `dot`)
- **topic/**: topical configuration (e.g. `git`, `zsh`)
    - **.config/**: config files (stowed to `~/.config`)
    - **.file**: dotfiles (stowed to `~/.file`)
    - **install.sh**: installation script
- **Makefile**: management commands
