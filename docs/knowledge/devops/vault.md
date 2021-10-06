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

>| if you coudn't connect to https://localhost:8200, you must configure cacert, env `VAULT_CACERT`
