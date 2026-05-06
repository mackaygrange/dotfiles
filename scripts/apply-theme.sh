#!/bin/bash
#
# apply-theme.sh — Apply a color variant across all dotfiles
#
# Usage:
#   ./scripts/apply-theme.sh <variant>
#
# Built-in Rosé Pine variants:
#   moon, main, dawn
#
# Custom themes:
#   woodland, catppuccin-mocha, dracula, gruvbox-dark, nord,
#   solarized-dark, tokyonight, onedark, kanagawa, everforest,
#   synthwave84, ayu-dark, monokai-pro, github-dark
#
# This script reads a palette from theme/palettes/<variant>.sh and writes the
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

PALETTE="$DOTFILES_DIR/theme/palettes/${VARIANT}.sh"
if [[ ! -f "$PALETTE" ]]; then
    echo "[!] Unknown variant: $VARIANT"
    echo "    Available: moon, main, dawn, woodland, catppuccin-mocha, dracula,"
    echo "               gruvbox-dark, nord, solarized-dark, tokyonight, onedark,"
    echo "               kanagawa, everforest, synthwave84, ayu-dark, monokai-pro,"
    echo "               github-dark"
    exit 1
fi

# shellcheck source=../theme/palettes/moon.sh
source "$PALETTE"

echo "[*] Applying '$VARIANT' theme..."

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

    # Gradient wallpaper generation command — center color is per-theme
    # (GRADIENT_CENTER defaults to IRIS if the palette file doesn't set it)
    : "${GRADIENT_CENTER:=$IRIS}"
    sed_replace "$I3_CONFIG" \
        'radial-gradient:"#[0-9a-fA-F]\{6\}"-"#[0-9a-fA-F]\{6\}"' \
        "radial-gradient:\"#${GRADIENT_CENTER}\"-\"#${BASE}\""
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
color9     #${TERM_BRIGHT_RED}
color10    #${TERM_BRIGHT_GREEN}
color11    #${TERM_BRIGHT_YELLOW}
color12    #${TERM_BRIGHT_BLUE}
color13    #${TERM_BRIGHT_MAGENTA}
color14    #${TERM_BRIGHT_CYAN}
color15    #${TERM_BRIGHT_WHITE}

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
#     Built-in variants (main/moon/dawn) just set the variant name.
#     Custom palettes override colors via the palette = {} block.
# =====================================================================
NVIM_COLORS="$DOTFILES_DIR/nvim/lua/mgrange/config/conf_colors.lua"
if [[ -f "$NVIM_COLORS" ]]; then
    echo "  [+] nvim/lua/mgrange/config/conf_colors.lua"

    # Determine the closest rose-pine base variant for the plugin
    case "$VARIANT" in
        main|moon|dawn) RP_VARIANT="$VARIANT" ;;
        *)              RP_VARIANT="moon" ;;  # dark custom themes use moon as base
    esac

    sed_replace "$NVIM_COLORS" \
        'variant = ".*"' \
        "variant = \"${RP_VARIANT}\""
    sed_replace "$NVIM_COLORS" \
        'dark_variant = ".*"' \
        "dark_variant = \"${RP_VARIANT}\""

    # For custom themes, populate the palette override block
    if [[ "$VARIANT" != "main" && "$VARIANT" != "moon" && "$VARIANT" != "dawn" ]]; then
        local_nvim_tmp=$(mktemp)
        awk -v rp_var="$RP_VARIANT" \
            -v base="$BASE" -v surface="$SURFACE" -v overlay="$OVERLAY" \
            -v muted="$MUTED" -v subtle="$SUBTLE" -v text="$TEXT" \
            -v love="$LOVE" -v gold="$GOLD" -v rose="$ROSE" \
            -v pine="$PINE" -v foam="$FOAM" -v iris="$IRIS" \
            -v hl_low="$HIGHLIGHT_LOW" -v hl_med="$HIGHLIGHT_MED" -v hl_high="$HIGHLIGHT_HIGH" '
        /^  palette = \{/ {
            print
            printf "    %s = {\n", rp_var
            printf "      base = '\''#%s'\'',\n", base
            printf "      surface = '\''#%s'\'',\n", surface
            printf "      overlay = '\''#%s'\'',\n", overlay
            printf "      muted = '\''#%s'\'',\n", muted
            printf "      subtle = '\''#%s'\'',\n", subtle
            printf "      text = '\''#%s'\'',\n", text
            printf "      love = '\''#%s'\'',\n", love
            printf "      gold = '\''#%s'\'',\n", gold
            printf "      rose = '\''#%s'\'',\n", rose
            printf "      pine = '\''#%s'\'',\n", pine
            printf "      foam = '\''#%s'\'',\n", foam
            printf "      iris = '\''#%s'\'',\n", iris
            printf "      highlight_low = '\''#%s'\'',\n", hl_low
            printf "      highlight_med = '\''#%s'\'',\n", hl_med
            printf "      highlight_high = '\''#%s'\'',\n", hl_high
            printf "    },\n"
            # Skip any existing content until closing },
            skip = 1
            next
        }
        skip && /^  \},/ { skip = 0; print; next }
        skip { next }
        { print }
        ' "$NVIM_COLORS" > "$local_nvim_tmp" && mv "$local_nvim_tmp" "$NVIM_COLORS"
    else
        # For built-in variants, clear any previous custom palette overrides
        local_nvim_tmp=$(mktemp)
        awk '
        /^  palette = \{/ {
            print
            skip = 1
            next
        }
        skip && /^  \},/ { skip = 0; print; next }
        skip { next }
        { print }
        ' "$NVIM_COLORS" > "$local_nvim_tmp" && mv "$local_nvim_tmp" "$NVIM_COLORS"
    fi
