# DNS

There is dozen of possibilities to avoid to touch host file and benefit from domain wilcards.

I use dnsmasq, a small dns server.

## Linux way

Arch and Debian comes with a dnsmasq packaged with the [NetworkManager](https://wiki.archlinux.org/index.php/NetworkManager) utility.

To redirect all your local domains (ie. \*.test), 

1 - Check NetworkManager use dnsmasq as DNS resolver:

File: `/etc/NetworkManager/NetworkManager.conf`

```ini
[main]
dns=dnsmasq
```

2 - Add an entry to `/etc/NetworkManager/dnsmasq.d/` and restart NetworkManager:

```sh
# echo "address=/test/127.0.0.1" > /etc/NetworkManager/dnsmasq.d/docker
# systemctl restart NetworkManager
```

3 - Verify `/etc/resolv.conf` content, it should be:

```
search home
nameserver 127.0.0.1
```


## macOS way

macOS doesn't bundle dnsmasq but we can install it via homebrew.
First you need to know IP address of your running docker-machine.

```sh
$ brew update
$ brew install dnsmasq
$ echo "address=/test/$(docker-machine ip xxx)" > /usr/local/etc/dnsmasq.conf
$ sudo mkdir -p /etc/resolver
$ sudo tee /etc/resolver/test >/dev/null <<EOF
nameserver 127.0.0.1
EOF
$ sudo brew services start dnsmasq
```

More info [here](https://blog.thesparktree.com/local-development-with-wildcard-dns) and [there](https://passingcuriosity.com/2013/dnsmasq-dev-osx/).

## Docker way

Not tested but it seems an interesting way to do it, [read here](https://adrianperez.org/improving-dev-environments-all-the-http-things/).
