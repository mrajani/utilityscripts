#!/bin/bash
# Install aws-vault Linux Platform 
set -eou pipefail

url=https://github.com/99designs/aws-vault/releases
url_latest=${url}/latest
url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})
tag=${url_effective##*/}
ver=${tag##[a-z]}
os_ver=$(lsb_release -sr)
aws_vault=aws-vault-linux-amd64
wget -q -O $HOME/.local/bin/${aws_vault} ${url}/download/${tag}/${aws_vault}
echo "Installing ${tag} version of aws-vault for ${os_ver} $(lsb_release -cs) "
