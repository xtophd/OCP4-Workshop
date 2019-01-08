#!/bin/bash

## This script is intended to be run:
##     on the control host (ie: workstation)
##     CWD =  ~root/OCP-Workshop

myInventory="./configs/docker-workshop"

if [ ! -e "${myInventory}" ] ; then
   echo "ERROR: Are you in the right directory? Can not find ${myInventory}" ; exit
   exit
fi

echo ""
echo "## Calling ansible playbook: ./playbooks/docker-install.yml"
echo ""
time ansible-playbook -i ${myInventory} ./playbooks/docker-install.yml

