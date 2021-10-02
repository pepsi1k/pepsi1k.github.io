#!/bin/bash

JWT_TOKEN=$(cat /run/secrets/kubernetes.io/serviceaccount/token)
K8S_CA_CRT=$(cat /run/secrets/kubernetes.io/serviceaccount/ca.crt | tr -d '\n')
K8S_HOST="https://kubernetes"

vault login $VAULT_TOKEN > /dev/null 2>&1

# access to consul
vault secrets enable consul
vault write consul/roles/management token_type=management lease=30m

# access to token
vault auth enable approle
vault write auth/approle/role/consul-backup \
secret_id_ttl=5m \
token_ttl=5m \
token_max_ttl=5m \
bind_secret_id=true \
policies='consul-backup'

vault policy write consul-backup -<<EOF
path "consul/creds/management" {
  capabilities = ["read"]
}
EOF

# auth kubernetes 
vault auth enable kubernetes
vault write auth/kubernetes/config \
  token_reviewer_jwt="${JWT_TOKEN}" \
  kubernetes_host=$K8S_HOST \
  kubernetes_ca_cert="${K8S_CA_CRT}"

vault write auth/kubernetes/role/consul-backup-login \
  bound_service_account_names='consul-backup-login' \
  bound_service_account_namespaces='default' \
  policies='consul-backup-login'
  ttl=300 \
  max_ttl=300

vault policy write consul-backup-login -<<EOF
path "auth/approle/role/consul-backup/role-id" {
  capabilities = ["read"]
}
path "auth/approle/role/consul-backup/secret-id" {
  capabilities = ["update"]
}
EOF

while true; do
  sleep 25
done 