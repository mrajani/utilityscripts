#!/bin/bash
# Install awx parser on Linux Platform 

product=awx
awx_latest_url=https://github.com/ansible/awx/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $awx_latest_url)
awx_version=${temp##*/}
echo Downloading awx $awx_version
zipfile=${awx_version}.zip
url=https://github.com/ansible/awx/archive/${zipfile}
wget -c -q ${url} && unzip -u -q -d ${HOME} ${zipfile} && rm ${zipfile} 

# mkdir awx && tar -C awx --strip-components=1 -xvf 17.0.1.tar.gz
# https://github.com/ansible/awx/releases/tag/17.0.1
# https://github.com/ansible/awx/archive/17.0.1.zip
# https://github.com/ansible/awx/archive/17.0.1.tar.gz
# curl -s https://releases.hashicorp.com/consul/ | tee consul.html
# cat consul.html | pup 'body ul li a text{}' | egrep -v '\.\.|ent|rc|beta' | head -1 | sed -s 's/consul_//'
