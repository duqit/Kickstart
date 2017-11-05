install
text
lang en_GB.UTF-8
keyboard us
timezone Europe/Berlin
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --disabled=NetworkManager
services --enabled=sshd
eula --agreed
#ignoredisk --only-use=sda
reboot

bootloader --location=mbr
zerombr
clearpart --all --initlabel
part swap --asprimary --fstype="swap" --size=1024
part /boot --fstype xfs --size=200
part pv.01 --size=1 --grow
volgroup vg_root01 pv.01
logvol / --fstype xfs --name=lv_system --vgname=vg_root --size=1 --grow

rootpw --iscrypted $1$v9a1rt9i$U65p6z39VFTN90WeBhC9u/

repo --name=base --baseurl=http://mirror.cogentco.com/pub/linux/centos/7/os/x86_64/
url --url="http://mirror.cogentco.com/pub/linux/centos/7/os/x86_64/"

%packages --nobase --ignoremissing
@core
%end

