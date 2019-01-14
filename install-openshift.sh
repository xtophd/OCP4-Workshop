#!/bin/bash

## This script is intended to be run:
##     on the control host (ie: workstation)
##     CWD =  ~root/OCP-Workshop

myInventory="./configs/ocp-workshop"

if [ ! -e "${myInventory}" ] ; then
   echo "ERROR: Are you in the right directory? Can not find ${myInventory}" ; exit
   exit
fi

time ansible-playbook -i ${myInventory} -5 \
   ./playbooks/workstation-pre-install.yml \
   ./playbooks/cluster-pre-install.yml \
   /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml \
   ./playbooks/cluster-post-install.yml
