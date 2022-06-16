
## Curl with cacert
```bash
curl --cacert ca.crt https://example.com
```

## Find large files/directories
```bash
Find bit size file
du -a / 2> /dev/null | sort -n -r | head -n 20

Show directory size
du -sh */
```

## List available packages
```bash
# ubuntu
apt-cache madison gitlab-ce
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

## usermod add group

```bash
sudo usermod -a -G <groupname> <username>
```

## Capture packets from remote server
```bash
# create FIFO file
mkfifo /tmp/remote
wireshark -k -i /tmp/remote
ssh user@host "tcpdump -s 0 -U -n -w - -i eth0 not port 22" > /tmp/remote
```

## generate user:pass for basic auth
```bash
htpasswd -nbm <user> <password>
```

## p2p git
```bash
git daemon --verbose --export-all --reuseaddr --base-path=.git --strict-paths .git/
git clone git://<server-ip>/ <repo>
```