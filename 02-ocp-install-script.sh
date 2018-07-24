#!/bin/bash


## WORKSTATION: run the installer

echo -e "\n## Calling ansible playbook: ./playbooks/workstation-pre-install.yml\n"
time ansible-playbook -f 5 /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
