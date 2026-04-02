#!/bin/bash
#
# apply-theme.sh — Apply a Rosé Pine color variant across all dotfiles
#
# Usage:
#   ./theme/apply-theme.sh [moon|main|dawn]
#
# This script reads a palette from theme/<variant>.sh and writes the
# appropriate color values into every configuration file that uses
# hardcoded colors.  Files that use a plugin-based theme (Neovim,
# tmux) are updated to select the correct variant instead.
#
# Run this from the dotfiles root directory, or it will auto-detect
# the correct path.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

# ---------------------------------------------------------------------------
# Argument handling
# ---------------------------------------------------------------------------
VARIANT="${1:-moon}"

PALETTE="$SCRIPT_DIR/${VARIANT}.sh"
if [[ ! -f "$PALETTE" ]]; then
    echo "[!] Unknown variant: $VARIANT"
    echo "    Available: moon, main, dawn"
    exit 1
fi

# shellcheck source=moon.sh
source "$PALETTE"

echo "[*] Applying Rosé Pine '$VARIANT' theme..."

# ---------------------------------------------------------------------------
# Helper: Replace a line matching a pattern with a new line
# ---------------------------------------------------------------------------
# sed_replace <file> <grep-pattern> <full-replacement-line>
sed_replace() {
    local file="$1" pattern="$2" replacement="$3"
    if [[ -f "$file" ]]; then
        sed -i "s|${pattern}|${replacement}|" "$file"
    fi
}

# ---------------------------------------------------------------------------
# Helper: Replace a block between two marker comments
# ---------------------------------------------------------------------------
# replace_block <file> <start-marker> <end-marker> <new-content>
replace_block() {
    local file="$1" start="$2" end="$3" content="$4"
    if [[ ! -f "$file" ]]; then return; fi
    # Use awk to replace everything between (and including) the markers
    awk -v s="$start" -v e="$end" -v c="$content" '
        $0 ~ s { print; printf "%s\n", c; skip=1; next }
        $0 ~ e { skip=0; print; next }
        !skip  { print }
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
}

# =====================================================================
# 1. i3 config — variable block at top
# =====================================================================
I3_CONFIG="$DOTFILES_DIR/i3/config"
if [[ -f "$I3_CONFIG" ]]; then
    echo "  [+] i3/config"
    sed_replace "$I3_CONFIG" \
        '^set \$base .*' \
        "set \$base           #${BASE}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$surface .*' \
        "set \$surface        #${SURFACE}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$overlay .*' \
        "set \$overlay        #${OVERLAY}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$muted .*' \
        "set \$muted          #${MUTED}66"
    sed_replace "$I3_CONFIG" \
        '^set \$subtle .*' \
        "set \$subtle         #${SUBTLE}66"
    sed_replace "$I3_CONFIG" \
        '^set \$text .*' \
        "set \$text           #${TEXT}FF"
    sed_replace "$I3_CONFIG" \
        '^set \$love .*' \
        "set \$love           #${LOVE}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$gold .*' \
        "set \$gold           #${GOLD}FF"
    sed_replace "$I3_CONFIG" \
        '^set \$rose .*' \
        "set \$rose           #${ROSE}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$pine .*' \
        "set \$pine           #${PINE}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$foam .*' \
        "set \$foam           #${FOAM}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$iris .*' \
        "set \$iris           #${IRIS}A8"
    sed_replace "$I3_CONFIG" \
        '^set \$highlightlow .*' \
        "set \$highlightlow   #${HIGHLIGHT_LOW}66"
    sed_replace "$I3_CONFIG" \
        '^set \$highlightmed .*' \
        "set \$highlightmed   #${HIGHLIGHT_MED}66"
    sed_replace "$I3_CONFIG" \
        '^set \$highlighthigh .*' \
        "set \$highlighthigh  #${HIGHLIGHT_HIGH}66"

    # Gradient wallpaper generation command uses iris and base
    sed_replace "$I3_CONFIG" \
        'radial-gradient:"#[0-9a-fA-F]\{6\}"-"#[0-9a-fA-F]\{6\}"' \
        "radial-gradient:\"#${IRIS}\"-\"#${BASE}\""
fi

# =====================================================================
# 2. i3status — color_good / color_degraded / color_bad
# =====================================================================
I3STATUS="$DOTFILES_DIR/i3status/i3status.conf"
if [[ -f "$I3STATUS" ]]; then
    echo "  [+] i3status/i3status.conf"
    sed_replace "$I3STATUS" \
        'color_good = ".*"' \
        "color_good = \"#${FOAM}\""
    sed_replace "$I3STATUS" \
        'color_degraded = ".*"' \
        "color_degraded = \"#${IRIS}\""
    sed_replace "$I3STATUS" \
        'color_bad = ".*"' \
        "color_bad = \"#${LOVE}\""
fi

