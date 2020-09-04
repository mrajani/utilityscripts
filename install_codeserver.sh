#!/bin/bash
# Install Code Server on Linux Platform 

url_latest=https://github.com/cdr/code-server/releases/latest
url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})
tag=${url_effective##*/}
ver=${tag##[a-z]}
echo "Installing ${tag} or ${ver} version of codeserver"

codeserver=code-server-${ver}-linux-x86_64.tar.gz
wget -q https://github.com/cdr/code-server/releases/download/${tag}/${codeserver}

vsdir=$HOME/.vscodeserver
[[ -d $vsdir ]] && rm -rf $vsdir
mkdir $vsdir \
  && tar zxf $codeserver -C $vsdir --strip-components 1 \
  && rm $codeserver

[[ -L $HOME/.local/bin/code-server ]] && rm -rf $HOME/.local/bin/code-server
ln -s $vsdir/bin/code-server $HOME/.local/bin/code-server

echo "Install Extensions GitLens, Terraform, Ansible"
