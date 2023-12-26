[ 1/11/2023 - master branch - k8s-1.27.4 ]
- Added kube-vip for implementing load balancing feature in local kubernetes cluster.
- kube-vip-cloud-provisioner provided IPAM for servie type Load Balancer.
- Ingress controller is assigned with load balancer ip 192.168.56.64
- Vagrant hosts are update with hosts ip address in vagrant file.
  - master: 192.168.56.100 -> 192.168.56.102
  - worker1: 192.168.56.110 -> 192.168.56.102
  - worker2: 192.168.56.120 -> 192.168.56.102
- /etc/hosts is updated with below values.  
  192.168.56.100 master  
  192.168.56.110 worker1  
  192.168.56.120 worker2  
  192.168.56.64 master.com argocd.master.com dashboard.master.com  
- K8s dashboard can be accessed with: https://dashboard.master.com 
