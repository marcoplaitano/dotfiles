# File:   ~/.config/shell/keymaps.zsh
# Author: Marco Plaitano
# Github: https://github.com/marcoplaitano
# Brief:  ZSH keyboard shortcuts.


# Use VIM keybindings.
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim by entering VISUAL mode.
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# Fix bugs when switching modes
bindkey "^?" backward-delete-char
bindkey "^u" backward-kill-line
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^k" kill-line

# Ctrl + Left|Right arrow to jump 1 word backward/forward in the command.
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# Use UP and DOWN arrows to cycle through history.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search


# Ctrl + B  cd up one level.
goup() {
    cd .. ; zle accept-line
}
zle -N goup
bindkey '^B' goup

# Ctrl + F  use FZF to select a folder to cd into.
goto() {
    list=$(find $HOME -maxdepth 3 -type d \
            ! -path '*.ssh*' \
            ! -path '*.ssr*' \
            ! -path '*snap*' \
            ! -path '*.cache*' \
            ! -path '*.local*' \
            ! -path '*.java*' \
            ! -path '*.vscode/*' | sort -u )
    dir=$(echo $list | fzf --prompt "Directory: " --reverse $(get_fzf_colors))
    [[ -d "$dir" ]] && cd "$dir"
    zle reset-prompt
}
zle -N goto
bindkey '^F' goto

# Ctrl + L  actually clear the screen.
reallyclear() {
    clear ; zle reset-prompt
}
zle -N reallyclear
bindkey "^l" reallyclear
