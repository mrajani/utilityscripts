#!/bin/sh

# Install Secret Hub for Linux Platform
sh_url=https://github.com/secrethub
url_latest=${sh_url}/secrethub-cli/releases/latest
url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})
tag=${url_effective##*/}
echo "Installing ${tag} version of SecretHub"
# https://github.com/secrethub/secrethub-cli/releases/download/v0.27.0/secrethub-v0.27.0-linux-amd64.tar.gz

secrethub=secrethub-${tag}-linux-amd64.tar.gz
wget -q $sh_url/secrethub-cli/releases/download/${tag}/${secrethub}

shdir=$HOME/.secrethub
[[ -d $shdir ]] && rm -rf $shdir
mkdir $shdir \
  && tar zxf ${secrethub} -C $shdir --strip-components 1 \
  && rm ${secrethub}
ln -s $shdir/* $HOME/.local/bin/


url_latest=${sh_url}/terraform-provider-secrethub/releases/latest
url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})
tag=${url_effective##*/}

tfprovider=terraform-provider-secrethub-linux-64-bit.tar.gz
echo Installing Secret Hub $tag version Terraform Provider

wget -q $sh_url/terraform-provider-secrethub/releases/download/${tag}/${tfprovider}
[[ ! -d ~/.terraform.d ]] && echo "Install Terraform" && exit
[[ ! -d ~/.terraform.d/plugins ]] && mkdir ~/.terraform.d/plugins
tar zxf ${tfprovider} -C ~/.terraform.d/plugins && rm ${tfprovider}
