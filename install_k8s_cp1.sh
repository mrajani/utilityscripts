#!/bin/bash
set -e

if [ -e ./k8s_env ]; then
    source ./k8s_env
else
    echo "File k8s_env is missing"
    exit
fi

echo ${K8sCP1} ${K8sCP2} ${K8sCP3} ${docker_version}
[[ -z ${K8sCP1} ]] && echo "Master Node not setup" && exit
[[ -z ${POD_CIDR} ]] && echo "Set value for POD_CIDR" && exit
[[ -z ${LBInt} ]] && echo "Set Internal IP of LB" && exit


sudo mkdir -p /etc/kubernetes/kubeadm
cat <<EOF | sudo tee /etc/kubernetes/kubeadm/kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta1
kind: ClusterConfiguration
kubernetesVersion: stable
controlPlaneEndpoint: "${LBInt}:6443"
networking:
  podSubnet: ${POD_CIDR}
EOF

sudo kubeadm init \
 --config=/etc/kubernetes/kubeadm/kubeadm-config.yaml \
 --upload-certs

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

curl -sSLO https://docs.projectcalico.org/v3.9/manifests/calico.yaml
# sed -i -e "s?192.168.0.0/16?$POD_CIDR?g" calico.yaml
curl -sSLO https://docs.projectcalico.org/v3.9/manifests/canal.yaml -O
# sed -i -e "s?10.244.0.0/16?$POD_CIDR?g" canal.yaml

curl -sSLO https://github.com/projectcalico/calicoctl/releases/download/v3.5.8/calicoctl
chmod +x calicoctl

echo run out put of kubeadm init first
echo sudo kubectl apply -f calico.yaml

# 
# kubeadm token create --ttl 10m --print-join-command
#
# kubeadm init phase upload-certs --experimental-upload-certs

