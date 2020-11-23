#!/bin/sh

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

export PATH="`pwd`/src/u-boot-socfpga/tools:$PATH"

cd src/linux-socfpga
git checkout socfpga-5.4.64-lts
make socfpga_defconfig
make -j8 uImage LOADADDR=0x8000
make -j8 modules
make dtbs
