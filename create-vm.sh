#!/bin/bash

SERVER_PRE="kvmhost01"
SERVER_NUM="02"

echo " "
echo "Host Machine: ${SERVER_PRE}${SERVER_NUM}"
echo " "
for VM in 01 02 03 04 05 06 07 08 09 10 11
do
        GUEST_NAME="${SERVER_PRE}${SERVER_NUM}g${VM}"

        echo "${GUEST_NAME}"

        GUEST_EXISTS=`virsh list --all | grep ${GUEST_NAME} | wc -l`

        if [ "${GUEST_EXISTS}" == "0" ]; then

                echo "   Guest...Missing"
                echo -n "      Guest Being Created..."
                # Check Disks
                DISK_EXISTS=`lvdisplay | grep ${GUEST_NAME} | wc -l`
                if [ "${DISK_EXISTS}" == "0" ]; then
                        lvcreate -L 10G -n${GUEST_NAME} vg_kvm
                fi

                /usr/bin/virt-install -n ${GUEST_NAME} -r 512 --os-variant=virtio26 -l http://192.168.0.10/iso/centos-5.5/ --nographics --noautoconsole --disk path=/dev/vg_kvm/${GUEST_NAME}, bus=virtio -b br0 -x "console=ttyS0 ks=http://192.168.0.10/ks_deploy/ks_deploy/${GUEST_NAME}/kvmg/centos_5_5" &

                echo "OK";
        else
                echo "   Guest...OK"
        fi
done


/usr/bin/virt-install -n test -r 512 --os-variant=virtio26 -l http://192.168.0.10/cblr/ks_mirror/rhel5u8-x86_64 --nographics --noautoconsole --disk path=/tmp/test.img,bus=virtio,size=8 -b br0 -x "console=ttyS0 ks=http://192.168.0.10/cblr/svc/op/ks/system/test.local"
