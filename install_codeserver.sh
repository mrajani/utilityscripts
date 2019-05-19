#!/bin/bash
# Install Code Server on Linux Platform 

tag=1.939-vsc1.33.1
codeserver=code-server${tag}-linux-x64.tar.gz
wget https://github.com/cdr/code-server/releases/download/${tag}/${codeserver}
mkdir vscodeserver \
&& tar zxf $codeserver -C vscodeserver --strip-components 1 \
&& rm $codeserver

#url_latest=https://github.com/cdr/code-server/releases/latest
#url_effective=$(curl -sSL -I -o /dev/null -w %{url_effective} ${url_latest})