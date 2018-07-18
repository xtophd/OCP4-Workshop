#!/bin/bash

##
## Most of this will get moved into an Ansible Playbook
##

## WORKSTATION
yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

## NODES
for i in node1 node2 node3 ; do
  ssh $i "yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct"
done

## WORKSTATION
yum install atomic-openshift-utils



