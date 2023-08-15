#!/bin/bash

#Name: SK Maifuj Alam
#Email: sk.maifujalam@gmail.com
#Website: maifuj.com
#
#Copyright 2023 SK Maifuj Alam. All rights reserved.
#
#This computer code, including any associated documentation or files (the "Code"), is the intellectual property of
#SK Maifuj Alam and is protected by copyright laws and international treaties. Unauthorized reproduction or distribution
#of this Code, or any portion thereof, may result in severe civil and criminal penalties and will be prosecuted to the
#maximum extent possible under the law.Permission is hereby granted, free of charge, to any person or organization
#obtaining a copy of this Code, to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
#Code, subject to the following conditions:
#
#1. The above copyright notice and this permission notice shall be included in all copies or substantial portions of the
#Code.
#
#2. The Code is provided "as is," without warranty of any kind, express or implied, including but not limited to the
#   warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall
#   SK Maifuj Alam be liable for any claim, damages, or other liability, whether in an action of contract, tort, or
#   otherwise, arising from, out of, or in connection with the Code or the use or other dealings in the Code.
#
#For inquiries regarding the Code or any permitted use, please contact [Your Email Address].
#
#SK Maifuj Alam retains all ownership rights and other rights in the Code not expressly granted in this copyright notice.
#
#Date: 06-August-2023


# NOTE:- Set environment variable at ~/.bashrc with, export SSHPASS=vagrant

MASTER=master
WORKER1=worker1
WORKER2=worker2

#printf "Populating known hosts..\n"
#{
#  ssh-keyscan master
#  ssh-keyscan worker1
#  ssh-keyscan worker2
#} >> ~/.ssh/known_hosts
echo "Pinging $MASTER"
if ping -c 2 $MASTER &> /dev/null ;then
  echo "$MASTER is reachable"
  ####### Configure MASTER #######
  # Remove any known host of MASTER
  ssh-keygen -f "/home/alam/.ssh/known_hosts" -R $MASTER &> /dev/null
  # Add MASTER fingerprint to known host
  (ssh-keyscan $MASTER >> ~/.ssh/known_hosts) &> /dev/null
  # Copying ssh public keys to servers
  sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no vagrant@$MASTER &> /dev/null
  echo "Master is configured for password less SSH from host"
  # ssh vagrant@master
  else
    echo "$MASTER is NOT Reachable"
fi

echo "Pinging $WORKER1"
if ping -c 2 $WORKER1 &> /dev/null ;then
  echo "$WORKER1 is Reachable"
  ####### Configure WORKER1 #######
  # Remove any known host of WORKER1
  ssh-keygen -f "/home/alam/.ssh/known_hosts" -R $WORKER1 &> /dev/null
  # Add WORKER1 fingerprint to known host
  (ssh-keyscan $WORKER1 >> ~/.ssh/known_hosts) &> /dev/null
  # Copying ssh public keys to servers
  sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no vagrant@$WORKER1 &> /dev/null
  echo "Worker1 is configured for password less SSH from host"
  # ssh vagrant@worker1
  else
    echo "$WORKER1 is NOT Reachable"
fi

echo "Pinging $WORKER2"
if ping -c 2 $WORKER2 &> /dev/null ;then
  echo "$WORKER2 is reachable"
  ####### Configure WORKER2 #######
  # Remove any known host of WORKER2
  ssh-keygen -f "/home/alam/.ssh/known_hosts" -R $WORKER2 &> /dev/null
  # Add MASTER fingerprint to known host
  (ssh-keyscan $WORKER2 >> ~/.ssh/known_hosts) &> /dev/null
  # Store PASSWORD for WORKER2
  sshpass -e ssh-copy-id -i ~/.ssh/id_rsa.pub -o StrictHostKeyChecking=no vagrant@$WORKER2 &> /dev/null
  echo "Worker2 is configured for password less SSH from host"
  # ssh vagrant@worker2
  else
    echo "$WORKER2 is NOT Reachable"
fi

printf "\n Merging Kube-config Files\n"
cp -vf ~/.kube/config ~/.kube/config.backup
KUBECONFIG=../config:~/.kube/config kubectl config view --flatten | tee  ~/.kube/config
#cp -vf ../config ~/.kube/new_config
echo "KUBECONFIG=new_config:~/.kube/config kubectl config view --flatten > config" > ~/.kube/update_kubeconfig.sh
#chmod 777  ~/.kube/update_kubeconfig.sh
##sudo sh ~/.kube/update_kubeconfig.sh