#!/bin/bash

# Web Server URL
WEB_SERVER=http://mirror.centos.org
# Centos Mirror.
CENTOS_MIRROR=$WEB_SERVER/centos/7/os/x86_64/

KS_URL=https://raw.githubusercontent.com/virtuallytd/centos-tools/master/kickstart/centos7.ks

# Grab kernel and initrd from mirror
curl -o /boot/vmlinuz $CENTOS_MIRROR/isolinux/vmlinuz
curl -o /boot/initrd.img $CENTOS_MIRROR/isolinux/initrd.img

# Use correct options for Grub for EFI or BIOS
if [ -d /sys/firmware/efi ]; then
cat <<EOF >> /etc/grub.d/40_custom
menuentry "Install CentOS 7" {
    set root='hd0,gpt2'
    linuxefi /vmlinuz ks=$KS_URL
    initrdefi /initrd.img
}
EOF
GRUBCFG='/boot/efi/EFI/centos/grub.cfg'
else
cat <<EOF >> /etc/grub.d/40_custom
menuentry "Install CentOS 7" {
    set root=(hd0,1)
    linux /vmlinuz ks=$KS_URL
    initrd /initrd.img
}
EOF
GRUBCFG='/boot/grub2/grub.cfg'
fi

echo "GRUB_DEFAULT=\"Install CentOS 7\"" >> /etc/default/grub
( grub2-mkconfig -o $GRUBCFG && reboot ) || exit 1
