#!/bin/bash

##
## NOTE: you must point to the correct inventory
##
##   Take a sample config from ./configs and
##   copy it to ./playbooks/vars-custom/master-config.yml
##

myInventory="./config/master-config.yml"
##myExtravars="./config/libvirt-config.yml"

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

##
##
##

case "$1" in
    "all")
        echo "ansible-playbook -i ${myInventory} -f 10  ./playbooks/bastion-setup.yml"
        time  ansible-playbook -i ${myInventory} -f 10  ./playbooks/bastion-setup.yml
        ;;
         
    "basics"      | \
    "cockpit"     | \
    "dns"         | \
    "dhcp"        | \
    "pxe"         | \
    "uefi"        | \
    "lock"        | \
    "unlock"      | \
    "nfs"         | \
    "ntp"         | \
    "haproxy"     | \
    "haproxy_vip" | \
    "matchbox"    | \
    "httpd"       | \
    "squid"       | \
    "openshift"   | \
    "workshop"    | \
    "refresh"     | \
    "finish")

        echo "ansible-playbook -i ${myInventory} -f 10 --tags $1 ./playbooks/bastion-setup.yml"
        time  ansible-playbook -i ${myInventory} -f 10 --tags $1 ./playbooks/bastion-setup.yml
        ;;

    "usher")
        echo "ansible-playbook -i ${myInventory} -f 10  ./playbooks/deployment-usher.yml"
        time  ansible-playbook -i ${myInventory} -f 10  ./playbooks/deployment-usher.yml
        ;;

    *)
        echo "USAGE: bastion-setup.sh [ all | basics | cockpit | dns | dhcp | pxe | uefi | ntp | haproxy | haproxy_vip | matchbox | httpd | openshift | finish | usher ]"
        ;;

esac         

