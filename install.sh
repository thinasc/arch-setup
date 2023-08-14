echo "Partitioning"
parted -s /dev/sda mklabel msdos
parted /dev/sda mkpart primary 1MiB 100%
mkfs.ext4 /dev/sda1

echo "Mounting"
mount /dev/sda1 /mnt
# mkdir /mnt/boot
# mkdir /mnt/home

echo "Pacstrapping"
pacstrap /mnt base linux ansible

echo "Generating fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "Generating GRUB"
arch-chroot /mnt
mkinitcpio -p linux
pacman -Syyuu grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "Setup resolv.conf"
echo 'nameserver 1.1.1.1' > /etc/resolv.conf
