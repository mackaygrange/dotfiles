#!/bin/bash

# Script to remove all .bak-* directories in the home folder
echo "[*] Searching for .dotfiles_backup_* directories in $HOME..."

for dir in "$HOME"/.dotfiles_backup_*; do
  if [ -d "$dir" ]; then
    echo "Removing directory: $dir"
    rm -rf "$dir"
  fi
done

echo "[OK] Completed removal of .dotfiles_backup_* directories."
