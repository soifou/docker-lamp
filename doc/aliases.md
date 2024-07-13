# Aliases

## LEMP

Some useful aliases to manage your containers.

```sh
LEMP_REPO="/path/to/lamp"
alias lamp="docker-compose -f $LEMP_REPO/docker-compose.yml"

# switch to different php-fpm versions
lamp-fpm() {
    lamp stop php
    lamp rm -f php
    [ "$1" ] && lamp -f "$LEMP_REPO/docker-compose.php$1.yml" up -d php || lamp up -d php
}

# switch to different mariadb versions
lamp-mariadb() {
    lamp stop db
    lamp rm -f db
    [ "$1" ] && lamp -f "$LEMP_REPO/docker-compose.mariadb$1.yml" up -d db || lamp up -d db
}
```

Worflow example:

- `lamp up -d web mariadb php mail`: Create and start containers
- `lamp-fpm 7.4`: Downgrade to PHP 7.4 container instead of latest PHP-FPM container
- `lamp-fpm`: Switch back to your latest PHP-FPM container
- `lamp-mariadb 10.1`: Downgrade to MariaDB 10.1 instead
- `lamp stop`: Stop your containers
- `lamp rm -f`: Remove your containers

## MySQL

To play with `mariadb` from CLI you can add theses aliases:

```sh
alias mysql="lamp exec mariadb mariadb -proot"
alias mysqlimport="lamp exec -T mariadb mariadb -proot"
# Need mariadb-server-utils
alias mysqldump="docker exec -i lamp_db mariadb-dump"
```

## PHP

To use PHP CLI you can add a function like this one:

```sh
php() {
    cpath="/app/${$(pwd)//$XDG_DEVELOP_DIR/}"

    # NOTE: add custom port in case we want to use the build-in php webserver feature
    # available in many php framework. (-p 8080:8080)
    # php bin/console server:run 0.0.0.0:8080
    # --add-host domain.test:172.17.0.5 \
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -v "$PWD":$cpath \
        -w $cpath \
        -u `id -u`:`id -g` \
        --env COMPOSER_HOME=$cpath/.composer \
        --env COMPOSER_CACHE_DIR=$cpath/.composer/cache \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-${PHP_VERSION:-8.3}-wkhtmltopdf php ${@:1}
}
```

For instance if we are working on `project` the folder path could be here:

- macOS : `/Users/foo/Development/project1`
- Docker : `/app/project1`

Or inside inside a subfolder:

- macOS : `/Users/foo/Development/repository1/project1`
- Docker : `/app/repository1/project1`

So we have to substitute the absolute path to guess the folder path for the
current project in the php container.

## Composer

```sh
composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        --net=lamp-network \
        soifou/composer-alpine ${@:1}
}
```

## WP-CLI

```sh
wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        -u $(id -u):$(id -g) \
        --net=lamp-network \
        soifou/wpcli-alpine ${@:1}
}
```
