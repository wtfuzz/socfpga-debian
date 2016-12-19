#!/bin/sh

#TOOLCHAIN_URL="https://launchpad.net/linaro-toolchain-binaries/trunk/2013.10/+download/gcc-linaro-arm-linux-gnueabihf-4.8-2013.10_linux.tar.bz2"
#TOOLCHAIN_SHA1="93a74cbb3b90d4b3d52816871c9e9656dd71806f"

#TOOLCHAIN_URL="https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/arm-linux-gnueabihf/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf.tar.xz"

TOOLCHAIN_URL="https://releases.linaro.org/components/toolchain/binaries/latest/arm-linux-gnueabihf/gcc-linaro-6.2.1-2016.11-x86_64_arm-linux-gnueabihf.tar.xz"
TOOLCHAIN_SHA1="15ebc22d33557b67f8a8170c1921a3159012acc9"

TOOLCHAIN_LOCAL="tools/gcc-arm-linux.tar.xz"

TOOLCHAIN_ROOT="`pwd`/tools/gcc-linaro-6.2.1-2016.11-x86_64_arm-linux-gnueabihf"

echo $TOOLCHAIN_ROOT

sudo apt update
sudo apt install wget device-tree-compiler git binfmt-support qemu qemu-user-static debootstrap libncurses-dev

# Check if tools/gcc-arm-linux.tar.bz2 already exists
echo "$TOOLCHAIN_SHA1 $TOOLCHAIN_LOCAL" | sha1sum -c -

if [ $? -ne 0 ]; then
  echo "Downloading $TOOLCHAIN_URL"
  wget -O tools/gcc-arm-linux.tar.bz2 $TOOLCHAIN_URL
fi


echo "$TOOLCHAIN_SHA1 $TOOLCHAIN_LOCAL" | sha1sum -c -
if [ $? -ne 0 ]; then
  echo "Invalid toolchain hash!"
  exit 1
fi

echo "Extracting toolchain..."
tar Jxf $TOOLCHAIN_LOCAL -C tools

#git clone https://github.com/altera-opensource/u-boot-socfpga.git src/u-boot-socfpga
#git clone https://github.com/altera-opensource/linux-socfpga.git src/linux-socfpga

