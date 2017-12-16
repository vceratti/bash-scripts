#!/usr/bin/env bash

project_name=""
branch=""
disable_docker_check=""

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

args="project-name:,branch:,disable-docker-check:"

OPTIONS=$(getopt  -o p:e: --long ${args} -- "$@" 2> /dev/null)

if [[ $? -ne 0 ]]
then
    help-usage
fi

eval set -- "${OPTIONS}"

while true ; do
    case "$1" in
        --disable-docker-check ) disable_docker_check="${2}"; shift 2;;
        --project-name ) project_name="${2}"; shift 2;;
        --branch ) branch="${2}"; shift 2;;
        --  ) shift; break;;
        *|--help) help-usage;;
    esac
done
