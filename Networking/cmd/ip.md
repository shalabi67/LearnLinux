# ip

## show arp table
ip n
ip neigh

## Show mac address
ip link

## Show just the network interface enp0s25
ip a show enp0s25

## Print ip address
ip a show enp0s25 | grep inet -w | awk -F" " {' print $2 '} | awk -F"/" {' print $1 '}

## Print mac address
ip link show enp0s25 | grep ether | awk -F" " {' print $2 '}

## Set device down
ip link set eth0 down

## Set device up
ip link set eth0 up

## Delete ip
ip a del 10.0.3.4/24 dev eth0

## Add ip
ip a add 10.0.3.4/24 dev eth0

## Empty arp table
ip -s neigh flush all

## Delete ip
ip a delete 10.0.3.4/24 dev eth0

Notice the deletion or addition of the ip will change the route table

## Add ip
ip a add 10.0.3.66/24 dev eth0 

## Add route to route table
ip route add default via 192.168.178.1 
