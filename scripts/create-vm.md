# Set guestname
GUEST_NAME=test02

# using image with virtio
/usr/bin/virt-install -n ${GUEST_NAME} -r 2048 --os-variant=centos7.0 -l http://mirror.centos.org/centos/7/os/x86_64/ --nographics --noautoconsole --disk path=/var/lib/libvirt/images/${GUEST_NAME}.qcow2,size=10,bus=virtio,format=qcow2 --network=bridge=br0,model=virtio -x "console=ttyS0 ks=https://raw.githubusercontent.com/virtuallytd/centos-tools/master/kickstart/centos7vm.ks"

# Create lvm 
lvcreate -L 10G -n${GUEST_NAME} centos_server

# using lvm with virtio
/usr/bin/virt-install -n ${GUEST_NAME} -r 2048 --os-variant=centos7.0 -l http://mirror.centos.org/centos/7/os/x86_64/ --nographics --noautoconsole --disk path=/dev/centos_server/${GUEST_NAME},bus=virtio --network=bridge=br0,model=virtio -x "console=ttyS0 ks=https://raw.githubusercontent.com/virtuallytd/centos-tools/master/kickstart/centos7vm-vda.ks"

# test writing 1Gb File Speed
time dd if=/dev/zero of=/tmp/test oflag=direct bs=64k count=16000
