# File:   ~/.config/shell/prompt.zsh
# Author: Marco Plaitano
# Github: https://github.com/marcoplaitano


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


# Get and print info about git repository.
git_details() {
    local branch upstream numbers behind ahead
    local dirty_state_info num_commits_info

    # Do nothing if the current directory is not a Git repository.
    ! git rev-parse &>/dev/null && return

    # Check if in .git/ directory (some of the following checks don't make
    # sense/won't work in the .git directory).
    [[ "$(git rev-parse --is-inside-git-dir)" == "true" ]] && return

    # Get branch name.
    branch="$( printf "%s" "$(git rev-parse --abbrev-ref HEAD 2>/dev/null \
                              || git rev-parse --short HEAD 2>/dev/null \
                              || printf "unknown" )" | tr -d "\n" )"

    # Check for untracked files.
    if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
        dirty_state_info+="?"
    fi

    # Check for unstaged changes.
    if [[ -n $(git status --porcelain) ]]; then
        dirty_state_info+="*"
    fi

    # Check for uncommitted changes in the index.
    if ! git diff --quiet --ignore-submodules --cached; then
        dirty_state_info+="+"
    fi

    # Check for stashed files.
    if git rev-parse --verify refs/stash &>/dev/null; then
        dirty_state_info+="$"
    fi

    # Count number of commits ahead/behind with upstream.
    upstream="$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null || echo "origin/HEAD")"
    numbers=$(git rev-list --count --left-right $upstream...HEAD 2>/dev/null)
    behind=$(echo $numbers | awk '{print $1}')
    ahead=$(echo $numbers | awk '{print $2}')
    case "$behind$ahead" in
        "" | "00") ;;
        "0"*) num_commits_info=">$ahead" ;;
        *"0") num_commits_info="<$behind" ;;
        *)    num_commits_info="<>" ;;       # diverged from upstream.
    esac

    # Add space between different sections.
    [[ -n $dirty_state_info ]] && dirty_state_info=" $dirty_state_info"
    [[ -n $num_commits_info ]] && num_commits_info=" $num_commits_info"

    echo -e " (${branch}${dirty_state_info}${num_commits_info})"
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



autoload colors && colors

# Allows for parameter expansions and command substitution in the prompt.
setopt prompt_subst



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
    PROMPT+='%F{magenta}$(git_details)%f'
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
