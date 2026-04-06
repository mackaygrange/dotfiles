# Solarized Dark — Color Palette Reference

A precision-engineered color scheme with scientifically chosen color
relationships. Designed by Ethan Schoonover for maximum readability
with both dark and light backgrounds.

Official docs: <https://ethanschoonover.com/solarized/>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#002b36` | Primary background             |
| Surface         | `#073642` | Secondary background / panels  |
| Overlay         | `#1a4450` | Popups, tooltips, overlays     |
| Muted           | `#586e75` | Comments, inactive text        |
| Subtle          | `#839496` | Secondary text                 |
| Text            | `#fdf6e3` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#dc322f` | Errors, urgent, critical       |
| Gold            | `#b58900` | Warnings, highlights           |
| Rose            | `#cb4b16` | Strings, accents               |
| Pine            | `#268bd2` | Functions, links               |
| Foam            | `#2aa198` | Success, good status           |
| Iris            | `#6c71c4` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#073642` | Subtle selection / focus bg    |
| Highlight Med   | `#1a4450` | Active selection background    |
| Highlight High  | `#2b5561` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#002B36` |
| color1    | Love      | `#DC322F` |
| color2    | Foam      | `#2AA198` |
| color3    | Gold      | `#B58900` |
| color4    | Pine      | `#268BD2` |
| color5    | Iris      | `#6C71C4` |
| color6    | Rose      | `#CB4B16` |
| color7    | Text      | `#FDF6E3` |
| color8    | Muted     | `#586E75` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Pine  | `#268bd2` | Ocean blue glow                    |
| Edge     | Base  | `#002b36` | Fades into deep teal-black         |

```
radial-gradient:"#268bd2"-"#002b36"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Violet for language constructs         |
| Functions      | Pine   | Blue highlights callable items         |
| Strings        | Rose   | Orange for literal text                |
| Constants      | Gold   | Yellow draws attention to values       |
| Comments       | Muted  | Base01 gray recedes naturally          |
| Errors         | Love   | Bold red signals urgency               |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Cyan differentiates type annotations   |
| Operators      | Subtle | Base0 — present but not distracting    |
