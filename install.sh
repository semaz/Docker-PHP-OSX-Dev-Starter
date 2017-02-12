#!/usr/bin/env bash

DOCKER_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

get_rc_path(){
    if [ -f "~/.bashrc" ]; then
        echo ".bashrc"
    else
        echo ".bash_rc"
    fi
}

alias reloadBash="exec $SHELL -l"

if grep -q "$DOCKER_PATH/shell/functions.sh" ~/$(get_rc_path)
then
    echo "Docker scripts already installed."
else
    echo "\n# Docker functions autoload \nsource $DOCKER_PATH/shell/functions.sh" >> ~/$(get_rc_path);
    echo "Docker scripts installed.";
    reloadBash;
fi;