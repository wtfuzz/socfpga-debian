#!/bin/sh

ROOT_PATH="rootfs/"

sudo debootstrap --arch armhf buster $ROOT_PATH
sudo cp /usr/bin/qemu-arm-static $ROOT_PATH/usr/bin
