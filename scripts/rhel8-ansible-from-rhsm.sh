#!/bin/bash

## This script is designed to quickly take care of registering
## this client to rhsm for OS packages and updates and installing ansible

subscription-manager register

subscription-manager attach

subscription-manager repos --disable=*

subscription-manager repos --enable=ansible-2.9-for-rhel-8-x86_64-rpms \
                           --enable=rhel-8-for-x86_64-appstream-rpms   \
                           --enable=rhel-8-for-x86_64-baseos-rpms

yum install -y ansible ipcalc
