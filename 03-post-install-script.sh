#!/bin/bash


## WORKSTATION: run post installation steps

echo ""
echo "## Calling ansible playbook: ./playbooks/ocp-post-install.yml"
echo ""
time ansible-playbook -f 5 ./playbooks/ocp-post-install.yml
