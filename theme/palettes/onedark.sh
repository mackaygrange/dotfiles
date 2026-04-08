#!/bin/bash
# One Dark — Iconic dark theme from Atom editor
# https://github.com/atom/one-dark-syntax

VARIANT="onedark"

# Base colors
BASE="282c34"
SURFACE="2c313c"
OVERLAY="3e4451"
MUTED="5c6370"
SUBTLE="828997"
TEXT="abb2bf"

# Accent colors
LOVE="e06c75"
GOLD="e5c07b"
ROSE="d19a66"
PINE="61afef"
FOAM="56b6c2"
IRIS="c678dd"

# Highlight colors
HIGHLIGHT_LOW="2c323c"
HIGHLIGHT_MED="3e4451"
HIGHLIGHT_HIGH="4b5263"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="282C34"
TERM_FG="ABB2BF"
TERM_BLACK="282C34"       # color0 / color8
TERM_RED="E06C75"         # color1 / color9   (Love)
TERM_GREEN="98C379"       # color2 / color10  (Pine)
TERM_YELLOW="E5C07B"      # color3 / color11  (Gold)
TERM_BLUE="61AFEF"        # color4 / color12  (Foam)
TERM_MAGENTA="C678DD"     # color5 / color13  (Iris)
TERM_CYAN="56B6C2"        # color6 / color14  (Rose)
TERM_WHITE="ABB2BF"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="5C6370" # color8           (Muted)
TERM_BRIGHT_RED="E05561"      # color9
TERM_BRIGHT_GREEN="8CC265"    # color10
TERM_BRIGHT_YELLOW="D19A66"   # color11
TERM_BRIGHT_BLUE="4AA5F0"     # color12
TERM_BRIGHT_MAGENTA="C162DE"  # color13
TERM_BRIGHT_CYAN="42B3C2"     # color14
TERM_BRIGHT_WHITE="D7DAE0"    # color15
