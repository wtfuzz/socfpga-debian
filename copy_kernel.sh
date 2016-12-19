#!/bin/sh

sudo cp src/linux-socfpga/arch/arm/boot/zImage target/boot/
sudo cp src/linux-socfpga/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dtb target/boot/socfpga.dtb
