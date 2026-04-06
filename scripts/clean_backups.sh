#       _                    _                _                          _
#      | |                  | |              | |                        | |
#   ___| | ___  __ _ _ __   | |__   __ _  ___| | ___   _ _ __  ___   ___| |__
#  / __| |/ _ \/ _` | '_ \  | '_ \ / _` |/ __| |/ / | | | '_ \/ __| / __| '_ \
# | (__| |  __/ (_| | | | | | |_) | (_| | (__|   <| |_| | |_) \__ \_\__ \ | | |
#  \___|_|\___|\__,_|_| |_| |_.__/ \__,_|\___|_|\_\\__,_| .__/|___(_)___/_| |_|
#                       ______                          | |
#                      |______|                         |_|

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
