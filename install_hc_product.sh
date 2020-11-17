#!/bin/bash
# Install Vault Server on Linux Platform 

packer_latest_url=https://github.com/hashicorp/packer/releases/latest
consul_latest_url=https://github.com/hashicorp/consul/releases/latest
vault_latest_url=https://github.com/hashicorp/vault/releases/latest

product=packer
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $packer_latest_url)
tag=${temp##*/v}
zipfile=${product}_${tag}_linux_amd64.zip
url=https://releases.hashicorp.com/${product}/${tag}/${zipfile}
echo "Downloading ${tag} version of ${product}"
wget -c -q ${url} && unzip -d ~/.local/bin ${zipfile} && rm ${zipfile} 

product=consul
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $consul_latest_url)
tag=${temp##*/v}
zipfile=${product}_${tag}_linux_amd64.zip
url=https://releases.hashicorp.com/${product}/${tag}/${zipfile}
echo "Downloading ${tag} version of ${product}"
wget -c -q ${url} && unzip -d ~/.local/bin ${zipfile} && rm ${zipfile} 

product=vault
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $vault_latest_url)
tag=${temp##*/v}
zipfile=${product}_${tag}_linux_amd64.zip
url=https://releases.hashicorp.com/${product}/${tag}/${zipfile}
echo "Downloading ${tag} version of ${product}"
wget -c -q ${url} && unzip -d ~/.local/bin ${zipfile} && rm ${zipfile} 

