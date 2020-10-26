#!/bin/bash
# Install Vault Server on Linux Platform 

product=${1:-vault}
tag=${2:-1.5.5}
zipfile=${product}_${tag}_linux_amd64.zip
url=https://releases.hashicorp.com/${product}/${tag}/${zipfile}
echo "Downloading ${tag} version of ${product}"
wget -c -q ${url} && unzip -d ~/.local/bin ${zipfile} && rm ${zipfile} 

