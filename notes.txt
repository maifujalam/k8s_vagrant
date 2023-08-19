1. vagrant.exe package --base master --output k8s-1.27.2.box
2. vagrant.exe box add --name k8s-1.27.2  C:/Users/ALAM/IdeaProjects/kubernetes/vm-provision/k8s_localhost/k8s-1.27.2.box
3. sudo yum install container-tools
4. Set system variables:- [ https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/ ]
  cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
  overlay
  br_netfilter
  EOF

  sudo modprobe overlay
  sudo modprobe br_netfilter

  # sysctl params required by setup, params persist across reboots
  cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
  net.bridge.bridge-nf-call-iptables  = 1
  net.bridge.bridge-nf-call-ip6tables = 1
  net.ipv4.ip_forward                 = 1
  EOF

  # Apply sysctl params without reboot
  sudo sysctl --system
5. Verify system variable: sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward
6.For RHEL/Centos server add containerd.io repo:
  a. sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  b. dnf install containered.io

6.1 Download containered from yum.
    a. sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    b. yum install -y yum-utils && sudo yum update
    c. sudo yum install -y containerd --downloadonly --downloaddir=/vagrant/packages/.  OR
       sudo yumdownloader -y containerd --downloadonly --downloaddir=/vagrant/packages/. --resolve
    d. sudo rpm -Uhv /vagrant/packages/*.rpm

7.Generate Containerd.io config file:
  a. sudo containerd config default > /etc/containerd/config.toml or cp config.toml  /etc/containerd/
  b. restart and enable containered.io
  c. Edit cgroup to use systemd: [https://kubernetes.io/docs/setup/production-environment/container-runtimes/]
  d. systemctl restart containerd.service
8. Disable firewalld,swap.
9. Install metric server with helm.
  a. h repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
  b. h repo update
  c. h pull metrics-server/metrics-server --version 3.10.0 --untar
  d. h install metricserver metrics-server -n kube-system
  e. h list ,h status metricserver
