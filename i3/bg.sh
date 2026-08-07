#!/bin/bash

#  _                 _
# | |               | |
# | |__   __ _   ___| |__
# | '_ \ / _` | / __| '_ \
# | |_) | (_| |_\__ \ | | |
# |_.__/ \__, (_)___/_| |_|
#         __/ |
#        |___/
# V1.0

BASE="$HOME/repos/dotfiles/wallpapers/wideshot.jpg"
OVERLAY="$HOME/repos/dotfiles/wallpapers/gradients.png"
BACKGROUND="$HOME/repos/dotfiles/wallpapers/bg.jpg"
GRADIENT_1="#ff7edb"
GRADIENT_2="#262335"
DISPLAY_HEIGHT=5360
DISPLAY_WIDTH=1440

convert \
-size ${DISPLAY_HEIGHT}x${DISPLAY_WIDTH} \
-define gradient:radii=1024,512 \
-define gradient:angle=30 \
radial-gradient:${GRADIENT_1}-${GRADIENT_2} \
$OVERLAY

convert \
\( $BASE -resize ${DISPLAY_HEIGHT}x${DISPLAY_WIDTH} \) \
\( $OVERLAY -alpha set -evaluate multiply 0.80 \) \
-compose multiply \
-composite \
$BACKGROUND

# Pixelate Image:
# convert \
# $BACKGROUND \
# -scale 10% \
# -scale 1000% \
# $BACKGROUND

# Blur Image:
# convert \
# $BACKGROUND \
# -blur 0x4 \
# $BACKGROUND

# Set Background:
hsetroot -root -cover $BACKGROUND
