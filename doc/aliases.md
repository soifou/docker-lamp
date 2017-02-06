## Aliases and CLI

### LAMP
Some useful aliases to manage your containers.
```
alias lamp="docker-compose -f /path/to/docker-compose.yml"
alias lamp5.6="lamp -f /path/to/docker-compose.php5.6.yml"
alias lamp7.0="lamp -f /path/to/docker-compose.php7.0.yml"
# switch to php version
alias lamp-switch="lamp5.6 stop php && lamp7.0 stop php && lamp up -d php"
alias lamp-switch5.6="lamp stop php && lamp7.0 stop php && lamp5.6 up -d php"
alias lamp-switch7.0="lamp stop php && lamp5.6 stop php && lamp7.0 up -d php"
```

Worflow example:
* `lamp up -d`: Create and start containers
* `lamp-switch5.6`: Use PHP 5.6 container intead of default PHP 7.1 container
* `lamp-switch7.0`: Use PHP 7.0 container intead of default PHP 7.1 container
* `lamp-switch`: Switch back to your default PHP 7.1 container
* `lamp stop`: Stop your containers
* `lamp rm -f`: Remove your container

### MySQL
To play with `mysql` from CLI you can add theses aliases:
```
alias mysql-cli="docker exec -it lamp_db mysql -uroot -proot"
alias mysql="docker exec -i lamp_db mysql"
alias mysqldump="docker exec -i lamp_db mysqldump"
```

### PHP
To use PHP CLI you can add a function like this one:
```
function php() {
    DEVELOPMENT_PATH=/Users/<me>/Development
    ABSOLUTE_PATH=$(pwd)
    RELATIVE_PATH="${ABSOLUTE_PATH//$DEVELOPMENT_PATH}"
    # since we're working inside the lamp network
    # we should stick to the php container working path (/app)
    DOCKER_CURRENT_PATH="/app$RELATIVE_PATH"
    docker run -it --rm \
        --name php7-cli-running-script \
        -v "$PWD":$DOCKER_CURRENT_PATH \
        -w $DOCKER_CURRENT_PATH \
        --net=$DOCKER_NETWORK_NAME \
        soifou/php-alpine:cli-7.0 ${@:1}
}
```
For instance if we are working on `project` the folder path could be here:
- OSX : `/Users/<me>/Development/project1`
- Docker : `/app/project1`

Or inside inside a subfolder:
- OSX : `/Users/<me>/Development/repository1/project1`
- Docker : `/app/repository1/project1`

So we have to substitute the absolute OSX path to guess the folder path for the current project in the php container.

### Composer
```
function composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        --net=$DOCKER_NETWORK_NAME \
        soifou/composer-alpine ${@:1}
}
```

### WP-CLI
```
function wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/wpcli-alpine ${@:1}
}
```

### n98-magerun (1.X)
```
function n98() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        -u `id -u`:`id -g` \
        --net=$DOCKER_NETWORK_NAME \
        soifou/n98-magerun-alpine ${@:1}
}
```