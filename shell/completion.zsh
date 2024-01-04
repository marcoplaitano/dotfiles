# File:   ~/.config/shell/completion.zsh
# Author: Marco Plaitano
# Github: https://github.com/marcoplaitano
# Reference: https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Completion-System


autoload -Uz compinit ; compinit -d $ZSH_COMPDUMP
_comp_options+=(globdots)

# Use caching.
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$XDG_CACHE_HOME/.zcompcache"

# Case insensitive.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Automatically upload list of options.
zstyle ':completion:*' rehash true

# Select completions with arrow keys (also TAB).
zstyle ':completion:*' menu select

# Group and order results by category.
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# Enable approximate matches.
zstyle ':completion:::::' completer _expand _complete _approximate

# When copying, moving or deleting sort files by most recent first.
zstyle ':completion:*:*:cp:*' file-sort modification
zstyle ':completion:*:*:mv:*' file-sort modification
zstyle ':completion:*:*:rm:*' file-sort modification

# Filenames/extensions to ignore during completion.
zstyle ':completion:*:*:*:*files' ignored-patterns '*.(o|out|class|DS_Store)'
# Commands for which completion should show all files.
zstyle ':completion:*:*:(ls|rm):*files' ignored-patterns '^*'

# Use colors.
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Style tags (descriptors of matches found).
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
# Style errors due to approximate search.
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# History.
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true


################################################################################
###  CUSTOM SCRIPTS COMPLETION
################################################################################

_complete_kill_process() {
    compadd compositor firefox lofi mpv music panel plank polybar pomodoro \
            radio redshift screenrecord spotify teams telegram webcam
}
compdef _complete_kill_process kill_process


_complete_convert() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '-i[Input format. Default flac.]:format:(flac mp3 m4a mp4)' \
               '-o[Output format. Default m4a.]:format:(flac mp3 m4a mp4)' \
               {-d,--dir}'[Output destination dir.]:directory:_files -/'

}
compdef _complete_convert convert.sh


_complete_night_mode() {
    _arguments '(- 1 *)--help' \
               '(- 1 *)--off' \
               '(- 1 *)--on' \
               '(- 1 *)--toggle' \
               '(- 1 *)--status[1 if on, 0 if off]'
}
compdef _complete_night_mode night_mode


_complete_repositories() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '--colored[Print repo names with color.]' \
               {-f,--full}'[Print full path for each repo.]'
}
compdef _complete_repositories repositories


_complete_ask_fzf() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               {-a,--accept-all}'[Accept any input, also no match.]' \
               '-p[Prompt.]:Prompt:' \
               {-s,--sort}'[Sort input list.]' \
               '-l[Input list. Must be last argument.]'
}
compdef _complete_ask_fzf ask_fzf


_complete_fzf_kill() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]'
}
compdef _complete_fzf_kill fzf_kill


_complete_executer() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               {-p,--plot,--show-plot}'[Open R plots.]' \
               '*:File:_files -g \*.\(c\|cpp\|py\|sh\|r\|m\|java\|jar\|out\)'
}
compdef _complete_executer executer


_complete_dark_theme() {
    _arguments '(- 1 *)--help' \
               '(- 1 *)--off' \
               '(- 1 *)--on' \
               '(- 1 *)--toggle' \
               '(- 1 *)--status'
}
compdef _complete_dark_theme dark_theme


_complete_icons_desktop() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '--hide[Hide icons.]' \
               '--show[Show icons.]' \
               '--toggle[Toggle visibility.]'
}
compdef _complete_icons_desktop icons_desktop


_complete_wallpaper() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '(- 1 *)'{-r,--random}'[Choose random image from DIR. Default is wallpapers dir.]:Directory:_files -/' \
               '1:Image:_files'
}
compdef _complete_wallpaper wallpaper


_complete_screenrecord() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '--stop[Stop recording.]' \
               '-fps[Specify FPS. Default 25.]:FPS:(24 25 30)' \
               {-m,--mute}'[Do not record audio.]' \
               '--audio-in[Record input audio.]' \
               '--audio-out[Record output audio.]' \
}
compdef _complete_screenrecord screenrecord


_complete_streamcut() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               {-t,--time}'[Seconds to cut]:Seconds:' \
               {-e,--end}'[Cut from end of file. Default.]' \
               {-b,--beginning}'[Cut from beginning of file.]' \
               '*:File:'
}
compdef _complete_streamcut streamcut


