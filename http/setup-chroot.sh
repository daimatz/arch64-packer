#!/bin/sh
set -ex

echo arch64.local > /etc/hostname

echo 'Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist

ln -s /usr/share/zoneinfo/Japan /etc/localtime
sed -i.bak -e 's/#\(en_US.UTF-8.*\)/\1/' /etc/locale.gen
rm /etc/locale.gen.bak
locale-gen

# yaourt
cat >> /etc/pacman.conf <<EOF
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch
EOF
pacman -Sy --noconfirm yaourt

# For vagrant
echo -e 'vagrant\nvagrant\n' | passwd
useradd -m vagrant
echo -e 'vagrant\nvagrant\n' | passwd vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/vagrant
chmod 0440 /etc/sudoers.d/vagrant

# For ssh
dhcpcd_txt=/root/dhcpcd.txt
systemctl enable sshd.service
systemctl enable $(head -1 $dhcpcd_txt)

mkinitcpio -p linux
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
