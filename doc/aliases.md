## Aliases and CLI

### LAMP
```
alias lamp="docker-compose -f /path/to/docker-compose.yml"
```
You can then `lamp up -d` and `lamp stop` to start/stop the LAMP stack.

### MySQL
To play with `mysql` from CLI you can add theses aliases:
```
alias mysql="docker exec -i docker_db mysql"
alias mysqldump="docker exec -i docker_db mysqldump"
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