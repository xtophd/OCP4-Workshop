#!/bin/bash

##
## NOTE: you must point to the correct inventory and extravars yml
##
##   Take a sample configs from ./sample-configs and 
##   copy it to ./config/
##

myInventory="./config/master-config.init"

if [[ ! -e "${myInventory}" || ! -e "./xtoph-deploy.yml" ]] ; then
    echo "ERROR: Are you in the right directory? Can not find ${myInventory} | xtoph-deploy.yml" ; exit
    exit
fi

##
##
##

case "$1" in

    "deploy"     | \
    "undeploy"   | \
    "redeploy"   | \
    "setup+"     | \
    "setup")

        time  ansible-playbook --ask-vault-pass -i ${myInventory} -f 10 -e xtoph_deploy_cmd=${1} xtoph-deploy.yml
        ;;

    *)
        echo "USAGE: xtoph-deploy.sh [ setup | setup+ | deploy | undeploy | redeploy ]"
        echo ""
        echo "  setup     ... runs only 'setup' plays"
        echo "  setup+    ... runs both 'setup' and 'deploy' plays"
        echo "  deploy    ... runs only 'deploy' plays"
        echo "  undeploy  ... runs only 'undeploy' plays"
        echo "  redeploy  ... runs both 'undeploy' and 'deploy' plays"
        ;;

esac         
