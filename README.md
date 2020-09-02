# Docker Archlinux with Systemd

[![Build Status](https://travis-ci.com/CarloDePieri/docker-archlinux-systemd.svg?branch=master)](https://travis-ci.com/CarloDePieri/docker-archlinux-systemd)

An updated Archlinux docker image (based on [archlinux](https://hub.docker.com/_/archlinux))
with the full base group and Systemd support.

## Building the image

You need a [working Docker installation](https://docs.docker.com/engine/install/).
Then run:

```bash
docker build -t carlodepieri/docker-archlinux-systemd .
```

or, for convenience:

```bash
make
```

This will build the image. The command `docker images` can then be used to verify a
successful build.

## Creating a new container

Run:

```bash
docker run --name=cdp-arch-systemd --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro
carlodepieri/docker-archlinux-systemd
```

or, for convenience:

```bash
make run-container
```

This will start a new container based on the image with the cgroup folder available
as read-only and `--privileged`.

> **Important Note**: these steps are necessary to make systemd behave,
> but be sure to understand [the security concerns involved](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities).

## Connecting to the container

Run:

```bash
docker exec -it cdp-arch-systemd env TERM=xterm bash
```

or, for convenience:

```bash
make shell
```
