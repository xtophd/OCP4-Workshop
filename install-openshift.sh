#!/bin/bash

## This script is intended to be run:
##     on the control host (ie: workstation)
##     CWD =  ~root/OCP-Workshop

myInventory="./configs/ocp-workshop"

if [ ! -e "${myInventory}" ] ; then
   echo "ERROR: Are you in the right directory? Can not find ${myInventory}" ; exit
   exit
fi

echo ""
echo "## Calling ansible playbook: ./playbooks/workstation-pre-install.yml"
echo ""

time ansible-playbook -i ${myInventory} ./playbooks/workstation-pre-install.yml

echo ""
echo "## Calling ansible playbook: ./playbooks/cluster-pre-install.yml"
echo ""

time ansible-playbook -i ${myInventory} -f 5 ./playbooks/cluster-pre-install.yml

## Run the installer

echo ""
echo "## Calling ansible playbook: ./playbooks/workstation-pre-install.yml"
echo ""

time ansible-playbook -i ${myInventory} -f 5 /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml

## Run post installation steps

echo ""
echo "## Calling ansible playbook: ./playbooks/ocp-post-install.yml"
echo ""

time ansible-playbook -i ${myInventory} -f 5 ./playbooks/cluster-post-install.yml
