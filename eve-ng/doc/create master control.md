# create master control-plane
[kubernetes prerequestt](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
[install docker on debian](https://docs.docker.com/engine/install/debian/)
[how to setup cluster machine](https://docs.dman.cloud/posts/install-kubernetes-with-kubeadm/)

## configure server

### configure network
```
sudo su
nano /etc/netplan/00-installer-config.yaml

#add these
    ens3:
      dhcp4: false
      dhcp6: false
      addresses:
        - 192.168.178.90/24
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
        - 192.168.10.90/24          
```

```
netplan apply
```

#### configure master node
```
sudo su
bash <<EOF
sed -i 's/ubuntu/master/g' /etc/hostname
sed -i 's/ubuntu/master/g' /etc/hosts
hostname master
EOF
rebbot
```

### Forwarding IPv4 and letting iptables see bridged traffic
```
sudo su
```

```
cat <<EOF |  tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sysctl --system
```

```
# verify modules are running
lsmod | grep br_netfilter
lsmod | grep overlay

#verify iptables
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward
```

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
### install cluster
```
kubeadm config images pull --cri-socket=unix:///var/run/crio/crio.sock
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address 192.168.10.90 --cri-socket=unix:///var/run/crio/crio.sock

```

copy config file
```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```


### NOT VALID do not use install containerd
run steps in [install docker on ubuntu](https://docs.docker.com/engine/install/ubuntu/)

remove docker
```
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
```

```

```



