#!/bin/bash

## This script is designed to quickly take care of adding
## the needed content streams for the oVirt SDK
##
## It is assumed that ansible was installed the same way
## and the host already has the appropriate entitlements
## attached

subscription-manager repos --enable=rhv-4.3-manager-for-rhel-7-x86_64-rpms \
                           --enable=rhel-7-server-rpms

yum install -y python-ovirt-engine-sdk4
