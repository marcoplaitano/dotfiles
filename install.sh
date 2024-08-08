#!/bin/bash

# File:   install.sh
# Author: Marco Plaitano
# Date:   14 Apr 2022
# Brief:  Set up (all) the dotfiles of this git repository.

# Enable xtracing (redirected to this log file).
LOGFILE="/var/tmp/installation.log"
exec {BASH_XTRACEFD}>>$LOGFILE
PS4='$?\011 $(date +%H:%M:%S.%3N)  $BASH_SOURCE@$LINENO   \011'
set -x

# Prepare config directory.
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:="$HOME/.config"}"
if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
    echo "Creating config folder '$XDG_CONFIG_HOME'."
    mkdir -p "$XDG_CONFIG_HOME"
fi

# Associate files/dirs in this 'dotfiles' repository with the correspondent
# files and dirs found across the system.
declare -A repo_files=(
    ["alacritty"]="$XDG_CONFIG_HOME/alacritty"
    ["bat"]="$XDG_CONFIG_HOME/bat"
    ["git"]="$XDG_CONFIG_HOME/git"
    ["gnupg"]="$XDG_CONFIG_HOME/gnupg"
    ["helix"]="$XDG_CONFIG_HOME/helix"
    ["i3"]="$XDG_CONFIG_HOME/i3"
    ["nvim"]="$XDG_CONFIG_HOME/nvim"
    ["picom"]="$XDG_CONFIG_HOME/picom"
    ["polybar"]="$XDG_CONFIG_HOME/polybar"
    ["_other/colors/polybar/default.ini"]="$XDG_CONFIG_HOME/user/polybar_theme.ini"
    ["python"]="$XDG_CONFIG_HOME/python"
    ["redshift"]="$XDG_CONFIG_HOME/redshift"
    ["shell"]="$XDG_CONFIG_HOME/shell"
    ["shell/bashrc"]="$HOME/.bashrc"
    ["shell/inputrc"]="$HOME/.inputrc"
    ["shell/profile"]="$HOME/.profile"
    ["shell/zshenv"]="$HOME/.zshenv"
    ["shell/zshrc"]="$XDG_CONFIG_HOME/shell/.zshrc"
    ["tmux"]="$XDG_CONFIG_HOME/tmux"
    ["vim"]="$HOME/.vim"
    ["xfce4/xfce4-keyboard-shortcuts.xml"]="$XDG_CONFIG_HOME/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
    ["xfce4/terminal_colorschemes"]="/usr/share/xfce4/terminal/colorschemes"
    ["xfce4/terminalrc"]="$XDG_CONFIG_HOME/xfce4/terminal/terminalrc"
)

# Sort repo files in alphabetical order.
sorted_repo_files=( $(echo ${!repo_files[@]} | tr ' ' $'\n' | sort) )


_safe_exit() {
    popd &>/dev/null || true
}
trap _safe_exit EXIT

_print_ok() {
    printf "\e[1;32m✓\e[0m\n"
}
_print_err() {
    printf "\e[1;31m✗ \e[0m%s\n" "$1"
}

_die() {
    [[ -n $1 ]] && echo "$1" >&2
    exit 1
}

_help() {
    printf "Usage: %s [FILE]... [OPTION]
Install dotfiles from this repository onto the machine by using symlinks.

-h, --help          Show this guide and exit
-l, --list          List all config files/dirs that can be installed
-a, --all           Install everything. (default)
FILE                Config file/directory to install
autostart           Install autostart applications
configs             Install config files
cronjobs            Install cronjobs
fonts               Install fonts
sounds              Install sounds\n" "$(basename "$0")"
}

# Create symlink from source $1 to destination $2.
# Ask whether to overwrite (delete + write) destination, if it already exists.
_copy() {
    printf "===== %s " "$2"
    if [[ -e "$2" ]]; then
        unset ans
        while [[ -z $ans ]]; do
            read -rp "Replace? " ans
            case "${ans,,}" in
                y|yes|s|si) rm -r "$2" ;;
                n|no) return ;;
                *) unset ans ;;
            esac
        done
    fi
    if ln -fs "$1" "$2" &>/dev/null
    then _print_ok
    else _print_err "Couldn't link to $2"
    fi
}

# List all files that can be installed.
_list() {
    for repo_file in "${sorted_repo_files[@]}"; do
        echo "$repo_file"
    done
    printf "\nSee '%s -h' for info about cronjobs, fonts, ...\n" "$(basename "$0")"
}

_install_autostart() {
    printf "===== autostart "
    local autostart_dir="$HOME/.config/autostart/"
    [[ ! -d "$autostart_dir" ]] && mkdir -p "$autostart_dir"
    if cp autostart/* "$autostart_dir"
    then _print_ok
    else _print_err
    fi
}

_install_cronjobs() {
    printf "===== cronjobs "
    if [[ -e cronjobs/cron.txt ]]; then
        if crontab cronjobs/cron.txt; then
            _print_ok
            return
        fi
    fi
    _print_err
}

_install_fonts() {
    printf "===== fonts "
    if bash _other/fonts/install_fonts.sh &>/dev/null
    then _print_ok
    else _print_err
    fi
}

_install_sounds() {
    printf "===== sounds "
    if bash _other/sounds/install_sounds.sh &>/dev/null
    then _print_ok
    else _print_err
    fi
}

_install_config() {
    local repo_file="$1"
    local sys_file="${repo_files[$repo_file]}"
    if [[ -e "$repo_file" ]]; then
        _copy "$(pwd)/$repo_file" "$sys_file"
    else
        _print_err "Dotfile '$repo_file' does not exist. Skipped."
    fi
}

_install_configs() {
    for repo_file in "${sorted_repo_files[@]}"; do
        _install_config "$repo_file"
    done
}

_install_all() {
    _install_autostart
    _install_configs
    _install_cronjobs
    _install_fonts
    _install_sounds
}


# Get into this repository.
pushd "${0%/*}" &>/dev/null || _die

# Default action is to install everything.
[[ -z $1 ]] && { _install_all ; exit ;}

# Parse command line arguments.
while [[ -n $1 ]]; do
    case "$1" in
        -h | --help)
            _help ; exit ;;
        -l | --list)
            _list ; exit ;;
        -a | --all)
            _install_all ; exit ;;
        --autostart | autostart)
            _install_autostart ;;
        --configs | configs)
            _install_configs ;;
        --cronjobs | cronjobs)
            _install_cronjobs ;;
        --fonts | fonts)
            _install_fonts ;;
        --sounds | sounds)
            _install_sounds ;;
        -*)
            _die "Invalid option. See '$(basename "$0") -h' for more." ;;
        *)
            _install_config "$1" ;;
    esac
    shift
done
