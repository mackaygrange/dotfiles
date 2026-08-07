#!/bin/bash

#           _                 __       _ _       _
#          | |               / _|     | | |     | |
#  ___  ___| |_ _   _ _ __  | |_ _   _| | |  ___| |__
# / __|/ _ \ __| | | | '_ \ |  _| | | | | | / __| '_ \
# \__ \  __/ |_| |_| | |_) || | | |_| | | |_\__ \ | | |
# |___/\___|\__|\__,_| .__/ |_|  \__,_|_|_(_)___/_| |_|
#                    | |______
#                    |_|______|

# Linux dotfiles setup script
# This script runs all of the subscripts TODO: Add flags to toggle certain steps
# Usage: ./setup_full.sh

set -e # Exit on error

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.."

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

# ============================================================================
# MAIN SETUP
# ============================================================================

# Parse command line arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		echo "Usage: ./setup_full.sh [options]"
		echo ""
		echo "This script creates symlinks for dotfiles in your home directory."
		echo "Existing configurations will be backed up to a timestamped directory."
		echo "This script will also download all of the necessary packages depending on the distro."
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

echo "[== [+] RUNNING FULL SETUP SCRIPT ==]"
echo ""

$DOTFILES_DIR/scripts/install_packages.sh
$DOTFILES_DIR/scripts/setup_symlinks.sh

echo "[== [-] FULL SETUP SCRIPT COMPLETE ==]"
