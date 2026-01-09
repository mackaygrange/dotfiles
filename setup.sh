#!/bin/bash

# Linux dotfiles setup script
# This script installs configuration files to their appropriate locations
# Supported: Arch Linux, Ubuntu
# Usage: ./setup.sh

set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Usage: ./setup.sh"
            echo ""
            echo "This script will install dotfiles and automatically install packages for your distro."
            echo "Supported distros: Arch Linux, Ubuntu"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Define package lists for each distro
declare -A arch_packages=(
    ["common"]="lua5.4 luarocks python3 git neofetch neovim vim ssh lsd less fzf cmake make ripgrep"
    ["arch_specific"]="wofi waybar hyprland hyprpaper uwsm"
)

declare -A ubuntu_packages=(
    ["common"]="lua5.4 luarocks python3 git neofetch neovim vim ssh lsd less fzf cmake make ripgrep"
)

# Detect OS and Distro
detect_os_and_distro()
{
    OS="$(uname -s)"
    DISTRO=""
    case "$OS" in
        Linux*)
            if [ -f /etc/os-release ]; then
                # Modern standard for Linux distro detection
                . /etc/os-release
                DISTRO="${ID}"
            elif [ -f /etc/arch-release ]; then
                DISTRO="arch"
            fi
            ;;
    esac
}

# Validate OS and Distro support
validate_os_and_distro()
{
    if [ "$OS" != "Linux" ]; then
        echo "[X] Error: This script only supports Linux"
        echo "Detected OS: $OS"
        exit 1
    fi

    if [ "$DISTRO" != "arch" ] && [ "$DISTRO" != "ubuntu" ]; then
        echo "[X] Error: Unsupported distro: $DISTRO"
        echo "Supported distros: Arch Linux, Ubuntu"
        exit 1
    fi
}

# Function to automatically install packages for detected distro
install_packages_for_distro() {
    echo "[*] Installing packages for detected distro..."
    echo ""

    if [ "$DISTRO" = "arch" ]; then
        echo "[*] Installing packages for Arch Linux..."
        local packages="${arch_packages[common]} ${arch_packages[arch_specific]}"

        if command -v sudo &> /dev/null; then
            sudo pacman -S --noconfirm $packages || {
                echo "[X] Error: Failed to install packages on Arch Linux"
                return 1
            }
        else
            pacman -S --noconfirm $packages || {
                echo "[X] Error: Failed to install packages on Arch Linux"
                return 1
            }
        fi
        echo "[+] Arch Linux packages installed"

    elif [ "$DISTRO" = "ubuntu" ]; then
        echo "[*] Installing packages for Ubuntu..."
        local packages="${ubuntu_packages[common]}"

        if command -v sudo &> /dev/null; then
            sudo apt update || true
            sudo apt install -y $packages || {
                echo "[X] Error: Failed to install packages on Ubuntu"
                return 1
            }
        else
            apt update || true
            apt install -y $packages || {
                echo "[X] Error: Failed to install packages on Ubuntu"
                return 1
            }
        fi
        echo "[+] Ubuntu packages installed"

    else
        echo "[!] Package installation not supported for distro: $DISTRO"
        echo "Please install the following packages manually if needed:"
        return 0
    fi

    echo ""
}

# Configuration mapping: folder_name|destination|distro_requirement
# distro_requirement: empty=all distros, arch=only arch
declare -a config_list=(
    "kitty|$CONFIG_DIR/kitty|"
    "nvim|$CONFIG_DIR/nvim|"
    "waybar|$CONFIG_DIR/waybar|arch"
    "hypr|$CONFIG_DIR/hypr|arch"
    "wofi|$CONFIG_DIR/wofi|arch"
    "neofetch|$CONFIG_DIR/neofetch|"
    "git|$CONFIG_DIR/git|"
    "uwsm|$CONFIG_DIR/uwsm|arch"
    "fonts|$HOME/.fonts|"
    "icons|$HOME/.icons|arch"
    "ssh|$HOME/.ssh|special"
)

