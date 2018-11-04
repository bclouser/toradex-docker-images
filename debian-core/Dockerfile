FROM arm32v7/debian:buster

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

COPY qemu-arm-static /usr/bin/

# Resin-xbuild
# Attempting to symlink these failed.
# COPY resin-xbuild /usr/bin/
# RUN [ "/usr/bin/qemu-arm-static" "/bin/ln", "-s", "/usr/bin/resin-xbuild", "/usr/bin/cross-build-start" ]
# RUN [ "/usr/bin/qemu-arm-static" "/bin/ln", "-s", "/usr/bin/resin-xbuild", "/usr/bin/cross-build-end" ]
COPY resin-xbuild /usr/bin/cross-build-start
COPY resin-xbuild /usr/bin/cross-build-end
RUN [ "/usr/bin/cross-build-start" ]

RUN apt-get -y update && apt-get install -y  --no-install-recommends apt-utils
RUN apt-get -y update && apt-get install -y  --no-install-recommends \
    vim-tiny \
    less \
    kmod \
    curl \
    wget \
    usbutils \
    debconf

# Install Systemd... for now
ENV INITSYSTEM 1
RUN apt-get update && apt-get install -y --no-install-recommends \
		systemd \
		systemd-sysv

ENV container docker

# We never want these to run in a container
RUN systemctl mask \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    sys-kernel-config.mount \
    getty@.service \
    systemd-logind.service \
    systemd-remount-fs.service \
    getty.target \
    graphical.target \
    kmod-static-nodes.service

### Clean up packages... dont want these taking up space
RUN apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

RUN [ "/usr/bin/cross-build-end" ]