# =====================================================================
# 3. Kitty — terminal colors block
# =====================================================================
KITTY="$DOTFILES_DIR/kitty/kitty.conf"
if [[ -f "$KITTY" ]]; then
    echo "  [+] kitty/kitty.conf"
    KITTY_COLORS="background #${TERM_BG}
foreground #${TERM_FG}

color0     #${TERM_BLACK}
color1     #${TERM_RED}
color2     #${TERM_GREEN}
color3     #${TERM_YELLOW}
color4     #${TERM_BLUE}
color5     #${TERM_MAGENTA}
color6     #${TERM_CYAN}
color7     #${TERM_WHITE}
color8     #${TERM_BRIGHT_BLACK}
color9     #${TERM_RED}
color10    #${TERM_GREEN}
color11    #${TERM_YELLOW}
color12    #${TERM_BLUE}
color13    #${TERM_MAGENTA}
color14    #${TERM_CYAN}
color15    #${TERM_WHITE}

background_opacity 0.8"
    replace_block "$KITTY" "# BEGIN_KITTY_COLORS" "# END_KITTY_COLORS" "$KITTY_COLORS"
fi

# =====================================================================
# 4. Dunst — urgency section colors
#    The global background uses Overlay.  Per-urgency backgrounds are
#    slight tints of Overlay for visual differentiation.
#    Frame colors: low=Pine, normal=Gold, critical=Love
# =====================================================================
DUNST="$DOTFILES_DIR/dunst/dunstrc"
if [[ -f "$DUNST" ]]; then
    echo "  [+] dunst/dunstrc"
    local_dunst_tmp=$(mktemp)
    awk -v overlay="$OVERLAY" -v pine="$PINE" -v gold="$GOLD" -v love="$LOVE" -v text="$TEXT" '
        /^\[global\]/         { section="global" }
        /^\[urgency_low\]/    { section="low" }
        /^\[urgency_normal\]/ { section="normal" }
        /^\[urgency_critical\]/ { section="critical" }
        /^[[:space:]]*background =/ && section=="global" {
            gsub(/#[0-9a-fA-F]{6}/, "#" overlay)
        }
        /^[[:space:]]*background =/ && section=="low" {
            gsub(/#[0-9a-fA-F]{6}/, "#" overlay)
        }
        /^[[:space:]]*background =/ && section=="normal" {
            gsub(/#[0-9a-fA-F]{6}/, "#" overlay)
        }
        /^[[:space:]]*background =/ && section=="critical" {
            gsub(/#[0-9a-fA-F]{6}/, "#" overlay)
        }
        /^[[:space:]]*frame_color =/ {
            if (section == "low")      { gsub(/#[0-9a-fA-F]{6}/, "#" pine) }
            if (section == "normal")   { gsub(/#[0-9a-fA-F]{6}/, "#" gold) }
            if (section == "critical") { gsub(/#[0-9a-fA-F]{6}/, "#" love) }
        }
        { print }
    ' "$DUNST" > "$local_dunst_tmp" && mv "$local_dunst_tmp" "$DUNST"
fi

# =====================================================================
# 5. Hyprland — border colors
# =====================================================================
HYPR="$DOTFILES_DIR/hypr/hyprland.conf"
if [[ -f "$HYPR" ]]; then
    echo "  [+] hypr/hyprland.conf"
    # Active border: Rose → Pine gradient (only match uncommented lines)
    ROSE_UPPER=$(echo "$ROSE" | tr '[:lower:]' '[:upper:]')
    PINE_UPPER=$(echo "$PINE" | tr '[:lower:]' '[:upper:]')
    MUTED_UPPER=$(echo "$MUTED" | tr '[:lower:]' '[:upper:]')
    sed -i "/^[[:space:]]*col\.active_border/s|rgba([0-9a-fA-F]\{6\}EE) rgba([0-9a-fA-F]\{6\}EE)|rgba(${ROSE_UPPER}EE) rgba(${PINE_UPPER}EE)|" "$HYPR"
    sed -i "/^[[:space:]]*col\.inactive_border/s|rgba([0-9a-fA-F]\{6\}AA)|rgba(${MUTED_UPPER}AA)|" "$HYPR"
fi

# =====================================================================
# 6. Picom — shadow color
# =====================================================================
PICOM="$DOTFILES_DIR/picom/picom.conf"
if [[ -f "$PICOM" ]]; then
    echo "  [+] picom/picom.conf"
    sed_replace "$PICOM" \
        'shadow-color = "#[0-9a-fA-F]\{6\}"' \
        "shadow-color = \"#${LOVE}\""
fi

# =====================================================================
# 7. Rofi — rosepine.rasi palette variables
# =====================================================================
ROFI="$DOTFILES_DIR/rofi/rosepine.rasi"
if [[ -f "$ROFI" ]]; then
    echo "  [+] rofi/rosepine.rasi"
    sed_replace "$ROFI" 'bg: #[0-9a-fA-F]\{6,8\};'  "bg: #${BASE}A8;"
    sed_replace "$ROFI" 'cur: #[0-9a-fA-F]\{6,8\};'  "cur: #${SURFACE}A8;"
    sed_replace "$ROFI" 'fgd: #[0-9a-fA-F]\{6\};'    "fgd: #${TEXT};"
    sed_replace "$ROFI" 'cmt: #[0-9a-fA-F]\{6\};'    "cmt: #${MUTED};"
    sed_replace "$ROFI" 'cya: #[0-9a-fA-F]\{6\};'    "cya: #${FOAM};"
    sed_replace "$ROFI" 'grn: #[0-9a-fA-F]\{6\};'    "grn: #${PINE};"
    sed_replace "$ROFI" 'ora: #[0-9a-fA-F]\{6\};'    "ora: #${ROSE};"
    sed_replace "$ROFI" 'pur: #[0-9a-fA-F]\{6\};'    "pur: #${IRIS};"
    sed_replace "$ROFI" 'red: #[0-9a-fA-F]\{6\};'    "red: #${LOVE};"
    sed_replace "$ROFI" 'yel: #[0-9a-fA-F]\{6\};'    "yel: #${GOLD};"
fi

# =====================================================================
# 8. Wofi — style.css colors  (uses Rosé Pine palette properly)
# =====================================================================
WOFI="$DOTFILES_DIR/wofi/style.css"
if [[ -f "$WOFI" ]]; then
    echo "  [+] wofi/style.css"
    local_wofi_tmp=$(mktemp)
    awk -v base_r="$(printf '%d' "0x${BASE:0:2}")" \
        -v base_g="$(printf '%d' "0x${BASE:2:2}")" \
        -v base_b="$(printf '%d' "0x${BASE:4:2}")" \
        -v surf_r="$(printf '%d' "0x${SURFACE:0:2}")" \
        -v surf_g="$(printf '%d' "0x${SURFACE:2:2}")" \
        -v surf_b="$(printf '%d' "0x${SURFACE:4:2}")" \
        -v text_hex="${TEXT}" \
        -v subtle_hex="${SUBTLE}" '
    BEGIN { section="" }
    /^window /           { section="window" }
    /^#input$/           { section="input" }
    /^#inner-box$/       { section="inner-box" }
    /^#outer-box$/       { section="outer-box" }
    /^#text$/            { section="text" }
    /^#entry:selected$/  { section="selected" }
    /^#entry$/           { section="entry" }
    /^#entry:focus$/     { section="focus" }
    /^#scroll$/          { section="scroll" }
    /background-color:/ && section=="window" {
        printf "    background-color: rgba(%d, %d, %d, 0.95);\n", base_r, base_g, base_b
        next
    }
    /background-color:/ && section=="input" {
        printf "    background-color: rgba(%d, %d, %d, 0.95);\n", surf_r, surf_g, surf_b
        next
    }
    /background-color:/ && section=="selected" {
        printf "    background-color: rgba(%d, %d, %d, 0.95);\n", surf_r, surf_g, surf_b
        next
    }
    /color:/ && section=="input" {
        printf "    color: #%s;\n", text_hex
        next
    }
    /color:/ && section=="text" {
        printf "    color: #%s;\n", subtle_hex
        next
    }
    { print }
    ' "$WOFI" > "$local_wofi_tmp" && mv "$local_wofi_tmp" "$WOFI"
fi

# =====================================================================
# 9. Waybar — style.css  (replace key color values by CSS selector context)
#    Only update colors that are clearly Rosé Pine palette colors.
#    Leave non-palette decorative colors untouched.
# =====================================================================
WAYBAR_CSS="$DOTFILES_DIR/waybar/style.css"
if [[ -f "$WAYBAR_CSS" ]]; then
    echo "  [+] waybar/style.css"
    BASE_R=$(printf '%d' "0x${BASE:0:2}")
    BASE_G=$(printf '%d' "0x${BASE:2:2}")
    BASE_B=$(printf '%d' "0x${BASE:4:2}")
    MUTED_R=$(printf '%d' "0x${MUTED:0:2}")
    MUTED_G=$(printf '%d' "0x${MUTED:2:2}")
    MUTED_B=$(printf '%d' "0x${MUTED:4:2}")
    TEXT_R=$(printf '%d' "0x${TEXT:0:2}")
    TEXT_G=$(printf '%d' "0x${TEXT:2:2}")
    TEXT_B=$(printf '%d' "0x${TEXT:4:2}")
    ROSE_UPPER=$(echo "$ROSE" | tr '[:lower:]' '[:upper:]')
    PINE_UPPER=$(echo "$PINE" | tr '[:lower:]' '[:upper:]')

    local_wb_tmp=$(mktemp)
    awk \
        -v rose_upper="#${ROSE_UPPER}" \
        -v pine_upper="#${PINE_UPPER}" \
        -v base_r="$BASE_R" -v base_g="$BASE_G" -v base_b="$BASE_B" \
        -v muted_r="$MUTED_R" -v muted_g="$MUTED_G" -v muted_b="$MUTED_B" \
        -v text_r="$TEXT_R" -v text_g="$TEXT_G" -v text_b="$TEXT_B" '
    BEGIN { sel="" }
    {
        # Track CSS selectors — reset on } and set on selector lines
        if (/^\}/) { sel="" }
        else if (/^window#waybar/) { sel="waybar" }
        else if (/^#workspaces button\.active/) { sel="ws-active" }
        else if (/^#clock$/) { sel="clock" }
        else if (/^#cpu$/) { sel="cpu" }
        else if (/^#custom-gpuinfo/) { sel="mem" }
        else if (/^#tray,$/) { sel="tray-window" }

        # waybar window bg → base
        if (sel=="waybar" && /background: rgba/) {
            sub(/rgba\([0-9]+, [0-9]+, [0-9]+/, "rgba(" base_r ", " base_g ", " base_b)
        }
        # waybar window border → muted
        if (sel=="waybar" && /border: [0-9]+px solid rgba/) {
            sub(/rgba\([0-9]+, [0-9]+, [0-9]+/, "rgba(" muted_r ", " muted_g ", " muted_b)
        }
        # active workspace text → text color
        if (sel=="ws-active" && /color: rgba/) {
            sub(/rgba\([0-9]+, [0-9]+, [0-9]+/, "rgba(" text_r ", " text_g ", " text_b)
        }
        # clock text → text color
        if (sel=="clock" && /color: rgba/) {
            sub(/rgba\([0-9]+, [0-9]+, [0-9]+/, "rgba(" text_r ", " text_g ", " text_b)
        }
        # CPU icon → Rose
        if (sel=="cpu" && /color: #/) {
            sub(/#[0-9a-fA-F]+/, rose_upper)
        }
        # Memory/GPU → Pine
        if (sel=="mem" && /color: #/) {
            sub(/#[0-9a-fA-F]+/, pine_upper)
        }
        # tray/window block → text rgba
        if (sel=="tray-window" && /color: rgba/) {
            sub(/rgba\([0-9]+, [0-9]+, [0-9]+/, "rgba(" text_r ", " text_g ", " text_b)
        }
        print
    }
    ' "$WAYBAR_CSS" > "$local_wb_tmp" && mv "$local_wb_tmp" "$WAYBAR_CSS"
fi

# =====================================================================
# 10. Neovim — update variant in rose-pine setup
# =====================================================================
NVIM_COLORS="$DOTFILES_DIR/nvim/lua/mgrange/config/colors.lua"
if [[ -f "$NVIM_COLORS" ]]; then
    echo "  [+] nvim/lua/mgrange/config/colors.lua"
    sed_replace "$NVIM_COLORS" \
        'variant = ".*"' \
        "variant = \"${VARIANT}\""
    sed_replace "$NVIM_COLORS" \
        'dark_variant = ".*"' \
        "dark_variant = \"${VARIANT}\""
fi

# =====================================================================
# 11. tmux — update variant
# =====================================================================
TMUX_CONF="$DOTFILES_DIR/tmux/.tmux.conf"
if [[ -f "$TMUX_CONF" ]]; then
    echo "  [+] tmux/.tmux.conf"
    sed_replace "$TMUX_CONF" \
        "@rose_pine_variant '.*'" \
        "@rose_pine_variant '${VARIANT}' # Options are 'main', 'moon' or 'dawn'"
fi

# =====================================================================
# 12. Update rosepine-palette.md with current variant
# =====================================================================
PALETTE_MD="$DOTFILES_DIR/rosepine-palette.md"
if [[ -f "$PALETTE_MD" ]]; then
    echo "  [+] rosepine-palette.md"
    sed_replace "$PALETTE_MD" \
        '^# Rosé Pine .* — Color Palette Reference' \
        "# Rosé Pine $(echo "$VARIANT" | sed 's/./\U&/') — Color Palette Reference"
fi

# =====================================================================
# Done
# =====================================================================
echo ""
echo "[OK] Theme '$VARIANT' applied to all configuration files."
echo ""
echo "To reload active sessions:"
echo "  • i3:       \$mod+Shift+r"
echo "  • Hyprland: (auto-reloads on save)"
echo "  • tmux:     prefix + I  (to reinstall plugins)"
echo "  • Neovim:   :source \$MYVIMRC  or restart"
echo "  • kitty:    ctrl+shift+f5"
echo "  • dunst:    killall dunst && dunst &"
echo "  • waybar:   killall waybar && waybar &"
