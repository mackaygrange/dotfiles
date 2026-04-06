# Dracula — Color Palette Reference

A dark theme with vibrant neon accents inspired by the classic Dracula color
scheme. High contrast with a purple-tinted background for comfortable
night-time coding.

Official docs: <https://draculatheme.com/>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#282a36` | Primary background             |
| Surface         | `#343746` | Secondary background / panels  |
| Overlay         | `#44475a` | Popups, tooltips, overlays     |
| Muted           | `#6272a4` | Comments, inactive text        |
| Subtle          | `#7e8ab6` | Secondary text                 |
| Text            | `#f8f8f2` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#ff5555` | Errors, urgent, critical       |
| Gold            | `#f1fa8c` | Warnings, highlights           |
| Rose            | `#ffb86c` | Strings, accents               |
| Pine            | `#50fa7b` | Functions, links               |
| Foam            | `#8be9fd` | Success, good status           |
| Iris            | `#bd93f9` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#2e3041` | Subtle selection / focus bg    |
| Highlight Med   | `#44475a` | Active selection background    |
| Highlight High  | `#5a5e73` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#282A36` |
| color1    | Love      | `#FF5555` |
| color2    | Pine      | `#50FA7B` |
| color3    | Gold      | `#F1FA8C` |
| color4    | Iris      | `#BD93F9` |
| color5    | Love (bright) | `#FF79C6` |
| color6    | Foam      | `#8BE9FD` |
| color7    | Text      | `#F8F8F2` |
| color8    | Muted     | `#6272A4` |
| color9–15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Iris  | `#bd93f9` | Purple neon glow                   |
| Edge     | Base  | `#282a36` | Fades into dark charcoal           |

```
radial-gradient:"#bd93f9"-"#282a36"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Vibrant purple for language constructs |
| Functions      | Pine   | Neon green pops against dark base      |
| Strings        | Rose   | Warm orange for literal text           |
| Constants      | Gold   | Bright yellow draws attention          |
| Comments       | Muted  | Slate blue recedes into background     |
| Errors         | Love   | Bright red for urgency                 |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Cyan differentiates type annotations   |
| Operators      | Subtle | Subdued but legible                    |
