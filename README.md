# LEMP stack with Docker Toolbox

## Overview
This is my development environment which run a Linux [LEMP stack](https://lemp.io/) that work on most of my PHP projects. All the Docker images are based on Alpine Linux to get something that remains light for disk space.

- Container web: Nginx
- Container php: PHP5.x/7.x with FPM and all common PHP extensions
- Container db: MariaDB 10.x
- Container mail: Maildev
- Container cache: Redis

## Installation

* [on macOS](doc/install-osx.md)
* [on Linux](doc/install-linux.md)

## What next?

* [Post configuration](doc/config.md)
* [Aliases and CLI](doc/aliases.md)
* [Local development with Wildcard DNS](doc/dns.md)
* [Trusted development SSL certificates](doc/ssl.md)

## Read further

* http://mmenozzi.github.io/2016/01/22/php-web-development-with-docker/
* https://github.com/nerdpress-org/docker-sf3
* http://stackoverflow.com/questions/40012198/docker-custom-dns-resolve-among-containers