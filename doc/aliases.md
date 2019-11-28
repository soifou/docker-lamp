## Aliases and CLI

### LEMP

Some useful aliases to manage your containers.

```sh
LEMP_REPO="/path/to/lamp"
alias lamp="docker-compose -f $LEMP_REPO/docker-compose.yml"

# switch to different php-fpm versions
alias lamp-fpm="lamp stop php && lamp rm -f php && lamp up -d php"
alias lamp-fpm7.2="lamp stop php && lamp rm -f php && lamp -f $LEMP_REPO/docker-compose.php7.2.yml up -d php"
alias lamp-fpm7.1="lamp stop php && lamp rm -f php && lamp -f $LEMP_REPO/docker-compose.php7.1.yml up -d php"
alias lamp-fpm7.0="lamp stop php && lamp rm -f php && lamp -f $LEMP_REPO/docker-compose.php7.0.yml up -d php"
alias lamp-fpm5.6="lamp stop php && lamp rm -f php && lamp -f $LEMP_REPO/docker-compose.php5.6.yml up -d php"
alias lamp-fpm5.3="lamp stop php && lamp rm -f php && lamp -f $LEMP_REPO/docker-compose.php5.3.yml up -d php"
# switch to different mariadb versions
alias lamp-mariadb="lamp stop db && lamp rm -f db && lamp up -d db"
alias lamp-mariadb10.1="lamp stop db && lamp rm -f db && lamp -f $LAMP_REPO/docker-compose.mariadb10.1.yml up -d db"
alias lamp-mariadb10.2="lamp stop db && lamp rm -f db && lamp -f $LAMP_REPO/docker-compose.mariadb10.2.yml up -d db"
alias lamp-mariadb10.4="lamp stop db && lamp rm -f db && lamp -f $LAMP_REPO/docker-compose.mariadb10.4.yml up -d db"
```

Worflow example:

-   `lamp up -d`: Create and start containers
-   `lamp-fpm5.6`: Use PHP 5.6 container instead of latest PHP-FPM container
-   `lamp-fpm`: Switch back to your latest PHP-FPM container
-   `lamp-mariadb10.1`: Use MariaDB 10.1 instead
-   `lamp stop`: Stop your containers
-   `lamp rm -f`: Remove your container

### MySQL

To play with `mysql` from CLI you can add theses aliases:

```sh
alias mysql-cli="docker exec -it lamp_db mysql -uroot -proot"
alias mysql="docker exec -i lamp_db mysql"
alias mysqldump="docker exec -i lamp_db mysqldump"
```

### PHP

To use PHP CLI you can add a function like this one:

```sh
php() {
    DEVELOPMENT_PATH=/Users/<me>/Development
    ABSOLUTE_PATH=$(pwd)
    RELATIVE_PATH="${ABSOLUTE_PATH//$DEVELOPMENT_PATH}"
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

-   OSX : `/Users/<me>/Development/project1`
-   Docker : `/app/project1`

Or inside inside a subfolder:

-   OSX : `/Users/<me>/Development/repository1/project1`
-   Docker : `/app/repository1/project1`

So we have to substitute the absolute OSX path to guess the folder path for the current project in the php container.

### Composer

```sh
composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer-alpine ${@:1}
}
```

### WP-CLI

```sh
wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/wpcli-alpine ${@:1}
}
```

### n98-magerun (1.x)

```sh
n98() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/n98-magerun-alpine ${@:1}
}
```

### PHPUnit

```sh
phpunit() {
    docker run --rm -it \
        -v $(pwd):/app \
        --net=$DOCKER_NETWORK_NAME \
        phpunit/phpunit:latest ${@:1}
}
```
