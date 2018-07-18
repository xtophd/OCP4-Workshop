#!/bin/bash

##
## Most of this will get moved into an Ansible Playbook
##

## WORKSTATION
yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

## CLUSTER
for i in node1 node2 node3 ; do
  ssh $i "yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct"
done

## WORKSTATION
yum -y install atomic-openshift-utils

## CLUSTER
for i in node1 node2 node3 ; do
  ssh $i "yum install -y docker-1.13.1"
done

## CLUSTER
for i in node1 node2 node3 ; do

  ## Setup up docker storage
  scp docker-storage-setup $i:/etc/sysconfig
  ssh $i "rm -f /etc/sysconfig/docker-storage; vgremove --force docker-vg ; pvremove --force /dev/vdb ; wipefs -a /dev/vdb"
  ssh $i "docker-storage-setup"

  ## Setup up docker-novolume-plugin
  scp docker $i:/etc/sysconfig
  ssh $i "yum -y install docker-novolume-plugin ; systemctl enable docker-novolume-plugin ; systemctl start docker-novolume-plugin"
  
done

