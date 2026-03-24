#!/bin/bash

##
##    One variable we have to declare before doing anything else
##

export NODE_COUNT=10

##
##    Now we can source the shell libs and set everything up
##

RELOADER="$0"
echo "${RELOADER}"
echo "--------------------"

source ./xtoph-setup/xtoph-setup.shlib
source ./xtoph-setup/virthost-menu.shlib
source ./xtoph-setup/network-menu.shlib
source ./xtoph-setup/ansible-menu.shlib
source ./xtoph-setup/node-menu.shlib
source ./xtoph-setup/bastion-menu.shlib
source ./xtoph-setup/ldap-menu.shlib

# --

##
##    Variables unique to this Project
##

export PROJECT_NAME=""

export CLUSTER_WILDCARD="apps"
export CLUSTER_PROVISIONER="ai-vmedia"
export CLUSTER_LOADBALANCER_IP=""
export CLUSTER_NAME=""
export CLUSTER_API_IP=""
export CLUSTER_VERSION="4.20"
export CLUSTER_STRAPLESS="False"
export CLUSTER_CIDR="10.128.0.0/14"
export CLUSTER_CIDR_HOSTPREFIX="23"
export CLUSTER_TOPOLOGY="3x2"

export WORKSHOP_ADMIN_UID="cloud-admin"
export WORKSHOP_ADMIN_PW

export WORKSHOP_STUDENT_UID="cloud-user"
export WORKSHOP_STUDENT_PW

##
##    ESTABLISH SOME ADDITIONAL DEFAULTS
##

NAME_NODE1="bastion"
NAME_NODE2="bootstrap"
NAME_NODE3="master1"
NAME_NODE4="master2"
NAME_NODE5="master3"
NAME_NODE6="worker1"
NAME_NODE7="worker2"
NAME_NODE8="sno"
NAME_NODE9="arbiter"

NICMODE_NODE1="static"
NICMODE_NODE2="dhcp"
NICMODE_NODE3="dhcp"
NICMODE_NODE4="dhcp"
NICMODE_NODE5="dhcp"
NICMODE_NODE6="dhcp"
NICMODE_NODE7="dhcp"
NICMODE_NODE8="dhcp"
NICMODE_NODE9="dhcp"

HGROUP_NODE1="myBastion"
HGROUP_NODE2="myBootstrap"
HGROUP_NODE3="myMasters"
HGROUP_NODE4="myMasters"
HGROUP_NODE5="myMasters"
HGROUP_NODE6="myWorkers"
HGROUP_NODE7="myWorkers"
HGROUP_NODE8="mySNO"
HGROUP_NODE9="myArbiter"

##
##    Load current answer file
##

[[ -e ./config/ocp4-workshop-setup.ans ]] && . ./config/ocp4-workshop-setup.ans


# ---

cluster_dump () {

##
##    NOTE: don't save passwords 
##          user will always need 
##          to enter ALL of them
##

cat <<EOVARS

## CLUSTER SETTINGS

    PROJECT_NAME="${PROJECT_NAME}"
    CLUSTER_NAME="${CLUSTER_NAME}"
    CLUSTER_WILDCARD="${CLUSTER_WILDCARD}"
    CLUSTER_PROVISIONER="${CLUSTER_PROVISIONER}"
    CLUSTER_TOPOLOGY="${CLUSTER_TOPOLOGY}"
    CLUSTER_LOADBALANCER_IP="${CLUSTER_LOADBALANCER_IP}"
    CLUSTER_API_IP="${CLUSTER_API_IP}"
    CLUSTER_VERSION="${CLUSTER_VERSION}"
    CLUSTER_STRAPLESS="${CLUSTER_STRAPLESS}"
    CLUSTER_CIDR="${CLUSTER_CIDR}"
    CLUSTER_CIDR_HOSTPREFIX="${CLUSTER_CIDR_HOSTPREFIX}"

    WORKSHOP_ADMIN_UID="${WORKSHOP_ADMIN_UID}"
    WORKSHOP_STUDENT_UID="${WORKSHOP_STUDENT_UID}"

    ##WORKSHOP_ADMIN_PW=""
    ##WORKSHOP_STUDENT_PW=""

EOVARS

}


