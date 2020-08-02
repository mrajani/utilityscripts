#!/bin/bash
# Install Code Server on Linux Platform 

url_latest=https://github.com/PowerShell/PowerShell/releases/latest
url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})
tag=${url_effective##*/}
ver=${tag##[a-z]}
os_ver=$(lsb_release -sr)
pwsh=powershell-lts_${ver}-1.ubuntu.${os_ver}_amd64.deb
wget -q https://github.com/PowerShell/PowerShell/releases/download/${tag}/${pwsh}

echo "Installing ${tag} ${ver} version of PowerShell for ${os_ver} $(lsb_release -cs) "
echo "package ${pwsh}"

sudo dpkg -i ${pwsh}
sudo apt-get install -f -y

echo "Run pwsh and install Az module"
echo "Install-Module -Name Az -AllowClobber -Force"
pwsh -c "Install-Module -Name Az -AllowClobber -Force"

pwshdir=$HOME/.pwsh
[[ -d $pwshdir ]] && rm -rf $pwshdir
mkdir $pwshdir 
