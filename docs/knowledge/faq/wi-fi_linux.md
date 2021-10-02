

## CLI

```bash
ip link show
ip link set wls1 up
iw dev wls1 scan | grep -i ssid
wpa_supplicant -B -i wls1 -c <(wpa_passphrase ASUS-864C 12345678)
dhcpcd
```
