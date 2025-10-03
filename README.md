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
