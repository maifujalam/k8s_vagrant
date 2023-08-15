#!/bin/bash

KUBERNETES_VERSION=1.27.4-0
if [ $# -gt 0 ]; then
  KUBERNETES_VERSION="$1"
fi
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum clean all
#sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
PACKAGE_DIRECTORY="/vagrant/packages/"
if [ ! -d $PACKAGE_DIRECTORY ] ;then
  printf "Directory not present.Downloading Packages\n"
  sudo yum install -y containerd kubelet-$KUBERNETES_VERSION kubeadm-$KUBERNETES_VERSION kubectl-$KUBERNETES_VERSION --downloadonly --downloaddir=/vagrant/packages/.
fi

if [ -d "$PACKAGE_DIRECTORY" ] && [ -z "$(ls -A $PACKAGE_DIRECTORY)" ]; then
    echo "The directory $PACKAGE_DIRECTORY exists and is empty."
    sudo yum install -y containerd kubelet-$KUBERNETES_VERSION kubeadm-$KUBERNETES_VERSION kubectl-$KUBERNETES_VERSION --downloadonly --downloaddir=/vagrant/packages/.
else
    echo "The directory $PACKAGE_DIRECTORY either does not exist or is not empty."
fi
printf "Installing Packages\n"
sudo rpm -Uhv /vagrant/packages/*.rpm

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