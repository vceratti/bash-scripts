#!/usr/bin/env bash

function file-exists {
    filename=$1

    echo "$filename"

    if [ -e "$filename" ]; then
        return 1
    fi

    return 0
}
