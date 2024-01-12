#!/bin/bash

# File:   convert.sh
# Author: Marco Plaitano
# Brief:  Convert all audio files in the current directory from one format to
#         another.


_die() {
    [[ -n $1 ]] && echo "$1" >&2
    exit 1
}

_help() {
    printf "Usage: $(basename "$0") [-i IN_FORMAT] [-o OUT_FORMAT] [OPTION]
Convert all audio files in the current directory from one format to another.

-h, --help          Show this guide and exit.
-i IN_FORMAT        Input format. Default is '$in_format'.
-o OUT_FORMAT       Output format. Default is '$out_format'.
-d, --dir DIR       Save results in DIR. Default is current directory.
"
}



# Default values.
in_format="flac"
out_format="m4a"
out_dir="."


# Parse command line arguments.
while [[ -n $1 ]]; do
    case "$1" in
        -h | --help)
            _help ; exit ;;
        -d | --dir)
            [[ -z $2 ]] && _die "No directory given."
            out_dir="$2"
            shift ;;
        -i)
            [[ -z $2 ]] && _die "No input format given."
            in_format="$2"
            shift ;;
        -o)
            [[ -z $2 ]] && _die "No output format given."
            out_format="$2"
            shift ;;
        *)
            _die "Argument $1 not recognized." ;;
    esac
    shift
done


if [[ ! -d "$out_dir" ]]; then
    echo "Creating directory '$out_dir'"
    mkdir -p "$out_dir" || exit 1
fi


IFS=$'\n'
for file in $(find . -type f -name "*.$in_format"); do
    name=$(basename "$file")
    name=${name%.*}
    echo "$name"

    case $out_format in
        m4a)
            ffmpeg -i "$file" -vcodec copy -acodec alac "$out_dir"/"$name".m4a &>/dev/null ;;
        mp3)
            if [[ $in_format == m4a ]]; then
                ffmpeg -i "$file" -c:v copy -c:a libmp3lame -q:a 4 "$out_dir"/"$name".mp3 &>/dev/null
            else
                ffmpeg -i "$file" -acodec libmp3lame "$out_dir"/"$name".mp3 &>/dev/null
            fi ;;
        *)
            _die "Unrecognized filetype: $out_format." ;;
    esac

    [[ $? -ne 0 ]] && _die
done
