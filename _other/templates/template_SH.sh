#!/bin/bash


file=$1


echo $"\
#!/bin/bash

# File:   $(basename $file)
# Author: Marco Plaitano
# Date:   $(date +'%d %b %Y')
# Brief:


_die() {
    [[ -n \$1 ]] && error_msg=\"\$1\" || error_msg=\"Error in \$(basename \"\$0\").\"
    if [[ \$TERM != dumb ]]; then
        echo \"\$error_msg\" >&2
    else
        notify-send \"Error in \$(basename \"\$0\")\" \"\$error_msg\"
    fi
    exit 1
}

_help() {
    printf \"Usage: %s [OPTION]...
Description

-h, --help          Show this guide and exit.\\n\" \"\$(basename \"\$0\")\"
}

# Make sure that the script won't be executed more than once at a time.
_check_pid() {
    local PIDFILE=\"/tmp/\$(basename \"\$0\").pid\"
    if [[ -f \"\$PIDFILE\" ]]; then
        pid=\$(cat \"\$PIDFILE\")
        # Process found, script already running, do not execute this.
        ps -p \"\$pid\" &>/dev/null && _die \"Script already running.\"
    fi
    # Script wasn't running, write its pid.
    echo \$\$ > \"\$PIDFILE\"
}


_check_pid

# Parse command-line arguments.
while [[ -n \$1 ]]; do
    case \"\$1\" in
        -h | --help)
            _help ; exit ;;
        *)
            _die \"Argument '\$1' not recognized.\" ;;
    esac
    shift
done

" > "$file"
