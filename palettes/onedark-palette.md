# One Dark — Color Palette Reference

The iconic dark theme from Atom editor, ported to every major tool.
Features a cool blue-gray background with vivid yet tasteful syntax
colors that have become a modern standard.

Official docs: <https://github.com/atom/one-dark-syntax>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#282c34` | Primary background             |
| Surface         | `#2c313c` | Secondary background / panels  |
| Overlay         | `#3e4451` | Popups, tooltips, overlays     |
| Muted           | `#5c6370` | Comments, inactive text        |
| Subtle          | `#828997` | Secondary text                 |
| Text            | `#abb2bf` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#e06c75` | Errors, urgent, critical       |
| Gold            | `#e5c07b` | Warnings, highlights           |
| Rose            | `#d19a66` | Strings, accents               |
| Pine            | `#61afef` | Functions, links               |
| Foam            | `#56b6c2` | Success, good status           |
| Iris            | `#c678dd` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#2c323c` | Subtle selection / focus bg    |
| Highlight Med   | `#3e4451` | Active selection background    |
| Highlight High  | `#4b5263` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#282C34` |
| color1    | Love      | `#E06C75` |
| color2    | Pine      | `#98C379` |
| color3    | Gold      | `#E5C07B` |
| color4    | Foam      | `#61AFEF` |
| color5    | Iris      | `#C678DD` |
| color6    | Rose      | `#56B6C2` |
| color7    | Text      | `#ABB2BF` |
| color8    | Muted     | `#5C6370` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#c678dd` | Rich purple glow                   |
| Edge     | Base  | `#282c34` | Fades into cool charcoal           |

```
radial-gradient:"#c678dd"-"#282c34"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Purple for language constructs         |
| Functions      | Pine   | Bright blue for callable items         |
| Strings        | Rose   | Warm brown-orange for literals         |
| Constants      | Gold   | Yellow draws attention to values       |
| Comments       | Muted  | Gray recedes naturally                 |
| Errors         | Love   | Coral-red signals urgency              |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Cyan differentiates type annotations   |
| Operators      | Subtle | Neutral gray, present but subdued      |
