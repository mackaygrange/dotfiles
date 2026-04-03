# Kanagawa — Color Palette Reference

A dark colorscheme inspired by the famous painting "The Great Wave off
Kanagawa" by Katsushika Hokusai. Rich, muted colors with an ink-wash
aesthetic reflecting traditional Japanese art.

Official docs: <https://github.com/rebelot/kanagawa.nvim>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#1f1f28` | Primary background             |
| Surface         | `#2a2a37` | Secondary background / panels  |
| Overlay         | `#363646` | Popups, tooltips, overlays     |
| Muted           | `#727169` | Comments, inactive text        |
| Subtle          | `#c8c093` | Secondary text                 |
| Text            | `#dcd7ba` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#c34043` | Errors, urgent, critical       |
| Gold            | `#c0a36e` | Warnings, highlights           |
| Rose            | `#d27e99` | Strings, accents               |
| Pine            | `#7e9cd8` | Functions, links               |
| Foam            | `#6a9589` | Success, good status           |
| Iris            | `#957fb8` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#2a2a37` | Subtle selection / focus bg    |
| Highlight Med   | `#363646` | Active selection background    |
| Highlight High  | `#49443c` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#1F1F28` |
| color1    | Love      | `#C34043` |
| color2    | Foam      | `#76946A` |
| color3    | Gold      | `#C0A36E` |
| color4    | Pine      | `#7E9CD8` |
| color5    | Iris      | `#957FB8` |
| color6    | Rose      | `#6A9589` |
| color7    | Text      | `#DCD7BA` |
| color8    | Muted     | `#727169` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Pine  | `#7e9cd8` | Great wave blue glow               |
| Edge     | Base  | `#1f1f28` | Fades into ink-wash darkness        |

```
radial-gradient:"#7e9cd8"-"#1f1f28"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Onimurasaki (purple) for constructs    |
| Functions      | Pine   | Wave blue for callable items           |
| Strings        | Rose   | Sakura pink for literal text           |
| Constants      | Gold   | Warm gold draws the eye               |
| Comments       | Muted  | Fuji gray recedes into background      |
| Errors         | Love   | Vermillion red signals urgency         |
| Warnings       | Gold   | Amber for caution                      |
| Types          | Foam   | Spring green differentiates types      |
| Operators      | Subtle | Old linen — present but subdued        |
