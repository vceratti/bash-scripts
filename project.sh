#!/usr/bin/env bash

function choose_project_name {
    while empty_str_cmd "$project_name"; do

        log_ask 'Choose a project name: '

        read -r project_name
    done

    log_important "Your project name is:   $project_name"
}

function choose_env {
    if [[ ! "$branch" =~ php56\-api|php71\-api ]]; then
        branch=""
    fi;

    while empty_str_cmd "$branch"; do
        log_ask 'Choose an environment setting:'
        log_ask ' 1) PHP 7.1 and MariaDB (latest)'
        log_ask ' 2) PHP 5.6 and MySQL 5.6 '

        read -r env

        if (( env == 1 )); then
            branch="php71-api"
        fi

        if (( env == 2 )); then
            branch="php56-api"
        fi
   done;
}