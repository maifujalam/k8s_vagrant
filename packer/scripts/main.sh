#!/bin/bash
echo "/n/nThis is main script/n/n"
sudo sh /vagrant/ShellScripts/1_download-packages.sh --K8S_VERSION=1.31.1
sudo sh /vagrant/ShellScripts/2_configure_network.sh
sudo sh /vagrant/ShellScripts/3-configure_firealld_selinux.sh
sudo sh /vagrant/ShellScripts/4_copy_bins.sh
sudo sh /vagrant/ShellScripts/config_crictl.sh
sudo sh /vagrant/ShellScripts/5_kubernetes_images.sh
sudo sh /vagrant/ShellScripts/6_configure_kubectl.sh
echo "/n/n Build Successful.  /n/n"