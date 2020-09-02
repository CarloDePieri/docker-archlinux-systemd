# FROM archlinux/base:latest
FROM archlinux:latest
MAINTAINER "Carlo De Pieri" <depieri.carlo@gmail.com>

# Make sure systemd knows we are in a container
ENV container "docker"

# Update the system and install the full base group; then delete the cache
RUN pacman -Syu --noconfirm base; \
yes | pacman -Scc

# Clean unneeded services
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /lib/systemd/system/graphical.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Prepare the cgroup volume
VOLUME [ "/sys/fs/cgroup" ]

# Start systemd at init
CMD ["/usr/sbin/init"]
