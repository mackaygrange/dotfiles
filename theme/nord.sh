#!/bin/bash
# Nord — Arctic, north-bluish color palette
# https://www.nordtheme.com/

VARIANT="nord"

# Base colors
BASE="2e3440"
SURFACE="3b4252"
OVERLAY="434c5e"
MUTED="616e88"
SUBTLE="d8dee9"
TEXT="eceff4"

# Accent colors
LOVE="bf616a"
GOLD="ebcb8b"
ROSE="d08770"
PINE="81a1c1"
FOAM="88c0d0"
IRIS="b48ead"

# Highlight colors
HIGHLIGHT_LOW="353b49"
HIGHLIGHT_MED="434c5e"
HIGHLIGHT_HIGH="4c566a"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$PINE"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="2E3440"
TERM_FG="ECEFF4"
TERM_BLACK="2E3440"       # color0 / color8
TERM_RED="BF616A"         # color1 / color9   (Love)
TERM_GREEN="A3BE8C"       # color2 / color10  (Pine)
TERM_YELLOW="EBCB8B"      # color3 / color11  (Gold)
TERM_BLUE="81A1C1"        # color4 / color12  (Foam)
TERM_MAGENTA="B48EAD"     # color5 / color13  (Iris)
TERM_CYAN="88C0D0"        # color6 / color14  (Rose)
TERM_WHITE="ECEFF4"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="616E88" # color8           (Muted)
