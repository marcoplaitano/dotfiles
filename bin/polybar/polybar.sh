#!/bin/bash

# File:   polybar
# Author: Marco Plaitano
# Date:   11 Aug 2022
# Brief:  Start a new instance of polybar.


# Terminate already running panel instances.
kill_process panel


config_file="$HOME/.config/polybar/config.ini"

polybar topbar -q -r --config="$config_file" 2>&1 & disown

# polybar_tray
