# Change mac by ifconfig

First of all, to edit our network card mac address we need to disable our network card
```
ifconfig enp3s0 down
ifconfig enp3s0 hw ether 00:00:00:11:22:33
ifconfig enp3s0 up
```