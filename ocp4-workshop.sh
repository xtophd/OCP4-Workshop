#!/bin/bash

##
## NOTE: you must point to the correct inventory
##
##   Take a sample config from ./sample-configs/[platform]/* and
##   copy it (or them) to ./config.
##

myInventory="./config/master-config.yml"

##    
##    NOTE: This script is intended to be run
##          on the deployhost (xtoph_deploy)
##          or on the host that will be the 
##          cluster bastion
##
##    NOTE: You MUST be in the project directory
##          to run this
##

if [ ! -e "${myInventory}" ] ; then
    echo "ERROR: Are you in the right directory? Can not find ${myInventory}" ; exit
    exit
fi

if [ ! -e "./playbooks" ] ; then
    echo "ERROR: Are you in the right directory? Can not find ./playbooks" ; exit
    exit
fi

##
##
##

case "$1" in
    "all")
        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10  ./playbooks/ocp4-workshop.yml
        ;;
         
    "basics"      | \
    "cockpit"     | \
    "dns"         | \
    "dhcp"        | \
    "firewall"    | \
    "gui"         | \
    "pxe"         | \
    "iso"         | \
    "lock"        | \
    "unlock"      | \
    "nfs"         | \
    "ntp"         | \
    "haproxy"     | \
    "matchbox"    | \
    "httpd"       | \
    "squid"       | \
    "openshift"   | \
    "workshop"    | \
    "user"        | \
    "vnc")

        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 --tags $1 ./playbooks/ocp4-workshop.yml
        ;;

    "finish")
        time  ansible-playbook -i ${myInventory} -f 10  ./playbooks/bastion-openshift-finish.yml
        ;;

    "shutdown")
        time  ansible-playbook -i ${myInventory} -f 10  ./playbooks/bastion-openshift-shutdown.yml
        ;;

    "usher")
        time  ansible-playbook -i ${myInventory} -f 10  ./playbooks/deployment-usher.yml
        ;;

    *)
        echo "USAGE: bastion-setup.sh [ all | basics | cockpit | gui | dns | dhcp | firewall | pxe | uefi | ntp | haproxy | matchbox | httpd | openshift | workshop | user | finish | lock | shutdown | unlock | user | usher | vnc ]"
        ;;

esac         

