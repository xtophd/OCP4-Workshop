#!/bin/bash

## WORKSTATION: run the installer
time ansible-playbook -f 5 /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
