# Tokyo Night — Color Palette Reference

Inspired by the vibrant lights of downtown Tokyo at night. A clean dark
theme featuring cool blues and soft purples against a deep midnight
background.

Official docs: <https://github.com/folke/tokyonight.nvim>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#1a1b26` | Primary background             |
| Surface         | `#24283b` | Secondary background / panels  |
| Overlay         | `#414868` | Popups, tooltips, overlays     |
| Muted           | `#565f89` | Comments, inactive text        |
| Subtle          | `#a9b1d6` | Secondary text                 |
| Text            | `#c0caf5` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#f7768e` | Errors, urgent, critical       |
| Gold            | `#e0af68` | Warnings, highlights           |
| Rose            | `#ff9e64` | Strings, accents               |
| Pine            | `#7aa2f7` | Functions, links               |
| Foam            | `#73daca` | Success, good status           |
| Iris            | `#bb9af7` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#222436` | Subtle selection / focus bg    |
| Highlight Med   | `#2f334d` | Active selection background    |
| Highlight High  | `#3d4264` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#1A1B26` |
| color1    | Love      | `#F7768E` |
| color2    | Foam      | `#73DACA` |
| color3    | Gold      | `#E0AF68` |
| color4    | Pine      | `#7AA2F7` |
| color5    | Iris      | `#BB9AF7` |
| color6    | Rose      | `#FF9E64` |
| color7    | Text      | `#C0CAF5` |
| color8    | Muted     | `#565F89` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#bb9af7` | Neon purple glow                   |
| Edge     | Base  | `#1a1b26` | Fades into midnight blue           |

```
radial-gradient:"#bb9af7"-"#1a1b26"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Purple neon for language constructs    |
| Functions      | Pine   | Electric blue for callable items       |
| Strings        | Rose   | Warm orange for literal text           |
| Constants      | Gold   | Amber draws attention to values        |
| Comments       | Muted  | Dark slate recedes into background     |
| Errors         | Love   | Coral-red signals urgency              |
| Warnings       | Gold   | Amber for caution                      |
| Types          | Foam   | Teal green differentiates types        |
| Operators      | Subtle | Lavender-gray — present but subdued    |
