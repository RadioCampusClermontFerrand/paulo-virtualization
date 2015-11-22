#!/bin/bash


#ps aux|grep "^root.*launch-kvm"&& xmessage "Paulo deja en route" && exit 0

export QEMU_AUDIO_DRV=pa
export QEMU_AUDIO_ADC_VOICES=2
export QEMU_AUDIO_DAC_VOICES=2

# tap qemu
# version smp
ROOT_DIR=/home/paulo/xen
kvm -smp 4 \
    -m 1024 \
    -net nic,model=ne2k_pci,vlan=0,macaddr=00:13:D3:14:F5:55 -net tap,vlan=0,ifname=tap0 \
    -soundhw es1370 \
    -cdrom /dev/cdrom \
    -full-screen \
    -append "root=/dev/hda1" \
    -initrd $ROOT_DIR/initrd-2.4.7-10smp.img -kernel $ROOT_DIR/vmlinuz-2.4.7-10smp -hda $ROOT_DIR/paulo &


# ok
#kvm -smp 4 -initrd $ROOT_DIR/initrd-2.4.7-10.img -kernel $ROOT_DIR/vmlinuz-2.4.7-10 -hda $ROOT_DIR/paulo -append "root=/dev/hda1" -m 1024 -net nic,model=ne2k_pci,vlan=0,macaddr=00:13:D3:14:F5:55 -net tap,vlan=0,ifname=tap0  -soundhw es1370 -cdrom /dev/cdrom  -full-screen  &
#kvm -smp 4 -initrd $ROOT_DIR/initrd-2.4.7-10.img -kernel $ROOT_DIR/vmlinuz-2.4.7-10 -hda $ROOT_DIR/paulo -append "root=/dev/hda1" -m 1024 -net nic,model=ne2k_pci,vlan=0,macaddr=00:13:D3:14:F5:55  -net tap,vlan=0,ifname=tap0  -soundhw es1370 -device lsi -drive if=none,file=/dev/sr0,id=sr0 -device scsi-block,drive=sr0 &
# -full-screen
# -vga std
# -display sdl 

# pour configurer X: Xconfigurator


# nat qemu
#kvm -initrd $ROOT_DIR/initrd-2.4.7-10.img -kernel $ROOT_DIR/vmlinuz-2.4.7-10 -hda $ROOT_DIR/paulo -append "root=/dev/hda1" -m 1024 -net nic,model=ne2k_pci,vlan=0,macaddr=00:13:D3:14:F5:55 -net user,vlan=0 -redir tcp:2222:10.0.2.1:22  -redir tcp:139:10.0.2.1:139 -redir udp:137:10.0.2.1:137 -redir udp:138:10.0.2.1:138   -redir tcp:80:10.0.2.1:80  -soundhw es1370 -cdrom /dev/cdrom -monitor stdio -full-screen &

./set-sound.sh


#-drive file=/dev/sr0,if=ide,media=cdrom
#-cdrom /dev/cdrom

ethtool -K br0 tso off gso off
ethtool -K eth0 tso off gso off

