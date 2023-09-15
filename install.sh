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


# Associate files/dirs in this 'dotfiles' repository with the correspondent
# files and dirs found across the system.
declare -A repo_files=(
    ["alacritty"]="$XDG_CONFIG_HOME/alacritty"
    ["bat"]="$XDG_CONFIG_HOME/bat"
    ["git"]="$XDG_CONFIG_HOME/git"
    ["gnupg"]="$XDG_CONFIG_HOME/gnupg"
    ["i3"]="$XDG_CONFIG_HOME/i3"
    ["nvim"]="$XDG_CONFIG_HOME/nvim"
    ["picom"]="$XDG_CONFIG_HOME/picom"
    ["polybar"]="$XDG_CONFIG_HOME/polybar"
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
    ["vlc"]="$XDG_CONFIG_HOME/vlc"
    ["xfce4/xfce4-keyboard-shortcuts.xml"]="$XDG_CONFIG_HOME/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml"
    ["xfce4/terminal_colorschemes"]="/usr/share/xfce4/terminal/colorschemes"
    ["xfce4/terminalrc"]="$XDG_CONFIG_HOME/xfce4/terminal/terminalrc"
)

# Sort repo files in alphabetical order.
sorted_repo_files=( $( echo ${!repo_files[@]} | tr ' ' $'\n' | sort ) )



_die() {
    [[ -n $1 ]] && error_msg="$1" || error_msg="Error in $(basename "$0")."
    echo "$error_msg" >&2
    exit 1
}

_help() {
    printf "Usage: $(basename $0) [FILE] [OPTION]
Install dotfiles and configuration files from this repository.
The 'installation' process consists in symlinking the files and directories
in this repository to their respective system location.

-h, --help          Show this guide and exit.
-l, --list          List all config files/dirs that can be installed.
FILE                Config file/directory to install.
-a, --all           Install everything. (Default action).
--autostart         Install autostart applications.
--cronjobs          Install cronjobs.
--fonts             Install fonts.
--sounds            Install sounds.
"
}


# Create symlink from source $1 to destination $2.
# Ask whether to overwrite (delete + write) destination, if it already exists.
_copy() {
    local ans
    if [[ -e "$2" ]]; then
        while [[ -z $ans ]]; do
            read -rp "'$2' already exists. Replace it? " ans
            case "${ans,,}" in
                y|yes|s|si) rm -r "$2" ;;
                n|no) return ;;
                *) unset ans ;;
            esac
        done
    fi
    if ! ln -fs "$1" "$2" ; then
        echo "WARNING: Could not link '$1' to '$2'." >&2
    fi
}


# List all files that can be installed.
_list() {
    for repo_file in "${sorted_repo_files[@]}"; do
        echo "$repo_file"
    done
    echo
    echo "See '$(basename $0) -h' for info about cronjobs, fonts, ..."
}

_install_autostart() {
    echo "===== Installing autostart ..."
    local autostart_dir
    autostart_dir="$HOME/.config/autostart/"
    [[ ! -d "$autostart_dir" ]] && mkdir -p "$autostart_dir"
    cp "$(pwd)"/autostart/* "$autostart_dir"
}

_install_cronjobs() {
    echo "===== Installing cronjobs ..."
    [[ -e cronjobs/cron.txt ]] && crontab cronjobs/cron.txt
}

_install_fonts() {
    echo "===== Installing fonts ..."
    if pushd _other/fonts &>/dev/null ; then
        bash ./install_fonts.sh
        popd &>/dev/null
    fi
}

_install_sounds() {
    echo "===== Installing sounds ..."
    if pushd _other/sounds &>/dev/null ; then
        bash ./install_sounds.sh
        popd &>/dev/null
    fi
}

_install_config() {
    local repo_file sys_file
    repo_file="$1"
    sys_file="${repo_files[$repo_file]}"
    if [[ -e "$repo_file" ]]; then
        echo "===== Installing $repo_file ..."
        _copy "$(pwd)/$repo_file" "$sys_file"
    else
        echo "WARNING: dotfile '$repo_file' does not exist. Skipped." >&2
    fi
}

_install_all() {
    for repo_file in "${sorted_repo_files[@]}"; do
        _install_config "$repo_file"
    done
    _install_autostart
    _install_cronjobs
    _install_fonts
    _install_sounds
}



# Prepare config directory.
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
    echo "Creating config folder '$XDG_CONFIG_HOME'."
    mkdir -p "$XDG_CONFIG_HOME"
fi


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
        --autostart)
            _install_autostart ;;
        --cronjobs)
            _install_cronjobs ;;
        --fonts)
            _install_fonts ;;
        --sounds)
            _install_sounds ;;
        -*)
            _die "Invalid option. See '$(basename $0) -h' for more." ;;
        *)
            _install_config "$1" ;;
    esac
    shift
done
