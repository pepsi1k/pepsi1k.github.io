# Helm

```bash
# pull chart 
helm pull banzaicloud-stable/vault --untar
# download new dependency versions and store them at charts/*.tgz
helm dependency update 
# show template 
helm template --values bank-vault.yml -n vualt bank-vault <chart-path>
```