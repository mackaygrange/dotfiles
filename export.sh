#!/bin/bash

# ============================================================================
# DOTFILES EXPORT SCRIPT
# ============================================================================
# This script installs a wrapper script to ~/.local/bin that:
# 1. Locates the dotfiles repo
# 2. Runs setup.sh (which handles git pull)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_BIN_DIR="$HOME/.local/bin"
INSTALL_PATH="$LOCAL_BIN_DIR/dotfiles-setup"

echo "[*] Creating dotfiles setup wrapper script..."
echo ""

# Create ~/.local/bin if it doesn't exist
if [ ! -d "$LOCAL_BIN_DIR" ]; then
    echo "[*] Creating $LOCAL_BIN_DIR..."
    mkdir -p "$LOCAL_BIN_DIR"
fi

# Create wrapper script that finds repo, pulls, and runs setup
cat > "$INSTALL_PATH" << 'EOF'
#!/bin/bash

# ============================================================================
# DOTFILES SETUP WRAPPER
# ============================================================================
# This wrapper script:
# 1. Locates the dotfiles repository
# 2. Runs the setup.sh script (which handles git pull)

set -e

# ============================================================================
# FIND DOTFILES REPOSITORY
# ============================================================================
find_dotfiles_repo() {
    # Check common locations for dotfiles repo
    local possible_paths=(
        "$HOME/repos/dotfiles"
        "$HOME/dev/repos/dotfiles"
        "$HOME/.dotfiles"
        "$HOME/dotfiles"
    )
    
    for path in "${possible_paths[@]}"; do
        if [ -d "$path" ] && [ -f "$path/setup.sh" ]; then
            echo "$path"
            return 0
        fi
    done
    
    return 1
}

# Find the repository
DOTFILES_DIR=$(find_dotfiles_repo)

if [ -z "$DOTFILES_DIR" ]; then
    echo "[X] Error: Could not find dotfiles repository"
    echo ""
    echo "Checked locations:"
    echo "  - $HOME/repos/dotfiles"
    echo "  - $HOME/dev/repos/dotfiles"
    echo "  - $HOME/.dotfiles"
    echo "  - $HOME/dotfiles"
    echo ""
    echo "Please ensure your dotfiles repo exists in one of these locations"
    exit 1
fi

echo "[+] Found dotfiles repo: $DOTFILES_DIR"
echo ""

# ============================================================================
# RUN SETUP SCRIPT
# ============================================================================
echo "[*] Running setup.sh from $DOTFILES_DIR..."
echo ""

bash "$DOTFILES_DIR/setup.sh" "$@"
EOF

# Make the wrapper executable
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
echo "  dotfiles-setup"
echo ""
echo "What it does:"
echo "  1. Finds your dotfiles repo in: ~/repos/dotfiles, ~/dev/repos/dotfiles, etc."
echo "  2. Runs: setup.sh (which handles git pull and syncing configs)"
echo ""
echo "If the command is not found, run:"
echo "  source ~/.bashrc"
echo ""