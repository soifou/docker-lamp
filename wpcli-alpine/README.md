# WP-CLI on Alpine Linux


## Bash alias

You can create a bash alias like this:
```
function wp() {
    docker run -it --rm \
        -v $(pwd):/mnt \
        --net=lamp-network \
        mbodenhamer/alpine-wpcli wp --path=/mnt ${@:1}
}
```
Assuming docker network is `lamp-network`.
See your available networks with `docker network ls`

## Database operations

If you want import/export database, you can do something like this:
```
$ cd /path/to/wordpress/project
$ wp db import /mnt/dump.sql
```
Since the `--path` point inside the container, your dump must be available inside.