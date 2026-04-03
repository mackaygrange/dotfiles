#!/bin/bash
# Ayu Dark — Simple, bright, and elegant dark theme
# Warm-toned background with precise accent colors
# https://github.com/ayu-theme/ayu-colors

VARIANT="ayu-dark"

# Base colors
BASE="0d1017"
SURFACE="131721"
OVERLAY="1a1f29"
MUTED="636a72"
SUBTLE="acb6bf"
TEXT="bfbdb6"

# Accent colors
LOVE="d95757"
GOLD="ffb454"
ROSE="f29668"
PINE="59c2ff"
FOAM="95e6cb"
IRIS="d2a6ff"

# Highlight colors
HIGHLIGHT_LOW="131721"
HIGHLIGHT_MED="1a1f29"
HIGHLIGHT_HIGH="242936"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="0D1017"
TERM_FG="BFBDB6"
TERM_BLACK="0D1017"       # color0 / color8
TERM_RED="D95757"         # color1 / color9   (Love)
TERM_GREEN="7FD962"       # color2 / color10  (Foam)
TERM_YELLOW="FFB454"      # color3 / color11  (Gold)
TERM_BLUE="59C2FF"        # color4 / color12  (Pine)
TERM_MAGENTA="D2A6FF"     # color5 / color13  (Iris)
TERM_CYAN="95E6CB"        # color6 / color14  (Rose)
TERM_WHITE="BFBDB6"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="636A72" # color8           (Muted)
