# Synthwave '84 — Color Palette Reference

A neon-soaked retro-futuristic theme inspired by 1980s synthwave aesthetics.
Electric pinks, hot cyans, and deep purples against a dark midnight
background, evoking VHS tape covers and arcade cabinets.

Inspired by: <https://github.com/robb0wen/synthwave-vscode>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#262335` | Primary background             |
| Surface         | `#2e2a3e` | Secondary background / panels  |
| Overlay         | `#3b3654` | Popups, tooltips, overlays     |
| Muted           | `#6c6783` | Comments, inactive text        |
| Subtle          | `#848bbd` | Secondary text                 |
| Text            | `#e0d9f5` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#fe4450` | Errors, urgent, critical       |
| Gold            | `#fede5d` | Warnings, highlights           |
| Rose            | `#ff7edb` | Strings, accents               |
| Pine            | `#36f9f6` | Functions, links               |
| Foam            | `#72f1b8` | Success, good status           |
| Iris            | `#b893ce` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#2e2a3e` | Subtle selection / focus bg    |
| Highlight Med   | `#3f3a56` | Active selection background    |
| Highlight High  | `#504a6e` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#262335` |
| color1    | Love      | `#FE4450` |
| color2    | Foam      | `#72F1B8` |
| color3    | Gold      | `#FEDE5D` |
| color4    | Pine      | `#36F9F6` |
| color5    | Iris      | `#B893CE` |
| color6    | Rose      | `#FF7EDB` |
| color7    | Text      | `#E0D9F5` |
| color8    | Muted     | `#6C6783` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Rose  | `#ff7edb` | Hot neon pink glow                 |
| Edge     | Base  | `#262335` | Fades into deep midnight purple    |

```
radial-gradient:"#ff7edb"-"#262335"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Neon purple for language constructs    |
| Functions      | Pine   | Electric cyan for callable items       |
| Strings        | Rose   | Hot pink for literal text              |
| Constants      | Gold   | Bright yellow draws the eye            |
| Comments       | Muted  | Dark purple recedes into background    |
| Errors         | Love   | Neon red signals urgency               |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Neon green differentiates types        |
| Operators      | Subtle | Muted lavender — present but subdued   |
