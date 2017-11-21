#!/usr/bin/env bash

git_token_php_build="5e2cd84c632e063ff21675e6c65387a9556236c1"

function checkout_build_repo {
    log_wait "Checking out and installing build-tools"

    rm -rf .build
    mkdir .build
    cd .build
    git init  &> /dev/null
    git pull "https://$git_token_php_build@github.com/vceratti/php-build-tools.git" "$branch" &> /dev/null

    cd "$root"
}
