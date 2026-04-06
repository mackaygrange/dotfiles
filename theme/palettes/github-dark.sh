#!/bin/bash
# GitHub Dark — Official dark theme from GitHub
# Clean, professional, and highly legible
# https://github.com/primer/github-vscode-theme

VARIANT="github-dark"

# Base colors
BASE="0d1117"
SURFACE="161b22"
OVERLAY="21262d"
MUTED="8b949e"
SUBTLE="b1bac4"
TEXT="e6edf3"

# Accent colors
LOVE="f85149"
GOLD="e3b341"
ROSE="ffa657"
PINE="79c0ff"
FOAM="56d364"
IRIS="d2a8ff"

# Highlight colors
HIGHLIGHT_LOW="161b22"
HIGHLIGHT_MED="21262d"
HIGHLIGHT_HIGH="30363d"

# i3 gradient wallpaper — center color (defaults to IRIS if unset)
GRADIENT_CENTER="$PINE"

# Terminal-specific mappings (ANSI color slots)
TERM_BG="0D1117"
TERM_FG="E6EDF3"
TERM_BLACK="0D1117"       # color0 / color8
TERM_RED="F85149"         # color1 / color9   (Love)
TERM_GREEN="56D364"       # color2 / color10  (Foam)
TERM_YELLOW="E3B341"      # color3 / color11  (Gold)
TERM_BLUE="79C0FF"        # color4 / color12  (Pine)
TERM_MAGENTA="D2A8FF"     # color5 / color13  (Iris)
TERM_CYAN="FFA657"        # color6 / color14  (Rose)
TERM_WHITE="E6EDF3"       # color7 / color15  (Text)
TERM_BRIGHT_BLACK="8B949E" # color8           (Muted)
TERM_BRIGHT_RED="F9736D"      # color9
TERM_BRIGHT_GREEN="77DB83"    # color10
TERM_BRIGHT_YELLOW="E8C267"   # color11
TERM_BRIGHT_BLUE="93CCFF"     # color12
TERM_BRIGHT_MAGENTA="DBB9FF"  # color13
TERM_BRIGHT_CYAN="FFB778"     # color14
TERM_BRIGHT_WHITE="EBF0F5"    # color15
