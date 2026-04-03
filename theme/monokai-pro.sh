#!/bin/bash
# Monokai Pro — Iconic Monokai refined for modern editors
# Rich saturated accents against a warm dark background
# https://monokai.pro/

VARIANT="monokai-pro"

# Base colors
BASE="2d2a2e"
SURFACE="373438"
OVERLAY="403e41"
MUTED="727072"
SUBTLE="939293"
TEXT="fcfcfa"

# Accent colors
LOVE="ff6188"
GOLD="ffd866"
ROSE="fc9867"
PINE="a9dc76"
FOAM="78dce8"
IRIS="ab9df2"

# Highlight colors
HIGHLIGHT_LOW="353236"
HIGHLIGHT_MED="403e41"
HIGHLIGHT_HIGH="4e4c4f"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$IRIS"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="2D2A2E"
TERM_FG="FCFCFA"
TERM_BLACK="2D2A2E"       # color0 / color8
TERM_RED="FF6188"         # color1 / color9   (Love)
TERM_GREEN="A9DC76"       # color2 / color10  (Pine)
TERM_YELLOW="FFD866"      # color3 / color11  (Gold)
TERM_BLUE="78DCE8"        # color4 / color12  (Foam)
TERM_MAGENTA="AB9DF2"     # color5 / color13  (Iris)
TERM_CYAN="FC9867"        # color6 / color14  (Rose)
TERM_WHITE="FCFCFA"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="727072" # color8           (Muted)
