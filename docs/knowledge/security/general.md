## Encrypt/decrypt file with password 
```bash
openssl aes-256-cbc -a -salt -in secrets.txt -out secrets.txt.enc
openssl aes-256-cbc -d -a -in secrets.txt.enc -out secrets.txt
```

## Get certificate
```bash
echo | \
    openssl s_client -servername kubernetes.default.svc.cluster.local -connect kubernetes.default.svc.cluster.local:443 2>/dev/null | \
    openssl x509 -text
```

## Chrome developer configurations
```
chrome://flags
chrome://inspect
```