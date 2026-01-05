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
    local common_packages=("lua" "luarocks" "neovim" "python3" "git" "neofetch" "vim" "openssh" "lsd" "less" "fzf" "cmake" "make" "grub" "ripgrep")
    
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

# Kitty terminal configuration (Linux/macOS only)
if [ "$OS" != "Windows" ]; then
    setup_config "$DOTFILES_DIR/kitty/kitty.conf" "$CONFIG_DIR/kitty/kitty.conf"
else
    echo "[>>] Skipped kitty (Windows detected)"
fi

# Neovim configuration (all platforms)
setup_config "$DOTFILES_DIR/nvim/init.lua" "$CONFIG_DIR/nvim/init.lua"
if [ -d "$DOTFILES_DIR/nvim/lua" ]; then
    mkdir -p "$CONFIG_DIR/nvim"
    rsync -av --delete "$DOTFILES_DIR/nvim/lua/" "$CONFIG_DIR/nvim/lua/"
    echo "[+] Synced: $CONFIG_DIR/nvim/lua"
fi

# Waybar configuration (Arch Linux only)
if [ "$DISTRO" = "arch" ]; then
    setup_config "$DOTFILES_DIR/waybar/config.jsonc" "$CONFIG_DIR/waybar/config.jsonc"
    setup_config "$DOTFILES_DIR/waybar/style.css" "$CONFIG_DIR/waybar/style.css"
else
    echo "[>>] Skipped waybar (Arch Linux not detected)"
fi

# Hyprland configuration (Arch Linux only)
if [ "$DISTRO" = "arch" ]; then
    [ -d "$CONFIG_DIR/hypr" ] || mkdir -p "$CONFIG_DIR/hypr"
    setup_config "$DOTFILES_DIR/hypr/hyprland.conf" "$CONFIG_DIR/hypr/hyprland.conf"
    setup_config "$DOTFILES_DIR/hypr/hyprpaper.conf" "$CONFIG_DIR/hypr/hyprpaper.conf"
else
    echo "[>>] Skipped hyprland (Arch Linux not detected)"
fi

# Wofi configuration (Arch Linux only)
if [ "$DISTRO" = "arch" ]; then
    setup_config "$DOTFILES_DIR/wofi/config" "$CONFIG_DIR/wofi/config"
    setup_config "$DOTFILES_DIR/wofi/style.css" "$CONFIG_DIR/wofi/style.css"
else
    echo "[>>] Skipped wofi (Arch Linux not detected)"
fi

# Wezterm configuration (Windows only)
if [ "$OS" = "Windows" ]; then
    setup_config "$DOTFILES_DIR/wezterm/helpers.lua" "$CONFIG_DIR/wezterm/helpers.lua"
else
    echo "[>>] Skipped wezterm (Windows not detected)"
fi

# Neofetch configuration (Linux/macOS only)
if [ "$OS" != "Windows" ]; then
    setup_config "$DOTFILES_DIR/neofetch/config.conf" "$CONFIG_DIR/neofetch/config.conf"
else
    echo "[>>] Skipped neofetch (Windows detected)"
fi

# Bash configuration (optional)
if [ -f "$DOTFILES_DIR/bash/bashrc" ]; then
    echo "To use bash configs, manually source them in ~/.bashrc:"
    echo "  source $DOTFILES_DIR/bash/bashrc"
fi

# User dirs configuration
if [ -f "$DOTFILES_DIR/user-dirs.dirs" ]; then
    cp "$DOTFILES_DIR/user-dirs.dirs" "$CONFIG_DIR/user-dirs.dirs"
    echo "✓ Installed: user-dirs.dirs"
fi

echo ""
echo "[OK] Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "1. Review backup files (.bak) if needed"
echo "2. Restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
echo "3. Restart your applications to load new configs"

