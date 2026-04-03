# Monokai Pro — Color Palette Reference

The iconic Monokai colorscheme refined for modern editors. Rich, saturated
accent colors against a warm dark background — the quintessential "coder"
palette that has defined syntax highlighting for over a decade.

Inspired by: <https://monokai.pro/>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#2d2a2e` | Primary background             |
| Surface         | `#373438` | Secondary background / panels  |
| Overlay         | `#403e41` | Popups, tooltips, overlays     |
| Muted           | `#727072` | Comments, inactive text        |
| Subtle          | `#939293` | Secondary text                 |
| Text            | `#fcfcfa` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#ff6188` | Errors, urgent, critical       |
| Gold            | `#ffd866` | Warnings, highlights           |
| Rose            | `#fc9867` | Strings, accents               |
| Pine            | `#a9dc76` | Functions, links               |
| Foam            | `#78dce8` | Success, good status           |
| Iris            | `#ab9df2` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#353236` | Subtle selection / focus bg    |
| Highlight Med   | `#403e41` | Active selection background    |
| Highlight High  | `#4e4c4f` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#2D2A2E` |
| color1    | Love      | `#FF6188` |
| color2    | Pine      | `#A9DC76` |
| color3    | Gold      | `#FFD866` |
| color4    | Foam      | `#78DCE8` |
| color5    | Iris      | `#AB9DF2` |
| color6    | Rose      | `#FC9867` |
| color7    | Text      | `#FCFCFA` |
| color8    | Muted     | `#727072` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#ab9df2` | Soft purple glow                   |
| Edge     | Base  | `#2d2a2e` | Fades into warm charcoal           |

```
radial-gradient:"#ab9df2"-"#2d2a2e"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Purple for language constructs         |
| Functions      | Pine   | Green for callable items               |
| Strings        | Rose   | Warm orange for literal text           |
| Constants      | Gold   | Bright yellow draws attention          |
| Comments       | Muted  | Gray recedes naturally                 |
| Errors         | Love   | Hot pink signals urgency               |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Cyan differentiates type annotations   |
| Operators      | Subtle | Neutral gray — present but subdued     |
