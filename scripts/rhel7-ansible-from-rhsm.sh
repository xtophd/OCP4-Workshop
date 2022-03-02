#!/bin/bash

## This script is designed to quickly take care of registering
## this client to rhsm for OS packages and updates and installing ansible

subscription-manager register

subscription-manager attach

subscription-manager repos --disable=*

subscription-manager repos --enable=rhel-7-server-ansible-2.9-rpms \
                           --enable=rhel-7-server-rpms 

yum install -y ansible
