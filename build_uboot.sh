#!/bin/sh

cd src/u-boot-socfpga
git checkout master
make mrproper
make socfpga_cyclone5_config
make -j4
