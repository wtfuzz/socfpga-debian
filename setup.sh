#!/bin/sh

sudo apt update
sudo apt install wget device-tree-compiler git binfmt-support qemu qemu-user-static debootstrap libncurses-dev gcc-arm-linux-gnueabihf

git clone https://github.com/altera-opensource/u-boot-socfpga.git src/u-boot-socfpga
git clone https://github.com/altera-opensource/linux-socfpga.git src/linux-socfpga

