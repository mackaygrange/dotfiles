#!/bin/bash

# ============================================================================
# DOTFILES EXPORT SCRIPT
# ============================================================================
# This script creates a symlink to setup.sh in ~/.local/bin
# making it available as 'dotfiles-setup' from anywhere

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_SCRIPT="$SCRIPT_DIR/setup.sh"
LOCAL_BIN_DIR="$HOME/.local/bin"
INSTALL_PATH="$LOCAL_BIN_DIR/dotfiles-setup"

echo "[*] Installing dotfiles setup command..."
echo ""

# Check if setup.sh exists
if [ ! -f "$SETUP_SCRIPT" ]; then
    echo "[X] Error: setup.sh not found at $SCRIPT_DIR"
    exit 1
fi

# Create ~/.local/bin if it doesn't exist
if [ ! -d "$LOCAL_BIN_DIR" ]; then
    echo "[*] Creating $LOCAL_BIN_DIR..."
    mkdir -p "$LOCAL_BIN_DIR"
fi

# Create symlink to setup.sh
if [ -e "$INSTALL_PATH" ]; then
    echo "[!] $INSTALL_PATH already exists, removing..."
    rm "$INSTALL_PATH"
fi

echo "[*] Creating symlink to setup.sh..."
ln -s "$SETUP_SCRIPT" "$INSTALL_PATH"
chmod +x "$INSTALL_PATH"

echo "[+] Created: $INSTALL_PATH → $SETUP_SCRIPT"
echo ""

# ============================================================================
# CHECK AND UPDATE PATH
# ============================================================================
echo "[*] Checking if $LOCAL_BIN_DIR is in PATH..."

if echo "$PATH" | grep -q "$LOCAL_BIN_DIR"; then
    echo "[+] $LOCAL_BIN_DIR is already in PATH"
else
    echo "[!] $LOCAL_BIN_DIR is NOT in PATH"
    echo "[*] Adding to ~/.bashrc..."
    
    # Add to bashrc if not already there
    if ! grep -q "export PATH=\"\$HOME/.local/bin:\$PATH\"" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# Add ~/.local/bin to PATH for user scripts" >> "$HOME/.bashrc"
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$HOME/.bashrc"
        echo "[+] Added PATH export to ~/.bashrc"
        echo "[!] Run: source ~/.bashrc"
    fi
fi

echo ""
echo "[OK] Installation complete!"
echo ""
echo "Usage:"
echo "  dotfiles-setup"
echo ""
echo "What it does:"
echo "  1. Finds repo location via DOTFILES_DIR"
echo "  2. Updates via: git pull (from within setup.sh)"
echo "  3. Syncs configuration files"
echo ""
echo "If the command is not found, run:"
echo "  source ~/.bashrc"
echo ""