#!/bin/bash

# Linux/Mac dotfiles setup script
# This script installs configuration files to their appropriate locations
# Usage: ./setup.sh [-p|--packages]

set -e  # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${HOME}/.config"
INSTALL_PACKAGES=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--packages)
            INSTALL_PACKAGES=true
            shift
            ;;
        -h|--help)
            echo "Usage: ./setup.sh [OPTIONS]"
            echo ""
            echo "Options:"
            echo "  -p, --packages    Install packages (lua, neovim, git, etc.)"
            echo "  -h, --help        Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

mkdir -p "$CONFIG_DIR"

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
            elif [ -f /etc/lsb-release ]; then
                # Ubuntu/Debian fallback
                . /etc/lsb-release
                DISTRO=$(echo "${DISTRIB_ID}" | tr '[:upper:]' '[:lower:]')
            elif [ -f /etc/arch-release ]; then
                DISTRO="arch"
            elif [ -f /etc/debian_version ]; then
                DISTRO="debian"
            fi
            ;;
        Darwin*)
            OS="macOS"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            OS="Windows"
            ;;
    esac
}

detect_os_and_distro

echo "Installing dotfiles from $DOTFILES_DIR..."
echo "Detected OS: $OS"
if [ -n "$DISTRO" ]; then
    echo "Detected Distro: $DISTRO"
fi
echo ""

# Function to check and install script dependencies
check_dependencies() {
    # Dependencies required for the script to function
    local script_dependencies=("rsync")
    local missing_deps=()
    
    echo "[*] Checking script dependencies..."
    
    for dep in "${script_dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "[!] Missing dependency: $dep"
            missing_deps+=("$dep")
        else
            echo "[+] Found: $dep"
        fi
    done
    
    # If there are missing dependencies, try to install them
    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo ""
        echo "[*] Attempting to install missing dependencies..."
        install_packages_by_distro "${missing_deps[@]}"
        [ $? -eq 0 ] || return 1
        echo "[+] Dependencies installed successfully"
    fi
    
    echo ""
}

# Check dependencies first, exit if check fails
check_dependencies || exit 1

# Function to install packages by distro
install_packages_by_distro() {
    local packages=("$@")
    
    if [ "$DISTRO" = "arch" ]; then
        if ! command -v pacman &> /dev/null; then
            echo "[X] Error: pacman not found. Cannot install packages."
            return 1
        fi
        sudo pacman -S --noconfirm "${packages[@]}" || {
            echo "[X] Error: Failed to install packages on Arch Linux"
            return 1
        }
    elif [ "$DISTRO" = "ubuntu" ] || [ "$DISTRO" = "debian" ]; then
        if ! command -v apt &> /dev/null && ! command -v apt-get &> /dev/null; then
            echo "[X] Error: apt/apt-get not found. Cannot install packages."
            return 1
        fi
        
        local pkg_manager="apt"
        if ! command -v apt &> /dev/null; then
            pkg_manager="apt-get"
        fi
        
        sudo $pkg_manager update || {
            echo "[X] Error: Failed to update package lists"
            return 1
        }
        sudo $pkg_manager install -y "${packages[@]}" || {
            echo "[X] Error: Failed to install packages on Ubuntu/Debian"
            return 1
        }
    else
        echo "[X] Error: Package manager not supported for distro: $DISTRO"
        printf "Please manually install: %s\n" "${packages[@]}"
        return 1
    fi
}

# Function to install packages based on distro
install_packages() {
    if [ "$INSTALL_PACKAGES" = false ]; then
        echo "Package installation disabled. Use -p or --packages to enable."
        return 0
    fi
    
    echo "[*] Installing packages..."
    echo ""
    
    # Common packages for all Linux distros
    local common_packages=("lua" "luarocks" "neovim" "python3" "git" "neofetch" "vim" "openssh" "lsd" "less" "fzf" "cmake" "make" "grub" "ripgrep" "awesome")
    
    if [ "$DISTRO" = "arch" ]; then
        echo "[*] Installing packages for Arch Linux..."
        
        # Arch-specific packages
        local arch_packages=("wofi" "waybar" "hyprland" "hyperpaper" "uwsm")
        local all_packages=("${common_packages[@]}" "${arch_packages[@]}")
        
        install_packages_by_distro "${all_packages[@]}"
        echo "[+] Arch Linux packages installed"
        
    elif [ "$DISTRO" = "ubuntu" ] || [ "$DISTRO" = "debian" ]; then
        echo "[*] Installing packages for Ubuntu/Debian..."
        
        install_packages_by_distro "${common_packages[@]}"
        echo "[+] Ubuntu/Debian packages installed"
        
    else
        echo "[!] Package installation not supported for distro: $DISTRO"
        echo "Please install the following packages manually:"
        printf '  - %s\n' "${common_packages[@]}"
        if [ "$DISTRO" = "arch" ]; then
            printf '  - %s\n' "wofi" "waybar" "hyprland" "hyperpaper" "uwsm"
        fi
        return 1
    fi
    
    echo ""
}