fi

# =====================================================================
# 11. tmux — update variant and status-bar colors
#     The rose-pine tmux plugin only supports main/moon/dawn.
#     Custom themes use the closest dark variant *and* apply direct
#     color overrides after plugins load so the bar matches the palette.
#
#     The plugin embeds hardcoded hex colors into format strings
#     (status-left, status-right, window-status-format, etc.) so simple
#     set -g overrides alone are not enough.  For custom themes we also
#     generate a helper script that reads every affected tmux option,
#     replaces the moon palette hex values with the custom palette, and
#     writes the results back.  A run-shell call executes it after TPM.
# =====================================================================
TMUX_CONF="$DOTFILES_DIR/tmux/.tmux.conf"
if [[ -f "$TMUX_CONF" ]]; then
    echo "  [+] tmux/.tmux.conf"
    case "$VARIANT" in
        main|moon|dawn) TMUX_VARIANT="$VARIANT" ;;
        *)              TMUX_VARIANT="moon" ;;  # dark custom themes use moon as base
    esac
    sed_replace "$TMUX_CONF" \
        "@rose_pine_variant '.*'" \
        "@rose_pine_variant '${TMUX_VARIANT}' # Options are 'main', 'moon' or 'dawn'"

    OVERRIDE_SCRIPT="$DOTFILES_DIR/theme/.tmux-override-colors.sh"

    # For custom themes, populate the override block with palette colors.
    # For built-in rose-pine variants, clear it so the plugin handles colors.
    if [[ "$VARIANT" != "main" && "$VARIANT" != "moon" && "$VARIANT" != "dawn" ]]; then

        # --- Generate the color-substitution helper script ---
        # This script is run-shell'd from tmux.conf AFTER TPM loads the
        # rose-pine plugin, so it can read back the format strings the
        # plugin generated and swap the moon palette hex values for the
        # custom palette values.
        BASE_LC=$(echo "$BASE" | tr '[:upper:]' '[:lower:]')
        SURFACE_LC=$(echo "$SURFACE" | tr '[:upper:]' '[:lower:]')
        OVERLAY_LC=$(echo "$OVERLAY" | tr '[:upper:]' '[:lower:]')
        MUTED_LC=$(echo "$MUTED" | tr '[:upper:]' '[:lower:]')
        SUBTLE_LC=$(echo "$SUBTLE" | tr '[:upper:]' '[:lower:]')
        TEXT_LC=$(echo "$TEXT" | tr '[:upper:]' '[:lower:]')
        LOVE_LC=$(echo "$LOVE" | tr '[:upper:]' '[:lower:]')
        GOLD_LC=$(echo "$GOLD" | tr '[:upper:]' '[:lower:]')
        ROSE_LC=$(echo "$ROSE" | tr '[:upper:]' '[:lower:]')
        PINE_LC=$(echo "$PINE" | tr '[:upper:]' '[:lower:]')
        FOAM_LC=$(echo "$FOAM" | tr '[:upper:]' '[:lower:]')
        IRIS_LC=$(echo "$IRIS" | tr '[:upper:]' '[:lower:]')
        HL_LOW_LC=$(echo "$HIGHLIGHT_LOW" | tr '[:upper:]' '[:lower:]')
        HL_MED_LC=$(echo "$HIGHLIGHT_MED" | tr '[:upper:]' '[:lower:]')
        HL_HIGH_LC=$(echo "$HIGHLIGHT_HIGH" | tr '[:upper:]' '[:lower:]')

        cat > "$OVERRIDE_SCRIPT" << 'SCRIPT_HEADER'
