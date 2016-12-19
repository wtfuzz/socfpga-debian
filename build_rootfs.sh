#!/bin/sh

ROOT_PATH="rootfs/"

sudo debootstrap --arch armhf jessie $ROOT_PATH
sudo cp /usr/bin/qemu-arm-static rootfs/usr/bin
