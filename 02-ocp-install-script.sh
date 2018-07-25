#!/bin/bash


## WORKSTATION: run the installer

echo ""
echo "## Calling ansible playbook: ./playbooks/workstation-pre-install.yml"
echo ""
time ansible-playbook -f 5 /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
