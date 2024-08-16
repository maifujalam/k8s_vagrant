#!/bin/bash
printf "\n\nDownloading Images for k8s 1.30.4\n\n"
kubeadm config images list --kubernetes-version v1.30.4
kubeadm config images pull --kubernetes-version v1.30.4
printf "\n\nDownload Images for k8s 1.30.4 is Successful. \n\n"