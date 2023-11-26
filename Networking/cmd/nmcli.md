# nmcli
It shows <b>DNS configuration information</b>. In addition to seeing the MAC address,
as well as the IP and subnet, we also see our default route.

nmcli depends on `NetworkManager`

```
systemctl status NetworkManager
nmcli
```

## nmcli device show
used to get complete information about known devices.
```
nmcli c

nmcli dev show enp0s8

nmcli con show 'Wired connection 1
```

show device for ipv4
```
nmcli con show 'Wired connection 1' | grep ipv4
```


## nmcli connection show
used to get an overview on active connection profiles.
```
nmcli c

nmcli con show 'Wired connection 1
```
