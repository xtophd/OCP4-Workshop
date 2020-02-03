#!/bin/bash

##
## NOTE: you must point to the correct inventory
##

myInventory="./configs/libvirt-ocp4.3-custom"

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
    "init")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-setup.yml 
        ;;
         
    "dns")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-dns.yml 
        ;;

    "dhcp")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-dhcp.yml 
        ;;

    "ntp")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-ntp.yml 
        ;;

    "haproxy")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-haproxy.yml 
        ;;

    "matchbox")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-matchbox.yml 
        ;;

    "httpd")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-httpd.yml 
        ;;

    "openshift")
        time ansible-playbook -i ${myInventory} -f 10 ./playbooks/bastion-openshift.yml 
        ;;

    *)
        echo "USAGE: bastion-setup.sh [ init | dns | dhcp | ntp | haproxy | matchbox | httpd | openshift ]"
        ;;

esac         

