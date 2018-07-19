#!/bin/bash

##
## Most of this will get moved into an Ansible Playbook
##

## WORKSTATION:  install minimum tool requirements
yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct

## CLUSTER: install minimum tool requirements
for i in node1 node2 master ; do
  ssh $i "yum install -y wget git net-tools bind-utils yum-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct"
done

## WORKSTATION: install openshift utilities (which includes OCP installer)
yum -y install atomic-openshift-utils

## CLUSTER: install docker (specific version)
for i in node1 node2 master ; do
  ssh $i "yum install -y docker-1.13.1"
done

## CLUSTER: configure docker storage
for i in node1 node2 master ; do

  scp docker-storage-setup $i:/etc/sysconfig
  ssh $i "rm -f /etc/sysconfig/docker-storage; vgremove --force docker-vg ; pvremove --force /dev/vdb ; wipefs -a /dev/vdb"
  ssh $i "docker-storage-setup"
  
done

## CLUSTER: configure docker novolume plugin
for i in node1 node2 master ; do

  scp docker $i:/etc/sysconfig
  ssh $i "yum -y install docker-novolume-plugin"
  ssh $i "systemctl enable docker-novolume-plugin ; systemctl start docker-novolume-plugin"
  
done


## WORKSTATION: run the prereq checks
cp -f hosts /etc/ansible/hosts
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml

## WORKSTATION: run the installer
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml

