#!/bin/bash
echo "Installing argocd cli"
VERSION=v2.8.4 # Select desired TAG from https://github.com/argoproj/argo-cd/releases
if [  ! $(which argocd) ]; then
  curl -SL -o /tmp/argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
  sudo install -m 555 /tmp/argocd-linux-amd64 /usr/local/bin/argocd
  rm /tmp/argocd-linux-amd64
else
  echo "Argocd cli present at" $(which argocd)
fi
