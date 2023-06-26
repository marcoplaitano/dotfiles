#!/bin/bash


file=$1
name=$2


# Header comments.
echo $"\
/**
 * @file $(basename "$file")
 * @author Marco Plaitano
 * @date $(date +'%d %b %Y')
 */
" > "$file"


# Look for an header file in one of the project's folders.
for dir in $(find .. -maxdepth 2 -type d); do
    if [[ -f "$dir"/"$name".hpp ]]; then
        echo "#include \"""$name"".hpp\"" >> "$file"
        exit
    fi
done


# If no header has been found, assume this is the main source file.
echo $"#include <iostream>


int main(int argc, char **argv) {

    return EXIT_SUCCESS;
}" >> "$file"
