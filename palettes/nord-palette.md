# Nord — Color Palette Reference

An arctic, north-bluish color palette inspired by the beauty of the polar
night. Clean and minimal with a cool, frost-based accent system.

Official docs: <https://www.nordtheme.com/>

## Base Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Base            | `#2e3440` | Primary background             |
| Surface         | `#3b4252` | Secondary background / panels  |
| Overlay         | `#434c5e` | Popups, tooltips, overlays     |
| Muted           | `#616e88` | Comments, inactive text        |
| Subtle          | `#d8dee9` | Secondary text                 |
| Text            | `#eceff4` | Primary foreground / text      |

## Accent Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Love            | `#bf616a` | Errors, urgent, critical       |
| Gold            | `#ebcb8b` | Warnings, highlights           |
| Rose            | `#d08770` | Strings, accents               |
| Pine            | `#81a1c1` | Functions, links               |
| Foam            | `#88c0d0` | Success, good status           |
| Iris            | `#b48ead` | Keywords, accents              |

## Highlight Colors

| Role            | Hex       | Usage                          |
|-----------------|-----------|--------------------------------|
| Highlight Low   | `#353b49` | Subtle selection / focus bg    |
| Highlight Med   | `#434c5e` | Active selection background    |
| Highlight High  | `#4c566a` | Prominent selection            |

## Terminal Mappings (kitty)

| ANSI Slot | Color     | Hex       |
|-----------|-----------|-----------|
| color0    | Base      | `#2E3440` |
| color1    | Love      | `#BF616A` |
| color2    | Pine      | `#A3BE8C` |
| color3    | Gold      | `#EBCB8B` |
| color4    | Foam      | `#81A1C1` |
| color5    | Iris      | `#B48EAD` |
| color6    | Rose      | `#88C0D0` |
| color7    | Text      | `#ECEFF4` |
| color8    | Muted     | `#616E88` |
| color9-15 | (repeat bright variants) |    |

## i3 Background Gradient

| Position | Role  | Hex       | Result                             |
|----------|-------|-----------|------------------------------------|
| Center   | Pine  | `#81a1c1` | Frost blue glow                    |
| Edge     | Base  | `#2e3440` | Fades into polar night             |

```
radial-gradient:"#81a1c1"-"#2e3440"
```

## Neovim Syntax Mapping

| Syntax Element | Color  | Rationale                              |
|----------------|--------|----------------------------------------|
| Keywords       | Iris   | Purple provides keyword distinction    |
| Functions      | Pine   | Frost blue for callable items          |
| Strings        | Rose   | Aurora orange for literal text         |
| Constants      | Gold   | Warm yellow highlights values          |
| Comments       | Muted  | Polar night gray recedes              |
| Errors         | Love   | Aurora red signals urgency             |
| Warnings       | Gold   | Yellow for caution                     |
| Types          | Foam   | Frost cyan differentiates types        |
| Operators      | Subtle | Snow storm — present but subdued       |
