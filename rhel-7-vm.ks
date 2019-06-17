cmdline
install
lang en_GB.UTF-8
keyboard us
timezone Europe/Berlin
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --disabled=NetworkManager
services --enabled=sshd
eula --agreed
#ignoredisk --only-use=vda
reboot

# System bootloader configuration
#bootloader --location=mbr --boot-drive=vda
#zerombr
#clearpart --all --initlabel
#part pv.01 --size=1 --ondisk=vda --grow
#part /boot --fstype="xfs" --ondisk=vda --size=1024
#volgroup vg_system pv.01
#logvol swap --fstype="swap" --size=2048 --name=swap --vgname=vg_system
#logvol / --fstype="xfs" --name=lv_root --vgname=vg_system --size=1 --grow

# System bootloader configuration
bootloader --location=mbr
zerombr
clearpart --all --initlabel
part pv.01 --size=1 --grow
part /boot --fstype="xfs" --size=1024
volgroup vg_system pv.01
logvol swap --fstype="swap" --size=2048 --name=swap --vgname=vg_system
logvol / --fstype="xfs" --name=lv_root --vgname=vg_system --size=1 --grow


rootpw --iscrypted $1$v9a1rt9i$U65p6z39VFTN90WeBhC9u/

repo --name=base --baseurl=http://mirror.cogentco.com/pub/linux/centos/7/os/x86_64/
url --url="http://mirror.cogentco.com/pub/linux/centos/7/os/x86_64/"

%packages --nobase --ignoremissing
@core
%end
