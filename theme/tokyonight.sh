#!/bin/bash
# Tokyo Night — Vibrant lights of downtown Tokyo
# https://github.com/folke/tokyonight.nvim

VARIANT="tokyonight"

# Base colors
BASE="1a1b26"
SURFACE="24283b"
OVERLAY="414868"
MUTED="565f89"
SUBTLE="a9b1d6"
TEXT="c0caf5"

# Accent colors
LOVE="f7768e"
GOLD="e0af68"
ROSE="ff9e64"
PINE="7aa2f7"
FOAM="73daca"
IRIS="bb9af7"

# Highlight colors
HIGHLIGHT_LOW="222436"
HIGHLIGHT_MED="2f334d"
HIGHLIGHT_HIGH="3d4264"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="1A1B26"
TERM_FG="C0CAF5"
TERM_BLACK="1A1B26"       # color0 / color8
TERM_RED="F7768E"         # color1 / color9   (Love)
TERM_GREEN="73DACA"       # color2 / color10  (Foam)
TERM_YELLOW="E0AF68"      # color3 / color11  (Gold)
TERM_BLUE="7AA2F7"        # color4 / color12  (Pine)
TERM_MAGENTA="BB9AF7"     # color5 / color13  (Iris)
TERM_CYAN="FF9E64"        # color6 / color14  (Rose)
TERM_WHITE="C0CAF5"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="565F89" # color8           (Muted)
