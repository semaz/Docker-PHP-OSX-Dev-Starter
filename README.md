# Docker PHP OSX Development Starter #

This is project for local development using docker.
Project contains compose file and a settings of all images.

Fully tested on OS X 10.12 with lastest version of Docker.

For fix volume speed install https://github.com/EugenMayer/docker-sync and run `sh sync-start.sh`

## Images ##
- Nginx (https://hub.docker.com/_/nginx/)
- PHP7-FPM (custom from dockerfile)
- MySQL (https://hub.docker.com/_/mysql/)
- Memcached (https://hub.docker.com/r/eeacms/memcached/)
- Redis (https://hub.docker.com/_/redis/)
- RabbitMQ (https://hub.docker.com/_/rabbitmq/)
- Postgres (https://hub.docker.com/_/postgres/)
- pgAdmin4 (https://hub.docker.com/r/foxylion/pgadmin4/)
- Portainer (https://github.com/portainer/portainer)

## Install ##

1. `git clone https://github.com/DevCreel/Docker-PHP-Dev-Starter.git ~/Docker`
2. Place your projects into folder `~/Sites`
3. Run `cd && sh Docker/install.sh`

## Run ##

1.`cd ~/Docker && dcu`
2. add `127.0.0.1 intro.dev` to /etc/hosts
3. open in browser http://intro.dev

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

- pgAdmin is started as image
- phpMyAdmin, phpMemcachedAdmin, phpRedisAdmin located if folder `admin`.

## Data ##

Redis, MySQL, Postgres, pgAdmin store their data locally.
- ./mysql/data:/var/lib/mysql
- ./redis/data:/data
- ./postgres/data:/var/lib/postgresql/data
- ./postgres/admin:/data

## In future ##

- find good web log ui
- ...
