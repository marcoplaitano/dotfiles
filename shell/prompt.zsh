# File:   ~/.config/shell/prompt.zsh
# Author: Marco Plaitano
# Github: https://github.com/marcoplaitano

autoload colors && colors

# Allows for parameter expansions and command substitution in the prompt.
setopt prompt_subst


# Count execution time of last command.
preexec() {
    cmd_start=$(($(print -P %D{%s%6.}) / 1000))
}
precmd() {
    local now diff last_cmd sec min

    if [[ -n $cmd_start ]]; then
        now=$(($(print -P %D{%s%6.}) / 1000))
        diff=$((($now - $cmd_start) / 1000))
        # Get last command (expand aliases).
        last_cmd="$(history | tail -1)"
        last_cmd=$(echo $last_cmd | awk '{$1=""}1' | xargs)
        # If the last command is one of the following then discard execution
        # time. I don't want to print it out in the prompt.
        case "$last_cmd" in
            v | vi* | nvim* | *EDITOR* | terminalrc* | ssh* | \
            tmux* | *htop* | man* | fzf* | *pomodoro* | \
            cat* | less* | more* | bash)
                unset cmd_start cmd_time
                return ;;
        esac
        sec=$((diff % 60))
        min=$(((diff / 60) % 60))

        if [[ $min -gt 0 ]]; then
            [[ $sec -gt 0 ]] && cmd_time="${min}m${sec}s " || cmd_time="${min}m "
        else
            [[ $sec -ge 5 ]] && cmd_time="${sec}s " || cmd_time=""
        fi
        unset cmd_start

    else
        unset cmd_time
    fi
}


# Show error code of last executed command.
error_return() {
    local retval
    retval=$?
    case $retval in
        0 | 130 | 146)
            return ;;
        *)
            echo "err$retval " ;;
    esac
}


# Show closed lock if I do not have write permission for current directory.
locked_dir() {
    if [[ ! -w $(pwd) ]]; then
        echo ""
    fi
}


# Show info about current git repository.
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_STATESEPARATOR=" "
GIT_PS1_SHOWCONFLICTSTATE="yes"
GIT_PS1_HIDE_IF_PWD_IGNORED=1
source $HOME/.config/shell/git-prompt.sh



# Use special prompt symbol when user is root.
ROOT_SYMBOL='#'
# Change prompt symbol (when not root) based on current vim mode.
VI_NORMAL_SYMBOL=':'
VI_INSERT_SYMBOL='|'

function zle-line-init zle-keymap-select {
    PROMPT=''
    # Execution time.
    PROMPT+='%B%F{yellow}${cmd_time}%f'
    # Num of Background Jobs.
    PROMPT+='%F{cyan}%(1j.%j .)%f'
    # Username. (Color it RED if root).
    PROMPT+='%(!.%F{red}.%F{green})%n%f'
    # Hostname (in SSH).
    [[ -n $SSH_CONNECTION ]] && PROMPT+='%F{green}@%m%f'
    PROMPT+=' '
    # Path truncated at a depth of 5.
    PROMPT+='%F{blue}%(5~|../%3~|%~)%f'
    # Lock if no write permissions in current folder.
    PROMPT+='$(locked_dir)'
    # Git info.
    PROMPT+='%F{magenta}$(__git_ps1 " (%s)")%f'
    # Either leave a space or a newline if the available space is not long enough.
    PROMPT+=$'%-50(l: :\n)'
    # Prompt symbol.
    # Color it red if last command failed.
    # Do not consider "error" the following exit status codes:
    #    - 130  (CTRL+C)
    #    - 148  (CTRL+Z)
    PROMPT+='%f%(?..%(130?..%(148?..%F{red})))'
    # Change actual symbol based on the current vi mode and whether the user is
    # root.
    if [[ $KEYMAP == vicmd ]]; then
        PROMPT+='%(!.$ROOT_SYMBOL.$VI_NORMAL_SYMBOL)%f%b '
    else
        PROMPT+='%(!.$ROOT_SYMBOL.$VI_INSERT_SYMBOL)%f%b '
    fi

    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export PS2="| "
