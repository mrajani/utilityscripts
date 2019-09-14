#!/bin/sh


#!/bin/bash
# Install Secret Hub for Linux Platform
url_latest=https://github.com/secrethub/secrethub-cli/releases/latest
url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})
tag=${url_effective##*/}
echo "Installing ${tag} version of SecretHub"

# https://github.com/secrethub/secrethub-cli/releases/download/v0.27.0/secrethub-v0.27.0-linux-amd64.tar.gz

secrethub=secrethub-${tag}-linux-amd64.tar.gz
wget -q \
 https://github.com/secrethub/secrethub-cli/releases/download/${tag}/${secrethub}

shdir=$HOME/.secrethub
[[ -d $shdir ]] && rm -rf $shdir
mkdir $shdir \
  && tar zxf ${secrethub} -C $shdir --strip-components 1 \
  && rm ${secrethub}
ln -s $shdir/* $HOME/.local/bin/
