IMAGE_NAME = "skmaifujalam/k8s-1.30.4"  # Base image of VM which is vagrant box of RHEL 9 as default. generic/rhel9
BOX_VERSION = "3"                       # Base image version of above image as, 4.2.16
NM = 1                                  # Specify number of master vms to create(Example:-3,4,5 but minimum 3)
NW = 2                                  # Specify the the numbers of worker VMs to create (Example:- 2,3,4)
MASTER = "master"                       # Name of Master VM
WORKER = "worker"                       # Names of worker VMs(worker vms will be named as worker1,worker2,worker3 ... )
CPU_MASTER = 4                          # Specify the CPU of master VM(Example :-1,2)
CPU_WORKER = 2                          # Specify CPU of each worker VMs(Example :-1,2)
MEMORY_MASTER = 4096                    # Specify the RAM of master VMs in MB(Example :- 2048,4096)
MEMORY_WORKER = 2048                    # Specify the RAM of each worker VMs in MB(Example :- 2048,4096)
HDD = '20GB'                            # HDD of Each VM (Examples :- "15GB","20GB","30GB")

IP_MASTER = '192.168.56.2'
IP_WORKER = ['192.168.56.3','192.168.56.4']

Vagrant.configure("2") do |config|
    config.vagrant.plugins = ['vagrant-disksize','vagrant-hostmanager','vagrant-timezone']
    config.ssh.insert_key = false
    config.vm.box_check_update = false
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true  # false to disable update '/etc/hosts' of host with guest VMs dns.
    config.hostmanager.manage_guest = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.timezone.value = :host
    #config.disksize.size = HDD
    config.vm.synced_folder ".", "/vagrant", disabled: false
    (1..NM).each do |i|
        config.vm.define MASTER +  "" do |master|
            master.vm.provider "virtualbox" do |vmm|
                vmm.name = MASTER
                vmm.memory = MEMORY_MASTER
                vmm.cpus = CPU_MASTER
                vmm.gui = false
                vmm.linked_clone = false
            end
            master.vm.box = IMAGE_NAME
            master.vm.box_version = BOX_VERSION
            master.vm.network "private_network", ip: IP_MASTER , hostname: true
            master.vm.hostname = MASTER
            master.vm.provision "shell", inline: <<-SHELL
                sh /vagrant/ShellScripts/update_ssh_config.sh
                sh /vagrant/ShellScripts/k8s_master_bootstrap.sh
            SHELL
        end
    end

    (1..NW).each do |j|
    config.vm.define WORKER + "#{j}" do |worker|
            worker.vm.provider "virtualbox" do |vmw|
                vmw.name = WORKER+"#{j}"
                vmw.memory = MEMORY_WORKER
                vmw.cpus = CPU_WORKER
                vmw.gui = false
            end
            worker.vm.box = IMAGE_NAME
            worker.vm.box_version = BOX_VERSION
            worker.vm.network "private_network", ip: IP_WORKER[j-1]
            worker.vm.hostname = WORKER + "#{j}"
            worker.vm.provision "shell", inline: <<-SHELL
                sh /vagrant/ShellScripts/update_ssh_config.sh
                #sh /vagrant/ShellScripts/k8s_worker_bootstrap.sh
                kubeadm join --v=5 --config /vagrant/kubeadm-join/join-default-worker"#{j}".yaml
                echo "----- worker#{j} joined successfully to cluster -----"
            SHELL
        end
    end
#    config.trigger.after :up, type: :command do |t|
#      t.info = "Updating Kubeconfig"
#      t.run = {inline: "bash -c 'echo hostnamectl'"}
#      t.run = {path: "ShellScripts/0_configure_ssh.sh"}
#    end
end
