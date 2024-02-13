#!/bin/bash

# File:   pomodoro.sh
# Author: Marco Plaitano
# Brief:  Run a Pomodoro Timer to alternate work sprints with small pauses.
#         https://en.wikipedia.org/wiki/Pomodoro_Technique


################################################################################
###  VARIABLES
################################################################################

# Number of minutes for each slice.
declare -A TIMES=(
    [FOCUS]=25
    [PAUSE]=5
    [LONG PAUSE]=20
)

# Number of Focus slices to complete before a Long Pause is earned.
NUM_ITERATIONS=3

# Which color to tint the text with, based on the current slice.
declare -A COLORS=(
    [FOCUS]="\e[01;31m"      # red
    [PAUSE]="\e[01;32m"      # green
    [LONG PAUSE]="\e[01;32m" # green
    [RESET]="\e[00m"         # default foreground
)

# Notification sound to play when a new slice begins.
# (yes, they are the same but this makes it easy to replace each of them)
declare -A SOUNDS=(
    [FOCUS]="/usr/share/sounds/freedesktop/stereo/complete.oga"
    [PAUSE]="/usr/share/sounds/freedesktop/stereo/complete.oga"
    [LONG PAUSE]="/usr/share/sounds/freedesktop/stereo/complete.oga"
)


################################################################################
###  FUNCTIONS
################################################################################

_die() {
    [[ -n $1 ]] && echo "$1" >&2
    exit 1
}

_safe_exit() {
    printf "\r"
    clear
    block_socialmedia --unblock --now &>/dev/null
    tput cnorm
    exit
}

_read_input() {
    # Wait 1 second for 1 key press. (no need to send the input with ENTER)
    read -t 1 -rs -N 1 && {
        case "${REPLY,}" in
            # Q = exit the script
            q)
                _safe_exit ;;
            # N = set variable to notify the main loop to skip the current slice
            n)
                next_slice=true ;;
            # P or SPACE = pause or resume the timer
            p | ' ')
                [[ $is_paused == false ]] && is_paused=true || is_paused=false ;;
        esac
    }
}


################################################################################
###  SETUP
################################################################################

# Catch any signal that might stop the script abruptly.
trap "_safe_exit" SIGINT SIGQUIT SIGTERM

# Hide the cursor.
tput civis


################################################################################
###  MAIN LOOP
################################################################################

slice="FOCUS"
iteration=1
is_paused=false

while : ; do
    ############################# CONFIGURE SLICE ##############################
    # Block social media when starting FOCUS, unblock them during PAUSES.
    # This is a custom script I wrote:
    # https://github.com/marcoplaitano/dotfiles/blob/main/bin/block_socialmedia
    if [[ $slice == "FOCUS" ]]; then
        block_socialmedia --block &>/dev/null
    else
        block_socialmedia --unblock --now &>/dev/null
    fi

    # Timestamp at which slice will end.
    time_end=$(($(date +%s) + ${TIMES[$slice]} * 60))

    # Show info.
    clear
    printf "n:  next slice\np:  pause/resume\nq:  quit\n\n"
    printf "${COLORS[$slice]}%s  %s/%s${COLORS[RESET]}\n" \
            "$slice" $iteration $NUM_ITERATIONS

    ############################# COUNTDOWN ####################################
    # Loop at a rate of 1 second until the end timestamp is reached.
    while [[ $time_end -gt $(date +%s) ]]; do
        # Show remaining time.
        if [[ $is_paused == false ]]; then
            printf "%s       \r" "$(date -d @$((time_end-$(date +%s))) +%M:%S)"
        else
            printf "%s PAUSED\r" "$(date -d @$((time_end-$(date +%s))) +%M:%S)"
            # Keep the timer paused by adding 1 second to the end time.
            time_end=$((time_end + 1))
        fi

        # Wait 1 second listening for key presses.
        _read_input

        # Variable set in the function above if user presses N key.
        if [[ -n $next_slice ]]; then
            unset next_slice
            break
        fi
    done

    ############################# END SLICE ####################################
    # FOCUS ended. Start PAUSE or LONG_PAUSE
    if [[ $slice == "FOCUS" ]]; then
        if [[ $iteration -ge $NUM_ITERATIONS ]]; then
            iteration=0
            slice="LONG PAUSE"
        else
            slice="PAUSE"
        fi
        paplay "${SOUNDS[$slice]}" &
        notify-send "🍅 Pomodoro" "Take a break for ${TIMES[$slice]} min!"
    # PAUSE ended. Start FOCUS.
    else
        iteration=$((iteration + 1))
        slice="FOCUS"
        paplay "${SOUNDS[$slice]}" &
        notify-send "🍅 Pomodoro" "Time to focus for ${TIMES[$slice]} min!"
    fi
done
