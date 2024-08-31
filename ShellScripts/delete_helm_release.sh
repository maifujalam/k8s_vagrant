#!/bin/bash
helm -n kube-vip uninstall kube-vip-cloud-provider
helm -n kube-vip uninstall kube-vip
helm -n cert-manager uninstall cert-manager
helm -n tigera-operator uninstall calico
helm -n ingress-nginx uninstall ingress-nginx
