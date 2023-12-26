# k8s_vagrant

Install native 3 node kubernetes cluster in your system.It uses Vagrant to set up and
manage virtual machine running on VirtualBox.It follows 1 master 2 worker as default.But number of
workers can be updated.You can also update the number of CPU,Memory values of master and worker nodes.

## Prerequisites

Make sure you have installed all the following prerequisites on your machine:

- Virtualbox - Install latest version of VirtualBox from https://www.virtualbox.org/wiki/Downloads. Make sure It's
  configured to create HostOnly and NAT network.
  Also required to enable vagrant experimental feature to manage disk.
- Vagrant - Install latest version of Vagrant from https://developer.hashicorp.com/vagrant/downloads.
- Packer - Used to build base image for specific kubernetes version. (Optional, for Step-4 only)
- Linux Developer Account - Require to download kubernetes RPMs with all its dependencies. (Optional, for Step-4 only)

## Description

Creating K8S cluster requires to follow below steps:-

### **1. Download Vagrant box :**

This vagrant box image is custom base rhel9 image ready
to use as kubernetes cluster setup.It is loaded with packages required to setup kuberentes cluster.
It contains packages like:- kubeadm,kubectl,kubelet,containerd.io,helm,crictl pre-installed.  
Download this vagrant box image with command:
`vagrant box add skmaifujalam/k8s-1.27.4 --box-version=1.0`

    [Note:- If the desired kubernetes version of vagrant box is not available to download,follow step-4 to build it]

### **2. Configure Files :**

Update below Configuration files based on the requirement and environment:-

**Vagrantfile:—** Update box name,version as per the above downloaded image.You can update other options in this file
number of worker nodes and resource allocation of all nodes.

**kubeadm-init/init-default.yaml:-** Update this file with kubernetes version, criSocket, clusterName, etc for master
node.

**kubeadm-join/join-worker{n}.yaml:-** Update this file with kubernetes worker details like worker name,criSocket,etc.
If more than 3 works are needed, then create copy of this file and bump up worker no.

### 3. Create Kubernetes Cluster :

To start creating kubernetes cluster, make sure to have vagrant and Virtualbox installed.Then follow
the below steps to create kubernetes cluster.

- Go to project directory after cloning repo: `cd k8s_vagrant`
- Run vagrant status to check if vagrant file is valid and all plugins are properly installed: `vagrant status`
- Run vagrant up to start creating kubernetes cluster: `vagrant up`

### 4. Build Vagrant base box for specific kubernetes version:

To build the base virtual box for specific kubernetes version we need to download kubernetes packages.For this
we need to register our baseos machine to have RedHat Developer Subscription.

a. Download all rpm packages using base os as below:-

- Create/Login to Redhat Developer portal and obtain Red Hat Developer Subscription for Individuals.
- Goto base os building directory: `cd package_downloader`
- Delete any existing packages: rm -rfv packages
- Start vagrant box of base vm: vagrant up
- ssh into vagrant baseos: `vagrant ssh baseos`
- Register system to RedHat Portal: `sudo sh /vagrant/ShellScripts/register_system_redhat.sh`
- Download kubernetes package rpms: `sudo sh /vagrant/ShellScripts/download-packages.sh`
- Unregister system: `sudo sh /vagrant/ShellScripts/unregister_system_redhat.sh`
- Unregister/Delete VM from redhat portal(Optional):  https://access.redhat.com/management/subscriptions
- Destroy vagrant box: `vagrant destroy`
- As a result you will be left with downloaded rpms at: k8s_vagrant/package_downloader/packages
- Verify package size (Make sure its around 100M) : `du -hs package_downloader/packages/`

b. Install all the rpms downloaded above and preconfigure base image:-

- Make sure packer is installed: `packer --version`
- Go to packer folder: `cd k8s_vagrant/packer`
- Run packer to generate image: `packer build --force k8s.pkr.hcl` [ --force is to override existing vagrant box]
- After packer build is successful, we will get a folder name:  `output-k8s` containing package.box
- Load the package locally using script:  
  `sh k8s_vagrant/packer/add_box_local.sh` [need to update vagrant file to use this vagrant box]
- Upload the vagrant box to cloud.


## Authors

- [@SkMaifujAlam](https://github.com/maifujalam)