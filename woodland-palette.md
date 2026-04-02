# Woodland — Color Palette Reference

A custom earthy colorscheme built with color theory for terminal and code
editing environments. Designed around dark forest greens, warm browns, and
organic reds — like a walk through old-growth woodland at dusk.

## Design Principles

- **Analogous harmony**: Browns and greens sit adjacent on the color wheel,
  creating a naturally cohesive base that feels organic and restful.
- **Split-complementary accents**: Forest green's complements (red-orange,
  red-violet) provide error/warning colors that pop without clashing.
- **WCAG AA contrast**: All accent colors achieve ≥3:1 against both Base
  and Overlay backgrounds; text colors achieve ≥4.5:1 against Base.

## Base Colors

| Role            | Hex       | Usage                          | Inspiration        |
|-----------------|-----------|--------------------------------|--------------------|
| Base            | `#1a1714` | Primary background             | Forest floor soil  |
| Surface         | `#241f1b` | Secondary background / panels  | Dark tree bark     |
| Overlay         | `#332c25` | Popups, tooltips, overlays     | Dried autumn leaves|
| Muted           | `#7a6e60` | Comments, inactive text        | Weathered driftwood|
| Subtle          | `#8c7f6f` | Secondary text                 | Sandstone          |
| Text            | `#ddd5c8` | Primary foreground / text      | Birch bark         |

## Accent Colors

| Role            | Hex       | Usage                          | Inspiration        |
|-----------------|-----------|--------------------------------|--------------------|
| Love            | `#d45555` | Errors, urgent, critical       | Iron oxide / clay  |
| Gold            | `#c8943a` | Warnings, highlights           | Raw amber / honey  |
| Rose            | `#b87848` | Strings, accents               | Terracotta / sienna|
| Pine            | `#48946a` | Functions, links               | Dark forest canopy |
| Foam            | `#5ea07a` | Success, good status           | Sage moss          |
| Iris            | `#9775b8` | Keywords, accents              | Woodland wildflower|

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#262019` | Subtle selection / focus bg    |
| Highlight Med   | `#3d3429` | Active selection background    |
| Highlight High  | `#50463a` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#1A1714` |
| color1    | Love      | `#D45555` |
| color2    | Foam      | `#5EA07A` |
| color3    | Gold      | `#C8943A` |
| color4    | Pine      | `#48946A` |
| color5    | Iris      | `#9775B8` |
| color6    | Rose      | `#B87848` |
| color7    | Text      | `#DDD5C8` |
| color8    | Muted     | `#7A6E60` |
| color9–15 | (repeat bright variants) |    |

## i3 Background Gradient

The i3 config generates a radial gradient wallpaper using ImageMagick.
`apply-theme.sh` maps the gradient center to **Iris** and the edge to **Base**.

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#9775b8` | Soft purple wildflower glow        |
| Edge     | Base  | `#1a1714` | Fades into deep forest-floor brown |

```
radial-gradient:"#9775b8"-"#1a1714"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Purple stands out from the warm base   |
| Functions      | Pine   | Forest green — the hero accent color   |
| Strings        | Rose   | Warm terracotta reads naturally         |
| Constants      | Gold   | Amber draws the eye to literal values  |
| Comments       | Muted  | Weathered wood fades into background   |
| Errors         | Love   | Iron oxide red signals urgency         |
| Warnings       | Gold   | Amber for caution                      |
| Types          | Foam   | Sage green differentiates from Pine    |
| Operators      | Subtle | Sandstone — present but not distracting|

## Contrast Ratios (against Base `#1a1714`)

| Color   | Ratio  | AA Normal | AA Large |
|---------|--------|-----------|----------|
| Text    | 12.26  | ✓ Pass    | ✓ Pass   |
| Subtle  |  4.57  | ✓ Pass    | ✓ Pass   |
| Muted   |  3.59  | —         | ✓ Pass   |
| Love    |  4.45  | —         | ✓ Pass   |
| Gold    |  6.59  | ✓ Pass    | ✓ Pass   |
| Rose    |  4.95  | ✓ Pass    | ✓ Pass   |
| Pine    |  4.86  | ✓ Pass    | ✓ Pass   |
| Foam    |  5.77  | ✓ Pass    | ✓ Pass   |
| Iris    |  4.72  | ✓ Pass    | ✓ Pass   |