# Function to check if config should be installed based on distro requirement
should_install_config() {
    local distro_req="$1"

    # If distro requirement is empty or special, install for all
    if [ -z "$distro_req" ] || [ "$distro_req" = "special" ]; then
        return 0
    fi

    # Check if distro matches requirement
    if [ "$DISTRO" = "$distro_req" ]; then
        return 0
    fi

    return 1
}

# Function to setup configuration folder
setup_config_folder() {
    local src="$1"
    local dest="$2"
    local config_name="$3"
    
    if [ ! -d "$src" ]; then
        echo "[!] Source folder not found: $src"
        return 1
    fi
    
    # Create destination directory if needed
    mkdir -p "$dest"
    
    # Special handling for SSH (permissions)
    if [ "$config_name" = "ssh" ]; then
        rsync -av --delete "$src/" "$dest/"
        chmod 700 "$dest"
        chmod 600 "$dest"/* 2>/dev/null || true
        echo "[+] Synced: $dest (with SSH permissions)"
        return 0
    fi
    
    # Standard rsync for other configs, excluding lazy-lock.json from nvim
    rsync -av --delete --exclude="lazy-lock.json" "$src/" "$dest/"
    echo "[+] Synced: $dest"
}

mkdir -p "$CONFIG_DIR"
detect_os_and_distro
validate_os_and_distro
install_packages_for_distro
echo "Installing dotfiles from $DOTFILES_DIR..."
echo "Detected OS: $OS"
if [ -n "$DISTRO" ]; then
    echo "Detected Distro: $DISTRO"
fi
echo "[*] Setting up configuration folders..."

for config_entry in "${config_list[@]}"; do
    IFS='|' read -r config_name dest distro_req <<< "$config_entry"
    
    if should_install_config "$distro_req"; then
        setup_config_folder "$DOTFILES_DIR/$config_name" "$dest" "$config_name"
    else
        echo "[>>] Skipped $config_name (distro: $distro_req)"
    fi
done

echo "[*] Setting up shell rc files..."

# Bash RC
if [ -f "$DOTFILES_DIR/bash/.bashrc" ]; then
    if [ -e "$HOME/.bashrc" ] || [ -L "$HOME/.bashrc" ]; then
        mv "$HOME/.bashrc" "$HOME/.bashrc.bak"
    fi
    cp "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
    echo "[+] Copied: $HOME/.bashrc"
else
    echo "[!] .bashrc not found"
fi

# Bash profile
if [ -f "$DOTFILES_DIR/bash/.bash_profile" ]; then
    if [ -e "$HOME/.bash_profile" ] || [ -L "$HOME/.bash_profile" ]; then
        mv "$HOME/.bash_profile" "$HOME/.bash_profile.bak"
    fi
    cp "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
    echo "[+] Copied: $HOME/.bash_profile"
fi

# Bash logout
if [ -f "$DOTFILES_DIR/bash/.bash_logout" ]; then
    if [ -e "$HOME/.bash_logout" ] || [ -L "$HOME/.bash_logout" ]; then
        mv "$HOME/.bash_logout" "$HOME/.bash_logout.bak"
    fi
    cp "$DOTFILES_DIR/bash/.bash_logout" "$HOME/.bash_logout"
    echo "[+] Copied: $HOME/.bash_logout"
fi

# Inputrc
if [ -f "$DOTFILES_DIR/bash/.inputrc" ]; then
    if [ -e "$HOME/.inputrc" ] || [ -L "$HOME/.inputrc" ]; then
        mv "$HOME/.inputrc" "$HOME/.inputrc.bak"
    fi
    cp "$DOTFILES_DIR/bash/.inputrc" "$HOME/.inputrc"
    echo "[+] Copied: $HOME/.inputrc"
fi

# User dirs configuration
if [ -f "$DOTFILES_DIR/user-dirs.dirs" ]; then
    cp "$DOTFILES_DIR/user-dirs.dirs" "$CONFIG_DIR/user-dirs.dirs"
    echo "[+] Installed: user-dirs.dirs"
fi

echo "[OK] Dotfiles installation complete!"

# Refresh shell environment
echo "[*] Refreshing shell environment..."
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
    echo "[+] Sourced ~/.bashrc"
fi

echo "[OK] Shell environment refreshed!"
