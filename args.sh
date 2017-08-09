#!/usr/bin/env bash

project_name=""
branch=""

function usage-default {
    printf "
Usage: script.sh <params>

(define your own \"usage\" function in your main script)

"
    exit 1
}

function help-usage {
     usage 2> /dev/null; usage-default;
}

args="project-name:,branch:"

OPTIONS=$(getopt -o a: --long ${args} -- "$@" 2> /dev/null)

if [[ $? -ne 0 ]]
then
    help-usage
fi

eval set -- "${OPTIONS}"

while true ; do
    case "$1" in
        --project-name ) project_name="${2}"; shift 2;;
        --branch ) branch="${2}"; shift 2;;
        --  ) shift; break;;
        *|--help) help-usage;;
    esac
done