# ---

save_settings () {

    ##
    ##    NOTE: don't save passwords 
    ##          user will always need 
    ##          to enter ALL of them
    ##

    ##
    ##    NOTE:  Network broadcast and netmask
    ##           are calculated from the prefix
    ##           and also not saved
    ##

    if [[ ! -z ${NETWORK_PREFIX} && ! -z ${NETWORK_ID} ]]; then
        NETWORK_BROADCAST=`ipcalc ${NETWORK_ID}/${NETWORK_PREFIX} -b | cut -d= -f2` 
        NETWORK_NETMASK=`ipcalc ${NETWORK_ID}/${NETWORK_PREFIX} -m | cut -d= -f2` 
    fi

    cluster_dump  > ./config/ocp4-workshop-setup.ans
    ansible_dump  >> ./config/ocp4-workshop-setup.ans
    virthost_dump >> ./config/ocp4-workshop-setup.ans
    bastion_dump  >> ./config/ocp4-workshop-setup.ans
    network_dump  >> ./config/ocp4-workshop-setup.ans
    node_dump     >> ./config/ocp4-workshop-setup.ans
    ldap_dump     >> ./config/ocp4-workshop-setup.ans

}


# ---

cluster_settings () {

    ##
    ##    Network broadcast and netmask
    ##    are calculated from the prefix
    ##    and also not saved
    ##

    if [[ ! -z ${NETWORK_PREFIX} && ! -z ${NETWORK_ID} ]]; then
        NETWORK_BROADCAST=`ipcalc ${NETWORK_ID}/${NETWORK_PREFIX} -b | cut -d= -f2` 
        NETWORK_NETMASK=`ipcalc ${NETWORK_ID}/${NETWORK_PREFIX} -m | cut -d= -f2` 
    fi

    ##
    ##    Bash Lesson:  the bash shell parameter expansion ':+' passes
    ##                  expansion if paramenter is set and not null
    ##                  we use this to mask passwords for example
    ##

    echo ""
    echo "Project Name ... ${PROJECT_NAME}"
    echo ""

    echo "[ OCP CLUSTER ]"
    echo "    Name (ver)       ... ${CLUSTER_NAME} (${CLUSTER_VERSION})"
    echo "    Topology         ... ${CLUSTER_TOPOLOGY}"
    echo "    Provisioner      ... ${CLUSTER_PROVISIONER} (strapless = ${CLUSTER_STRAPLESS})"
    echo "    Wildcard         ... ${CLUSTER_WILDCARD}"
    echo "    Loadbalancer IP  ... ${CLUSTER_LOADBALANCER_IP}"
    echo "    API IP           ... ${CLUSTER_API_IP}"
    echo "    clusterNetwork"
    echo "      cidr           ... ${CLUSTER_CIDR}"
    echo "      hostPrefix     ... ${CLUSTER_CIDR_HOSTPREFIX}"
    echo "    Workshop Admin   ... ${WORKSHOP_ADMIN_UID} / ${WORKSHOP_ADMIN_PW:+**********}" 
    echo "    Workshop Student ... ${WORKSHOP_STUDENT_UID} / ${WORKSHOP_STUDENT_PW:+**********}" 
    echo "    BMC Defaults     ... ${BMC_UID_DEFAULT} / ${BMC_PW_DEFAULT:+**********}" 
}


# ---


current_settings () {
    cluster_settings
    ansible_settings
    network_settings
    ldap_settings
    bastion_settings
    virthost_settings
    node_settings
}


# ---


cluster_bulk_edit () {

    TMPFILE="$(mktemp /var/tmp/ocp-workshop-setup.XXXXX)"

    cluster_dump > $TMPFILE

    vi $TMPFILE

    read -p "Accept BULK EDIT update (Y/N)? " input

    if [[ "${input^^}" == "Y" ]]; then
      source $TMPFILE
      echo "Changes sourced..."
    fi

    rm $TMPFILE

}


