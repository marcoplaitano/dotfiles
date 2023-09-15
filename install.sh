#!/bin/bash

# File:   install.sh
# Author: Marco Plaitano
# Date:   14 Apr 2022
# Brief:  Set up all the dotfiles of this git repository.


# Create symlink from source $1 to destination $2.
# Ask whether to overwrite (delete + write) destination, if it already exists.
function _copy {
    local ans
    if [[ -e "$2" ]]; then
        unset ans
        while [[ -z $ans ]]; do
            read -rp "Destination '$2' already exists. Replace it? " ans
            case "${ans,,}" in
                y|yes|s|si) rm -r "$2" ;;
                n|no) return ;;
                *) unset ans ;;
            esac
        done
    fi
    if ln -fs "$1" "$2" ; then
        echo "LINK  '$1' ---> '$2'"
    else
        echo "WARNING: Could not link '$1' to '$2'." >&2
    fi
}


# Enable xtracing (this script has most probably been called by my general
# system setup script).
# In any case, tracing is redirected to this log file and won't appear on stdout
# nor in stderr.
LOGFILE="/var/tmp/installation.log"
exec {BASH_XTRACEFD}>>$LOGFILE
PS4='$?\011 $(date +%H:%M:%S.%3N)  $BASH_SOURCE@$LINENO   \011'
set -x

# Prepare config directory.
XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
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
keys=( $( echo ${!repo_files[@]} | tr ' ' $'\n' | sort ) )
# Create symlinks from repository files to system ones.
for repo_file in "${keys[@]}"; do
    sys_file="${repo_files[$repo_file]}"
    if [[ -e "$repo_file" ]]; then
        _copy "$(pwd)/$repo_file" "$sys_file"
    else
        echo "WARNING: dotfile '$(pwd)/$repo_file' does not exist. Skipped." >&2
    fi
done

# Install cron jobs.
[[ -e cronjobs/cron.txt ]] && crontab cronjobs/cron.txt

# Install autostart applications.
autostart_dir="$HOME/.config/autostart/"
[[ ! -d "$autostart_dir" ]] && mkdir "$autostart_dir"
cp "$(pwd)"/autostart/* "$autostart_dir"

# Install fonts.
if pushd _other/fonts &>/dev/null ; then
    bash ./install_fonts.sh
    popd &>/dev/null
fi

# Install sounds.
if pushd _other/sounds &>/dev/null ; then
    bash ./install_sounds.sh
    popd &>/dev/null
fi
