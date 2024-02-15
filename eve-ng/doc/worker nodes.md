# worker nodes

## worker 1
### configure network
```
sudo su
nano /etc/netplan/00-installer-config.yaml

#add these
    ens3:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.178.101/24
      routes:
        - to: 192.168.178.0/24
          via: 192.168.178.1
      nameservers:
        addresses: 
          - 192.168.178.1
    ens4:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.10.101/24          
```

```
netplan apply
```

#### configure worker node
```
sudo su
bash <<EOF
sed -i 's/ubuntu/worker1/g' /etc/hostname
sed -i 's/ubuntu/worker1/g' /etc/hosts
hostname worker1
EOF
rebbot
```

## worker 2
### configure network
```
sudo su
nano /etc/netplan/00-installer-config.yaml

#add these
    ens3:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.178.102/24
      routes:
        - to: 192.168.178.0/24
          via: 192.168.178.1
      nameservers:
        addresses: 
          - 192.168.178.1
    ens4:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.10.102/24          
```

```
netplan apply
```

#### configure worker node
```
sudo su
bash <<EOF
sed -i 's/ubuntu/worker2/g' /etc/hostname
sed -i 's/ubuntu/worker2/g' /etc/hosts
hostname worker2
EOF
rebbot
```

## worker 3
### configure network
```
sudo su
nano /etc/netplan/00-installer-config.yaml

#add these
    ens3:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.178.103/24
      routes:
        - to: 192.168.178.0/24
          via: 192.168.178.1
      nameservers:
        addresses: 
          - 192.168.178.1
    ens4:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.10.103/24          
```


#### configure worker node
```
bash <<EOF
sed -i 's/ubuntu/worker3/g' /etc/hostname
sed -i 's/ubuntu/worker3/g' /etc/hosts
hostname worker3
EOF
netplan apply

```


## all worker nodes
### diable swap
```
sudo swapoff -a
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true

```

### Install CRI-O Runtime On All The Nodes
```
cat <<EOF | sudo tee /etc/modules-load.d/crio.conf
overlay
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
sudo sysctl --system

```

Enable cri-o repositories for version 1.28
```
export OS="xUbuntu_22.04"
export VERSION="1.28"
cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/ /
EOF

cat <<EOF | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable:cri-o:$VERSION.list
deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable:/cri-o:/$VERSION/$OS/ /
EOF


# add gpg key
curl -L https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable:cri-o:$VERSION/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -

curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/$OS/Release.key | sudo apt-key --keyring /etc/apt/trusted.gpg.d/libcontainers.gpg add -

# Update and install crio and crio-tools
sudo apt-get update
sudo apt-get install cri-o cri-o-runc cri-tools -y

sudo systemctl daemon-reload
sudo systemctl enable crio --now

```


## create cluster
### install k8s tools
```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt-get install kubeadm kubelet kubectl
sudo apt-mark hold kubeadm kubelet kubectl
kubeadm version
```

### join cluster
```
kubeadm join 192.168.10.90:6443 --token saq0i7.0u659o7h53vfxaxq \
	--discovery-token-ca-cert-hash sha256:d79c9577017ba9cc42091bac5e70bcf327059a981221f3510badb5f55c31a864
```


