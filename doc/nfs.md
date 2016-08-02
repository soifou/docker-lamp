## About Network File System (NFS)
VirtualBox use `vboxfs` which is incredibly slow, specially when you deal with some PHP frameworks (ie. Symfony, Laravel) that require constant read/write. It exists [some alternatives](https://github.com/brikis98/docker-osx-dev#alternatives) to speed up your environment.

`docker-machine-nfs` fix my permissions problems and increase speed. So I stuck with this at the moment.

Once the NFS is enabled on your docker machine, check out `/etc/exports` file you should see a value like this:
```
/Users 192.168.99.100 -alldirs -mapall=501:20
```
If not try to set:
```
$ docker-machine-nfs dev-nfs -f --nfs-config="-alldirs -mapall=501:20"
```
To disable NFS support:
```
$ docker-machine-nfs dev-nfs -f --nfs-config="-alldirs -maproot=0"
```