packer {
  required_plugins {
    vagrant = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}
source "vagrant" "k8s" {    # Build k8s v 1.27.2 cluster with master components.
  source_path = "generic/rhel9"
  box_name = "rhel_9_box"
  communicator = "ssh"
  provider = "virtualbox"
  add_force = true
  box_version = "4.3.12"
}
build {
  name = "k8s_build"
  sources = ["source.vagrant.k8s"]
  provisioner "shell" {
    inline = ["sudo mkdir -pv /vagrant",
      "sudo chmod -R 777 /vagrant",
      "sudo chown vagrant:vagrant /vagrant"
    ]
  }
  provisioner "file" {
    source = "../ShellScripts"
    destination = "/vagrant/"
  }

  provisioner "file" {
    source = "../package_downloader/packages"
    destination = "/vagrant/"
  }
  provisioner "file" {
    source = "../package_downloader/bins"
    destination = "/vagrant/"
  }
  provisioner "file" {
    source = "../configs"
    destination = "/vagrant/"
  }
  provisioner "file" {
    source = "../kubeadm-init"
    destination = "/vagrant"
  }
  provisioner "file" {
    source = "../kubeadm-join"
    destination = "/vagrant"
  }
  provisioner "shell" {
    script       = "scripts/main.sh"
    pause_before = "1s"
    timeout      = "1s"
  }
}