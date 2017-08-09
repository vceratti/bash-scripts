#!/usr/bin/env bash

function is_installed {
    app_name=$1

    isInstalled=`dpkg-query -s "$app_name" 2> /dev/null | grep -isE 'status: install ok'`

    if empty_str_cmd "$isInstalled"; then
        return 1
    fi
    return 0
}

function apt_install {
    app=$1
    newline
    log_wait "Installing $app"
    sudo apt-get -y install "$app" &> /dev/null
}

function check_install {
    app=$1

    log_wait "Checking $app installation"

    if ! is_installed "$app"; then
        apt_install "$app"
    fi
    if ! is_installed "$app"; then
        error "Could not install $app; please install it and re-run this script"

    fi
    log_done "$app installed"
}
