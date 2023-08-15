#!/bin/bash

K8S_VERSION=1.27.4

echo "This is main script"
sudo sh /vagrant/ShellScripts/1_download-packages.sh --K8S_VERSION
sudo sh /vagrant/ShellScripts/2_configure_network.sh
sudo sh /vagrant/ShellScripts/3-configure_firealld_selinux.sh
ls /vagrant/ShellScripts/
sudo sh /vagrant/ShellScripts/4_config_crictl.sh
sudo sh /vagrant/ShellScripts/kubernetes_images.sh
sudo sh /vagrant/ShellScripts/5_install_helm.sh