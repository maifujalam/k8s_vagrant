#!/bin/bash
################ Linux Kernel Module ########################
echo "Add linux kernel modules..."
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
  overlay
  br_netfilter
EOF
modprobe overlay
modprobe br_netfilter
printf "\nVerify Linux kernel modules are added"
lsmod | grep br_netfilter
lsmod | grep overlay

################ Verify System Variables #######################
printf "\n Verify system variables are set to 1. \n\n"
# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-iptables  = 1
  net.bridge.bridge-nf-call-ip6tables = 1
  net.ipv4.ip_forward                 = 1
EOF
# Apply sysctl params without reboot
sudo sysctl --system
#su - vagrant -c "sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward"
printf "\nNetwork Configuration Completed...\n"
printf "Stopping for 5 sec\n"
sleep 5
