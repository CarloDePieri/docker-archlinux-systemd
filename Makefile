PACKAGE=carlodepieri/docker-archlinux-systemd
VERSION=latest
TAG=$(PACKAGE):$(VERSION)
NAME=cdp-arch-systemd
SHELL := /bin/bash
ACT_TEST_CTX=act-dev-ci
ACT_PROD_CTX_CI=act-prod-ci
ACT_PROD_CTX_DEPLOY=act-prod-deploy

# Convenience functions to kill and remove containers
rm_ctx_id = if docker ps -qa --filter "id=$(1)" | grep -q .; then echo -n "> rm -f "; docker rm -f $(1); fi
rm_ctx_name = if docker ps -qa --filter "name=$(1)" | grep -q .; then echo -n "> rm -f "; docker rm -f $(1); fi

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
	$(call rm_ctx_name,$(NAME))

clean-image: 
	docker rmi $(TAG)

clean: clean-container clean-image

act-dev:
	act -W .github/workflows/dev.yml

act-dev-shell:
	docker exec -it $(ACT_TEST_CTX) env TERM=xterm bash

act-dev-clean: clean-container
	$(call rm_ctx_name,$(ACT_TEST_CTX))

act-prod:
	act -r -W .github/workflows/prod.yml

act-prod-shell-ci:
	docker exec -it $(ACT_PROD_CTX_CI) env TERM=xterm bash

act-prod-shell-deploy:
	docker exec -it $(ACT_PROD_CTX_DEPLOY) env TERM=xterm bash

act-prod-clean: clean-container
	$(call rm_ctx_name,$(ACT_PROD_CTX_CI)) && \
		$(call rm_ctx_name,$(ACT_PROD_CTX_DEPLOY)) && \
		$(call rm_ctx_id,$$(docker ps -a -q --filter ancestor=moby/buildkit:buildx-stable-1))

.PHONY: clean clean-image clean-container test run-container build-image shell run build all act-dev act-dev-shell act-dev-clean act-prod act-prod-shell-ci act-prod-shell-deploy act-prod-clean
