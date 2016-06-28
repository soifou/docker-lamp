# DOCKER LAMP STACK on OSX

## Overview
This is my development environment which run a Linux LAMP stack that work on most of my PHP projects. All the Docker images are based on Alpine Linux to get something that remains light for disk space.

- Container web: Nginx latest (~70Mb)
- Container php: PHP7 with FPM and all common PHP extensions (~100Mb)
- Container db: MariaDB (~170Mb)
- Container mail: Maildev (~35Mb)

## Requirements
```sh
$ brew cask install virtualbox
$ brew install docker docker-machine docker-compose docker-machine-nfs docker-clean
$ source ~/.zshrc
```

## Init
TL;TR
```
$ make init
```

Create a boot2docker iso from Virtualbox, named for instance `dev-nfs`, change the share filesystem to NFS and launch all the linked containers to get the lamp stack running:
```sh
$ docker-machine create --driver virtualbox dev-nfs
$ docker-machine-nfs dev-nfs
$ cd path/to/docker/conf
$ docker-compose up -d
```

## Start/stop the LAMP stack
```sh
$ make start
...
$ make stop
```

## Start/stop Docker, machine and and the LAMP stack
```sh
$ make up
...
$ make down
```

## NFS (Fix permission and get high speed sharing on OSX)
The `docker-machine-nfs dev-nfs` should do the stuff.
Check out `/etc/exports` file you should see a value like this:
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
To cleanup container/images with ease I recommand to install `docker-cleanup` tool: https://github.com/meltwater/docker-cleanup
```sh
$ brew install docker-cleanup
```
Simply do a `docker-cleanup` and it will do most of the job.

## Aliases and CLI

To play with `mysql` from CLI you can add theses aliases:
```
alias mysql="docker exec -i docker_db mysql"
alias mysqldump="docker exec -i docker_db mysqldump"
```

