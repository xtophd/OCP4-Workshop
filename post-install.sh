#!/bin/bash

## MASTER: install config to enable htpasswd oauth
scp master-config.yaml master:/etc/origin/master

## MASTER: install the httpd-utils so we can manage accounts for OCP
ssh master "yum install -y httpd-utils ; touch /etc/origin/openshift-passwd"

