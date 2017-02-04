#!/usr/bin/env bash

DOKER_PATH=$(dirname "${BASH_SOURCE}")

if grep -q "~/$DOKER_PATH/shell/functions.sh" ~/.bash_rc; ##note the space after the string you are searching for
then
    echo "Docker scripts already installed."
else
    echo "\n# Docker functions autoload \nsource ~/$DOKER_PATH/shell/functions.sh" >> ~/.bash_rc;
    echo "Docker scripts installed.";
    exec bash -l;
fi;