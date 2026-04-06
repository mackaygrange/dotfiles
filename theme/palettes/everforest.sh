#!/bin/bash
# Everforest — Green-based dark theme for forest-inspired coding
# Soft warm greens with carefully chosen contrast
# https://github.com/sainnhe/everforest

VARIANT="everforest"

# Base colors
BASE="2d353b"
SURFACE="343f44"
OVERLAY="3d484d"
MUTED="859289"
SUBTLE="9da9a0"
TEXT="d3c6aa"

# Accent colors
LOVE="e67e80"
GOLD="dbbc7f"
ROSE="e69875"
PINE="a7c080"
FOAM="83c092"
IRIS="d699b6"

# Highlight colors
HIGHLIGHT_LOW="343f44"
HIGHLIGHT_MED="3d484d"
HIGHLIGHT_HIGH="475258"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$PINE"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="2D353B"
TERM_FG="D3C6AA"
TERM_BLACK="2D353B"       # color0 / color8
TERM_RED="E67E80"         # color1 / color9   (Love)
TERM_GREEN="A7C080"       # color2 / color10  (Pine)
TERM_YELLOW="DBBC7F"      # color3 / color11  (Gold)
TERM_BLUE="7FBBB3"        # color4 / color12  (Foam)
TERM_MAGENTA="D699B6"     # color5 / color13  (Iris)
TERM_CYAN="83C092"        # color6 / color14  (Rose)
TERM_WHITE="D3C6AA"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="859289" # color8           (Muted)
TERM_BRIGHT_RED="EB9799"      # color9
TERM_BRIGHT_GREEN="B8CC99"    # color10
TERM_BRIGHT_YELLOW="E2C998"   # color11
TERM_BRIGHT_BLUE="98C8C2"     # color12
TERM_BRIGHT_MAGENTA="DEADC4"  # color13
TERM_BRIGHT_CYAN="9BCCA7"     # color14
TERM_BRIGHT_WHITE="DBD1BB"    # color15
