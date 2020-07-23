#!/bin/bash
# Install Vault Server on Linux Platform 

tag=${1:-1.5.0}
vault=vault_${tag}_linux_amd64.zip
url=https://releases.hashicorp.com/vault/${tag}/${vault}
echo "Downloading ${tag} version of Vault"
wget -c -q ${url} && unzip -d ~/.local/bin ${vault} && rm ${vault} 

