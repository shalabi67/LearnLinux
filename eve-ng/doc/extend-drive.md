# links
[lvm documentation](https://wiki.ubuntu.com/Lvm)
[add disk to lvm](https://www.cyberciti.biz/faq/howto-add-disk-to-lvm-volume-on-linux-to-increase-size-of-pool/)
# collect extra space
fdisk /dev/sda 
#add new partition.
n

# lv show commsnd
pvs
vgs
lvs

# link partion to lvm
vgextend ubuntu-vg /dev/sda4
lvextend -l +100%FREE ubuntu-vg/ubuntu-lv
resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv
