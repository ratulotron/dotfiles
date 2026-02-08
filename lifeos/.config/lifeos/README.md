# LifeOS Configuration

This directory contains configuration files for the LifeOS personal management system.

## Files

- `config.yaml` - Main configuration (project paths, PARA structure, portfolio settings)
- `portfolio.duckdb` - Portfolio tracking database (created by install.sh)

## Location

Configuration is stored in `~/.config/lifeos/` and symlinked from `~/.dotfiles/lifeos/.config/lifeos/` via GNU Stow.

## Access

Environment variables set by `~/.dotfiles/lifeos/path.zsh`:
- `$LIFEOS_ROOT` - LifeOS project root (~/.lifeos)
- `$LIFEOS_CONFIG` - Configuration directory (~/.config/lifeos)
