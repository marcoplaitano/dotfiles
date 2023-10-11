#!/bin/bash

# File:   polybar
# Author: Marco Plaitano
# Date:   11 Aug 2022
# Brief:  Start a new instance of polybar.


_config_file="$HOME/.config/polybar/config.ini"
if [[ ! -r "$_config_file" ]]; then
    echo "Theme file '$_config_file' not found." >&2
    exit 1
fi

# Terminate already running panel instances.
kill_process panel

polybar topbar -q -r --config="$_config_file" 2>&1 & disown
# polybar_tray
