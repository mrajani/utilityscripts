#!/bin/bash

# Install GitUI on Linux Platform 

gitui_latest_url=https://github.com/extrawurst/gitui/releases/latest
# https://github.com/extrawurst/gitui/releases/download/v0.17/gitui-linux-musl.tar.gz

product=gitui
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $gitui_latest_url)
tag=${temp##*/}
zipfile=gitui-linux-musl.tar.gz
url=https://github.com/extrawurst/gitui/releases/download/${tag}/${zipfile}
echo $url
echo "Downloading ${tag} version of ${product}"
wget -c -q ${url} && tar -zxf ${zipfile} -C ~/.local/bin  && rm ${zipfile} 

