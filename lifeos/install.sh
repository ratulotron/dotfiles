#!/usr/bin/env zsh
# lifeos/install.sh - Setup LifeOS system integration

set -euo pipefail

LIFEOS_ROOT="${HOME}/.lifeos"
LIFEOS_CONFIG="${HOME}/.config/lifeos"

echo "Setting up LifeOS integration..."

# Clone or update LifeOS repository if it doesn't exist
if [[ ! -d "$LIFEOS_ROOT" ]]; then
    echo "  → Cloning LifeOS repository..."
    git clone https://github.com/ratul/life_of_ratul.git "$LIFEOS_ROOT"
else
    echo "  → LifeOS repository already exists at $LIFEOS_ROOT"
fi

# Create config directory
mkdir -p "$LIFEOS_CONFIG"

# Install life CLI system-wide using uv tool install
if command -v uv &> /dev/null; then
    echo "  → Installing life CLI via uv tool install..."
    uv tool install --force "$LIFEOS_ROOT" 2>/dev/null || true
    
    if command -v life &> /dev/null; then
        echo "✓ LifeOS integration complete"
        echo "  → life CLI available system-wide"
        echo "  → Try: life --help"
    else
        echo "  ⚠ life CLI installation had issues, but LifeOS root is available"
        echo "  → You can run: cd ~/.lifeos && uv run life --help"
    fi
else
    echo "  ℹ uv not found in PATH"
    echo "  → Ensure mise is configured or uv is installed"
    echo "  → You can still use: cd ~/.lifeos && python -m life.cli"
fi
