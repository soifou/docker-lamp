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
lamp-mysql() {
    lamp stop db
    lamp rm -f db
    [ "$1" ] && lamp -f "$LEMP_REPO/docker-compose.mariadb$1.yml" up -d db || lamp up -d db
}
```

Worflow example:

- `lamp up -d web mysql php maildev`: Create and start containers
- `lamp-fpm 7.4`: Downgrade to PHP 7.4 container instead of latest PHP-FPM container
- `lamp-fpm`: Switch back to your latest PHP-FPM container
- `lamp-mysql 10.1`: Downgrade to MariaDB 10.1 instead
- `lamp stop`: Stop your containers
- `lamp rm -f`: Remove your containers

## MySQL

To play with `mysql` from CLI you can add theses aliases:

```sh
alias mysql-cli="docker exec -it lamp_db mysql -uroot -proot"
alias mysql="docker exec -i lamp_db mysql"
alias mysqldump="docker exec -i lamp_db mysqldump"
```

## PHP

To use PHP CLI you can add a function like this one:

```sh
php() {
    DEVELOPMENT_PATH="/Users/foo/Development"
    ABSOLUTE_PATH=$(pwd)
    RELATIVE_PATH="${ABSOLUTE_PATH//$DEVELOPMENT_PATH/}"
    # since we're working inside the lamp network
    # we should stick to the php container working path (/app)
    DOCKER_CURRENT_PATH="/app$RELATIVE_PATH"
    docker run -it --rm \
        -v "$PWD":$DOCKER_CURRENT_PATH \
        -w $DOCKER_CURRENT_PATH \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.0 ${@:1}
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

## PHPUnit

```sh
phpunit() {
    docker run --rm -it \
        -v $(pwd):/app \
        --net=$DOCKER_NETWORK_NAME \
        phpunit/phpunit:latest ${@:1}
}
```
