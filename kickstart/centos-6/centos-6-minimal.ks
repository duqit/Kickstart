#pay attention to the comments inline !!


install
text
reboot
#uncomment the #cdrom line and comment the url one for installs from DVD
#cdrom
#use a mirror close to you or even better, the local one provided by your organization
#replace x86_64 with i386 for 32bit installs
url --url http://vault.centos.org/6.0/os/x86_64/
lang en_US.UTF-8
keyboard us
skipx
network --device eth0 --bootproto dhcp
#do not forget to change the password !
rootpw Password123$
firewall --enabled
selinux --permissive
authconfig --enableshadow --enablemd5
timezone UTC
bootloader --location=mbr
# The following is the partition information you requested
# Note that any partitions you deleted are not expressed
# here so unless you clear all partitions first, this is
# not guaranteed to work
clearpart --all --initlabel
part /boot --fstype ext3 --size=250
part pv.2 --size=5000 --grow 
volgroup VolGroup00 --pesize=32768 pv.2
logvol / --fstype ext4 --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
logvol swap --fstype swap --name=LogVol01 --vgname=VolGroup00 --size=256 --grow --maxsize=512

%packages --nobase
#use the next line instead of the previous one if you do not care about the doc files
#%packages --nobase --excludedocs
coreutils
yum
rpm
e2fsprogs
lvm2
grub
openssh-server
openssh-clients
dhclient
yum-presto
-atmel-firmware
-b43-openfwwf
-cronie
-cronie-anacron
-crontabs
-cyrus-sasl
-info
-postfix
-sudo
-sysstat
-xorg-x11-drv-ati-firmware
-yum-utils
-ipw2100-firmware
-ipw2200-firmware
-ivtv-firmware
-iwl1000-firmware
-iwl3945-firmware
-iwl4965-firmware
-iwl5000-firmware
-iwl5150-firmware
-iwl6000-firmware
-iwl6050-firmware
-libertas-usb8388-firmware
-rt61pci-firmware
-rt73usb-firmware
-mysql-libs
-zd1211-firmware
%end
%post
%end
