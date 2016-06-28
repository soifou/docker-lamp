# WP-CLI on Alpine Linux


## Bash alias

You can create a bash alias like this:
```
function wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        --net=docker_default \
        mbodenhamer/alpine-wpcli wp --path=/mnt ${@:1}
}
```
Assuming docker network is `docker_default`.
See your available networks with `docker network ls`

## Database operations

If you want import/export database, you can do something like this:
```
$ wp db import /mnt/dump.sql
```
Since the `--path` point inside the container, your dump must be available inside.