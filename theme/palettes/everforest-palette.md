# Everforest — Color Palette Reference

A green-based dark theme designed for comfortable, forest-inspired coding.
Soft, warm greens dominate the palette with carefully chosen contrast to
reduce eye strain during long sessions.

Official docs: <https://github.com/sainnhe/everforest>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#2d353b` | Primary background             |
| Surface         | `#343f44` | Secondary background / panels  |
| Overlay         | `#3d484d` | Popups, tooltips, overlays     |
| Muted           | `#859289` | Comments, inactive text        |
| Subtle          | `#9da9a0` | Secondary text                 |
| Text            | `#d3c6aa` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#e67e80` | Errors, urgent, critical       |
| Gold            | `#dbbc7f` | Warnings, highlights           |
| Rose            | `#e69875` | Strings, accents               |
| Pine            | `#a7c080` | Functions, links               |
| Foam            | `#83c092` | Success, good status           |
| Iris            | `#d699b6` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#343f44` | Subtle selection / focus bg    |
| Highlight Med   | `#3d484d` | Active selection background    |
| Highlight High  | `#475258` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#2D353B` |
| color1    | Love      | `#E67E80` |
| color2    | Pine      | `#A7C080` |
| color3    | Gold      | `#DBBC7F` |
| color4    | Foam      | `#7FBBB3` |
| color5    | Iris      | `#D699B6` |
| color6    | Rose      | `#83C092` |
| color7    | Text      | `#D3C6AA` |
| color8    | Muted     | `#859289` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Pine  | `#a7c080` | Soft forest canopy glow            |
| Edge     | Base  | `#2d353b` | Fades into deep woodland shadow    |

```
radial-gradient:"#a7c080"-"#2d353b"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Soft purple for language constructs    |
| Functions      | Pine   | Forest green for callable items        |
| Strings        | Rose   | Warm orange for literal text           |
| Constants      | Gold   | Amber draws the eye to values          |
| Comments       | Muted  | Gray-green recedes into background     |
| Errors         | Love   | Soft red signals urgency               |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Aqua green differentiates types        |
| Operators      | Subtle | Muted sage — present but subdued       |
