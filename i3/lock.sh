#!/bin/bash

img="$HOME/.cache/i3lock.png"
scrot -o $img

# Pixelate image
convert $img -scale 10% -scale 1000% $img

# Blur image
convert $img -blur 0x8 $img

# Add text // George Deterrent
# convert $img -fill red -font $HOME/.fonts/CaskaydiaCoveNerdFont-Bold.ttf -pointsize 200 -gravity NorthEast -annotate 0 'NOT TODAY GEORGE!' $img

i3lock -uefi $img
