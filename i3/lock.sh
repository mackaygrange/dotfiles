#!/bin/bash

#  _  _____    ___            _          _
# (_)|____ |  / / |          | |        | |
#  _     / / / /| | ___   ___| | __  ___| |__
# | |    \ \/ / | |/ _ \ / __| |/ / / __| '_ \
# | |.___/ / /  | | (_) | (__|   < _\__ \ | | |
# |_|\____/_/   |_|\___/ \___|_|\_(_)___/_| |_|

# Verify required dependencies are installed
for cmd in scrot convert i3lock; do
	if ! command -v "$cmd" &>/dev/null; then
		echo "[!] $cmd is not installed. Cannot lock screen." >&2
		exit 1
	fi
done

img="$HOME/.cache/i3lock.png"
scrot -o "$img"

# Pixelate image
convert "$img" -scale 10% -scale 1000% "$img"

# Blur image
convert "$img" -blur 0x8 "$img"

# Add text // George Deterrent
# convert $img -fill red -font $HOME/.fonts/CaskaydiaCoveNerdFont-Bold.ttf -pointsize 200 -gravity NorthEast -annotate 0 'NOT TODAY GEORGE!' $img

i3lock -uefi "$img"
