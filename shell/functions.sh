#!/usr/bin/env bash

# compose
alias dc='docker-compose'
alias dck='dc kill'
alias dcs='dc stop'
alias dcd='dc down'
alias dcu='dc up -d'
alias dcr='dc restart'
alias dcur='dc up --force-recreate -d'
alias dcb='dc build --force-rm'

# service
alias dservice='docker-service'

# sync
alias ds='docker-sync'
alias dss='docker-sync-stack'
alias dssu='docker-sync-stack --daemon start'
alias dssd='docker-sync-stack clean'

# logs
alias dlog='docker logs -f'
alias dlogsc='docker-logs-clear'

# login
alias dlogin='docker-login'

# ps
alias dps='docker ps'
alias dpsa='docker ps -a'

# stop, kill
alias dsall='docker stop $(docker ps -a -q)'
alias dkall='docker kill $(docker ps -a -q)'

# rm
alias drm='docker rm -f'
alias drmi='docker rmi -f'
alias drmall='docker rm -f $(docker ps -a -q)'
alias drmiall='docker rmi -f $(docker images -q)'

# machine
alias dm='docker-machine'
alias dme='docker-machine-env'

# functions
docker-machine-env() {
    eval $(docker-machine env $1)
}

docker-login() {
    docker exec -i -t $1 bash
}

docker-service() {
    docker exec -i -t $1 service $2 $3;
}

docker-logs-clear() {
    LOGS_PATH=$(dirname "${BASH_SOURCE}")/../logs;

    if [ -d "$LOGS_PATH" ]; then
        array=(`find "${LOGS_PATH}" -type f -name \*.log | sort -r`)
        for nm in "${array[@]}"
        do
            cat /dev/null > "${nm}"
        done
    else
        echo 'Docker logs folder not found.';
    fi
}