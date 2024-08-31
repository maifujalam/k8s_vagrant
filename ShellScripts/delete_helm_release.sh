#!/bin/bash
helm -n kube-vip uninstall kube-vip-cloud-provider
helm -n kube-vip uninstall kube-vip
helm helm -n ingress-nginx uninstall ingress-nginx
