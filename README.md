# DOCKER LAMP STACK on OSX

## Overview
This is my development environment which run a Linux LAMP stack that work on most of my PHP projects. All the Docker images are based on Alpine Linux to get something that remains light for disk space.

- Container web: Nginx latest (~70Mb)
- Container php: PHP7 with FPM and all common PHP extensions (~100Mb)
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
TL;TR
```
$ make init
```

The init process does the following stuff:
- Create a boot2docker ISO from Virtualbox, named for instance `dev-nfs`
- Change the shared filesystem to Network File System (NFS)
- Create a custom briged network named `lamp-network` 
- Launch the Compose file with the linked containers

```sh
$ docker-machine create --driver virtualbox dev-nfs
$ docker-machine-nfs dev-nfs
$ docker network create --driver bridge lamp-network
$ cd path/to/docker/conf
$ docker-compose up -d
```

## Start/stop the LAMP stack
```sh
$ make start
... do stuff ...
$ make stop
```

## Start/stop Docker, machine and the LAMP stack
```sh
$ make up
... do stuff ...
$ make down
```

## About Network File System (NFS)
VirtualBox use `vboxfs` which is incredibly slow, specially when you deal with some PHP frameworks (ie. Symfony, Laravel) that require constant read/write. It exists [some alternatives](https://github.com/brikis98/docker-osx-dev#alternatives) to speed up your environment.

`docker-machine-nfs` fix my permissions problems and increase speed. So I stuck with this at the moment.

Once the NFS is enabled on your docker machine, check out `/etc/exports` file you should see a value like this:
```
/Users 192.168.99.100 -alldirs -mapall=501:20
```
If not try to set:
```
$ docker-machine-nfs dev-nfs -f --nfs-config="-alldirs -mapall=501:20"
```
To disable NFS support:
```
$ docker-machine-nfs dev-nfs -f --nfs-config="-alldirs -maproot=0"
```

## Play with docker
Build and commit your own images:
```sh
$ docker build folderwithDockerfile/
$ docker tag commit owner/repo:tag
```

Test you docker image freshly cooked
```sh
$ docker run -it --rm owner/repo cmd
```

Create an account to Docker hub
```sh
$ docker login
$ docker push owner/repo
```

Read further:
- https://github.com/docker/dceu_tutorials/blob/master/08-Automated-builds.md
- https://docs.docker.com/engine/userguide/containers/dockerrepos/
- https://docs.docker.com/docker-hub/github/

## Cleanup
To cleanup containers/images/networks with ease I recommand to install [docker-cleanup](https://github.com/meltwater/docker-cleanup)
```sh
$ brew install docker-cleanup
```
Simply do `docker-clean` regularly and it will do most of the job.

## Aliases and CLI

To play with `mysql` from CLI you can add theses aliases:
```
alias mysql="docker exec -i docker_db mysql"
alias mysqldump="docker exec -i docker_db mysqldump"
```

## Some other interesting links
- http://mmenozzi.github.io/2016/01/22/php-web-development-with-docker/
