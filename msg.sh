#!/usr/bin/env bash

function newline {
    printf "\n"
}

function log_highlight {
    printf "[ $1 ]"
}

function log_important {
    newline
    printf "  <<<   $1   >>>  "
    newline
}

function log_title {
    newline
    log_highlight "$1"
    newline
}

function log {
    newline
    printf "   - $1"
    newline
}

function log_ask {
    newline
    printf " * $1"
}

function log_ask_newline {
    log_ask "$1"
    newline
}

function log_wait {
   newline
   printf "   - $1... "
}

function log_done {
    text="$1"
    if empty_str_cmd "$1"; then
        text="Done"
    fi

    printf " $text!"
    newline
}

function log_error {
    newline
    newline
    printf "ERROR: $1"
}

function log_exit {
    print_l $1
    exit 1
}


function empty_str_cmd {
    cmd_return="$1"

    if [ "$cmd_return" = "" ]; then
        return 0;
    fi;
    return 1
}

function should_run_command {
    newline
    read -p " * $1 (y/n)? " choice

    case "$choice" in
      y|Y ) return 0;;
      n|N ) return 1;;
      * ) return 1;;
    esac
}

function ask_and_install {
    cmd=$1

    if should_run_command "Check and install $cmd"; then
        check_install "$cmd"
    fi
}
