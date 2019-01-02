#!/bin/bash


## DOCKER: separate host is configured with docker alone for basic exercises

echo ""
echo "## Calling ansible playbook: ./playbooks/docker-install.yml"
echo ""
time ansible-playbook -i ./configs/docker-hosts.yml ./playbooks/docker-install.yml
