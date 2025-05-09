# Docker Archlinux with Systemd

[![prod](https://github.com/CarloDePieri/docker-archlinux-systemd/actions/workflows/prod.yml/badge.svg)](https://github.com/CarloDePieri/docker-archlinux-systemd/actions/workflows/prod.yml) [![Docker Cloud Automated build](https://img.shields.io/badge/docker%20build-automatic-success)](https://hub.docker.com/r/carlodepieri/docker-archlinux-systemd) [![Maintenance](https://img.shields.io/maintenance/yes/2025)](https://github.com/CarloDePieri/docker-archlinux-systemd)

An updated Archlinux docker image (based on [archlinux](https://hub.docker.com/_/archlinux))
with the full base group and Systemd support.

Images are built by GitHub CI, tagged and pushed to DockerHub once a month.

#### Available tags

Arch is a rolling release distribution. This means that the [available tags](https://hub.docker.com/r/carlodepieri/docker-archlinux-systemd/tags)
are nothing more than arbitrary snapshots of the distro at that particular time.

Beware when using tags in automated testing environments: while usually a good
practice, keep in mind that in reality Arch is changing daily and that a system
test with a pinned environment could become useless quickly. A more in-depth
discussion on this can be found [here](https://github.com/CarloDePieri/docker-archlinux-ansible/issues/6).

## From Docker Hub

A [working Docker installation](https://docs.docker.com/engine/install/) is needed.
Then pull the image with:

```bash
docker pull carlodepieri/docker-archlinux-systemd
```

Create and start a container with:

```bash
docker run --detach --privileged carlodepieri/docker-archlinux-systemd
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
docker build --target build -t carlodepieri/docker-archlinux-systemd .
```

or, for convenience:

```bash
make
```

This will build the image. The command `docker images` can then be used to verify
a successful build.

### Creating a new container

Run:

```bash
docker run --name=cdp-arch-systemd --detach --privileged carlodepieri/docker-archlinux-systemd
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

## Compatibility with systems that need cgroups volumes

Certain combinations of systemd, docker and linux kernel cgroup configuration may
require the cgroup folder manually mounted inside the container. In this case
checkout the git repository and run:

```bash
docker build --target build_with_volume -t carlodepieri/docker-archlinux-systemd .
```

or:

```bash
make build-image-volume
```

Then run the container with:

```bash
docker run --name=cdp-arch-systemd --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro carlodepieri/docker-archlinux-systemd
```

or:

```bash
make run-container-volume
```

A shell can still be obtained as illustrated above.

## Note

Containers started this way will have extended control over the host because of the `--privileged` flag.

> **Important**: these steps are necessary to make systemd behave,
> but be sure to understand [the security concerns involved](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities).
