# Docker Toolbox on OSX

## Prerequisites
- [HomeBrew](http://brew.sh/)

## Requirements
```sh
$ brew install caskroom/cask/brew-cask
$ brew cask install virtualbox
$ brew install docker docker-machine docker-compose docker-machine-nfs docker-clean
```

## Init
The init process does the following stuff:
* Create a boot2docker ISO from Virtualbox, named for instance `dev-nfs`
* Change the shared filesystem to Network File System (NFS)
* Create a custom briged network named `lamp-network` 
* Launch the Compose file with the linked containers

So in CLI you should type something like this:
```sh
$ docker-machine create --driver virtualbox dev-nfs
$ docker-machine-nfs dev-nfs
$ docker network create --driver bridge lamp-network
$ docker-compose -f /path/to/docker/docker-compose up -d
```

## Why NFS ?
* [OSX Network File System](doc/nfs.md)

## Tweak 
Since you have to add docker vars each time you load a shell, add this to your bashrc/zshrc/whateverrc:

```
DOCKER_MACHINE_NAME="dev-nfs"
if [[ `docker-machine status $DOCKER_MACHINE_NAME` == "Running" ]]; then
    eval $(docker-machine env $DOCKER_MACHINE_NAME)
fi
```

Then start a shell session Docker should return its vars:
```
env | grep DOCKER
```

## What's next?
* [Post configuration](doc/config.md)

## Read further
* https://www.docker.com/products/docker-toolbox
* https://docs.docker.com/machine/get-started/
