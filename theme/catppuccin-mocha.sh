#!/bin/bash
# Catppuccin Mocha — Soothing pastel dark theme
# https://catppuccin.com/

VARIANT="catppuccin-mocha"

# Base colors
BASE="1e1e2e"
SURFACE="313244"
OVERLAY="45475a"
MUTED="6c7086"
SUBTLE="a6adc8"
TEXT="cdd6f4"

# Accent colors
LOVE="f38ba8"
GOLD="f9e2af"
ROSE="fab387"
PINE="89b4fa"
FOAM="94e2d5"
IRIS="cba6f7"

# Highlight colors
HIGHLIGHT_LOW="2a2b3d"
HIGHLIGHT_MED="3b3c50"
HIGHLIGHT_HIGH="4c4d63"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="1E1E2E"
TERM_FG="CDD6F4"
TERM_BLACK="1E1E2E"       # color0 / color8
TERM_RED="F38BA8"         # color1 / color9   (Love)
TERM_GREEN="94E2D5"       # color2 / color10  (Foam)
TERM_YELLOW="F9E2AF"      # color3 / color11  (Gold)
TERM_BLUE="89B4FA"        # color4 / color12  (Pine)
TERM_MAGENTA="CBA6F7"     # color5 / color13  (Iris)
TERM_CYAN="FAB387"        # color6 / color14  (Rose)
TERM_WHITE="CDD6F4"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="6C7086" # color8           (Muted)
