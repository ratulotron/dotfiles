# ratul does dotfiles

Modern dotfiles with a clean convention-over-configuration approach.

Fork of [Zach Holman's dotfiles](http://github.com/holman/dotfiles) with modern CLI tools, Oh My Zsh, and Tokyo Night theming.

## prerequisites

- **macOS**: Xcode Command Line Tools (`xcode-select --install`), `git`, `make`
- **Linux (Debian/Ubuntu)**: `sudo apt install build-essential curl file git`

Homebrew/Linuxbrew will install GNU Stow and the rest of the toolchain automatically.

## quick start

```sh
git clone https://github.com/ratulotron/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
make stow
make check
```

- Run `make install` first so Homebrew/Linuxbrew can install GNU Stow (and the rest of the toolchain).
- Then run `make stow` to create the symlinks.
- Finally run `make check` to verify Stow can restow cleanly without changes.

## file naming convention

Simple patterns for automatic symlinking:

### **Home Directory Files**

Stow mirrors the package layout into `$HOME`. Place files exactly where you want them to land:

```
topic/.filename → ~/.filename
```

- `git/.gitconfig` → `~/.gitconfig`
- `zsh/.zshrc` → `~/.zshrc`

### **Config Directories**

Mirror the `.config` tree beneath each package:

```
topic/.config/<tool>/ → ~/.config/<tool>/
```

- `atuin/.config/atuin/` → `~/.config/atuin/`
- `helix/.config/helix/` → `~/.config/helix/`

### **Single Config Files**

Place the file under `.config` with the desired relative path:

```
topic/.config/<filename> → ~/.config/<filename>
```

- `starship/.config/starship.toml` → `~/.config/starship.toml`

### **Executables**

Files in `bin/` are added directly to `$PATH`.

## management

```sh
# Main operations
dot            # git pull + install + stow
dot install    # run all installers
dot update     # same as `dot`
dot stow       # restow packages
dot check      # dry-run restow + legacy link check

# Maintenance
dot clean      # Unstow everything
dot edit       # Open dotfiles in $EDITOR
dot help       # Show commands
```

## what's different

- **Modern CLI tools**: `bat`, `fd`, `ripgrep`, `eza`, `git-delta`, `zoxide` replacing old Unix utilities
- **Development setup**: Node.js, Python, Rust, Go, Docker, PostgreSQL
- **macOS optimized**: Ghostty terminal, Raycast, Rectangle, developer-friendly system defaults
- **Shell enhancements**: Oh My Zsh, Atuin history sync, 50+ aliases, smart completions
- **Tokyo Night theming**: Consistent colors across all tools

## shell framework (Oh My Zsh)

The dotfiles use [Oh My Zsh](https://ohmyz.sh/) as the shell framework. It's installed automatically by `zsh/install.sh` along with two community plugins:

- **zsh-autosuggestions** – fish-like command suggestions
- **zsh-syntax-highlighting** – real-time syntax highlighting

The plugin list lives in `zsh/.zshrc`. Themes are disabled because **Starship** handles the prompt (see `starship/.config/starship.toml`).

To add or remove plugins, edit the `plugins=( ... )` array in `zsh/.zshrc` and reload with `source ~/.zshrc` or open a new terminal.

## tool installation priority

Tools are installed in this order of preference:

1. **[Homebrew](https://brew.sh/)** - CLI utilities and system tools (cross-platform via Linuxbrew)
2. **[Mise](https://mise.jdx.dev/)** - Language runtimes with version management
3. **Topical `install.sh` scripts** - Last resort for tools not available elsewhere

CLI utilities like `bat`, `fd`, `ripgrep`, `eza`, `git-delta` are managed by Homebrew for simplicity. Language runtimes (`node`, `python`, `rust`, `go`) are managed by Mise for per-project version control.

### source of truth (low-overhead)

Avoid maintaining a giant per-tool table in this README.

- Policy is the source of truth: install precedence is **brew -> mise -> topical install script**.
- Canonical locations are:
  - `Brewfile` / `Mac.Brewfile`
  - `mise/.config/mise/config.toml`
  - topical `<topic>/install.sh` scripts
- Only update README when workflow/policy changes, not for every package bump.

### machine-specific overrides

Keep shared defaults in this repo, and put host-specific/secrets in untracked local files.

- Use `~/.localrc` for secrets and machine-only env vars.
- Prefer local mise overrides in `~/.config/mise/config.local.toml` for machine-specific runtime/tool differences.
- Do not commit office-only, personal-only, or WSL-only overrides into shared topic files.

### adding a tool to Mise

Edit `mise/.config/mise/config.toml`, add the tool under `[tools]`, then run:

```sh
mise install
```

## what's installed

### via Homebrew (`Brewfile`)

- **Modern CLI**: `bat`, `eza`, `fd`, `ripgrep`, `git-delta`, `zoxide`, `dust`, `duf`, `bottom`, `procs`, `sd`, `xh`, `tealdeer`
- **Dev tools**: `fzf`, `jq`, `yq`, `just`, `gh`, `lazygit`, `starship`, `helix`, `hyperfine`
- **System**: `git`, `stow`, `mise`, `wget`, `tree`, `htop`, `ffmpeg`

### via Homebrew (`Mac.Brewfile`) - macOS only

- **Apps**: Ghostty, iTerm2, VS Code, Cursor, Raycast, Rectangle, Notion, Slack, Discord, Spotify, Chrome

### via Mise (`mise/.config/mise/config.toml`)

- **Languages**: Node.js, Python, Rust, Go, Elixir, Gleam, Deno, Bun
- **Ecosystem tools**: uv, ruff, pnpm, yarn, cargo-binstall, terraform, ollama

## troubleshooting

```sh
make check                # Dry-run stow and detect legacy links
dot check                 # Same as above via the wrapper
dot help                  # Show all available commands
```

Common fixes:

- Broken symlinks: `dot clean && dot stow`
- Missing packages: `dot install`
- Outdated system: `dot update`
- Toolchain drift: `mise install`

## ci smoke checks

CI runs a smoke suite on macOS and Linux to prevent precedence and shell breakage:

- Shell syntax validation for `install.sh` and `*.zsh` files
- `shellcheck` for `install.sh` scripts
- Install precedence invariant check in `Makefile` (homebrew -> mise -> topic installers)
- `make check` stow dry-run integrity check

## license

MIT License. Fork it, use it, improve it.

## structure

- **bin/**: global scripts (including `dot`)
- **topic/**: topical configuration (e.g. `git`, `zsh`)
  - **path.zsh**: exports PATH entries or environment variables for that topic
  - **init.zsh**: initializes the tool (e.g. `atuin/init.zsh` runs `atuin init`)
  - **.config/**: config files (stowed to `~/.config`)
  - **.file**: dotfiles (stowed to `~/.file`)
  - **install.sh**: installation script
- **Makefile**: management commands

Use the topical `path.zsh`/`init.zsh` files for tool-specific setup so the shared `zsh/.zshrc` can stay lightweight. Optional tools (Docker completions, uvx, Atuin, etc.) are always wrapped in existence checks to keep shells happy on both macOS and Linux.
