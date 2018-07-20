#!/bin/bash

## This script is intended to be run on the control host (ie: workstation)

## Install the ansible hosts inventory
cp -f ./configs/ansible-hosts /etc/ansible/hosts

## Now we can do things via ansible where possible

ansible-playbook -f 3 ./playbooks/workstation-pre-install.yml
ansible-playbook -f 3 ./playbooks/cluster-pre-install.yml
