# Trusted development SSL certificates

Here's the steps to set up a local secured website.

1 - Serve SSL from web container:

```
web:
    ports:
        [...]
        - 443:443
    volumes:
        [...]
        - ./nginx/ssl/:/etc/nginx/ssl
```

2 - Generate a trusted development certificate:

Using [mkcert](https://github.com/FiloSottile/mkcert) you can easily generate trusted certificates:

```sh
$ cd /dir/to/nginx/ssl
$ mkcert secured.local
```

3 - Configure server block to serve https:

```
server {
    server_name secured.local;
    root /app/secured;

    include snippets/ssl.conf;
    include snippets/basic-php.conf;
}
```

4 - Restart web container:

```sh
$ docker-compose restart web
$ docker-compose exec web chown -R root:root /etc/nginx/ssl
$ docker-compose exec web chmod 644 /etc/nginx/ssl/secured.local-key.pem
```


5 - Test connection:

```sh
$ curl -I https://secured.local

HTTP/2 200
server: nginx/1.15.1
content-type: text/html; charset=UTF-8
x-powered-by: PHP/7.2.1
cache-control: no-store, no-cache, must-revalidate
pragma: no-cache
refresh: 0;url=https://secured.local
```
