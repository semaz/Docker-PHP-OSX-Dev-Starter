FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" && apt-get dist-upgrade

RUN apt-get install -y -f apt-utils apt-transport-https wget curl git nano vim \
    locales ca-certificates python-software-properties software-properties-common

# Locale
RUN dpkg-reconfigure -f noninteractive locales \
    && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen && export LC_ALL=en_US.UTF-8

# ppa:ondrej
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update

RUN apt-get install -y php-pear php7.1-common php7.1-cli php7.1-dev php7.1-mbstring\
    php7.1-fpm php7.1-intl php7.1-json php-memcached php7.1-mysql php7.1-gmp \
    php7.1-opcache php7.1-pgsql php7.1-redis php7.1-xml php7.1-curl php7.1-apcu  \
    php7.1-bcmath php7.1-mcrypt php7.1-zip php7.1-gd php-xdebug php-imagick php-yaml \
    libfreetype6-dev libjpeg62 libmcrypt-dev libpng12-dev libmemcached-dev libgmp-dev libmhash-dev \
    zlib1g-dev libicu-dev libpq-dev libxml2-dev libmagickwand-dev graphviz

RUN pecl channel-update pecl.php.net && pecl install redis apcu imagick mongodb

# XHProf
RUN mkdir /tmp/xhprof && mkdir -p /var/www && cd /var/www && git clone https://github.com/longxinH/xhprof \
    && cd xhprof/extension && phpize && ./configure && make && make install

# Nginx && Supervisor
RUN apt-get -y install nginx supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf
EXPOSE 9001

# PHP socket
RUN mkdir -p /var/run/php/sessions && chmod 0777 -R /var/run/php/sessions

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# node
RUN cd ~ && curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash \
    && . ~/.bashrc && nvm install v8.10.0 && nvm use v8.10.0 \
    && npm install -g svgo && npm install -g --unsafe-perm puppeteer

# optimize images
RUN apt-get install -y jpegoptim optipng pngquant gifsicle

# Clean all
RUN apt-get autoremove &&  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN usermod -u 1000 www-data && usermod -G staff www-data

ADD bashrc /root/.bashrc

CMD ["supervisord"]