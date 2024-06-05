# Docker on macOS

## Prerequisites

- [Homebrew](https://brew.sh/)

## Init

1 - Install docker

```sh
brew install docker docker-compose docker-buildx
```

Set the plugin folder in docker config

```sh
cat ~/.config/docker/config.json
    {
        "auths": {},
        "currentContext": "colima",
        "cliPluginsExtraDirs": [
            "/opt/homebrew/lib/docker/cli-plugins"
        ]
    }
```

2 - Install colima

Here we use [Colima](https://github.com/abiosoft/colima/), a wrapper around [Lima](https://github.com/lima-vm/lima) (Linux Machines) to ease the management of docker containers with sane performance and facilities.

```sh
colima start \
    --profile default \
    --activate \
    --network-address \
    --arch aarch64 \
    --cpu 10 \
    --disk 48 \
    --memory 8 \
    --mount ${HOME}:w \
    --ssh-agent \
    --vm-type vz \
    --vz-rosetta \
    --verbose
```

- adapt `--arch`, `--cpu`, `--disk`, `--memory` with your actual machine
- for arm device only `--vm-type vz`, `--vz-rosetta` (need rosetta installed)
- `--network-address` expose the public IP (if you need to deal with local domain)
- the config generated is here `~/.colima/default/colima.yaml`
- the log can be found here `~/.colima/default/daemon/daemon.log`

3 - Export the following environment variables to your current shell

```sh
export COLIMA_VM="default"
export COLIMA_VM_SOCKET="${HOME}/.colima/${COLIMA_VM}/docker.sock"
export DOCKER_HOST="unix://${COLIMA_VM_SOCKET}"
```

4 - Test

```sh
docker run --rm hello-world
docker compose version
```

## What's next?

- [Post configuration](config.md)

## Read further

- [https://medium.com/@guillem.riera/the-most-performant-docker-setup-on-macos-apple-silicon-m1-m2-m3-for-x64-amd64-compatibility-da5100e2557d]
