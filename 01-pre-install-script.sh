#!/bin/bash

## This script is intended to be run:
##     on the control host (ie: workstation)
##     CWD =  ~root/OCP-Workshop

##
## Install the ansible hosts inventory
##
echo "\n## Installing config file: /etc/ansible/hosts"
cp -f ./configs/ansible-hosts /etc/ansible/hosts

##
## Now we can do things via ansible where possible
##

echo "\n## Calling ansible playbook: ./playbooks/workstation-pre-install.yml"
time ansible-playbook ./playbooks/workstation-pre-install.yml

echo "\n## Calling ansible playbook: ./playbooks/cluster-pre-install.yml"
time ansible-playbook -f 4 ./playbooks/cluster-pre-install.yml
