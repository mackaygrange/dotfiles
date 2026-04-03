# Catppuccin Mocha — Color Palette Reference

A soothing pastel theme with warm, low-contrast colors. Catppuccin Mocha is the
darkest variant — designed to be easy on the eyes during extended coding sessions
while providing clear syntax distinction through a pastel accent palette.

Official docs: <https://catppuccin.com/>

## Design Principles

- **Pastel accent palette**: Soft, desaturated colors reduce eye strain while
  maintaining excellent semantic separation.
- **Warm undertone base**: The dark base uses warm blue-gray instead of pure
  black, creating a comfortable reading surface.
- **WCAG AA contrast**: All accent colors achieve ≥3:1 against Base; text
  colors achieve ≥4.5:1.

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#1e1e2e` | Primary background             |
| Surface         | `#313244` | Secondary background / panels  |
| Overlay         | `#45475a` | Popups, tooltips, overlays     |
| Muted           | `#6c7086` | Comments, inactive text        |
| Subtle          | `#a6adc8` | Secondary text                 |
| Text            | `#cdd6f4` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#f38ba8` | Errors, urgent, critical       |
| Gold            | `#f9e2af` | Warnings, highlights           |
| Rose            | `#fab387` | Strings, accents               |
| Pine            | `#89b4fa` | Functions, links               |
| Foam            | `#94e2d5` | Success, good status           |
| Iris            | `#cba6f7` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#2a2b3d` | Subtle selection / focus bg    |
| Highlight Med   | `#3b3c50` | Active selection background    |
| Highlight High  | `#4c4d63` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#1E1E2E` |
| color1    | Love      | `#F38BA8` |
| color2    | Foam      | `#94E2D5` |
| color3    | Gold      | `#F9E2AF` |
| color4    | Pine      | `#89B4FA` |
| color5    | Iris      | `#CBA6F7` |
| color6    | Rose      | `#FAB387` |
| color7    | Text      | `#CDD6F4` |
| color8    | Muted     | `#6C7086` |
| color9–15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#cba6f7` | Soft lavender glow                 |
| Edge     | Base  | `#1e1e2e` | Fades into warm dark blue-gray     |

```
radial-gradient:"#cba6f7"-"#1e1e2e"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Mauve/lavender stands out clearly      |
| Functions      | Pine   | Blue draws attention to call sites     |
| Strings        | Rose   | Warm peach reads naturally             |
| Constants      | Gold   | Yellow highlights literal values       |
| Comments       | Muted  | Overlay gray fades into background     |
| Errors         | Love   | Pink-red signals urgency               |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Teal differentiates from blue          |
| Operators      | Subtle | Subtext — present but not distracting  |

## Contrast Ratios (against Base `#1e1e2e`)

| Color   | Ratio  | AA Normal | AA Large |
|---------|--------|-----------|----------|
| Text    | 11.07  | ✓ Pass    | ✓ Pass   |
| Subtle  |  7.45  | ✓ Pass    | ✓ Pass   |
| Muted   |  4.05  | —         | ✓ Pass   |
| Love    |  5.87  | ✓ Pass    | ✓ Pass   |
| Gold    | 10.85  | ✓ Pass    | ✓ Pass   |
| Rose    |  8.02  | ✓ Pass    | ✓ Pass   |
| Pine    |  6.96  | ✓ Pass    | ✓ Pass   |
| Foam    |  8.87  | ✓ Pass    | ✓ Pass   |
| Iris    |  6.06  | ✓ Pass    | ✓ Pass   |