#!/bin/bash
# Auto-generated by apply-theme.sh — DO NOT EDIT
# Replaces rose-pine moon palette colors in tmux format strings with
# the active custom palette.

replace_colors() {
    local val="$1"
SCRIPT_HEADER
        # Build the sed expression that maps moon → custom palette.
        # Moon palette (lowercase, as emitted by the rose-pine plugin):
        cat >> "$OVERRIDE_SCRIPT" << SCRIPT_SED
    val=\$(printf '%s' "\$val" | sed \\
        -e 's/#232136/#${BASE_LC}/g' \\
        -e 's/#2a273f/#${SURFACE_LC}/g' \\
        -e 's/#393552/#${OVERLAY_LC}/g' \\
        -e 's/#6e6a86/#${MUTED_LC}/g' \\
        -e 's/#908caa/#${SUBTLE_LC}/g' \\
        -e 's/#e0def4/#${TEXT_LC}/g' \\
        -e 's/#eb6f92/#${LOVE_LC}/g' \\
        -e 's/#f6c177/#${GOLD_LC}/g' \\
        -e 's/#ea9a97/#${ROSE_LC}/g' \\
        -e 's/#3e8fb0/#${PINE_LC}/g' \\
        -e 's/#9ccfd8/#${FOAM_LC}/g' \\
        -e 's/#c4a7e7/#${IRIS_LC}/g' \\
        -e 's/#2a283e/#${HL_LOW_LC}/g' \\
        -e 's/#44415a/#${HL_MED_LC}/g' \\
        -e 's/#56526e/#${HL_HIGH_LC}/g')
    printf '%s' "\$val"
}

SCRIPT_SED
        cat >> "$OVERRIDE_SCRIPT" << 'SCRIPT_BODY'
# Override global options that may contain embedded color codes
for opt in status-style status-left status-right message-style \
           message-command-style pane-border-style pane-active-border-style; do
    val="$(tmux show-option -gqv "$opt" 2>/dev/null)" || continue
    [[ -z "$val" ]] && continue
    new_val="$(replace_colors "$val")"
    [[ "$new_val" != "$val" ]] && tmux set-option -gq "$opt" "$new_val"
done

# Override window options that may contain embedded color codes
for opt in window-status-style window-status-activity-style \
           window-status-current-style window-status-format \
           window-status-current-format mode-style; do
    val="$(tmux show-window-option -gqv "$opt" 2>/dev/null)" || continue
    [[ -z "$val" ]] && continue
    new_val="$(replace_colors "$val")"
    [[ "$new_val" != "$val" ]] && tmux set-window-option -gq "$opt" "$new_val"
done
SCRIPT_BODY

        # Also set options that the plugin uses simple color values for
        # (not embedded in format strings, so direct set works)
        cat >> "$OVERRIDE_SCRIPT" << SCRIPT_DIRECT
# Direct color overrides (no format-string embedding)
tmux set-option -gq display-panes-active-colour "#${TEXT_LC}"
tmux set-option -gq display-panes-colour "#${GOLD_LC}"
tmux set-window-option -gq clock-mode-colour "#${LOVE_LC}"
SCRIPT_DIRECT

        chmod +x "$OVERRIDE_SCRIPT"

        # --- Build the TMUX_THEME block ---
        # The run-shell call does the heavy lifting (format-string rewriting).
        # The set -g lines below act as a safety net for any options that
        # the plugin might set without embedding hex codes in format strings.
        TMUX_THEME_BLOCK="run-shell 'bash ${OVERRIDE_SCRIPT}'