# ---


prepare_deployment () {

    echo ""

    echo "## Install Ansible from ${ANSIBLE_SOURCE}"

    case ${ANSIBLE_SOURCE} in 

      "RHSM") 
        ./sample-scripts/rhel9-install-ansible-rhsm.sh 
        ;;

      "EPEL") 
        ./sample-scripts/rhel9-install-ansible-epel.sh 
        ;;
    
      "INSTALLED") 
        echo " - success (ansible already installed)"
        ;;

      "*" )
        echo "WARNING: you must set a valid ansible source"
        return 1
        ;;
    esac

    ##
    ##    Reprint the current settings & re-calculate any vars
    ##      (ipcalc may have just gotten installed)
    ##

    echo -n "## Here are the current settings"

    current_settings



    echo -n "## Templating configuration files"

    ansible-playbook sample-configs/ocp4-workshop-setup.yml




    echo -n "## Encrypt the credentials.yml"

    if [[ -z "${ANSIBLE_VAULT_PW}" ]]; then
      echo " - FAILED" 
      echo "WARNING: you must set the ANSIBLE_VAULT_PW"
      return 1
    else
      echo "${ANSIBLE_VAULT_PW}" > ./config/vault-pw.tmp
      ansible-vault encrypt --vault-password-file ./config/vault-pw.tmp config/credentials.yml 1>/dev/null 2>&1

      if [[ $? ]] ; then
        rm -f ./config/vault-pw.tmp
        echo " - success" 
      else
        rm -f ./config/vault-pw.tmp
        echo " - FAILED" 
        return 1
      fi
    fi

}

# ---

cluster_menu () {

    SAVED_PROMPT="$PS3"

    PS3="CLUSTER MENU: "

    echo ""
    cluster_settings
    echo ""

    select action in "RETURN to previous menu" "BULK EDIT params" "Set Name" "Set Version" "Set Topology" "Set Wildcard" "Set LB IP" "Set API IP" "Set CIDR" "Set CIDR Host Prefix" "Set Provisioner" "Toggle Strapless" "Set Workshop Admin UID/PW" "Set Workshop Student UID/PW" "Set Default BMC Password"
    do
      case ${action}  in

        "BULK EDIT params")
          cluster_bulk_edit
          ;;

        "Set Name")
           set_key "Cluster Name"  CLUSTER_NAME
           ;;

        "Set Version")
           echo ""
           SAVED_PROMPT="$PS3"
           PS3="Set Version [${CLUSTER_VERSION}]:"

           select choice in "4.21" "4.20" "4.19" "4.18" "4.17" "4.16" "4.15" "4.14" "4.13" "4.12" "4.11" "4.10" "4.9" "4.8" "4.7" "4.6" "4.5" "4.4" "4.3" "4.2" "CANCEL"
           do
              case "$choice" in
                "4.21" | \
                "4.20" | \
                "4.19" | \
                "4.18" | \
                "4.17" | \
                "4.16" | \
                "4.15" | \
                "4.14" | \
                "4.13" | \
                "4.12" | \
                "4.11" | \
                "4.10" | \
                "4.9"  | \
                "4.8"  | \
                "4.7"  | \
                "4.6"  | \
                "4.5"  | \
                "4.4"  | \
                "4.3"  | \
                "4.2"  ) 
                  CLUSTER_VERSION="$choice"
                  break ;;
                "*" )
                  ;;
              esac
            done
          PS3=${SAVED_PROMPT}
          REPLY=
          ;;

        "Set Topology")
           echo ""
           SAVED_PROMPT="$PS3"
           PS3="Set Topology [${CLUSTER_TOPOLOGY}]:"

           select choice in "3x2" "3x0" "sno" "tna" "CANCEL"
           do
              case "$choice" in
                "3x2" | \
                "3x0" | \
                "sno" | \
                "tna" )
                  CLUSTER_TOPOLOGY="$choice"
                  break ;;
                "CANCEL" )
                  break ;;
                "*" )
                  break ;;
              esac
            done
          PS3=${SAVED_PROMPT}
          REPLY=
          ;;

        "Set Provisioner")
           echo ""
           SAVED_PROMPT="$PS3"
           PS3="Set Provisioner [${CLUSTER_PROVISIONER}]:"

           select choice in "upi-pxe" "upi-vmedia" "ai-http" "ai-vmedia" "CANCEL"
           do
              case "$choice" in
                "upi-pxe"    | \
                "upi-vmedia" | \
                "ai-http"    | \
                "ai-vmedia"  )
                  CLUSTER_PROVISIONER="$choice"
                  break ;;
                "CANCEL" )
                  break ;;
                "*" )
                  break ;;
              esac
            done
          PS3=${SAVED_PROMPT}
          REPLY=
          ;;

        "Toggle Strapless")
           toggle_key CLUSTER_STRAPLESS 
           ;;

        "Set Wildcard")
           set_key "Wildcard SubDomain" CLUSTER_WILDCARD
           ;;

        "Set LB IP")
          set_key "Loadbalancer IP" CLUSTER_LOADBALANCER_IP
          ;;

        "Set API IP")
          set_key "API IP" CLUSTER_API_IP
          ;;

        "Set CIDR")
          set_key "clusterNetwork cidr" CLUSTER_CIDR
          ;;

        "Set CIDR Host Prefix")
          set_key "clusterNetwork cidr hostPrefix" CLUSTER_CIDR_HOSTPREFIX
          ;;

        "Set Workshop Admin UID/PW")
          set_uidpw "Workshop Admin" WORKSHOP_ADMIN_UID WORKSHOP_ADMIN_PW
          ;;

        "Set Workshop Student UID/PW")
          set_uidpw "Workshop Student" WORKSHOP_STUDENT_UID WORKSHOP_STUDENT_PW
          ;;

        "Set Default BMC Password")
          set_uidpw "Default BMC" BMC_UID_DEFAULT BMC_PW_DEFAULT
          ;;

        "RETURN to previous menu")
          PS3=${SAVED_PROMPT}
          break
          ;;

        "*")
          echo "That's NOT an option, try again..."
          ;;

      esac

      ##
      ##    Reprint the current settings
      ##

      echo ""
      cluster_settings
      echo ""

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}

