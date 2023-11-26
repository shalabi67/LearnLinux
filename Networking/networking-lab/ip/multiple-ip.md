# multiple ip on the same interface
We want to do that if we have multiple service running on the same machine and we do not want to do port forwarding

In this learning activity, you're being tasked with adding two more IPs to the existing environment. 
There is currently a private IP of 192.168.1.10. You must add 192.168.1.50 and 192.168.1.40.

## solution

sudo nmcli c mod 'Wired connection 1' ipv4.addresses 192.168.1.30/24,192.168.1.40/24
