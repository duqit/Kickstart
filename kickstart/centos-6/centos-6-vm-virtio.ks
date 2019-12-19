#version=CENTOS6
# Action
install

# System authorization information
auth --enableshadow --passalgo=sha512

# Accept Eula
eula --agreed

reboot
# Use network installation
url --url="http://archive.kernel.org/centos-vault/6.0/os/x86_64/"
#Repos
repo --name=base --baseurl=http://archive.kernel.org/centos-vault/6.0/os/x86_64/

# Run the Setup Agent on first boot
firstboot --disabled
ignoredisk --only-use=vda

# Keyboard layouts
keyboard us

# System language
lang en_US.UTF-8

# Network information
network  --bootproto=dhcp --noipv6 --activate
network --hostname=server.localdomain

# Root password (Password123$)
rootpw --iscrypted $1$v9a1rt9i$U65p6z39VFTN90WeBhC9u/

# System services
services --enabled=sshd

# System timezone
timezone Europe/Berlin

user --groups=wheel --homedir=/home/ansible --name=ansible --password=$1$v9a1rt9i$U65p6z39VFTN90WeBhC9u/ --iscrypted --gecos="Ansible"
#sshkey --username=ansible "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBMFz5Axpke6RGAPfyWSrQVY3zU6wJtMEbJpvXfD1Sgs ansible@virtuallytd.com"

# System bootloader configuration
bootloader --location=mbr --boot-drive=vda
zerombr
ignoredisk --only-use=vda

# Partition clearing information
clearpart --all --initlabel --drives=vda 
#bootloader --append="crashkernel=auto" --location=mbr --boot-drive=vda
part /boot --fstype="xfs" --ondisk=vda --size=1024
part pv.01 --fstype="lvmpv" --size=1 --ondisk=vda --grow
volgroup vg_system pv.01
logvol swap --fstype="swap" --size=2048 --name=swap --vgname=vg_system
logvol / --fstype="xfs" --name=lv_root --vgname=vg_system --size=1 --grow

# Selinux State
selinux --disabled

%packages --nobase --ignoremissing --excludedocs
@core
-iwl*
-NetworkManager*
%end
