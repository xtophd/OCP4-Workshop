#!/bin/bash

## WORKSTATION: run the installer
time ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
