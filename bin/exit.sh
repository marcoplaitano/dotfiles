#!/bin/bash

# File:   exit.sh
# Author: Marco Plaitano
# Date:   18 Feb 2023
# Brief:  Execute an exit command for a xfce4 desktop session.


_die() {
    [[ -n $1 ]] && error_msg="$1" || error_msg="Error in $(basename "$0")."
    if [[ $TERM != dumb ]]; then
        echo "$error_msg" >&2
    else
        notify-send "Error in $(basename "$0")" "$error_msg"
    fi
    exit 1
}

_help() {
    printf "Usage: $(basename "$0") --CMD
Logout from current xfce4 desktop session executing the command given.

-h, --help      Show this guide and exit.
--suspend
--logout
--hibernate
--poweroff      Perform shutdown routine and poweroff.
--reboot        Perform shutdown routine and reboot. Ask for confirmation first.
"
}

# Ask to specify a command via dmenu.
_ask_action() {
    declare -A menu=(
      [  Shutdown]="_shutdown_routine poweroff"
      [  Reboot]="_shutdown_routine reboot"
      [  Suspend]="_suspend"
      [  Lock]="_lock"
      [  Logout]="_logout"
    )
    options="$(printf "%s\n" "${!menu[@]}")"
    choice="$(ask_dmenu -F -l "$options")"
    choice="${choice##*' '}" # remove icon and spaces
    cmd="${choice,,}"      # make it lowercase
}

# Choose script function to execute based on the command received.
_perform_action() {
    case $1 in
        -h | --help)
            _help ; exit ;;
        --lock | --logout | --suspend | --hibernate)
            _${1#*--} ;;
        --poweroff | --reboot)
            _shutdown_routine ${1#*--} ;;
        *)
            _die "Argument '$1' not recognized." ;;
    esac
}

# Ask whether to confirm the action (reboot).
_ask_confirmation() {
    if [[ $TERM != dumb ]]; then
        ans=$(ask_fzf -p "confirm?" -l "yes no")
    else
        ans=$(ask_dmenu -p "confirm?" -l "yes\nno")
    fi
    if [[ -z $ans ]]; then
        return 1
    else
        case "${ans,,}" in
            y | yes) return ;;
            *)       return 1 ;;
        esac
    fi
}

_logout() {
    if pgrep i3 &>/dev/null; then
        i3-msg exit
    else
        xfce4-session-logout --logout --fast
    fi
}

_lock() {
    betterlockscreen -l blur
}

_suspend() {
    systemctl suspend
}

# Steps to perform before shutting down the machine.
_shutdown_routine() {
    # If the action si reboot ask for confirmation.
    if [[ "$1" == reboot ]]; then
        _ask_confirmation || exit
    fi

    for vm in $(find $HOME/.local/VMs -mindepth 1 -maxdepth 1 -type d 2>/dev/null \
                | awk -F "/" '{print $NF}')
    do
        vboxmanage controlvm "$vm" poweroff --type headless
    done
    docker stop $(docker ps -q)
    night_mode --off
    kill_process firefox lofi music panel plank pomodoro reminder \
                 songrec spotify teams telegram
    # Argument is the command to execute, either 'poweroff' or 'reboot'.
    systemctl "$1"
}


# Ask for a command if none has been given.
cmd="$1"
if [[ -z $cmd ]]; then
    _ask_action
    [[ -z $cmd ]] && exit
    cmd=--"$cmd" # Add leading -- to make it look like a command line argument
fi

_perform_action "$cmd"
