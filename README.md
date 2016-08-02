# LAMP stack with Docker Toolbox

## Overview
This is my development environment which run a Linux LAMP stack that work on most of my PHP projects. All the Docker images are based on Alpine Linux to get something that remains light for disk space.

- Container web: Nginx latest (~70Mb)
- Container php: PHP7 with FPM and all common PHP extensions (~70Mb)
- Container db: MariaDB (~170Mb)
- Container mail: Maildev (~35Mb)

## Prerequisites
- [HomeBrew](http://brew.sh/)

## Requirements
```sh
$ brew install caskroom/cask/brew-cask
$ brew cask install virtualbox
$ brew install docker docker-machine docker-compose docker-machine-nfs docker-clean
$ source ~/.zshrc
```

## Init

The init process does the following stuff:
- Create a boot2docker ISO from Virtualbox, named for instance `dev-nfs`
- Change the shared filesystem to Network File System (NFS)
- Create a custom briged network named `lamp-network` 
- Launch the Compose file with the linked containers

So in CLI you should type something like this:
```sh
$ docker-machine create --driver virtualbox dev-nfs
$ docker-machine-nfs dev-nfs
$ docker network create --driver bridge lamp-network
$ docker-compose -f /path/to/docker/docker-compose up -d
```

## What next?

* [Post configuration](config.md)
* [Network File System](nfs.md)
* [Aliases and CLI](aliases.md)


## Some other interesting links
- http://mmenozzi.github.io/2016/01/22/php-web-development-with-docker/
