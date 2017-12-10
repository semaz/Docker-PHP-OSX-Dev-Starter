FROM php:7.1.12-fpm

ENV REFRESHED_AT="2017–12–11"

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get install -y --force-yes --no-install-recommends apt-utils wget

RUN apt-get install -y --force-yes wget curl git nano

# ppa:ondrej
RUN apt-get install -y --force-yes apt-transport-https lsb-release ca-certificates \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y --force-yes php-pear php7.1-common \
    php7.1-fpm php7.1-intl php7.1-json php7.1-memcached php7.1-mysql php7.1-cli \
    php7.1-opcache php7.1-pgsql php7.1-redis php7.1-xml php7.1-curl php7.1-xdebug \
    locales libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev libmemcached-dev \
    zlib1g-dev libicu-dev libpq-dev libxml2-dev libmagickwand-dev curl git nano \
    && dpkg-reconfigure -f noninteractive locales \
    && echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen \
    && locale-gen

# memcached
RUN cd /tmp && git clone https://github.com/php-memcached-dev/php-memcached && cd php-memcached && git checkout php7 \
    && phpize && ./configure --disable-memcached-sasl && make && make install

RUN docker-php-source extract \
    && pecl install redis apcu imagick \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo_mysql pdo_pgsql pgsql mysqli mcrypt pcntl zip \
    opcache intl mbstring \
    && docker-php-ext-enable opcache redis apcu memcached imagick \
    && docker-php-source delete

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# phpunit
RUN wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

RUN apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

RUN export LC_ALL=C

CMD ["php-fpm"]