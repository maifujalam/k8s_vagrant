#!/bin/bash
FILE=/home/vagrant/.kube/config
if [ -f "$FILE" ]; then
    printf "\n Deleting existing k8s Cluster...\n"
    kubeadm reset --force
fi
####################### Init K8s Cluster ########################
printf "\nInitializing Cluster...\n"
  kubeadm init --config /vagrant/kubeadm-init/init-default.yaml

printf "\nCopying Config Files...\n"
  su - vagrant -c 'mkdir -p $HOME/.kube'
  su - vagrant -c 'sudo cp -vf /etc/kubernetes/admin.conf $HOME/.kube/config'
  su - vagrant -c 'sudo cp -vf /etc/kubernetes/admin.conf /vagrant/config'
  su - vagrant -c 'sudo chown $(id -u):$(id -g) $HOME/.kube/config'

printf "\nCooling down for 5 seconds...\n"
sleep 5

####################### Install Calico Cluster ########################
printf "\nInstalling Tigera Operator for Calico CNI...\n"
  su - vagrant -c 'kubectl create namespace tigera-operator'

printf "\nInstalling Tigera Operator for Calico CNI...\n"
  su - vagrant -c 'helm install calico /vagrant/manifests/tigera-operator -f /vagrant/manifests/tigera-operator/values1.yaml --namespace tigera-operator'

printf "\nInstalling Calico CNI with VXLAN...\n"
  su - vagrant -c 'kubectl apply -f /vagrant/manifests/tigera-operator/calico-install-vxlan.yaml'

printf "\nCooling down for 5 seconds...\n"
sleep 5

####################### Install Kube-VIP ########################

printf "\nInstalling Kube-vip...\n"
   su - vagrant -c 'helm install kube-vip --create-namespace --namespace kube-vip /vagrant/manifests/kube-vip -f /vagrant/manifests/kube-vip/values1.yaml '
   su - vagrant -c 'helm install kube-vip-cloud-provider --namespace kube-vip /vagrant/manifests/kube-vip-cloud-provider -f /vagrant/manifests/kube-vip-cloud-provider/values1.yaml'

printf "\nCooling down for 5 seconds...\n"
sleep 5

##################### Install Cert Manager ########################

printf "\nInstalling cert-manager...\n"
   su - vagrant -c 'helm -n cert-manager install cert-manager --create-namespace --namespace cert-manager /vagrant/manifests/cert-manager -f /vagrant/manifests/cert-manager/values1.yaml'

printf "\nCooling down for 5 seconds...\n"
sleep 5

####################### Install ingress-nginx ########################

printf "\nInstalling ingress-nginx...\n"
   su - vagrant -c 'helm -n ingress-nginx install ingress-nginx --create-namespace --namespace ingress-nginx /vagrant/manifests/ingress-nginx -f /vagrant/manifests/ingress-nginx/values1.yaml'

printf "\nCooling down for 90 seconds...\n"
  sleep 90

######################## Install Metric Server ########################
#printf "\nInstalling metric server...\n"
#   su - vagrant -c 'helm -n kube-system install metrics-server /vagrant/manifests/metrics-server -f /vagrant/manifests/metrics-server/values1.yaml '
#
#printf "\nCooling down for 5 seconds...\n"
#sleep 5
#

######################## Install k8s-dashboard########################
#
#printf "\nInstalling k8s Dashboard...\n"
#  su - vagrant -c 'helm -n kubernetes-dashboard install k8s-dashboard /vagrant/manifests/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard -f /vagrant/manifests/kubernetes-dashboard/values1.yaml'
#
#printf "\nCooling down for 20 seconds...\n"
#  sleep 20
#
######################## Create k8s-dashboard user ########################
#printf "\n Extracting dashboard token\n"
#  su - vagrant -c 'kubectl -n kubernetes-dashboard create token admin-user --duration=8760h > /vagrant/dashboard_token.txt'
#
#printf "\nAppend token in kubeconfig file.\n"
#  su - vagrant -c 'sed -i "/client-key-data/a\    token: $(cat /vagrant/dashboard_token.txt)" /vagrant/config'
#
#printf "\nCooling down for 5 sec..\n"
#  sleep 5
#
######################## Create k8s-dashboard user ########################
#printf "\nConfiguring kubectl.\n"
#  su - vagrant -c 'sh /vagrant/ShellScripts/6.configure_kubectl.sh'
#printf "\n-------K8s master Initialized Successfully-----\n"
