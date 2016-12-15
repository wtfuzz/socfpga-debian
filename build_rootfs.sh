#!/bin/sh

ROOT_PATH="rootfs/"

sudo debootstrap --foreign --arch armhf jessie $ROOT_PATH
