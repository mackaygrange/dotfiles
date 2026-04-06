# Ayu Dark — Color Palette Reference

A simple, bright, and elegant theme with a warm-toned dark background.
Inspired by the Ayu colorscheme family, featuring precise accent colors
that provide clear semantic distinction without visual noise.

Official docs: <https://github.com/ayu-theme/ayu-colors>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#0d1017` | Primary background             |
| Surface         | `#131721` | Secondary background / panels  |
| Overlay         | `#1a1f29` | Popups, tooltips, overlays     |
| Muted           | `#636a72` | Comments, inactive text        |
| Subtle          | `#acb6bf` | Secondary text                 |
| Text            | `#bfbdb6` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#d95757` | Errors, urgent, critical       |
| Gold            | `#ffb454` | Warnings, highlights           |
| Rose            | `#f29668` | Strings, accents               |
| Pine            | `#59c2ff` | Functions, links               |
| Foam            | `#95e6cb` | Success, good status           |
| Iris            | `#d2a6ff` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#131721` | Subtle selection / focus bg    |
| Highlight Med   | `#1a1f29` | Active selection background    |
| Highlight High  | `#242936` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#0D1017` |
| color1    | Love      | `#D95757` |
| color2    | Foam      | `#7FD962` |
| color3    | Gold      | `#FFB454` |
| color4    | Pine      | `#59C2FF` |
| color5    | Iris      | `#D2A6FF` |
| color6    | Rose      | `#95E6CB` |
| color7    | Text      | `#BFBDB6` |
| color8    | Muted     | `#636A72` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#d2a6ff` | Soft violet glow                   |
| Edge     | Base  | `#0d1017` | Fades into deep midnight           |

```
radial-gradient:"#d2a6ff"-"#0d1017"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Violet for language constructs         |
| Functions      | Pine   | Bright blue for callable items         |
| Strings        | Rose   | Warm orange for literal text           |
| Constants      | Gold   | Amber draws attention to values        |
| Comments       | Muted  | Gray recedes into background           |
| Errors         | Love   | Red signals urgency                    |
| Warnings       | Gold   | Amber for caution                      |
| Types          | Foam   | Mint green differentiates types        |
| Operators      | Subtle | Light gray — present but subdued       |
