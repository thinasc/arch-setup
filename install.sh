echo "Partitioning"
parted -s /dev/sda mklabel msdos
parted /dev/sda mkpart primary 1MiB 472840KiB
parted /dev/sda mkpart primary 472840KiB 100%

mkfs.ext4 /dev/sda1
mkswap /dev/sda2

echo "Mounting"
mount /dev/sda1 /mnt
swapon /dev/sda2
# mkdir /mnt/boot
# mkdir /mnt/home

echo "Pacstrapping"
pacstrap /mnt base linux ansible

echo "Generating fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab

echo "Generating GRUB"
arch-chroot /mnt
mkinitcpio -p linux

pacman -Syyuu grub --noconfirm
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S git --noconfirm
git clone git@github.com:thinasc/arch-setup.git
