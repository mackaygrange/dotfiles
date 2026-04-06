# GitHub Dark — Color Palette Reference

The official dark theme from GitHub, designed for code review and
long reading sessions. Clean, professional, and highly legible with
carefully balanced blues and neutral backgrounds.

Inspired by: <https://github.com/primer/github-vscode-theme>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#0d1117` | Primary background             |
| Surface         | `#161b22` | Secondary background / panels  |
| Overlay         | `#21262d` | Popups, tooltips, overlays     |
| Muted           | `#8b949e` | Comments, inactive text        |
| Subtle          | `#b1bac4` | Secondary text                 |
| Text            | `#e6edf3` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#f85149` | Errors, urgent, critical       |
| Gold            | `#e3b341` | Warnings, highlights           |
| Rose            | `#ffa657` | Strings, accents               |
| Pine            | `#79c0ff` | Functions, links               |
| Foam            | `#56d364` | Success, good status           |
| Iris            | `#d2a8ff` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#161b22` | Subtle selection / focus bg    |
| Highlight Med   | `#21262d` | Active selection background    |
| Highlight High  | `#30363d` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#0D1117` |
| color1    | Love      | `#F85149` |
| color2    | Foam      | `#56D364` |
| color3    | Gold      | `#E3B341` |
| color4    | Pine      | `#79C0FF` |
| color5    | Iris      | `#D2A8FF` |
| color6    | Rose      | `#FFA657` |
| color7    | Text      | `#E6EDF3` |
| color8    | Muted     | `#8B949E` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Pine  | `#79c0ff` | Soft sky-blue glow                 |
| Edge     | Base  | `#0d1117` | Fades into deep GitHub dark        |

```
radial-gradient:"#79c0ff"-"#0d1117"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Lavender for language constructs       |
| Functions      | Pine   | Bright blue for callable items         |
| Strings        | Rose   | Warm orange for literal text           |
| Constants      | Gold   | Yellow draws attention to values       |
| Comments       | Muted  | Gray recedes into dark background      |
| Errors         | Love   | Coral-red signals urgency              |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Green differentiates type annotations  |
| Operators      | Subtle | Light gray — present but subdued       |
