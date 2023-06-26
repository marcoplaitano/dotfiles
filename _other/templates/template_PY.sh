#!/bin/bash


file=$1
name=$2


# write nothing in __init__ files
if [[ $name == "__init__" ]]; then
    touch "$file"
    exit 0
fi


echo $"\
# @file $(basename "$file")
# @author Marco Plaitano
# @date $(date +'%d %b %Y')


if __name__ == \"__main__\":
    pass" > "$file"
