#!/bin/sh

cd src/linux-socfpga
git checkout socfpga-4.7
#make ARCH=arm socfpga_defconfig
cp ../../kernel.config .config
make -j8 ARCH=arm uImage LOADADDR=0x8000
make -j8 ARCH=arm modules
make ARCH=arm dtbs
