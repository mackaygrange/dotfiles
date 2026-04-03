#!/bin/bash

# Linux package install script
# Usage: ./install_packages.sh

set -e # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
CONFIG_DIR="${HOME}/.config"
HELP_FLAG=0
INSTALL_FLAG=0



# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Detect OS and Distro:
detect_os_and_distro() {
	OS="$(uname -s)"
	DISTRO=""
	case "$OS" in
	Linux*)
		if [ -f /etc/os-release ]; then
			. /etc/os-release
			DISTRO="${ID}"
		elif [ -f /etc/arch-release ]; then
			DISTRO="arch"
		fi
		;;
	esac
}

# Install zoxide:
install_zoxide() {
	echo ""
	echo "[*] Installing zoxide from cargo..."
	if command -v cargo &>/dev/null 2>&1; then
		if command -v zoxide &>/dev/null 2>&1; then
			echo "[-] Zoxide is already installed!"
		else
			cargo install zoxide
			echo "[+] Installed zoxide!"
		fi
	else
		echo "[!] Cargo / Rustup not installed! Skipping install."
	fi
}

# Install tpm:
install_tpm() {
	echo ""
	echo "[*] Installing tmux package manager from github..."
	if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
		git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
		echo "[+] Installed tmux package manager!"
	else
		echo "[-] Tmux package manager already installed!"
	fi
}

install_nvm() {
	echo ""
	echo "[*] Installing node version manager from github..."
	if command -v curl &>/dev/null 2>&1; then
		if command -v nvm &>/dev/null 2>&1; then
			echo "[-] Node version manager is already installed!"
		else
			curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
			echo "[+] Installed node version manager!"
		fi
	else
		echo "[!] Curl not installed! Skipping install."
	fi
}

install_npm() {
	echo ""
	echo "[*] Installing node package manager with node version manager..."
	if command -v nvm &>/dev/null 2>&1; then
		if command -v npm &>/dev/null 2>&1; then
			echo "[-] Node package manager is already installed!"
		else
			nvm install --lts
			echo "[+] Installed node package manager!"
		fi
	else
		echo "[!] Node version manager not installed! Skipping install."
	fi
}

# Array containing the apt packages to download for ubuntu:
declare -a ubuntu_apt_packages=(
	"ssh"
	"git"
	"curl"
	"vim"
	"minicom"
	"wireshark"
	"tshark"
	"make"
	"cmake"
	"gcc"
	"g++"
	"python"
	"python-is-python3"
	"python-pip"
	"rustup"
	"cargo"
	"lua5.1"
	"luarocks"
	"snap"
	"hsetroot"
	"xclip"
	"scrot"
	"i3"
	"i3-status"
	"picom"
	"rofi"
	"kitty"
	"neofetch"
	"lsd"
	"tmux"
)

# Array containing the snap packeges to download for ubuntu:
declare -a ubuntu_snap_packages=(
  "nvim"
)

declare -a arch_pacman_packages=(
  "wofi"
  "hyprland"
  "waybar"
)

install_ubuntu_packages() {
  echo ""
  echo "[*] Installing Ubuntu packages..."

  for pkg in "${ubuntu_apt_packages[@]}"; do
    sudo apt-get install -y "$pkg"
  done

  for pkg in "${ubuntu_snap_packages[@]}"; do
    sudo snap install "$pkg" --classic
  done

  echo "[+] Installation of Ubuntu packages complete!"
}

install_arch_packages() {
  echo ""
  echo "[*] Installing Arch packages..."

  echo "[!] Installation of Arch packages complete!"
}

# ============================================================================
# MAIN SETUP
# ============================================================================



while getopts "hi" flag; do
  case "${flag}" in
    h) HELP_FLAG=1 ;;
    i) INSTALL_FLAG=1 ;;
  esac
done

if [[ "$HELP_FLAG" == 1 ]]; then
  echo "Usage: ./install_packages.sh [options]"
  echo ""
  echo "Options:"
  echo "  -h, --help    Show this help message"
  echo "  -i, --install Install Packages"
  exit 0
fi

detect_os_and_distro

echo "[== [+] RUNNING PACKAGE INSTALLATION SCRIPT ==]"
echo "  Detected OS: $OS"
if [ -n "$DISTRO" ]; then
  echo "  Detected Distro: $DISTRO"
fi
echo ""

# Install packages depending on the distro being used:
# TODO: Add support for more distros and complete arch package list:
if [ $EUID -ne 0 ]; then
  if [ "$INSTALL_FLAG" == 1  ]; then
    echo "[*] Installing packages..."
    if [ "$DISTRO" == "ubuntu" ]; then
      install_ubuntu_packages
    elif [ "$DISTRO" == "arch" ]; then
      install_arch_packages
    else
      echo "[!] $DISTRO distribution is not yet supported!"
    fi
  fi
else
  echo "[!] Do not run this script with sudo privileges, unexpected behaviour will occur"
  exit 1
fi

# These can be installed regardless of distro:
install_zoxide
install_tpm
install_nvm
install_npm

echo ""
echo "[OK] Package installation complete!"

# Refresh shell environment:
echo ""
echo "[*] Refreshing shell environment..."
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc" 2>/dev/null || true
	echo "[+] Sourced ~/.bashrc"
fi

# Indicate we are done:
echo ""
echo "[== [-] PACKAGE INSTALLATION SCRIPT COMPLETE ==]"
echo ""
