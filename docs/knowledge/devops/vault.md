# Vault


## Init Vault
After deploy banzai vault-operator and create Vault from CRD, you must unseal vault, 
unseal keys stored at `<namespace>/vault-unseal-keys`

```bash
# 1. consistently copy unseal keys
unsealKeys=$(kubectl get secret -o json -n vault vault-unseal-keys); for i in {0..3}; do
  read -p "Press enter to continue copy unseal-keys-$i"
  echo $unsealKeys | jq -r ".data[\"vault-unseal-$i\"]" | tr -d "\n" | base64 -d | xclip -selection clipboard
done 

# 2. consistently past unseal keys
vault operator unseal
```

>**Error unsealing x509: certificate signed by unknown authority**, 
  you must configure cacert, env `VAULT_CACERT=/vault/tls/ca.crt`

## Vault-configurer error

```log
{"level":"info","msg":"Failed applying configuration file: /config/vault-configurer/vault-config.yml , sleeping for 1m0s before trying again","time":"2021-10-06T12:38:47Z"}
```

If you see this error, probably you have an old secret `vault-unseal-keys`. You must delete old one and recreate CR Vault