#!/bin/sh

ROOT_PATH="rootfs/"

sudo debootstrap --foreign --arch armhf jessie $ROOT_PATH
sudo cp /usr/bin/qemu-arm-static rootfs/usr/bin
