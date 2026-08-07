#!/usr/bin/env bash

W=1920; H=1080

# 1. Radial base
convert -size ${W}x${H} radial-gradient:"#0d0221"-"#4b0082" base_radial.png

# 2. Plasma layer
convert -size ${W}x${H} plasma:"#ff6ec7"-"#00c9ff" -blur 0x8 plasma_layer.png

# 3. Diamond grid tile
convert -size 40x40 xc:none \
  -fill none -stroke white -strokewidth 1 \
  -draw "polygon 20,2 38,20 20,38 2,20" diamond_tile.png

convert -size ${W}x${H} tile:diamond_tile.png \
  -alpha set -channel A -evaluate set 15% +channel diamond_grid.png

# 4. Concentric rings
convert -size ${W}x${H} xc:black \
  -fx "sin((hypot(i-960, j-540) / 30) * 2 * pi) * 0.5 + 0.5" \
  rings_raw.png

# 5. Stars
convert -size ${W}x${H} xc:none \
  -fx "rand() < 0.0002 ? 1 : 0" -blur 0x1 stars.png

# 6. Final composite
convert base_radial.png \
  \( plasma_layer.png   -evaluate Multiply 0.45 \) -compose Screen    -composite \
  \( rings_raw.png      -evaluate Multiply 0.25 \) -compose Overlay   -composite \
  \( diamond_grid.png                             \) -compose Over     -composite \
  \( stars.png          -level 0,100%            \) -compose Screen    -composite \
  -modulate 100,130,100 \
  -sharpen 0x0.5 \
  final_background.png

echo "Done → final_background.png"
