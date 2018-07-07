# Docker Toolbox on OSX

## Prerequisites
- [HomeBrew](http://brew.sh/)

## Init

1 - Install docker toolbox:

```sh
$ brew install docker docker-machine docker-compose
```

2 - Create a docker machine using chosen driver:

*Using [virtualbox]() driver with NFS*

```sh
# install prerequisites
$ brew install caskroom/cask/brew-cask
$ brew cask install virtualbox
$ brew install docker-machine-nfs

# create the machine with NFS share solution
$ docker-machine create --driver virtualbox dev-nfs
$ docker-machine-nfs dev-nfs
```

*Using [xhyve](https://github.com/mist64/xhyve) driver*

```sh
# install/config prerequisites
$ brew install docker-machine-driver-xhyve
$ sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
$ sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

# create the machine with NFS share solution
$ docker-machine create --xhyve-cpu-count=2 --xhyve-memory-size=8192 --xhyve-disk-size=15000 --xhyve-experimental-nfs-share=true -d xhyve dev-xhyve
```

3 - Inject docker vars to current shell, create `lamp` network, start all containers:

```sh
$ eval $(docker-machine env dev-nfs)
$ docker network create --driver bridge lamp-network
$ cp docker-compose.yml.dist docker-compose.yml
$ docker-compose -f /path/to/docker/docker-compose up -d
```


## Why NFS ?

* [OSX Network File System](nfs.md)

## Tweak 

Since you have to add docker vars each time you load a shell, add this to your bashrc/zshrc/whateverrc:

```sh
DOCKER_MACHINE_NAME="dev-nfs"
if [[ `docker-machine status $DOCKER_MACHINE_NAME` == "Running" ]]; then
    eval $(docker-machine env $DOCKER_MACHINE_NAME)
fi
```

Then start a shell session Docker should return its vars:

```sh
$ env | grep DOCKER
```

## What's next?

* [Post configuration](config.md)

## Read further

* https://www.docker.com/products/docker-toolbox
* https://docs.docker.com/machine/get-started/
