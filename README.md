## Target Hardware

The test board is a Terasic de0-nano-soc

The default kernel doesn't have CONFIG_FHANDLE enabled for Debian systemd, so it is required to compile a kernel.

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
./MAKEALL socfpga_cyclone5

export PATH=`pwd`/u-boot-socfpga/tools:$PATH
```

### Compile kernel

```sh
git clone git://git.rocketboards.org/linux-socfpga.git
cd linux-socfpga
git checkout socfpga-3.15
make ARCH=arm socfpga_defconfig
```

#### Enable CONFIG_FHANDLE

```sh
make ARCH=arm menuconfig
```

General setup -> open by fhandle syscalls

```sh
make -j8 ARCH=arm uImage LOADADDR=0x8000
make ARCH=arm dtbs
make -j8 ARCH=arm modules
```

#### Copy kernel and DTB

```
Copy the files to the SD card boot partition
arch/arm/boot/zImage
arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb to socfpga.dtb
```

### Create rootfs

Requires binfmt-support

```
sudo qemu-debootstrap --no-check-gpg --arch=armhf jessie rootfs ftp://ftp.debian.org/debian/
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
