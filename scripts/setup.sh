#!/bin/bash

# Linux dotfiles setup script
# This script creates symlinks for configuration files
# Usage: ./setup.sh

set -e # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."
CONFIG_DIR="${HOME}/.config"
BACKUP_DIR="${HOME}/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# ============================================================================
# UPDATE GIT REPOSITORY
# ============================================================================
if [ -d "$DOTFILES_DIR/.git" ]; then
	echo "[*] Updating dotfiles repository..."

	# Check for uncommitted changes
	if ! git -C "$DOTFILES_DIR" diff-index --quiet HEAD --; then
		echo "[!] Warning: Uncommitted changes in dotfiles repo"
		read -p "Continue anyway? (y/n): " -n 1 -r
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "Aborted"
			exit 1
		fi
	fi

	# Pull latest changes
	if git -C "$DOTFILES_DIR" pull; then
		echo "[+] Repository updated successfully"
	else
		echo "[!] Warning: Failed to pull latest changes"
		read -p "Continue with local version? (y/n): " -n 1 -r
		echo
		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "Aborted"
			exit 1
		fi
	fi
	echo ""
fi

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		echo "Usage: ./setup.sh [options]"
		echo ""
		echo "This script creates symlinks for dotfiles in your home directory."
		echo "Existing configurations will be backed up to a timestamped directory."
		echo ""
		echo "Options:"
		echo "  -h, --help    Show this help message"
		exit 0
		;;
	*)
		shift
		;;
	esac
done

# Detect OS and Distro
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

# Configuration mapping: source_folder|destination|distro_requirement
declare -a config_dirs=(
	"kitty|$CONFIG_DIR/kitty|"
	"nvim|$CONFIG_DIR/nvim|"
	"waybar|$CONFIG_DIR/waybar|"
	"hypr|$CONFIG_DIR/hypr|"
	"wofi|$CONFIG_DIR/wofi|"
	"rofi|$CONFIG_DIR/rofi|"
	"neofetch|$CONFIG_DIR/neofetch|"
	"uwsm|$CONFIG_DIR/uwsm|"
	"i3|$CONFIG_DIR/i3|"
	"i3status|$CONFIG_DIR/i3status|"
	"picom|$CONFIG_DIR/picom|"
    "dunst|$CONFIG_DIR/dunst|"
	"fonts|$HOME/.fonts|"
	"icons|$HOME/.icons|"
)

# Home directory files: source_file|destination
declare -a home_files=(
	"bash/.bashrc|$HOME/.bashrc"
    "bash/.inputrc|$HOME/.inputrc"
    "bash/.bash_profile|$HOME/.bash_profile"
    "bash/.bash_logout|$HOME/.bash_logout"
    "git/.gitconfig|$HOME/.gitconfig"
	"user-dirs.dirs|$CONFIG_DIR/user-dirs.dirs"
	"tmux/.tmux.conf|$HOME/.tmux.conf"
)

# Backup existing file or directory
backup_if_exists() {
	local path="$1"

	if [ -e "$path" ] || [ -L "$path" ]; then
		# Create backup directory if it doesn't exist
		mkdir -p "$BACKUP_DIR"

		local basename="$(basename "$path")"
		local backup_path="$BACKUP_DIR/$basename"

		# Handle duplicate names in backup
		local counter=1
		while [ -e "$backup_path" ]; do
			backup_path="$BACKUP_DIR/${basename}.${counter}"
			((counter++))
		done

		mv "$path" "$backup_path"
		echo "[~] Backed up: $path -> $backup_path"
		return 0
	fi
	return 1
}

# Create symlink for configuration
create_symlink() {
	local src="$1"
	local dest="$2"
	local name="$3"

	if [ ! -e "$src" ]; then
		echo "[!] Source not found: $src"
		return 1
	fi

	# Create parent directory if needed
	mkdir -p "$(dirname "$dest")"

	# Backup existing file/directory/symlink
	backup_if_exists "$dest"

	# Create symlink
	ln -sf "$src" "$dest"
	echo "[+] Linked: $dest -> $src"

	return 0
}

# ============================================================================
# MAIN SETUP
# ============================================================================

mkdir -p "$CONFIG_DIR"
detect_os_and_distro

echo "Installing dotfiles from $DOTFILES_DIR..."
echo "Detected OS: $OS"
if [ -n "$DISTRO" ]; then
	echo "Detected Distro: $DISTRO"
fi

echo ""
echo "[*] Setting up configuration folders..."
for config_entry in "${config_dirs[@]}"; do
	IFS='|' read -r config_name dest distro_req <<<"$config_entry"
	if [ ! -d "$dest" ]; then
		mkdir $dest
	fi
	create_symlink "$DOTFILES_DIR/$config_name" "$dest" "$config_name"
done


echo ""
echo "[*] Setting up home directory files..."
for file_entry in "${home_files[@]}"; do
	IFS='|' read -r src_file dest <<<"$file_entry"

	if [ -f "$DOTFILES_DIR/$src_file" ]; then
		ln -sf "$DOTFILES_DIR/$src_file" "$dest"
		echo "[+] Linked: $dest -> $DOTFILES_DIR/$src_file"
	else
		echo "[!] Not found: $DOTFILES_DIR/$src_file"
	fi
done

echo ""
echo "[OK] Dotfiles installation complete!"

if [ -d "$BACKUP_DIR" ]; then
	echo ""
	echo "[*] Backups saved to: $BACKUP_DIR"
fi

# Refresh shell environment
echo ""
echo "[*] Refreshing shell environment..."
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc" 2>/dev/null || true
	echo "[+] Sourced ~/.bashrc"
fi

echo ""
echo "[OK] Setup complete! Your dotfiles are now symlinked."
echo "[*] Any changes you make will be reflected in both locations."
