# Wireguard

docs: 

```bash
pacman -S wireguard-tools

wg genkey > /etc/wireguard/private.key
wg pubkey < /etc/wireguard/private.key > public.key
```

```bash
# to enable kernel relaying/forwarding ability on bounce servers
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv4.conf.all.proxy_arp = 1" >> /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
```

we have two choice of configuration:

