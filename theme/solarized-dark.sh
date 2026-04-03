#!/bin/bash
# Solarized Dark — Precision-engineered color scheme
# https://ethanschoonover.com/solarized/

VARIANT="solarized-dark"

# Base colors
BASE="002b36"
SURFACE="073642"
OVERLAY="1a4450"
MUTED="586e75"
SUBTLE="839496"
TEXT="fdf6e3"

# Accent colors
LOVE="dc322f"
GOLD="b58900"
ROSE="cb4b16"
PINE="268bd2"
FOAM="2aa198"
IRIS="6c71c4"

# Highlight colors
HIGHLIGHT_LOW="073642"
HIGHLIGHT_MED="1a4450"
HIGHLIGHT_HIGH="2b5561"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$PINE"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="002B36"
TERM_FG="FDF6E3"
TERM_BLACK="002B36"       # color0 / color8
TERM_RED="DC322F"         # color1 / color9   (Love)
TERM_GREEN="2AA198"       # color2 / color10  (Foam)
TERM_YELLOW="B58900"      # color3 / color11  (Gold)
TERM_BLUE="268BD2"        # color4 / color12  (Pine)
TERM_MAGENTA="6C71C4"     # color5 / color13  (Iris)
TERM_CYAN="CB4B16"        # color6 / color14  (Rose)
TERM_WHITE="FDF6E3"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="586E75" # color8           (Muted)
