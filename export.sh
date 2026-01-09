#!/bin/bash

# ============================================================================
# DOTFILES EXPORT SCRIPT
# ============================================================================
# This script creates a wrapper script in ~/.local/bin that:
# 1. Performs git pull
# 2. Runs setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_SCRIPT="$SCRIPT_DIR/setup.sh"
LOCAL_BIN_DIR="$HOME/.local/bin"
INSTALL_PATH="$LOCAL_BIN_DIR/dotfiles-setup"
REPO_DIR="$SCRIPT_DIR"

echo "[*] Creating dotfiles setup wrapper..."
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

# Create wrapper script with git pull and setup
# Using variable expansion instead of sed to avoid issues
cat > "$INSTALL_PATH" << EOF
#!/bin/bash
set -e

REPO_DIR="$REPO_DIR"
SETUP_SCRIPT="$REPO_DIR/setup.sh"

# ============================================================================
# UPDATE GIT REPOSITORY
# ============================================================================
if [ -d "\$REPO_DIR/.git" ]; then
    echo "[*] Updating dotfiles repository..."
    
    # Check for uncommitted changes
    if ! git -C "\$REPO_DIR" diff-index --quiet HEAD --; then
        echo "[!] Warning: Uncommitted changes in dotfiles repo"
        read -p "Continue anyway? (y/n): " -n 1 -r
        echo
        if [[ ! \$REPLY =~ ^[Yy]\$ ]]; then
            echo "Aborted"
            exit 1
        fi
    fi
    
    # Pull latest changes
    if git -C "\$REPO_DIR" pull; then
        echo "[+] Repository updated successfully"
    else
        echo "[!] Warning: Failed to pull latest changes"
        read -p "Continue with local version? (y/n): " -n 1 -r
        echo
        if [[ ! \$REPLY =~ ^[Yy]\$ ]]; then
            echo "Aborted"
            exit 1
        fi
    fi
    echo ""
fi

# ============================================================================
# RUN SETUP SCRIPT
# ============================================================================
exec bash "\$SETUP_SCRIPT" "\$@"
EOF

chmod +x "$INSTALL_PATH"
echo "[+] Created wrapper script: $INSTALL_PATH"
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
echo "  dotfiles-setup          # Updates repo via git pull, then runs setup"
echo "  ./setup.sh              # Runs setup directly (no git pull)"
echo ""