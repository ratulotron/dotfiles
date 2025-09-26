# ratul does dotfiles

Your dotfiles are how you personalize your system. These are mine.

This is a fork of Zach Holman's excellent dotfiles project, heavily customized and modernized for my macOS development workflow. I was tired of having long alias files and everything strewn about, so I kept the topic-centric approach but added a bunch of modern CLI tools, productivity enhancements, and macOS-specific optimizations.

The original philosophy of topic-based organization works great — I can split things up into the main areas I use (git, system libraries, development tools, and so on), and the project stays organized and maintainable.

## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## what's inside

A lot of stuff. Seriously, a lot of stuff. Check them out in the file browser
above and see what components may mesh up with you.
[Fork it](https://github.com/holman/dotfiles/fork), remove what you don't
use, and build on what you do use.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into your `$HOME` as `~/.filename`.
- **topic/config/\*.symlink**: Files in `config/` subdirectories get symlinked to `~/.config/topic/filename` for modern app configurations.
  This unified `.symlink` convention handles both traditional dotfiles and modern config directory structures automatically.

## what's different in this fork

I've added a bunch of modern development tools and productivity enhancements. The basic structure stays the same, but now there's support for modern CLI tools like `bat`, `fd`, `ripgrep`, and `eza` that replace the old Unix utilities. Plus there's Oh My Zsh integration, Atuin for shell history, and a bunch of macOS-specific optimizations.

There's also Helix as a modern terminal editor, enhanced git workflows with delta for better diffs, and comprehensive Docker helpers. The Brewfile includes over 120 carefully selected packages, and there are custom functions for common development tasks.

Everything uses the Tokyonight theme for consistency, and there are macOS system defaults that make development work smoother.

## install

Run this:

```sh
git clone https://github.com/ratulotron/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/install
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

### management commands

The `dot` command provides a unified interface for all dotfiles operations:

```sh
# Main commands (dot is in PATH after install)
dot                             # Comprehensive update (default action)
dot help                        # Show all available commands
dot -e                          # Edit dotfiles directory

# Installation and setup
dot install                     # Full installation (git setup + dependencies + symlinks)
dot install --dry-run           # Preview what would be installed
dot bootstrap                   # Git setup + symlinks only
dot link                        # Create symlinks only
dot deps                        # Install dependencies only

# Maintenance and updates
dot update                      # Comprehensive update: repo, macOS, Homebrew, packages
dot health-check                # Verify symlinks and dependencies
dot list                        # List all managed files
dot clean                       # Remove broken symlinks

# Backup and restore
dot backup                      # Create backup before changes
dot restore                     # Restore from backup

# Alternative direct script usage (for advanced users)
./script/install --deps-only    # Just install packages
./script/install --link-only    # Just create symlinks
./script/link --dry-run         # Preview symlinks only
./script/dev-check              # Development environment check
```

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

### modular workflow

The installation process is now highly modular for different scenarios:

**New machine setup:**

```sh
./script/dotfiles install    # Everything in one go
```

**Just added new config files:**

```sh
./script/dotfiles link       # Relink configs only (fast)
```

**Added new Brewfile packages:**

```sh
./script/dotfiles deps       # Install new dependencies only
```

**Testing changes:**

```sh
./script/link --dry-run      # Preview what would be linked
./script/install --dry-run   # Preview full installation
```

**CI/CD or automation:**

```sh
./script/install --deps-only --dry-run   # Check dependencies
./script/install --link-only             # Just symlinks, no prompts
```

## the structure

There are a few special directories here:

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made available everywhere.
- **git/**: Git configuration and aliases.
- **homebrew/**: Homebrew setup and PATH configuration.
- **system/**: System aliases, functions, and productivity tools.
- **zsh/**: Zsh and Oh My Zsh configuration.
- **macos/**: macOS defaults and system tweaks.
- **script/**: Installation and management scripts.

### script directory

The `script/` directory contains modular management tools:

- **`install`** - Main installer with `--deps-only`, `--link-only`, `--dry-run` options
- **`bootstrap`** - Git setup + symlink creation (traditional behavior)
- **`link`** - Pure symlink creation with conflict resolution
- **`dotfiles`** - Unified management interface for all operations
- **`health-check`** - Verify symlinks and dependencies are working
- **`dev-check`** - Check development environment setup

## what gets installed

There's a lot of stuff in the Brewfile. Like, a lot. Over 120 packages of modern development tools and applications:

**Modern CLI replacements** because the old Unix tools are showing their age:

- **bat** instead of `cat` — syntax highlighting and git integration
- **fd** instead of `find` — faster and more user-friendly
- **ripgrep** instead of `grep` — seriously fast searching
- **dust** instead of `du` — better disk usage visualization
- **procs** instead of `ps` — colored output and tree view
- **bottom** instead of `top` — cross-platform system monitor
- **delta** for git diffs — beautiful syntax highlighting
- **eza** instead of `ls` — icons and git status
- **zoxide** instead of `cd` — smart directory jumping
- **hyperfine** for benchmarking commands

**Development environments** for the languages I actually use:

- **Node.js** with modern package managers (pnpm, yarn)
- **Python 3.13** with UV for fast package management
- **Rust** development environment
- **Go** programming language
- **PostgreSQL** and database tools
- **Docker** with enhanced CLI tools
- **Git** with delta for prettier diffs
- **Just** instead of Make — simpler task running
- **Tokei** for code statistics
- **Mise** for managing language versions

**Applications** that I actually use daily:

- **Ghostty** — modern GPU-accelerated terminal
- **Visual Studio Code** & **Cursor** — AI-powered code editors
- **Raycast** — better Spotlight with tons of plugins
- **Rectangle** — window management that doesn't suck
- **Bitwarden** — password management
- **CleanMyMac** — system optimization
- **Figma** — design work
- **Spotify** — music while coding
- **VLC** — plays everything

**Development productivity tools** because time is money:

- **fzf** — fuzzy finder for everything
- **lazygit** — beautiful git interface
- **tldr** — simplified man pages
- **tree** — directory visualization
- **jq** — JSON processing
- **httpie** — better curl
- **ncdu** — disk usage analysis
- **watch** — run commands periodically

**Shell setup** with Oh My Zsh and a bunch of useful plugins:

The usual suspects like git, docker, fzf, kubernetes, npm, pip, brew, plus some nice-to-haves like colored-man-pages, command-not-found, copypath, dirhistory, extract, jsontools, macos, safe-paste, web-search, and z for directory jumping.

**Custom stuff** I've added:

- 50+ aliases for common tasks
- 25+ functions for development workflows
- Atuin for magical shell history with sync
- Smart completions and suggestions
- Productivity shortcuts

**macOS tweaks** because the defaults are terrible for developers:

Finder shows hidden files, path bar, and status bar. Safari has developer tools enabled. Dock auto-hides and doesn't rearrange spaces. Screenshots go to a proper folder. Keyboard repeat is fast. Trackpad is configured for productivity. Menu bar doesn't overlap windows.

Security settings are balanced for development work. Performance is optimized. Mission Control works better. Time Machine is configured sensibly. Network settings don't get in the way of local development servers.

## some useful stuff

### git workflow

Git is setup with delta for beautiful diffs, streamlined aliases, automated branch cleanup, and conflict resolution helpers.

```bash
# Quick shortcuts
gac "commit message"    # Add all and commit
gl                      # Pull with prune
gp                      # Push to origin/HEAD
glog                    # Beautiful git log
gdh                     # Diff HEAD with delta
gsta                    # Smart stash with message

# Branch management
promote                 # Push and set upstream
nuke <branch>          # Delete branch locally and remotely
git-copy-branch-name    # Copy current branch to clipboard
git-delete-local-merged # Clean up merged branches
git-unpushed           # Show unpushed commits
git-wtf                # Show repository status overview

# Advanced operations
git-amend              # Amend last commit safely
git-edit-new           # Edit new files in last commit
git-track              # Track remote branch
git-undo               # Undo last commit (safe)
```

### development shortcuts

**Navigation stuff:**

```bash
# Smart project navigation
p <project>            # Jump to project directory with fuzzy matching
cdl <dir>              # cd and list directory contents
mkcd <dir>             # Create directory and navigate to it
..                     # Go up one directory
...                    # Go up two directories
....                   # Go up three directories
z <partial>            # Zoxide smart directory jumping

# Modern file listing
l                      # List files with eza (icons, git status)
ll                     # Long format with details
la                     # Show all files including hidden
lt                     # Tree view with sensible defaults
tree                   # Directory structure visualization
```

**Docker helpers:**

```bash
# Docker workflow enhancement
drun                   # docker run with interactive/cleanup
dexec <container>      # Execute commands in running container
dlogs <container>      # Follow container logs
dcleanup               # Clean up stopped containers and images
dps                    # Enhanced docker ps with formatting
dimages                # List images with better formatting
dstop-all              # Stop all running containers
drm-all                # Remove all stopped containers
```

**Development servers:**

```bash
# Quick server startup
dev node               # Auto-detect and start Node.js dev server
dev python             # Start Python development server
dev rust               # Cargo development server
serve                  # HTTP server for current directory
livereload             # Live-reloading development server

# Build and test shortcuts
b                      # Smart build (detects build system)
t                      # Smart test runner
fmt                    # Format code (detects formatter)
lint                   # Run linter (detects linter)
```

### system utilities

**System monitoring:**

```bash
# System insights
stats                  # Show most used commands with analytics
top                    # Enhanced process viewer (using bottom)
ports                  # Show listening ports and processes
myips                  # Display internal and external IP addresses
networkinfo            # Comprehensive network information
diskspace              # Disk usage with modern visualization
sysinfo                # System information overview

# Process management
killport <port>        # Kill process on specific port
psg <process>          # Search for running processes
cpu                    # Show CPU usage by process
mem                    # Show memory usage breakdown
```

**File operations:**

```bash
# Smart file handling
extract <file>         # Universal archive extraction (any format)
compress <file>        # Smart compression with optimal format
backup <file>          # Create timestamped .bak copy
duplicate <file>       # Create copy with incremented name
cleanup                # Remove common temporary files

# Content search and analysis
search <term> [dir]    # Fast content search with ripgrep
find-large             # Find largest files and directories
find-old               # Find old files for cleanup
count-lines            # Count lines of code (using tokei)
```

**Network stuff:**

```bash
# Network utilities
weather [city]         # Get detailed weather forecast
speedtest              # Internet speed test
ping-google            # Quick connectivity test
dns-flush              # Clear DNS cache (macOS)
headers <url>          # Show HTTP headers
download <url>         # Smart download with progress

# Development networking
serve-php              # PHP development server
tunnel <port>          # Create ngrok tunnel
localhost <port>       # Open localhost in browser
```

**Text processing:**

```bash
# Text manipulation
json-pretty <file>     # Pretty-print JSON with syntax highlighting
yaml-lint <file>       # Validate YAML syntax
csv-preview <file>     # Preview CSV with column alignment
log-tail <file>        # Tail logs with syntax highlighting

# Clipboard and quick access
copy-path              # Copy current directory path
copy-file <file>       # Copy file contents to clipboard
paste-file             # Paste clipboard to new file
qr <text>              # Generate QR code for text
```

## why this setup rocks

The modern CLI tools are genuinely faster and more intuitive than the old Unix stuff. One-letter aliases save a ton of typing. Smart completions prevent typos. Everything has consistent theming with Tokyonight colors.

macOS is optimized for development work instead of fighting against you. The shell knows what you're trying to do. Tools integrate well together instead of feeling like a random collection of scripts.

Numbers-wise: 120+ Homebrew packages, 50+ custom aliases, 25+ utility functions, 20+ Oh My Zsh plugins, and 30+ modern developer tools replacing traditional Unix utilities.

## influences

This builds on ideas from mathiasbynens/dotfiles (macOS system defaults), the original holman/dotfiles (modular structure), and the Oh My Zsh ecosystem (plugin-based extensibility). The goal is safety-first operations, developer-optimized settings, and consistent user experience.

## customization

Everything's modular, so you can easily customize it:

- Add new tools by updating the `Brewfile` and running `brew bundle`
- Modify aliases by editing files in the `system/` directory
- Add shell plugins by updating the plugin list in `zsh/zshrc.symlink`
- Change macOS settings by modifying `macos/set-defaults.sh`
- Add custom functions to `system/functions.zsh`
- Customize editor settings in the respective config directories

## keeping it updated

```sh
# Update everything at once
./script/dotfiles update

# Or update individually:
brew update && brew upgrade  # Update Homebrew packages
omz update                   # Update Oh My Zsh
atuin sync                   # Sync shell history
mise install                 # Update language versions

# Re-apply configs after changes
./script/dotfiles link       # Fast relink
./script/install --link-only # Alternative relink
```

## after installation

Run `script/install` to get everything set up. Then customize it to your preferences. Try out the modern CLI tools and discover the shortcuts. Set up Atuin for history sync if you want it across devices. Use `als` to see all available aliases. Add your own project-specific stuff as needed.

## troubleshooting

The unified `dot` command makes debugging simple:

```sh
# Quick diagnostics
dot health-check                # Check symlinks and dependencies
dot list                        # See what files are managed
./script/dev-check              # Verify development environment

# Preview changes before applying
dot install --dry-run           # Preview full installation
./script/link --dry-run         # Preview symlinks only

# Fix common issues
dot clean                       # Remove broken symlinks
dot update                      # Comprehensive system update

# Start fresh (create backup first)
dot backup                      # Create safety backup
dot clean                       # Remove broken symlinks
dot link                        # Recreate symlinks
```

Common issues:

- **Broken symlinks**: Run `dot clean` then `dot link`
- **Missing packages**: Run `dot deps` or `dot update`
- **Outdated system**: Run `dot update` for comprehensive refresh
- **Shell not zsh**: Run `chsh -s $(which zsh)` and restart terminal
- **Modern tools not found**: Check `./script/dev-check` for missing dependencies

## dig deeper

If you want to explore more:

- [Oh My Zsh plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins) for additional shell enhancements
- [Modern Unix](https://github.com/ibraheemdev/modern-unix) for more CLI tool replacements
- [macOS Defaults](https://macos-defaults.com/) for system optimization
- [The Art of Command Line](https://github.com/jlevy/the-art-of-command-line) for terminal mastery

## contributing

Found something useful or broken? Open an issue or send a pull request.

## license

MIT License. Fork it, use it, improve it.

## bugs

I want this to work for everyone; that means when you clone it down it should
work for you even though you may not have `rbenv` installed, for example. That
said, I do use this as _my_ dotfiles, so there's a good chance I may break
something if I forget to make a check for a dependency.

If you're brand-new to the project and run into any blockers, please
[open an issue](https://github.com/holman/dotfiles/issues) on this repository
and I'd love to get it fixed for you!

## thanks

This is a fork of [Zach Holman's](http://github.com/holman) excellent [dotfiles](http://github.com/holman/dotfiles). The topic-centric structure and philosophy are his - I just added a bunch of modern tools and macOS-specific optimizations on top. If you want to understand the thinking behind this approach, [read his post about it](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/).

The original project made it easy to get into dotfiles customization, and the modular structure makes it simple to add new tools and configurations without everything becoming a mess.
