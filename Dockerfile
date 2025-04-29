# syntax=docker/dockerfile:1
FROM archlinux:latest AS build
LABEL maintainer="depieri.carlo@gmail.com"
ENV container="docker"
RUN pacman -Syu --noconfirm; \
yes | pacman -Scc; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /lib/systemd/system/graphical.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
CMD ["/usr/sbin/init"]

FROM build AS build_with_volume
VOLUME [ "/sys/fs/cgroup" ]
