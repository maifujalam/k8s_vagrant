1. crictl config:  sudo cp crictl.yaml /etc/ -v
2. Run shell script to load modprobe modules: ./modules-load.sh
3. k8s config for sysctl: sudo cp k8s.conf /etc/sysctl.d/ -vf ; sudo sysctl --system
3. config.toml for containered.io : cp config.toml /etc/containerd/ -vf ; systemctl restart containerd.io
4. bashrc: append at the end of ./bashrc