# ---

main_menu () {

    PS3="MAIN MENU (select action): "

    echo ""
    current_settings
    echo ""

    select action in "PREPARE Deployment" \
                     "Set Project Name" \
                     "Cluster Settings" \
                     "Ansible Settings" \
                     "Network Settings" \
                     "LDAP Settings" \
                     "Bastion Settings" \
                     "Virt Host Settings" \
                     "Node Settings" \
                     "SAVE Current Params" \
                     "RELOAD Saved Params"

    do
      case ${action}  in

        "Set Project Name")
          read -p "Enter Prooject Name [${PROJECT_NAME}]: " input
          PROJECT_NAME=${input:-$PROJECT_NAME}
          ;;
        "Ansible Settings")
          ansible_menu
          ;;
        "LDAP Settings")
          ldap_menu
          ;;
        "Bastion Settings")
          bastion_menu
          ;;
        "Cluster Settings")
          cluster_menu
          ;;
        "Network Settings")
          network_menu
          ;;
        "Virt Host Settings")
          virthost_menu
          ;;
        "Node Settings")
          node_menu
          ;;
        "PREPARE Deployment")
          save_settings
          prepare_deployment
          ;;
        "SAVE Current Params")
          save_settings
          ;;
        "RELOAD Saved Params")
          exec "${RELOADER}"
          break
          ;;
        "*")
          echo "That's NOT an option, try again..."
          ;;       
 
      esac

      ##
      ##    Reprint the current settings
      ##

      echo ""
      current_settings
      echo ""

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}


##
##    Testing for 'ansible-playbook' command
##

[[ -x `which ansible-playbook` ]] && ANSIBLE_SOURCE="INSTALLED"


##
##    Engage the main_menu
##

main_menu



