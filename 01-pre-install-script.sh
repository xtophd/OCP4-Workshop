#!/bin/bash

## This script is intended to be run:
##     on the control host (ie: workstation)
##     CWD =  ~root/OCP-Workshop

##
## Install the ansible hosts inventory
##

echo ""
echo "## Installing config file: /etc/ansible/hosts"
echo ""
cp -f ./configs/ansible-hosts /etc/ansible/hosts

##
## Now we can do things via ansible where possible
##

echo ""
echo "## Calling ansible playbook: ./playbooks/workstation-pre-install.yml"
echo ""
time ansible-playbook ./playbooks/workstation-pre-install.yml

echo ""
echo "## Calling ansible playbook: ./playbooks/cluster-pre-install.yml"
echo ""
time ansible-playbook -f 4 ./playbooks/cluster-pre-install.yml
