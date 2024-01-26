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

if [[ ! -e "${myInventory}" || ! -e "./ocp4-workshop.yml" ]] ; then

    echo "ERROR: Are you in the right directory? Can not find ${myInventory} | ocp4-workshop.yml" ; exit
    exit
fi

##
##
##

case "$1" in
         
    "ai"          | \
    "assert"      | \
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
    "noop"        | \
    "ntp"         | \
    "haproxy"     | \
    "matchbox"    | \
    "httpd"       | \
    "squid"       | \
    "tests"       | \
    "upi"         | \
    "workshop"    | \
    "user"        | \
    "vnc")

        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e ocp4_workshop_cmd="configure" -e ocp4_workshop_subcmd="$1" ./ocp4-workshop.yml
        ;;

    "all")
        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e ocp4_workshop_cmd="configure"    ./ocp4-workshop.yml 
        ;;

    "setup")
        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e ocp4_workshop_cmd="setup"    ./ocp4-workshop.yml 
        ;;

    "finish")
        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e ocp4_workshop_cmd="finish"    ./ocp4-workshop.yml 
        ;;

    "shutdown")
        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e ocp4_workshop_cmd="shutdown" ./ocp4-workshop.yml 
        ;;

    "usher")
        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e ocp4_workshop_cmd="usher"    ./ocp4-workshop.yml 
        ;;

    *)
        echo "USAGE: ocp4-workshop.sh [ all | ai | assert | basics | cockpit | gui | dns | dhcp | firewall | pxe | uefi | nfs | noop | ntp | haproxy | matchbox | httpd | upi | workshop | user | finish | lock | setup | shutdown | tests | unlock | user | usher | vnc ]"
        ;;

esac         

