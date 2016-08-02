## Post configuration

### Host volume

Set your host volume in `docker-compose.yml` in web/php container.

```
web:
    [...]
    volumes:
        - ~/Development:/app
    [...]
```

### Nginx conf

Enable a default conf to serve PHP files:
```
$ cp nginx-alpine/conf.d/000-default.conf.dist nginx-alpine/conf.d/000-default.conf
```

Obviously you can add other config file to add peculiar projects (see `_example.conf.dist`).


### Restart web/php container

Since you tweak the conf, restart impacted containers:
```
$ docker-compose -f /path/to/docker/docker-compose.yml restart php
$ docker-compose -f /path/to/docker/docker-compose.yml restart web
```

### Update your hosts

Add an entry into `/etc/hosts` to point to your custom domain, ie:
```
192.168.99.100 local.dev
```

Go to your browser : http://local.dev