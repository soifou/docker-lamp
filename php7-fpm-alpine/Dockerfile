FROM alpine:edge
MAINTAINER François Fleur <fleur.fr@gmail.com>

# see: http://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management#Update_the_Package_list

RUN apk upgrade -U && \
    apk --update --repository=http://dl-4.alpinelinux.org/alpine/edge/testing add \
    # wkhtmltopdf dependencies for alpine
    # ttf-freefont fontconfig \
    ##############################################
    # to run some glibc binary on alpine-linux we have to call explicitly the musl runtime like this:
    # $ /lib/ld-musl-x86_64.so.1 binary args
    # see https://github.com/gliderlabs/docker-alpine/issues/47
    ##############################################
    make \
    php7 \
    zsh \
    git \
    php7-bcmath \
    php7-dom \
    php7-ctype \
    php7-curl \
    php7-fpm \
    # php7-gd \
    php7-iconv \
    php7-intl \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-openssl \
    # php7-opcache \
    php7-pdo \
    php7-pdo_mysql \
    php7-posix \
    php7-soap \
    php7-session \
    php7-xml \
    php7-zip \
    rm -fr /var/cache/apk/*

RUN git clone https://github.com/zsh-users/antigen.git $HOME/.antigen
COPY zshrc /root/.zshrc

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

VOLUME /app
EXPOSE 9000

CMD ["php-fpm7", "-F"]
