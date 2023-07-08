#!/bin/bash

walcolors_file="$HOME/.cache/wal/colors.sh"
source $walcolors_file

# Determine whether accent color is light or dark so that foreground
# color can be chosen accordingly.
is_color1_light=$(cat <<EOF
from math import sqrt
c = "$color1"
r,g,b = tuple(int(c.lstrip('#')[i:i+2], 16) for i in (0,2,4))
hsp = sqrt(0.299 * r*r + 0.587 * g*g + 0.114 * b*b)
print("light") if hsp > 121.5 else print("dark")
EOF
)
if [[ $(python -c "$is_color1_light") == light ]]; then
    foreground="$color0"
else
    foreground="$color15"
fi

# Normal colors (background, foreground).
nb="$color0"
nf="$color15"
# Selected colors (background, foreground).
sb="$color1"
sf="$foreground"
# Fuzzy Normal Highlight colors (background, foreground).
nhb="$color0"
nhf="$color15"
# Fuzzy Selected Highlight colors (background, foreground).
shb="$color1"
shf="$foreground"
