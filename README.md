# Debian Linux on socfpga

## Target Hardware

The test board is a Terasic de0-nano-soc

### Install Dependencies

#### Compiler Toolchain

On Ubuntu 17.10:
`sudo apt install gcc-arm-linux-gnueabihf`

```
wget https://launchpad.net/linaro-toolchain-binaries/trunk/2012.11/+download/gcc-linaro-arm-linux-gnueabihf-4.7-2012.11-20121123_linux.tar.bz2
tar jxfv gcc-linaro-arm-linux-gnueabihf-4.7-2012.11-20121123_linux.tar.bz2

```

#### Install packages, setup cross compiler path
```
sudo apt-get install device-tree-compiler

export PATH=`pwd`/gcc-linaro-arm-linux-gnueabihf-4.7-2012.11-20121123_linux/bin:$PATH
```

### Compile u-boot

```
git clone https://github.com/altera-opensource/u-boot-socfpga.git

export CROSS_COMPILE=arm-linux-gnueabihf-

cd u-boot-socfpga
git checkout master
make mrproper
make defconfig socfpga_de0_nano_soc_defconfig
make -j4

export PATH=`pwd`/u-boot-socfpga/tools:$PATH
```

### Compile kernel

```sh
export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

git clone https://github.com/altera-opensource/linux-socfpga.git
cd linux-socfpga
git checkout socfpga-4.15
make socfpga_defconfig
make -j8 uImage LOADADDR=0x8000
make dtbs
make -j8 modules
```

#### Copy kernel and DTB

```
Copy the files to the SD card boot partition
arch/arm/boot/zImage
arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dtb to socfpga.dtb
```

### Create rootfs

Requires binfmt-support

```
sudo qemu-debootstrap --no-check-gpg --arch=armhf stretch rootfs ftp://ftp.debian.org/debian/
chroot rootfs
```

Once inside the chroot

* Set the root password
* Update /etc/apt/sources.list
* apt-get update
* apt-get install openssh-server

exit chroot

Copy rootfs/* to SD card root partition

Install SD card into de0-nano-soc board

### Post installation
#### Setup Networking
Create /etc/network/interfaces.d/eth0 containing network configuration
#### Fix locales
```sh
apt-get install locales
dpkg-reconfigure locales
```
