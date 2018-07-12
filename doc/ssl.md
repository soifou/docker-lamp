# Trusted development SSL certificates

Here's the stesp to set up a local secured website.

1 - Serve SSL from web container:

```
web:
    image: nginx:1.15-alpine
    container_name: lamp_web
    ports:
        [...]
        - 443:443
    volumes:
        [...]
        - ./nginx/ssl/:/etc/nginx/ssl
```

2 - Generate a trusted development certificate:

Using [mkcert](https://github.com/FiloSottile/mkcert) you can easily generate trusted certificates:

```
$ mkcert secured.local
$ mv secured.local* /dir/to/nginx/ssl
```


3 - Configure server block to serve https:

```
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;

    server_name secured.local;
    root /app/secured;

    include snippets/ssl.conf;
    ssl_certificate /etc/nginx/ssl/secured.local.pem;
    ssl_certificate_key  /etc/nginx/ssl/secured.local-key.pem;

    include snippets/basic-php.conf;
}
```

4 - Restart web container:

```sh
$ docker-compose restart web
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
