#!/bin/zsh
#
# Install Language Servers for Helix
# Run this after setting up Homebrew and Mise
#

set -e

echo "› Installing language servers for Helix..."

# ─────────────────────────────────────────────────────────────────────────────
# Homebrew LSPs
# ─────────────────────────────────────────────────────────────────────────────
echo "› Installing LSPs from Homebrew..."
brew install --quiet \
    taplo \
    marksman \
    yaml-language-server \
    || true

# ─────────────────────────────────────────────────────────────────────────────
# Python LSPs (via uv/pip)
# ─────────────────────────────────────────────────────────────────────────────
echo "› Installing Python LSPs..."
if command -v uv >/dev/null 2>&1; then
    uv tool install pyright
    uv tool install ruff
elif command -v pipx >/dev/null 2>&1; then
    pipx install pyright
    pipx install ruff
else
    echo "⚠ Neither uv nor pipx found. Install Python LSPs manually."
fi

# ─────────────────────────────────────────────────────────────────────────────
# JavaScript/TypeScript LSPs (via npm)
# ─────────────────────────────────────────────────────────────────────────────
echo "› Installing JavaScript/TypeScript LSPs..."
if command -v npm >/dev/null 2>&1; then
    npm install -g \
        typescript \
        typescript-language-server \
        vscode-langservers-extracted \
        @vscode/emmet-helper \
        emmet-ls \
        @eslint/language-server \
        || true
else
    echo "⚠ npm not found. Install Node.js via mise first."
fi

# ─────────────────────────────────────────────────────────────────────────────
# Go LSP
# ─────────────────────────────────────────────────────────────────────────────
echo "› Installing Go LSP..."
if command -v go >/dev/null 2>&1; then
    go install golang.org/x/tools/gopls@latest
else
    echo "⚠ Go not found. Install Go via mise first."
fi

# ─────────────────────────────────────────────────────────────────────────────
# Rust LSP
# ─────────────────────────────────────────────────────────────────────────────
echo "› Installing Rust LSP..."
if command -v rustup >/dev/null 2>&1; then
    rustup component add rust-analyzer
else
    echo "⚠ rustup not found. Install Rust via mise first."
fi

# ─────────────────────────────────────────────────────────────────────────────
# Elixir LSP (choose one)
# ─────────────────────────────────────────────────────────────────────────────
echo "› Installing Elixir LSP..."
if command -v mix >/dev/null 2>&1; then
    # elixir-ls is the standard choice
    # Install via mise or manually:
    # https://github.com/elixir-lsp/elixir-ls
    echo "  ℹ Elixir-LS: Add 'elixir-lsp/elixir-ls' to mise or install manually"
    echo "    mise use -g elixir-lsp/elixir-ls@latest"
else
    echo "⚠ Elixir not found. Install Elixir via mise first."
fi

# ─────────────────────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────────────────────
echo ""
echo "✓ LSP installation complete!"
echo ""
echo "Verify with: hx --health"
echo ""
