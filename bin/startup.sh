#!/bin/bash

# File:   startup.sh
# Author: Marco Plaitano
# Date:   09 Jan 2024
# Brief:  To be executed at system startup.


# Make sure that the script won't be executed more than once at a time.
_check_pid() {
    local PIDFILE
    PIDFILE="/tmp/$(basename "$0").pid"

    if [[ -f "$PIDFILE" ]]; then
        pid=$(cat "$PIDFILE")
        # Process found, script already running, do not execute this.
        ps -p "$pid" &>/dev/null && exit
    fi
    # Script wasn't running, write its pid.
    echo $$ > "$PIDFILE"
}


_check_pid

# Keypad numbers lock.
numlockx on

alacritty_opacity off &

cache_wallpapers &
cache_code_dirs &
cache_filesystem &

# Hide mouse when inactive.
unclutter & disown

plank & disown

sleep 2
night_mode &
