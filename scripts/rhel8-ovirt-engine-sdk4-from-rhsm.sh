#!/bin/bash

## This script is designed to quickly take care of adding
## the needed content streams for the oVirt SDK
##
## It is assumed that ansible was installed the same way
## and the host already has the appropriate entitlements
## attached

subscription-manager repos --enable=rhv-4.4-manager-for-rhel-8-x86_64-rpms \
                           --enable=rhel-8-for-x86_64-appstream-rpms   \
                           --enable=rhel-8-for-x86_64-baseos-rpms

yum install -y python3-ovirt-engine-sdk4 ansible-ovirt-collection
