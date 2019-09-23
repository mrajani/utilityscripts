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

curl -sSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get -yqq update

cat <<EOF | sudo tee  /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system # reload the configurations
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt -yq autoremove 2>/dev/null 1>&2
