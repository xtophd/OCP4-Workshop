#!/bin/bash

## MASTER: install config to enable htpasswd oauth
scp master-config.yaml master:/etc/origin/master
