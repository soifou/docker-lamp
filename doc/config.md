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
$ cp nginx/conf.d/000-default.conf.dist nginx/conf.d/000-default.conf
```

Obviously you can add other config file to add others projects (see `example.conf.dist`).


### PHP conf

Set your custom php.ini variables here `php/php.ini`.

### Restart web/php container

Since you tweak the conf, restart impacted containers:
```
$ docker-compose -f /path/to/docker/docker-compose.yml restart php web
```

### Update your hosts

Add an entry into `/etc/hosts` to point to your custom domain, ie:
```
# OSX
192.168.99.100 local.dev

# Linux
127.0.0.1 local.dev
```

Go to your browser : http://local.dev

## What's next?
* [Aliases and CLI](aliases.md)