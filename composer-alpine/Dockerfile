FROM alpine:edge
MAINTAINER Samuel Parkinson <sam@graze.com>

RUN apk add --no-cache --repository "http://dl-cdn.alpinelinux.org/alpine/edge/testing" \
    ca-certificates \
    git \
    openssh \
    php7 \
    php7-curl \
    php7-ctype \
    php7-dom \
    php7-iconv \
    php7-json \
    php7-openssl \
    php7-pdo \
    php7-pdo_mysql \
    php7-phar \
    php7-posix \
    php7-session

RUN php7 -r "readfile('https://getcomposer.org/installer');" | \
    php7 -- --install-dir /usr/local/bin --filename composer && \
    mkdir -p /home/composer/.composer && \
    ln -s /root/.ssh /home/composer/.ssh

COPY composer-wrapper /usr/local/bin/composer-wrapper
RUN chmod +x /usr/local/bin/composer-wrapper

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /home/composer/.composer

WORKDIR /usr/src/app

VOLUME ["/home/composer/.composer"]

ENTRYPOINT ["/usr/local/bin/composer-wrapper"]