#!/bin/bash
printf "\nConfiguring crictl\n"
#### Download crictl #######
VERSION="v1.27.1"
if [[ ! -f  /vagrant/ShellScripts/crictl-$VERSION-linux-amd64.tar.gz ]];then
  printf "Downloading crictl binary"
  wget https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/crictl-$VERSION-linux-amd64.tar.gz
fi
sudo tar zxf /vagrant/ShellScripts/crictl-$VERSION-linux-amd64.tar.gz -C /usr/local/bin
############ Configure crictl ##########################
sudo cp /vagrant/configs/config.toml /etc/containerd/ -vf
sudo systemctl restart containerd.service
#sudo chmod -R 777 /var/run/containerd/
sudo cp /vagrant/configs/crictl.yaml /etc/ -v
crictl version
printf "\nChecking All containers..\n\n"
crictl ps