#!/bin/bash

function is_docker_compose_running {
    isServiceRunning=`docker-compose version 2> /dev/null | grep -isE 'docker-compose version'`

    if empty_str_cmd "$isServiceRunning"; then
        return 1
    fi

    return 0
}

function is_docker_running {
    sudo service docker restart &> /dev/null

    isServiceRunning=`docker ps 2> /dev/null | grep -isE 'CONTAINER ID'`

    if empty_str_cmd "$isServiceRunning"; then
        return 1
    fi

    return 0
}

function check_docker_service  {
    if ! is_docker_running; then
        return 1
    fi;

    if ! is_docker_compose_running; then
        return 1
    fi;

    return 0
}

function docker_install {

    sudo apt-get remove -yq docker-ce docker docker-engine docker.io > /dev/null
    sud apt-get update -yq &>/dev/null
    sudo apt-get install -yq apt-transport-https ca-certificates curl software-properties-common &>/dev/null
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &>/dev/null

    isInstalled=`sudo apt-key fingerprint 0EBFCD88 | grep '9DC8.*5822.*9FC7.*DD38.*854A.*E2D8.*8D81.*803C.*0EBF.*CD88' | cut -c7-`

    if empty_str_cmd "$isInstalled"; then
        log_error "Could not add DockerCE key into apt-key"
    fi

    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable" &> /dev/null
    sudo apt-get update  &> /dev/null

    check_install 'docker-ce'

    sudo groupadd docker &> /dev/null
    sudo usermod -aG docker $USER &> /dev/null


    log_wait "Installing Docker Compose"
    sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.14.0/docker-compose-$(uname -s)-$(uname -m)" &> /dev/null
    sudo chmod +x /usr/local/bin/docker-compose &> /dev/null

    isInstalled=`docker-compose --version  | grep '1.14.0' | cut -c7-`
    if empty_str_cmd "$isInstalled"; then
        log_error "Could not install Docker Compose"
    fi

   log_done

}

function install_docker_and_compose {
    if ! (empty_str_cmd "$disable_docker_check"); then
        return
    fi

    log_wait "Checking Docker and Docker Compose"

    if check_docker_service; then
        disable_docker_check="true"
        log_done 'Docker and Docker Compose are already installed and working'

        newline
    else
        if should_run_command "Install Docker and Docker-composer (will remove old docker.io installs)?"; then
            log_wait "Installing"
            newline
            docker_install
            newline

            if ! check_docker_service; then
                log '\nATTENTION!\n\nDocker installed! Please, logout and re-log with your user (to update permissions) and run this script again, to ensure you can run docker without sudo.\n'
                exit 1
            else
                disable_docker_check="true"
                log_done
            fi

        fi
    fi

}
