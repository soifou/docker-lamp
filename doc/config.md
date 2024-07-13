# Post configuration

## 1 - Host volume

Set your host volume in `docker-compose.yml` in web/php container.

```yaml
web:
    [...]
    volumes:
        - ~/Development:/app
    [...]
```

- `~/Development` is my local folder where I store all my projects.
- `/app` is the root folder for web/php container, don't change it.

## 2 - Nginx conf

Enable a default conf to serve PHP files:

```sh
cp nginx/conf.d/000-default.conf.dist nginx/conf.d/000-default.conf
```

Obviously you can add other config file to add others projects (see
`_example.conf.dist`).

## 3 - PHP conf (optional)

Set your custom php.ini variables here `php/php.ini`.

Add a dummy phpinfo:

```sh
echo "<?php phpinfo() ?>" >~/Development/index.php
```

## 4 - Restart web/php container

Since you tweak the conf, restart impacted containers:

```sh
docker-compose -f /path/to/docker/docker-compose.yml restart php web
```

## 5 - Update your hosts

### Manually

Add an entry in `/etc/hosts` to point to your custom domain, ie:

```conf
192.168.99.100 my.local # for macOS
127.0.0.1 my.local # for linux
```

Each time you create/delete a server block, you must update your hosts file
accordingly.

### Automatically

You should try instead to setup a DNS server to avoid these tedious task. I use
dnsmasq and it works like a charm.

## 6 - Finish

No more require config. Check in your browser your awesome new project:
[http://my.test/]

## What's next?

- [Aliases and CLI](aliases.md)
- [Local development with Wildcard DNS](dns.md)
- [Trusted development SSL certificates](ssl.md)
