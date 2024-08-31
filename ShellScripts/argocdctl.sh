#!/bin/bash
echo "Installing argocd cli"
VERSION=v2.12.0 # Select desired TAG from https://github.com/argoproj/argo-cd/releases
if [  ! $(which argocd) ]; then
  curl -SL -o /tmp/argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
  sudo install -m 555 /tmp/argocd-linux-amd64 /usr/local/bin/argocd
  rm /tmp/argocd-linux-amd64
else
  echo "Argocd cli present at" $(which argocd)
fi

ARGOCD_SERVER="argocd.master.com"
USERNAME=admin
PASSWORD=$(kubectl -n argo-cd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
# echo $PASSWORD

argocd login $ARGOCD_SERVER  --insecure  --username $USERNAME --password $PASSWORD --grpc-web #--skip-test-tls

printf "\n Adding Argocd Repo.\n"
argocd repo add git@github.com:maifujalam/k8s_vagrant.git --ssh-private-key-path ~/.ssh/id_rsa

printf "\n Installing default Apps. \n"
kubectl apply -f ../manifests/default-applications.yaml

printf "\nList of ArgoCD Apps\n"
argocd app list
#printf "\nList of ArgoCD Projects\n"
#argocd proj list

#printf "\n Removing obsoleted helm chart"
#sh delete_helm_release.sh