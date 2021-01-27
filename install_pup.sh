#!/bin/bash
# Install pup parser on Linux Platform 

pup_latest_url=https://github.com/ericchiang/pup/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $pup_latest_url)
pup_version=${temp##*/v}
echo Downloading pup v$pup_version
zipfile=${product}_v${pup_version}_linux_amd64.zip
url=https://github.com/ericchiang/pup/releases/download/v${pup_version}/${zipfile}
wget -c -q ${url} && unzip -d ~/.local/bin ${zipfile} && rm ${zipfile} 

# https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip
# curl -s https://releases.hashicorp.com/consul/ | tee consul.html
# cat consul.html | pup 'body ul li a text{}' | egrep -v '\.\.|ent|rc|beta' | head -1 | sed -s 's/consul_//'
