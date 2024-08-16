#!/bin/bash
crictl pull docker.io/kubernetesui/dashboard-api:1.7.0
crictl pull docker.io/kubernetesui/dashboard-auth:1.1.3
crictl pull docker.io/kubernetesui/dashboard-web:1.4.0
crictl pull ghcr.io/kube-vip/kube-vip-cloud-provider:v0.0.10
