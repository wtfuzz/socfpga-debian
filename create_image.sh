# Create an SD card image

# Copy the binary build artifacts to bin
cp src/u-boot-socfpga/spl/u-boot-spl.bin boot/
cp src/u-boot-socfpga/u-boot.bin boot/
cp src/u-boot-socfpga/u-boot-with-spl.sfp boot/
cp src/linux-socfpga/arch/arm/boot/zImage boot/
cp ./src/linux-socfpga/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb boot/

# Create a tarball of the root filesystem for guestfish
sudo tar --xattrs --xattrs-include=* -cf rootfs.tar -C rootfs .

# Create a 2GB image file using guestfish

sudo guestfish << _EOF_
sparse socfpga.img 2G
run
part-init /dev/sda mbr
part-add /dev/sda p 1 65535
part-add /dev/sda p 65536 131069
part-add /dev/sda p 131072 -1

part-set-mbr-id /dev/sda 1 0xb
part-set-mbr-id /dev/sda 2 0xa2
part-set-mbr-id /dev/sda 3 0x83

list-partitions

echo "Creating boot partition"
mkfs vfat /dev/sda1
echo "Creating root partition"
mkfs ext4 /dev/sda3
mount /dev/sda3 /

echo "Copying rootfs.tar to /"
tar-in rootfs.tar / xattrs:true selinux:true acls:true

mount /dev/sda1 /boot

#copy-in boot/u-boot-spl.bin /boot
#copy-in boot/u-boot.bin /boot
#copy-in boot/u-boot-with-spl.sfp /boot
#copy-in boot/zImage /boot
copy-in boot /
ls /boot

echo "Writing bootloader to /dev/sda2"
copy-file-to-device /boot/u-boot-with-spl.sfp /dev/sda2
_EOF_


sudo chown $USER:$USER socfpga.img
echo "Compressing SD card image"
pigz -f socfpga.img
