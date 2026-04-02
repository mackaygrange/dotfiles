# Gruvbox Dark — Color Palette Reference

A retro groove color scheme with warm, earthy tones. Designed for
pleasant coding with high readability, inspired by old terminal aesthetics
and vintage color palettes.

Official docs: <https://github.com/morhetz/gruvbox>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#282828` | Primary background             |
| Surface         | `#3c3836` | Secondary background / panels  |
| Overlay         | `#504945` | Popups, tooltips, overlays     |
| Muted           | `#928374` | Comments, inactive text        |
| Subtle          | `#a89984` | Secondary text                 |
| Text            | `#ebdbb2` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#fb4934` | Errors, urgent, critical       |
| Gold            | `#fabd2f` | Warnings, highlights           |
| Rose            | `#fe8019` | Strings, accents               |
| Pine            | `#b8bb26` | Functions, links               |
| Foam            | `#8ec07c` | Success, good status           |
| Iris            | `#d3869b` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#32302f` | Subtle selection / focus bg    |
| Highlight Med   | `#504945` | Active selection background    |
| Highlight High  | `#665c54` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#282828` |
| color1    | Love      | `#FB4934` |
| color2    | Pine      | `#B8BB26` |
| color3    | Gold      | `#FABD2F` |
| color4    | Foam      | `#83A598` |
| color5    | Iris      | `#D3869B` |
| color6    | Rose      | `#8EC07C` |
| color7    | Text      | `#EBDBB2` |
| color8    | Muted     | `#928374` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#d3869b` | Warm mauve glow                    |
| Edge     | Base  | `#282828` | Fades into deep charcoal           |

```
radial-gradient:"#d3869b"-"#282828"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Mauve stands out from warm palette     |
| Functions      | Pine   | Yellow-green for callable items        |
| Strings        | Rose   | Bright orange for literal text         |
| Constants      | Gold   | Warm yellow draws the eye              |
| Comments       | Muted  | Gray recedes into background           |
| Errors         | Love   | Bold red signals urgency               |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Aqua differentiates type annotations   |
| Operators      | Subtle | Warm gray, present but subdued         |
