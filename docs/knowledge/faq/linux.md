
## Find large files/directories
```bash
Find bit size file
du -a / 2> /dev/null | sort -n -r | head -n 20

Show directory size
du -sh */
```


## WI-FI cli

```bash
ip link show
ip link set wls1 up
iw dev wls1 scan | grep -i ssid
wpa_supplicant -B -i wls1 -c <(wpa_passphrase <ACCESS-POINT> <PASS>)
dhcpcd
```

# ArchLinux Ignore package

Open config file `/etc/pacman.conf` and add package name to this line:
```ini
IgnorePkg = <package-name>
```
