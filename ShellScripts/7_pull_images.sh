#!/bin/bash
crictl pull quay.io/jetstack/cert-manager-controller:v1.15.3
crictl pull quay.io/jetstack/cert-manager-startupapicheck:v1.15.3
crictl pull quay.io/jetstack/cert-manager-webhook:v1.15.3
crictl pull registry.k8s.io/ingress-nginx/controller:v1.11.2@sha256:d5f8217feeac4887cb1ed21f27c2674e58be06bd8f5184cacea2a69abaf78dce
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
crictl pull rancher/local-path-provisioner:v0.0.26
crictl pull docker.io/grafana/grafana:11.1.0
crictl pull registry.k8s.io/kube-state-metrics/kube-state-metrics:v2.13.0
crictl pull quay.io/prometheus/node-exporter:v1.8.2
crictl pull quay.io/prometheus/blackbox-exporter:v0.25.0
crictl pull quay.io/prometheus-operator/prometheus-config-reloader:v0.71.2
printf "/n/n Image Pull is successful./n/n"
rm -rvf /vagrant/*
printf "/n/n Build is Successful."