set -g status-style \"fg=#${PINE_LC},bg=default\"
set -g message-style \"fg=#${MUTED_LC},bg=default\"
set -g message-command-style \"fg=#${BASE_LC},bg=#${GOLD_LC}\"
set -g pane-border-style \"fg=#${HL_HIGH_LC}\"
set -g pane-active-border-style \"fg=#${GOLD_LC}\"
set -g display-panes-active-colour \"#${TEXT_LC}\"
set -g display-panes-colour \"#${GOLD_LC}\"
set -g mode-style \"bg=#${HL_MED_LC},fg=#${TEXT_LC}\"
set -gw window-status-style \"fg=#${IRIS_LC},bg=default\"
set -gw window-status-current-style \"fg=#${GOLD_LC},bg=default\"
set -gw window-status-activity-style \"fg=#${ROSE_LC},bg=default\"
set -gw clock-mode-colour \"#${LOVE_LC}\""
    else
        TMUX_THEME_BLOCK="# (Populated by apply-theme.sh for non-rosé-pine themes)"
        # Clean up override script when switching back to built-in variant
        rm -f "$OVERRIDE_SCRIPT"
    fi
    replace_block "$TMUX_CONF" "# BEGIN_TMUX_THEME" "# END_TMUX_THEME" "$TMUX_THEME_BLOCK"
fi

# =====================================================================
# 12. Update palette .md reference with current variant
# =====================================================================
PALETTE_MD="$DOTFILES_DIR/theme/palettes/rosepine-palette.md"
WOODLAND_MD="$DOTFILES_DIR/theme/palettes/woodland-palette.md"
if [[ -f "$PALETTE_MD" ]]; then
    echo "  [+] theme/palettes/rosepine-palette.md"
    sed_replace "$PALETTE_MD" \
        '^# Rosé Pine .* — Color Palette Reference' \
        "# Rosé Pine $(echo "${VARIANT}" | sed 's/./\U&/') — Color Palette Reference"
fi

# =====================================================================
# Done — reload running programs
# =====================================================================
echo ""
echo "[OK] Theme '$VARIANT' applied to all configuration files."
echo ""

# --- i3 (reload config, then restart to fully refresh i3bar colors) ---
if command -v i3-msg &>/dev/null && i3-msg -t get_version &>/dev/null 2>&1; then
    i3-msg reload 2>/dev/null && echo "  [↻] i3 config reloaded"
    # i3-msg restart causes i3 to re-exec, which may drop the IPC connection
    # before returning.  Run it in the background after a short delay so the
    # bar fully reinitialises with the new colors.
    ( sleep 0.5 && i3-msg restart ) &>/dev/null &
    echo "  [↻] i3 restart scheduled"
    # Also refresh i3status so status indicators pick up new colors
    killall -SIGUSR1 i3status 2>/dev/null && echo "  [↻] i3status refreshed"
fi

# --- background (regenerate gradient wallpaper and apply with hsetroot) ---
: "${GRADIENT_CENTER:=$IRIS}"
WALLPAPER="${DOTFILES_DIR}/wallpapers/gradient.png"
if command -v convert &>/dev/null && command -v hsetroot &>/dev/null; then
    convert -size 5360x1440 \
        -define gradient:radii=2440,720 \
        -define gradient:angle=20 \
        radial-gradient:"#${GRADIENT_CENTER}"-"#${BASE}" \
        "$WALLPAPER" \
    && hsetroot -root -fill "$WALLPAPER" \
    && echo "  [↻] background wallpaper updated"
fi

# --- Hyprland (auto-reloads on config save — no action needed) ---

# --- dunst (restart notification daemon) ---
if command -v dunst &>/dev/null && pgrep -x dunst &>/dev/null; then
    pkill -x dunst
    nohup dunst -config "${DOTFILES_DIR}/dunst/dunstrc" &>/dev/null &
    disown
    echo "  [↻] dunst restarted"
fi

# --- waybar (restart status bar) ---
if command -v waybar &>/dev/null && pgrep -x waybar &>/dev/null; then
    pkill -x waybar
    nohup waybar &>/dev/null &
    disown
    echo "  [↻] waybar restarted"
fi

# --- kitty (send SIGUSR1 to reload config) ---
if pgrep -x kitty &>/dev/null; then
    pkill -USR1 -x kitty && echo "  [↻] kitty config reloaded"
fi

# --- tmux (source config if server is running) ---
if command -v tmux &>/dev/null && tmux list-sessions &>/dev/null 2>&1; then
    tmux source-file "${DOTFILES_DIR}/tmux/.tmux.conf" &>/dev/null && echo "  [↻] tmux config reloaded"
fi

echo ""
echo "Note: Neovim must be reloaded from within each session (:source \$MYVIMRC or restart)."
