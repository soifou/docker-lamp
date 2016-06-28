FROM mbodenhamer/alpine:latest
MAINTAINER Matt Bodenhamer <mbodenhamer@mbodenhamer.com>

RUN apk add --no-cache \
    curl \
    git \
    mysql-client \
    nano \
    php-cli \
    php-curl \
    php-dom \
    php-json \
    php-mysql \
    php-openssl \
    php-phar \
    zip

RUN mkdir /usr/local/share/php && cd /usr/local/share/php &&\
    curl -sSfLJO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    php wp-cli.phar --allow-root cli version &&\
    chmod +x wp-cli.phar &&\
    ln -s /usr/local/share/php/wp-cli.phar /usr/local/bin/wp &&\
    wp --allow-root cli version &&\
    curl -sS https://getcomposer.org/installer | php &&\
    php composer.phar -V &&\
    chmod +x composer.phar &&\
    ln -s /usr/local/share/php/composer.phar /usr/local/bin/composer &&\
    composer -V