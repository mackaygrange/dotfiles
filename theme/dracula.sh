#!/bin/bash
# Dracula — Dark theme with vibrant neon accents
# https://draculatheme.com/

VARIANT="dracula"

# Base colors
BASE="282a36"
SURFACE="343746"
OVERLAY="44475a"
MUTED="6272a4"
SUBTLE="7e8ab6"
TEXT="f8f8f2"

# Accent colors
LOVE="ff5555"
GOLD="f1fa8c"
ROSE="ffb86c"
PINE="50fa7b"
FOAM="8be9fd"
IRIS="bd93f9"

# Highlight colors
HIGHLIGHT_LOW="2e3041"
HIGHLIGHT_MED="44475a"
HIGHLIGHT_HIGH="5a5e73"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="282A36"
TERM_FG="F8F8F2"
TERM_BLACK="282A36"       # color0 / color8
TERM_RED="FF5555"         # color1 / color9   (Love)
TERM_GREEN="50FA7B"       # color2 / color10  (Pine)
TERM_YELLOW="F1FA8C"      # color3 / color11  (Gold)
TERM_BLUE="BD93F9"        # color4 / color12  (Iris)
TERM_MAGENTA="FF79C6"     # color5 / color13  (Love bright)
TERM_CYAN="8BE9FD"        # color6 / color14  (Foam)
TERM_WHITE="F8F8F2"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="6272A4" # color8           (Muted)
