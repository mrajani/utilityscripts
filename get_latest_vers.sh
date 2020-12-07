#!/bin/bash
# Show latest version of Hashicorp


latest_url=https://github.com/hashicorp/packer/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
packer_version=${temp##*/v}
echo packer $packer_version

latest_url=https://github.com/hashicorp/consul/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
consul_version=${temp##*/v}
echo consul $consul_version

latest_url=https://github.com/hashicorp/vault/releases/latest
temp=$(curl -sSL -I -o /dev/null -w %{url_effective} $latest_url)
vault_version=${temp##*/v}
echo vault $vault_version