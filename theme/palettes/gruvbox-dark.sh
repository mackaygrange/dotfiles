#!/bin/bash
# Gruvbox Dark — Retro groove colorscheme with warm earthy tones
# https://github.com/morhetz/gruvbox

VARIANT="gruvbox-dark"

# Base colors
BASE="282828"
SURFACE="3c3836"
OVERLAY="504945"
MUTED="928374"
SUBTLE="a89984"
TEXT="ebdbb2"

# Accent colors
LOVE="fb4934"
GOLD="fabd2f"
ROSE="fe8019"
PINE="b8bb26"
FOAM="8ec07c"
IRIS="d3869b"

# Highlight colors
HIGHLIGHT_LOW="32302f"
HIGHLIGHT_MED="504945"
HIGHLIGHT_HIGH="665c54"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="282828"
TERM_FG="EBDBB2"
TERM_BLACK="282828"       # color0 / color8
TERM_RED="FB4934"         # color1 / color9   (Love)
TERM_GREEN="B8BB26"       # color2 / color10  (Pine)
TERM_YELLOW="FABD2F"      # color3 / color11  (Gold)
TERM_BLUE="83A598"        # color4 / color12  (Foam)
TERM_MAGENTA="D3869B"     # color5 / color13  (Iris)
TERM_CYAN="8EC07C"        # color6 / color14  (Rose)
TERM_WHITE="EBDBB2"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="928374" # color8           (Muted)
TERM_BRIGHT_RED="FB6D5C"      # color9
TERM_BRIGHT_GREEN="C6C851"    # color10
TERM_BRIGHT_YELLOW="FBCA58"   # color11
TERM_BRIGHT_BLUE="9BB7AC"     # color12
TERM_BRIGHT_MAGENTA="DB9EAF"  # color13
TERM_BRIGHT_CYAN="A4CC96"     # color14
TERM_BRIGHT_WHITE="EFE2C1"    # color15
