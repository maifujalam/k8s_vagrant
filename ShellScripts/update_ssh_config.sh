#!/usr/bin/env bash
echo "updating ssh config file.."
sudo sed -i 's/PasswordAuthentication no/# PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo systemctl status sshd
