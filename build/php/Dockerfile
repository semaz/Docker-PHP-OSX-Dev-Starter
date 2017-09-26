FROM php:7.1-fpm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
    && apt-get install -y --force-yes --no-install-recommends apt-utils

RUN apt-get install -y --force-yes wget curl

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && cd /usr/local/src && wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg

RUN apt-get install -y --force-yes apt-transport-https lsb-release ca-certificates \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

RUN apt-get update && apt-get install -y --force-yes php-pear php7.1-common php-all-dev \
    php7.1-fpm php7.1-intl php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-memcached php7.1-mysql \
    php7.1-opcache php7.1-pgsql php7.1-redis php7.1-zip php7.1-xml libcurl4-openssl-dev \
    libpng-dev libjpeg-dev libxml2-dev libpq-dev php7.1-apcu php7.1-gd php7.1-curl \
    php7.1-cli php7.1-bcmath php7.1-sqlite3 mysql-client libicu52 icu-devtools libicu-dev git nano \
    libxml2-dev libjpeg62-turbo-dev libpng12-dev libpng12-0 libpng3 libfreetype6 libfreetype6-dev \
    libmemcached-dev libmemcached11 php7.1-xdebug php7.1-bcmath

# Memcached
RUN cd /tmp && git clone https://github.com/php-memcached-dev/php-memcached && cd php-memcached && git checkout php7 \
    && phpize && ./configure --disable-memcached-sasl && make && make install

RUN docker-php-source extract \
    && pecl install redis apcu apcu_bc \
    && docker-php-ext-install -j$(nproc) gd bcmath pdo_mysql pdo_pgsql pcntl zip opcache mysqli intl \
    && docker-php-ext-enable opcache redis apcu memcached \
    && docker-php-source delete

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

ENV DEBIAN_FRONTEND teletype

RUN export LC_ALL=C

RUN wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

CMD ["php-fpm"]