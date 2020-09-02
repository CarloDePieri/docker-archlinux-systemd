# Docker Archlinux with Systemd

[![Build Status](https://travis-ci.com/CarloDePieri/docker-archlinux-systemd.svg?branch=master)](https://travis-ci.com/CarloDePieri/docker-archlinux-systemd) [![Docker Automated build](https://img.shields.io/docker/automated/carlodepieri/docker-archlinux-systemd.svg?maxAge=2592000)](https://hub.docker.com/r/carlodepieri/docker-archlinux-systemd/)

An updated Archlinux docker image (based on [archlinux](https://hub.docker.com/_/archlinux))
with the full base group and Systemd support.

## From Docker Hub

A [working Docker installation](https://docs.docker.com/engine/install/) is needed.
Then pull the image with:

```bash
docker pull carlodepieri/docker-archlinux-systemd
```

Create and start a container with:

```bash
docker run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro carlodepieri/docker-archlinux-systemd
```

A shell can then be obtained with:

```bash
docker exec -it [container-id] env TERM=xterm bash
```

## From GitHub

Clone the repo first with:

```bash
git clone git@github.com:CarloDePieri/docker-archlinux-systemd.git
```

### Building the image

A [working Docker installation](https://docs.docker.com/engine/install/) is needed.
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

### Creating a new container

Run:

```bash
docker run --name=cdp-arch-systemd --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro carlodepieri/docker-archlinux-systemd
```

or, for convenience:

```bash
make run-container
```

### Connecting to the container

Run:

```bash
docker exec -it cdp-arch-systemd env TERM=xterm bash
```

or, for convenience:

```bash
make shell
```

## Note

Containers started this way will have cgroup folder available
as read-only and `--privileged` turned on.

> **Important**: these steps are necessary to make systemd behave,
> but be sure to understand [the security concerns involved](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities).
