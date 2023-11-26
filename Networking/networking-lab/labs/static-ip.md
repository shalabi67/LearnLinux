# static ip
In this lab we will set the static ip for the lap-pc.

To connect to the machine `ssh -p 14701 mohammad@localhost`

this is the needed information:
```
ip: 192.168.1.10/24
gateway: 192.168.1.254

```

## solution
```shell
# get connection and device information
nmcli c

# set static ip
nmcli con mod 'Wired connection 1' ipv4.method manual ipv4.addresses 192.168.1.10/24 ipv4.gateway 192.168.1.254

# verify
nmcli c show 'Wired connection 1' | grep ipv4

## apply setting
sudo netplan apply

## test connection
ping -c 3 192.168.1.1
ping -c 3 192.168.2.1
ping -c 3 192.168.3.1
```