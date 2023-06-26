#!/bin/bash

sudo mkdir -p /usr/share/fonts/opentype/sfmono
sudo cp SFMono/*.*tf /usr/share/fonts/opentype/sfmono/

sudo mkdir -p /usr/share/fonts/truetype/UbuntuNerd
sudo cp UbuntuNerd/*.*tf /usr/share/fonts/truetype/UbuntuNerd

sudo fc-cache -f -v > /dev/null
