#!/bin/bash
########## Cleanup Old K8s Config #########
FILE=/home/vagrant/.kube/config
if [ -f "$FILE" ]; then
    printf "\n Deleting existing k8s Cluster...\n\n"
    kubeadm reset --force
fi
####################### Init K8s Cluster ########################
printf "\nJoining worker to cluster...\n\n"
