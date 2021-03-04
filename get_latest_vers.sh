#!/bin/bash
# Show latest version of Hashicorp

url=https://checkpoint-api.hashicorp.com/v1/check/nomad
ver=$(curl -sSL  ${url} | jq '.current_version'| sed -e 's/"//g')
echo nomad $ver

url=https://checkpoint-api.hashicorp.com/v1/check/vagrant
ver=$(curl -sSL  ${url} | jq '.current_version'| sed -e 's/"//g')
echo vagrant $ver

url=https://checkpoint-api.hashicorp.com/v1/check/packer
ver=$(curl -sSL  ${url} | jq '.current_version'| sed -e 's/"//g')
echo packer $ver

latest_url=https://github.com/hashicorp/packer/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
packer_version=${temp##*/v}
echo packer $packer_version

url=https://checkpoint-api.hashicorp.com/v1/check/consul
ver=$(curl -sSL  ${url} | jq '.current_version'| sed -e 's/"//g')
echo consul $ver

latest_url=https://github.com/hashicorp/consul/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
consul_version=${temp##*/v}
echo consul $consul_version

latest_url=https://github.com/hashicorp/vault/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
vault_version=${temp##*/v}
echo vault $vault_version

latest_url=https://github.com/hashicorp/terraform/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
terraform_version=${temp##*/v}
echo terraform $terraform_version

url=https://checkpoint-api.hashicorp.com/v1/check/terraform
ver=$(curl -sSL  ${url} | jq '.current_version'| sed -e 's/"//g')
echo terraform $ver

latest_url=https://github.com/ericchiang/pup/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
pup_version=${temp##*/v}
echo pup $pup_version
#cat consul.html | pup 'body ul li a text{}' | egrep -v '\.\.|ent|rc|beta' | head -1
#cat vault.html  | pup 'body ul li a text{}' | egrep -v '\.\.|ent|rc|beta' | head -1
