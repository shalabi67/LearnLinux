# routing lab
In this lab you need to fix routing table so the machine can access pc-1(192.168.1.1), pc2(192.168.2.1), and pc3(192.168.3.1)

to connect to the machine use password `root`
ssh -p 14701 mohammad@localhost

## Solution
Let us find what is the problem
```
ip route
```
 you will see there is no routes to subnets 192.168.2.0 and 192.168.3.0. so we need to add these routes

```
ip route add 192.168.0.0 dev enp0s8 via 192.168.1.254
netplan apply
```

after we do that then we can ping any machine in these subnets.
```
ping -c 2 192.168.1.1
ping -c 2 192.168.2.1
ping -c 2 192.168.3.1

```

