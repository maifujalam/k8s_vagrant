#!/bin/bash

PROJECT_PATH=/vagrant
KUBERNETES_VERSION=1.30.4
PACKAGE_DIRECTORY="$PROJECT_PATH/packages/"


if [ $# -gt 0 ]; then
  KUBERNETES_VERSION="$1"
fi
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.kubernetes.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.kubernetes.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
EOF
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update && sudo yum upgrade
sudo yum clean all


if [ ! -d $PACKAGE_DIRECTORY ] ;then
  printf "Directory not present.Downloading Packages\n"
  mkdir -pv "$PACKAGE_DIRECTORY"
fi

if [ -d "$PACKAGE_DIRECTORY" ] && [ -z "$(ls -A $PACKAGE_DIRECTORY)" ]; then
    echo "The directory $PACKAGE_DIRECTORY exists and is empty."
    sudo yum install -y containerd kubelet-$KUBERNETES_VERSION kubeadm-$KUBERNETES_VERSION kubectl-$KUBERNETES_VERSION --downloadonly --downloaddir=/vagrant/packages/.
else
    echo "The directory $PACKAGE_DIRECTORY either does not exist or is not empty."
fi
printf "Installing Packages\n"
sudo rpm -Uhv $PACKAGE_DIRECTORY/*.rpm

###### Verify Containerd  ########
printf "\nVerifying Binary...\n"
containerd -v
sudo systemctl enable --now containerd.service

########### Kubelet #############
kubelet --version
sudo systemctl enable --now kubelet

############ kubeadm ######
kubeadm version

########## kubectl #######
kubectl version
printf "\nVerifying Binary Completed. \n"