# Function to create symlink or copy file
setup_config() {
    local src="$1"
    local dest="$2"
    
    if [ ! -e "$src" ]; then
        echo "[!] Source not found: $src"
        return 1
    fi
    
    # Create destination directory if needed
    mkdir -p "$(dirname "$dest")"
    
    # Remove existing destination if it exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing: $dest"
        mv "$dest" "${dest}.bak"
    fi
    
    # Create symlink
    ln -s "$src" "$dest"
    echo "[+] Linked: $dest"
}

# Install packages if requested
install_packages

# Configuration mapping: folder_name|destination|os_requirement|distro_requirement
# os_requirement: empty=all, !Windows=exclude Windows, Windows=only Windows, Linux=only Linux
# distro_requirement: empty=all distros, arch=only arch, !arch=exclude arch
declare -a config_list=(
    "bash|$CONFIG_DIR/bash||"
    "kitty|$CONFIG_DIR/kitty|!Windows|"
    "nvim|$CONFIG_DIR/nvim|!Windows|"
    "waybar|$CONFIG_DIR/waybar|!Windows|arch"
    "hypr|$CONFIG_DIR/hypr|!Windows|arch"
    "wofi|$CONFIG_DIR/wofi|!Windows|arch"
    "wezterm|$CONFIG_DIR/wezterm|Windows|"
    "neofetch|$CONFIG_DIR/neofetch|!Windows|"
    "git|$CONFIG_DIR/git||"
    "uwsm|$CONFIG_DIR/uwsm||arch"
    "fonts|$HOME/.fonts||"
    "icons|$HOME/.icons|!Windows|arch"
    "ssh|$HOME/.ssh|||special"
)

# Function to check if config should be installed
should_install_config() {
    local os_req="$1"
    local distro_req="$2"
    
    # Check OS requirement
    if [ -n "$os_req" ]; then
        if [[ "$os_req" == !* ]]; then
            # Exclude OS (e.g., !Windows)
            local exclude_os="${os_req:1}"
            if [ "$OS" = "$exclude_os" ]; then
                return 1
            fi
        else
            # Include only specific OS
            if [ "$OS" != "$os_req" ]; then
                return 1
            fi
        fi
    fi
    
    # Check distro requirement
    if [ -n "$distro_req" ]; then
        if [[ "$distro_req" == !* ]]; then
            # Exclude distro
            local exclude_distro="${distro_req:1}"
            if [ "$DISTRO" = "$exclude_distro" ]; then
                return 1
            fi
        else
            # Include only specific distro
            if [ -z "$DISTRO" ] || [ "$DISTRO" != "$distro_req" ]; then
                return 1
            fi
        fi
    fi
    
    return 0
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
    
    # Standard rsync for other configs
    rsync -av --delete "$src/" "$dest/"
    echo "[+] Synced: $dest"
}

# Process configuration list
echo ""
echo "[*] Setting up configuration folders..."
echo ""

for config_entry in "${config_list[@]}"; do
    IFS='|' read -r config_name dest os_req distro_req <<< "$config_entry"
    
    if should_install_config "$os_req" "$distro_req"; then
        setup_config_folder "$DOTFILES_DIR/$config_name" "$dest" "$config_name"
    else
        reason=""
        if [ -n "$os_req" ]; then
            reason="$os_req"
        fi
        if [ -n "$distro_req" ]; then
            reason="$reason $distro_req"
        fi
        echo "[>>] Skipped $config_name ($reason)"
    fi
done

echo ""

# User dirs configuration
if [ -f "$DOTFILES_DIR/user-dirs.dirs" ]; then
    cp "$DOTFILES_DIR/user-dirs.dirs" "$CONFIG_DIR/user-dirs.dirs"
    echo "[+] Installed: user-dirs.dirs"
fi

echo ""
echo "[OK] Dotfiles installation complete!"
echo ""

# Refresh shell environment
echo "[*] Refreshing shell environment..."
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
    echo "[+] Sourced ~/.bashrc"
fi

if [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
    echo "[+] Sourced ~/.zshrc"
fi

echo ""
echo "[OK] Shell environment refreshed!"
echo ""
echo "Next steps:"
echo "1. Review backup files (.bak) if needed"
echo "2. Restart your applications to load new configs"

