echo "Partitioning"
parted -s /dev/sda mklabel msdos
parted /dev/sda mkpart primary 1MiB 100%
# parted /dev/sda set 1 boot on
mkfs.ext4 /dev/sda1

echo "Mounting"
mount /dev/sda1 /mnt
# mkdir /mnt/boot
# mkdir /mnt/home

echo "Pacstrapping"
pacstrap /mnt base linux ansible

echo "Generating fstab"
genfstab /mnt >> /mnt/etc/fstab

echo "Generating GRUB"
arch-chroot /mnt bash -c 'pacman -Sy grub; grub-install /dev/sda; grub-mkconfig -o /boot/grub/grub.cfg'
