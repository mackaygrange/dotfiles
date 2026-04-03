#!/bin/bash
# Kanagawa — Inspired by "The Great Wave off Kanagawa"
# Rich, muted colors with an ink-wash aesthetic
# https://github.com/rebelot/kanagawa.nvim

VARIANT="kanagawa"

# Base colors
BASE="1f1f28"
SURFACE="2a2a37"
OVERLAY="363646"
MUTED="727169"
SUBTLE="c8c093"
TEXT="dcd7ba"

# Accent colors
LOVE="c34043"
GOLD="c0a36e"
ROSE="d27e99"
PINE="7e9cd8"
FOAM="6a9589"
IRIS="957fb8"

# Highlight colors
HIGHLIGHT_LOW="2a2a37"
HIGHLIGHT_MED="363646"
HIGHLIGHT_HIGH="49443c"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$PINE"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="1F1F28"
TERM_FG="DCD7BA"
TERM_BLACK="1F1F28"       # color0 / color8
TERM_RED="C34043"         # color1 / color9   (Love)
TERM_GREEN="76946A"       # color2 / color10  (Foam)
TERM_YELLOW="C0A36E"      # color3 / color11  (Gold)
TERM_BLUE="7E9CD8"        # color4 / color12  (Pine)
TERM_MAGENTA="957FB8"     # color5 / color13  (Iris)
TERM_CYAN="6A9589"        # color6 / color14  (Rose)
TERM_WHITE="DCD7BA"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="727169" # color8           (Muted)
TERM_BRIGHT_RED="E82424"      # color9
TERM_BRIGHT_GREEN="98BB6C"    # color10
TERM_BRIGHT_YELLOW="E6C384"   # color11
TERM_BRIGHT_BLUE="7FB4CA"     # color12
TERM_BRIGHT_MAGENTA="938AA9"  # color13
TERM_BRIGHT_CYAN="7AA89F"     # color14
TERM_BRIGHT_WHITE="F2ECDA"    # color15
