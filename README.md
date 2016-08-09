# LAMP stack with Docker Toolbox

## Overview
This is my development environment which run a Linux LAMP stack that work on most of my PHP projects. All the Docker images are based on Alpine Linux to get something that remains light for disk space.

- Container web: Nginx latest (~70Mb)
- Container php: PHP7 with FPM and all common PHP extensions (~70Mb)
- Container db: MariaDB (~170Mb)
- Container mail: Maildev (~35Mb)

## Installation

* [on OSX](doc/install-osx.md)
* [on Linux](doc/install-linux.md)

## What next?

* [Post configuration](doc/config.md)
* [Aliases and CLI](doc/aliases.md)

## Read further
* http://mmenozzi.github.io/2016/01/22/php-web-development-with-docker/
* https://github.com/nerdpress-org/docker-sf3