_complete_login_message() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '--once[Display message once after boot.]'
}
compdef _complete_login_message login_message


_complete_reminder() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               {-n,--now}'[Display reminder now.]' \
               {-t,--time}'[Reminder time HH:MM]:Time:' \
               {-i,--in}'[Minutes until reminder.]:Minutes:' \
               '-d[Description.]'
}
compdef _complete_reminder reminder


_complete_exit() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '(- 1 *)--suspend' \
               '(- 1 *)--logout' \
               '(- 1 *)--lock' \
               '(- 1 *)--poweroff' \
               '(- 1 *)--reboot' \
}
compdef _complete_exit exit.sh


_complete_streaming() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '1:Title:'
}
compdef _complete_streaming ytdl


_complete_ytdl() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '1:URL:' \
               '2:File:'
}
compdef _complete_ytdl ytdl


_complete_clean() {
    _arguments '(- 1 *)-h[Show help guide.]' \
               '-p[Path to dir to clean.]:Directory:_files -/' \
               '-f[Force cleaning of system dir.]' \
               '-d[Depth to clean.]:Depth:'
}
compdef _complete_clean clean


_complete_microphone() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '(- 1 *)--status[Show capture status.]' \
               '(- 1 *)'{-l,--lower}'[Lower by 5%.]' \
               '(- 1 *)'{-r,--raise}'[Raise by 5%.]' \
               '(- 1 *)'{-t,--toggle}'[Toggle capture.]' \
               '(- 1 *)--on[Turn capture on.]' \
               '(- 1 *)--off[Turn capture off.]'
}
compdef _complete_microphone microphone


_complete_iso_install() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '1:ISO:_files -g \*.iso' \
               '2:USB:'
}
compdef _complete_iso_install iso_install


_complete_edit_file() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               {-e,--editor}'[Editor to use. Default is $EDITOR.]:' \
               '*:File:_files'
}
compdef _complete_edit_file edit_file


_complete_gif() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '-i[Input file]:Input:_files' \
               '-o[Output file]:Output:_files' \
               '-fps[FPS]:FPS:' \
               '-w[Width.]:' \
               '--skip[Skip first N seconds.]:Seconds:' \
               '-t[Only take first M seconds (starting from 0 or N).]:Seconds:'
}
compdef _complete_gif gif


_complete_blue_light_filter() {
    _arguments '(- 1 *)--help' '(- 1 *)--off' '(- 1 *)--on'
}
compdef _complete_blue_light_filter blue_light_filter


_complete_leaving() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]'
}
compdef _complete_leaving leaving


_complete_new_file() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               '-e[Editor in which to open file.]:Editor:' \
               '*:File:'
}
compdef _complete_new_file new_file


_complete_get_password() {
    typeset -A opt_args
    _arguments -C '(- 1 *)'{-h,--help}'[Show help guide.]' \
                  '(- 1 *)'{-c,--clip}'[Paste password into clipboard.]' \
                  '(- 1 *)'{-s,--show}'[Show full info.]' \
                  '*:Password:->passwords'
    case "$state" in
        passwords)
            local -a passwords
            local pswd
            pushd $HOME/.local/share/passwords
            for pswd in $(find . -maxdepth 2 -type f -name '*.gpg' | sort -n); do
                pswd=${pswd#\./}; pswd=${pswd%.*}
                passwords+=($pswd)
            done
            popd
            _describe 'Passwords' passwords
        ;;
    esac
}
compdef _complete_get_password get_password


_complete_webcam() {
    _arguments '(- 1 *)'{-h,--help}'[Show help guide.]' \
               {-r,--resolution}'[Resolution. Default 240p.]:Resolution:(120 240 480 720 1080)' \
               {-d,--device}'[Device. Default /dev/video0.]:Device:(/dev/video0)'
}
compdef _complete_webcam webcam


_complete_theme_terminal() {
    _arguments '1:Theme:->themes'
    case "$state" in
        themes)
            local -a themes
            local theme
            for theme in $(find /usr/share/xfce4/terminal/colorschemes/ -type f); do
                theme=$(basename $theme)
                theme=${theme%.*}
                themes+=($theme)
            done
            themes+=(wal)
            _describe 'Themes' themes ;;
    esac
}
compdef _complete_theme_terminal theme_terminal
