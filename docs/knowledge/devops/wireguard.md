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

# configure linux client 

```bash
sudo apt install wireguard

wg genkey > /etc/wireguard/prv.key
wg pubkey < /etc/wireguard/prv.key > pub.key
```

```
#/etc/wireguard/wg0.conf
[Interface]
Address = 10.1.1.1/24
# ListenPort = 51820
PrivateKey = <host-prv-key>

[Peer]
PublicKey = <peer-pub-key>
Endpoint = <host-ip>:51820
PersistentKeepalive = 30

AllowedIPs = 0.0.0.0/0
AllowedIPs = 10.1.1.0/24

# ifconfig.me
AllowedIPs = 34.117.59.81/32

```

```bash
sudo systemctl start wg-quick@wg0
```