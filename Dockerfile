FROM debian:trixie

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    live-build \
    debootstrap \
    squashfs-tools \
    xorriso \
    grub-pc-bin \
    grub-efi-amd64-bin \
    grub-efi-ia32-bin \
    mtools \
    dosfstools \
    isolinux \
    syslinux-common \
    syslinux-utils \
    fdisk \
    gdisk \
    parted \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
