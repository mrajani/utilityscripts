#!/bin/bash

if [ -e ./k8s_env ]; then
    source ./k8s_env
else 
    echo "File k8s_env is missing"
    exit
fi

echo ${K8sCP1} ${K8sCP2} ${K8sCP3} ${docker_version}
[[ -z ${K8sCP1} ]] && echo "Master Node not setup" && exit

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get -yqq update
sudo apt-get remove docker docker-engine docker.io
sudo DEBIAN_FRONTEND=noninteractive apt-get -yqq upgrade
sudo apt-get -yq install apt-transport-https ca-certificates curl software-properties-common
sudo apt install -yqq docker-ce=${docker_version} docker-ce-cli=${docker_version}
sudo usermod -aG docker ${user}
sudo systemctl status docker --no-pager
sudo systemctl is-active docker
sudo docker container run --rm hello-world
sudo apt -yq autoremove

sudo mkdir -p /etc/nginx
cat <<EOF | sudo tee /etc/nginx/nginx.conf
events { }
stream {
    upstream stream_backend {
        least_conn;
        server ${K8sCP1}:6443;
        server ${K8sCP2}:6443;
        server ${K8sCP3}:6443;
    }
    server {
        listen        6443;
        proxy_pass    stream_backend;
        proxy_timeout 3s;
        proxy_connect_timeout 1s;
    }
}
EOF
sudo docker run --name proxy \
    -v /etc/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
    -p 6443:6443 \
    -d nginx

