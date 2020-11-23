#!/bin/sh

export CROSS_COMPILE=arm-linux-gnueabihf-

cd src/u-boot-socfpga
git checkout socfpga_v2020.04
make mrproper
make socfpga_de0_nano_soc_defconfig
make -j16
