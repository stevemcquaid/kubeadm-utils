#!/bin/bash

# This script should work on ubuntu 16.04 machines
# Make sure you run this as root

# Enable ssh access for my machines
function get_public_keys () {
    mkdir -m 700 -p ~/.ssh
    for user in "$@"
    do
        curl -s https://github.com/"$user".keys >> ~/.ssh/authorized_keys
    done
    chmod 600 ~/.ssh/authorized_keys
}

get_public_keys stevemcquaid


# Install Docker CE
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
sudo apt-get update && sudo apt-get install -y docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
sudo groupadd docker
sudo usermod -aG docker $USER

# Install kubelet, kubeadm, kubectl
sudo apt-get update && sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl



