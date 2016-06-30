# Composer Alpine

## Build and tag your image

First build the Composer Alpine docker image:
```sh
$ docker build /path/to/composer-alpine
```

Then tag the new build image:
```sh
$ docker tag IMAGE_ID owner/repo:latest
```

In order to work with the LAMP stack, you should check the following: 
- the LAMP containers are up
- the docker network

To check the docker network, type:
```
$ docker network ls
```
And pick the one from the lamp stack, `lamp-network`.

## Alias

Create an alias in your shell rc file like below:
```sh
function composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        --net=lamp-network \
        owner/repo ${@:1}
}
```

When reloading your shell, `composer` should be available anywhere.


