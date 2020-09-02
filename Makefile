PACKAGE=carlodepieri/docker-archlinux-systemd
VERSION=latest
TAG=$(PACKAGE):$(VERSION)
NAME=cdp-arch-systemd
SHELL := /bin/bash

all: build

build: build-image

run: run-container

shell:
	docker exec -it $(NAME) env TERM=xterm bash

build-image:
	docker build -t $(TAG) .

run-container:
	docker run --name=$(NAME) --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro $(TAG)

test:
	[[ $$(docker exec $(NAME) systemctl show -p SystemState --value 2>/dev/null) == "running" ]] && exit 0 || exit 1

clean-container: 
	docker kill $(NAME) && docker rm $(NAME)

clean-image: 
	docker rmi $(TAG)

clean: clean-container clean-image

.PHONY: clean clean-image clean-container test run-container build-image shell run build all
