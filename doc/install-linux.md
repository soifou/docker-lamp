# Docker toolbox on Linux

## Prerequisites
* [Docker](https://docs.docker.com/engine/installation/linux/)
* [Docker-compose](https://docs.docker.com/compose/install/)

## Init
```
$ docker network create --driver bridge lamp-network
$ docker-compose -f /path/to/docker/docker-compose up -d
```

That's all !

## What's next?
* [Post configuration](doc/config.md)