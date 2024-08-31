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

####################### Configure kubernetes auto completion ########################
printf "\nConfiguring kubectl.\n"
  su - vagrant -c 'sh /vagrant/ShellScripts/6_configure_kubectl.sh'
printf "\n-------K8s master Initialized Successfully-----\n"

####################### Install Calico Network CNI ########################
printf "\nInstalling Tigera Operator for Calico CNI...\n"
  su - vagrant -c 'helm install calico /vagrant/manifests/tigera-operator -f /vagrant/manifests/tigera-operator/values.yaml --create-namespace --namespace tigera-operator'

printf "\nCooling down for 5 seconds...\n"
  sleep 5

####################### Install Kube-VIP ########################
printf "\nInstalling Kube-vip...\n"
   su - vagrant -c 'helm install kube-vip --create-namespace --namespace kube-vip /vagrant/manifests/kube-vip'
   su - vagrant -c 'helm install kube-vip-cloud-provider --namespace kube-vip /vagrant/manifests/kube-vip-cloud-provider'

printf "\nCooling down for 5 seconds...\n"
sleep 5

##################### Install Cert manager  ########################
printf "\nInstalling cert-manager...\n"
   su - vagrant -c 'helm -n cert-manager install cert-manager --create-namespace --namespace cert-manager /vagrant/manifests/cert-manager'
   su - vagrant -c "kubectl apply -f /vagrant/manifests/cert-manager/self-sign-issuer.yaml "

printf "\nCooling down for 10 seconds...\n"
  sleep 10

####################### Install ingress-nginx ########################
printf "\nInstalling ingress-nginx...\n"
   su - vagrant -c 'helm -n ingress-nginx install ingress-nginx --create-namespace --namespace ingress-nginx /vagrant/manifests/ingress-nginx'

printf "\nCooling down for 10 seconds...\n"
  sleep 10

######################## Install Argocd ########################
printf "\nInstalling ArgoCD...\n"
su - vagrant -c 'helm -n argo-cd install argo-cd /vagrant/manifests/argo-cd-7.4.3.tgz --create-namespace --namespace argo-cd'

printf "\nInstalling Argocd Apps ...\n"
  su - vagrant -c 'kubectl apply -f /vagrant/manifests/default-applications.yaml'

printf "\n-------K8s master Initialized Successfully-----\n"
