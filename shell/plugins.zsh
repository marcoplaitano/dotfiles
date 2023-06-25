# File:   ~/.config/shell/plugins.zsh
# Author: Marco Plaitano
# Github: https://github.com/marcoplaitano


ZSH_PLUGINS_DIR="$HOME/.config/shell/plugins"

_add_plugin() {
    plugin_repo="$1"
    plugin_name="$(echo $plugin_repo | cut -d "/" -f 2)"
    if [[ ! -d "$ZSH_PLUGINS_DIR/$plugin_name" ]]; then
        [[ ! -d "$ZSH_PLUGINS_DIR" ]] && mkdir -p "$ZSH_PLUGINS_DIR"
        git clone https://github.com/$plugin_repo "$ZSH_PLUGINS_DIR/$plugin_name"
    fi
    source "$ZSH_PLUGINS_DIR/$plugin_name/$plugin_name.plugin.zsh"
}



################################################################################
###   SYNTAX HIGHLIGHTING
################################################################################

# _add_plugin zdharma-continuum/fast-syntax-highlighting



################################################################################
###   AUTO SUGGESTIONS
################################################################################

_add_plugin zsh-users/zsh-autosuggestions

# Use Ctrl+P to toggle suggestions.
bindkey '^p' autosuggest-toggle

# Choose color.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Suggest based on this order.
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Do not suggest if buffer is longer than.
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=30

# Do not offer suggestions for cd based on history.
# export ZSH_AUTOSUGGEST_HISTORY_IGNORE="cd *"

# Do not offer suggestions for git based on completion.
# export ZSH_AUTOSUGGEST_COMPLETION_IGNORE="git *"



################################################################################
###   FZF HISTORY SEARCH
################################################################################

_add_plugin joshskidmore/zsh-fzf-history-search

# Add arguments to FZF.
export ZSH_FZF_HISTORY_SEARCH_FZF_EXTRA_ARGS='--height 7 --reverse '$(get_fzf_colors)''

# Put cursor at the end of the line.
export ZSH_FZF_HISTORY_SEARCH_END_OF_LINE=1

# Do not show duplicates in search.
export ZSH_FZF_HISTORY_SEARCH_EVENT_NUMBERS=0
export ZSH_FZF_HISTORY_SEARCH_DATES_IN_SEARCH=0
export ZSH_FZF_HISTORY_SEARCH_REMOVE_DUPLICATES=1



################################################################################
###   AUTO PAIRS
################################################################################

_add_plugin hlissner/zsh-autopair
