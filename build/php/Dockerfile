FROM php:7.0-fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get install -y --force-yes --no-install-recommends apt-utils

RUN apt-get install -y --force-yes wget curl

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && cd /usr/local/src && wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg

RUN apt-get update && apt-get install -y --force-yes php7.0-fpm php7.0-dev php-pear php7.0-common php-all-dev \
    php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-memcached php7.0-mysql \
    php7.0-opcache php7.0-pgsql php7.0-redis php7.0-zip php7.0-xml libcurl4-openssl-dev \
    libpng-dev libjpeg-dev libxml2-dev libpq-dev php7.0-apcu php7.0-gd php7.0-curl \
    php7.0-cli php7.0-bcmath php7.0-sqlite3 mysql-client libicu52 icu-devtools libicu-dev git nano \
    libxml2-dev libjpeg62-turbo-dev libpng12-dev libpng12-0 libpng3 libfreetype6 libfreetype6-dev \
    libmemcached-dev libmemcached11

# Memcached
RUN cd /tmp && git clone https://github.com/php-memcached-dev/php-memcached && cd php-memcached && git checkout php7 \
    && phpize && ./configure --disable-memcached-sasl && make && make install

RUN docker-php-source extract \
    && pecl install redis apc apcu apcu_bc \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo_mysql pdo_pgsql pcntl zip opcache mysqli intl \
    && docker-php-ext-enable opcache redis apcu memcached \
    && docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV DEBIAN_FRONTEND teletype

RUN export LC_ALL=C

CMD ["php-fpm"]