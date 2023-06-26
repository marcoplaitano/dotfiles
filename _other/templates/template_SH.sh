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
    printf \"Usage: \$(basename \$0) [OPTION]...
Description

-h, --help          Show this guide and exit.
\"
}


# Parse command-line arguments.
while [[ -n \$1 ]]; do
    case \"\$1\" in
        -h | --help)
            _help ; exit ;;
        *)
            _die \"Argument '\$1' not recognized.\" ;;
    esac
done

" > "$file"
