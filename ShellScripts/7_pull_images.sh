#!/bin/bash
crictl pull docker.io/kubernetesui/dashboard-api:1.7.0
crictl pull docker.io/kubernetesui/dashboard-auth:1.1.3
crictl pull docker.io/kubernetesui/dashboard-web:1.4.0
crictl pull ghcr.io/kube-vip/kube-vip-cloud-provider:v0.0.10
crictl pull ghcr.io/kube-vip/kube-vip:v0.7.0
crictl pull docker.io/calico/apiserver:v3.26.1
crictl pull docker.io/calico/cni:v3.26.1
crictl pull docker.io/calico/kube-controllers:v3.26.1
crictl pull docker.io/calico/node-driver-registrar:v3.26.1
crictl pull docker.io/calico/node:v3.26.1
crictl pull docker.io/calico/pod2daemon-flexvol:v3.26.1
crictl pull docker.io/calico/typha:v3.26.1
crictl pull quay.io/prometheus/node-exporter:v1.8.2
crictl pull quay.io/prometheus/prometheus:v2.54.0
crictl pull quay.io/prometheus/alertmanager:v0.27.0
crictl pull quay.io/prometheus-operator/prometheus-operator:v0.75.2
crictl pull quay.io/prometheus-operator/prometheus-config-reloader:v0.75.2

printf "/n/n Image Pull is successful./n/n"
rm -rvf /vagrant/*
printf "/n/n Build is Successful."
