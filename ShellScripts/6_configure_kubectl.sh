#!/bin/bash
printf "\nConfiguring Kubectl\n"
{
  echo "source <(kubectl completion bash)"
  echo "alias k=kubectl"
  echo "complete -o default -F __start_kubectl k"
} >> ~/.bashrc
#source ~/.bashrc
#k get no 2> /dev/null
