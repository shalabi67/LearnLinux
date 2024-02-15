## configure host running eve-ng
[Using Virtual Ethernet Adapters in Promiscuous Mode](https://kb.vmware.com/s/article/287)

when starting eve-ng virtual machine in vmware and you see an error about Promiscuous Mode then on the host running the virtual machine you need to run the following.
```
chmod a+rw /dev/vmnet0
chmod a+rw /dev/vmnet1
chmod a+rw /dev/vmnet8
```
## configure lab machines
cd /opt/unetlab/addons/qemu/

### make ubuntu and kali 
tar xzvf linux-ubuntu-22.04.02-server.tar.gz
tar xzvf linux-kali-large-2019.3.tar.gz
rm *.tar.gz

### make arista switch
mkdir veos-4.30.4M
mv vEOS-lab-4.30.4M.qcow2 veos-4.30.4M/hda.qcow2
mv Aboot-veos-serial-8.0.0.iso veos-4.30.4M/cdrom.iso

### make sisco
mkdir nxosv9k-10.2.1.F
mv nexus9500v64.10.2.1.F.qcow2 nxosv9k-10.2.1.F/sataa.qcow2

#### important note
sometime when you start the router it ends up with a `loader`prompt. if you see that then run
```
dir
boot <user the bin image name>
```


### make bigip
mkdir bigip-14.1.4.3
unzip BIGIP-14.1.4.3-0.0.8.ALL.qcow2.zip

### Clean and Fix Permission
/opt/unetlab/wrappers/unl_wrapper -a fixpermissions


