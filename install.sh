parted -s /dev/sda mklabel msdos
parted /dev/sda mkpart primary 1MiB 100%
# parted /dev/sda set 1 boot on
# mkfs.ext4 /dev/sda1
mount /dev/sda1 /mnt
# mkdir /mnt/boot
# mkdir /mnt/home

pacstrap /mnt base linux
genfstab /mnt >> /mnt/etc/fstab

arch-chroot /mnt bash -c 'pacman -Sy grub; grub-install /dev/sda; grub-mkconfig -o /boot/grub/grub.cfg'
reboot
