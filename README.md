# Docker PHP OSX Development Starter #

This is project for local development using docker.
Project contains compose file and a settings of all images.

Fully tested on OS X 10.13 with lastest version of Docker.

For fix volume speed install https://github.com/EugenMayer/docker-sync and run `sh sync-start.sh`

## Images ##
- PHP7-FPM with Nginx (custom from dockerfile)
- MySQL (https://hub.docker.com/_/mysql/)
- Memcached (https://hub.docker.com/r/eeacms/memcached/)
- Portainer (https://github.com/portainer/portainer)

## Install ##

1. `git clone https://github.com/DevCreel/Docker-PHP-Dev-Starter.git ~/Docker`
2. Place your projects into folder `~/Sites`
3. Run `cd && sh Docker/install.sh`

## Run ##

`cd ~/Docker && dcu`

The containers will be restarted independently.

## Settings ##

Description of images settings.

### Nginx ###

- nginx/nginx.conf - main config
- nginx/sites/* - vhost configs 
- nginx/admins/* - vhost configs of admin tools
 
 ### PHP ###
 
 - php/php.ini - main config
 - php/php-fpm.conf - fpm config
 - php/bashrc - file copied to container
 - Dockerfile - custom image config with all needed ext

## Shell ##

File `shell/functions.sh` contains useful docker aliases.

## Admins ##

- phpMyAdmin, phpMemcachedAdmin, phpRedisAdmin located if folder `admin`.

## Data ##

MySQL, Portainer store their data locally.
- ./mysql/data:/var/lib/mysql
- ./data/portainer:/data

## In future ##

- find good web log ui
- ...
