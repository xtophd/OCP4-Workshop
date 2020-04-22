#!/bin/bash

##
## NOTE: you must point to the correct inventory
##
##   Take a sample config from ./configs and 
##   copy it to ./playbooks/vars-custom/master-config.yml
##

myInventory="./config/master-config.yml"

## This script is intended to be run:
##     on the libvirt hypervisor node
##     in the project directory
##     EX: CWD == ~root/OCP4-Workshop

if [ ! -e "${myInventory}" ] ; then
    echo "ERROR: Are you in the right directory? Can not find ${myInventory}" ; exit
    exit
fi

if [ ! -e "./playbooks" ] ; then
    echo "ERROR: Are you in the right directory? Can not find ./playbooks" ; exit
    exit
fi

case "$1" in
    "all")

        echo "ansible-playbook -i ${myInventory} -f 10  ./playbooks/libvirt-setup.yml"
        time  ansible-playbook -i ${myInventory} -f 10  ./playbooks/libvirt-setup.yml
        ;;

    "basics"        | \
    "cockpit"       | \
    "network"       | \
    "dns"           | \
    "bastion"       | \
    "secret"        | \
    "repo"          | \
    "bastion-setup" | \
    "bootstrap"     | \
    "masters"       | \
    "workers"       | \
    "deploy")


        echo "ansible-playbook -i ${myInventory} -f 10 --tags $1 ./playbooks/libvirt-setup.yml"
        time  ansible-playbook -i ${myInventory} -f 10 --tags $1 ./playbooks/libvirt-setup.yml
        ;;

    *)
        echo "USAGE: libvirt-setup.sh [ all | basics | cockpit | network | dns | bastion | secret | repo | bastion-setup | bootstrap | masters | worksers | deploy]"
        ;;

esac

