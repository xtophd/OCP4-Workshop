#!/bin/bash

export ANSIBLE_SOURCE=""
export ANSIBLE_IP=""
export ANSIBLE_VAULT_PW=""
export CLUSTER_NAME=""
export CLUSTER_WILDCARD=""
export CLUSTER_PROVISIONER=""
export CLUSTER_LOADBALANCER_IP=""
export CLUSTER_API_IP=""
export NETWORK_ID=""
export NETWORK_PREFIX=""
export NETWORK_BROADCAST=""
export NETWORK_NETMASK=""
export NETWORK_GATEWAY=""
export NETWORK_BASEDOMAIN=""
export NETWORK_DNS_SERVER=""
export NETWORK_TIME_SERVER=""
export LIBVIRT_HOST_IP=""
export LIBVIRT_HOST_PW=""
export LIBVIRT_HOST_FQDN=""
export LIBVIRT_HOST_BRDEV=""
export ADDR_BASTION=""
export ADDR_BOOTSTRAP=""
export ADDR_MASTER1=""
export ADDR_MASTER2=""
export ADDR_MASTER3=""
export ADDR_WORKER1=""
export ADDR_WORKER2=""

##
##    Load current answer file
##

[[ -e ./config/ocp4-workshop-setup.ans ]] && . ./config/ocp4-workshop-setup.ans


# ---

save_settings () {

##
##    NOTE: don't save passwords 
##          user will always need 
##          to enter ALL of them
##
##          Network broadcast and netmask
##          are calculated from the prefix 
##          and also not saved
##

cat > ./config/ocp4-workshop-setup.ans <<EO_ANSWERS
ANSIBLE_SOURCE="${ANSIBLE_SOURCE}"
ANSIBLE_IP="${ANSIBLE_IP}"
CLUSTER_NAME="${CLUSTER_NAME}"
CLUSTER_WILDCARD="${CLUSTER_WILDCARD}"
CLUSTER_PROVISIONER="${CLUSTER_PROVISIONER}"
CLUSTER_LOADBALANCER_IP="${CLUSTER_LOADBALANCER_IP}"
CLUSTER_API_IP="${CLUSTER_API_IP}"
NETWORK_ID="${NETWORK_ID}"
NETWORK_GATEWAY="${NETWORK_GATEWAY}"
NETWORK_PREFIX="${NETWORK_PREFIX}"
NETWORK_BROADCAST="${NETWORK_BROADCAST}"
NETWORK_NETMASK="${NETWORK_NETMASK}"
NETWORK_BASEDOMAIN="${NETWORK_BASEDOMAIN}"
NETWORK_DNS_SERVER="${NETWORK_DNS_SERVER}"
NETWORK_TIME_SERVER="${NETWORK_TIME_SERVER}" 
LIBVIRT_HOST_IP="${LIBVIRT_HOST_IP}"
LIBVIRT_HOST_FQDN="${LIBVIRT_HOST_FQDN}"
LIBVIRT_HOST_BRDEV="${LIBVIRT_HOST_BRDEV}"
ADDR_BASTION="${ADDR_BASTION}"
ADDR_BOOTSTRAP="${ADDR_BOOTSTRAP}"
ADDR_MASTER1="${ADDR_MASTER1}"
ADDR_MASTER2="${ADDR_MASTER2}"
ADDR_MASTER3="${ADDR_MASTER3}"
ADDR_WORKER1="${ADDR_WORKER1}"
ADDR_WORKER2="${ADDR_WORKER2}"
EO_ANSWERS

}


# ---

current_settings () {

    if [[ ! -z ${NETWORK_PREFIX} && ! -z ${NETWORK_ID} ]]; then
        NETWORK_BROADCAST=`ipcalc ${NETWORK_ID}/${NETWORK_PREFIX} -b | cut -d= -f2` 
        NETWORK_NETMASK=`ipcalc ${NETWORK_ID}/${NETWORK_PREFIX} -m | cut -d= -f2` 
    fi

    ##
    ##    Bash Lesson:  the bash shell parameter expansion ':+' passes
    ##                  expansion if paramenter is set and not null
    ##

    echo ""
    echo "Current Settings"
    echo "----------------"
    echo "Ansible Source          ... ${ANSIBLE_SOURCE}"
    echo "Ansible Vault Password  ... ${ANSIBLE_VAULT_PW:+"**********"}" 
    echo "Ansible Control Host IP ... ${ANSIBLE_IP}"
    echo "Cluster Name            ... ${CLUSTER_NAME}"
    echo "Cluster Wildcard        ... ${CLUSTER_WILDCARD}"
    echo "Cluster Provisioner     ... ${CLUSTER_PROVISIONER}"
    echo "Cluster Loadbalancer IP ... ${CLUSTER_LOADBALANCER_IP}"
    echo "Cluster API IP          ... ${CLUSTER_API_IP}"
    echo "Network ID              ... ${NETWORK_ID}"
    echo "Network Prefix          ... ${NETWORK_PREFIX}] / ${NETWORK_NETMASK} / ${NETWORK_BROADCAST}"
    echo "Network Gateway         ... ${NETWORK_GATEWAY}"
    echo "Network Base Domain     ... ${NETWORK_BASEDOMAIN}"
    echo "Network DNS Server      ... ${NETWORK_DNS_SERVER}"
    echo "Network TIME Server     ... ${NETWORK_TIME_SERVER}" 
    echo "IP Address Bastion      ... ${ADDR_BASTION}"
    echo "IP Address Bootstrap    ... ${ADDR_BOOTSTRAP}"
    echo "IP Address(es) Master   ... ${ADDR_MASTER1} / ${ADDR_MASTER2} / ${ADDR_MASTER3}"
    echo "IP Address(es) Worker   ... ${ADDR_WORKER1} / ${ADDR_WORKER2}"
    echo "Libvirt Host IP         ... ${LIBVIRT_HOST_IP}" 
    echo "Libvirt Host Password   ... ${LIBVIRT_HOST_PW:+"**********"}" 
    echo "Libvirt Host FQDN       ... ${LIBVIRT_HOST_FQDN}" 
    echo "Libvirt Bridge Device   ... ${LIBVIRT_HOST_BRDEV}" 
    echo ""
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


#    echo -n "## Adjust DNS Configuration"
#
#    if [[ -z "${NETWORK_DNS_SERVER}" ]]; then
#      echo " - FAILED" 
#      echo "WARNING: you must set the DNS SERVER"
#      return 1
#    else
#      sed -i -e "s/^\(.*network_nameserver:\).*\$/\1 \"${NETWORK_DNS_SERVER}\"/" ./config/master-config.yml
#      if [[ $? ]] ; then
#        echo " - success" 
#      else
#        echo " - FAILED" 
#        return 1
#      fi
#    fi
#
#
#    echo -n "## Adjust TIME Configuration"
#
#    if [[ -z "${NETWORK_TIME_SERVER}" ]]; then
#      echo " - FAILED" 
#      echo "WARNING: you must set the TIME SERVER"
#      return 1
#    else
#      sed -i -e "s/^\(.*network_timeserver:\).*\$/\1 \"${NETWORK_TIME_SERVER}\"/" ./config/master-config.yml
#      if [[ $? ]] ; then
#        echo " - success" 
#      else
#        echo " - FAILED" 
#        return 1
#      fi
#    fi


    echo -n "## Parsing sample-configs"

#    cp ./sample-configs/libvirt-bridge/*.yml ./config

#    for i in ./sample-configs/libvirt-bridge/*.yml ; do
#        envsubst < $i > ./config/`basename $i`
#
#        if [[ $? ]] ; then
#          echo " $i - success" 
#        else
#          echo " $i - FAILED" 
#          return 1
#        fi
#    done

    echo -n "## Templating configuration files"
    ansible-playbook sample-configs/libvirt-bridge/_setup.yml

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

ipaddress_menu () {

    PS3="Select Node to Assign IP: "

    current_settings

    select action in "Bastion" "Bootstrap" "Master1" "Master2" "Master3" "Worker1" "Worker2" "Back to Main Menu"
    do
      case ${action}  in
        "Bastion")
          read -p "Enter Bastion IP [${ADDR_BASTION}]: " input
          ADDR_BASTION=${input:-$ADDR_BASTION}
          ;;

        "Bootstrap")
          read -p "Enter Bootstrap IP [${ADDR_BOOTSTRAP}]: " input
          ADDR_BOOTSTRAP=${input:-$ADDR_BOOTSTRAP}
          ;;

        "Master1")
          read -p "Enter Master1 IP [${ADDR_MASTER1}]: " input
          ADDR_MASTER1=${input:-$ADDR_MASTER1}
          ;;

        "Master2")
          read -p "Enter Master2 IP [${ADDR_MASTER2}]: " input
          ADDR_MASTER2=${input:-$ADDR_MASTER2}
          ;;

        "Master3")
          read -p "Enter Master3 IP [${ADDR_MASTER3}]: " input
          ADDR_MASTER3=${input:-$ADDR_MASTER3}
          ;;

        "Worker1")
          read -p "Enter Worker1 IP [${ADDR_WORKER1}]: " input
          ADDR_WORKER1=${input:-$ADDR_WORKER1}
          ;;

        "Worker2")
          read -p "Enter Worker2 IP [${ADDR_WORKER2}]: " input
          ADDR_WORKER2=${input:-$ADDR_WORKER2}
          ;;

        "Back to Main Menu")
          break
          ;;

        "*")
          echo "That's NOT an option, try again..."
          ;;

      esac

      ##
      ##    Reprint the current settings
      ##

      current_settings

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}




# ---

libvirt_menu () {

    PS3="Select Action: "

    current_settings

    select action in "Set Host IP" "Set Host Password" "Set Host FQDN" "Set Bridge Device" "Back to Main Menu"
    do
      case ${action}  in
        "Set Host IP")
          read -p "Enter libvirt host IP [${LIBVIRT_HOST_IP}]: " input
          LIBVIRT_HOST_IP=${input:-$LIBVIRT_HOST_IP}
          ;;

        "Set Host Password")
          echo "Enter new password and press Enter"
          read -s -p "Enter libvirt host password [${LIBVIRT_HOST_PW:+"**********"}]: " input
          echo ""
          read -s -p "Enter libvirt host password again [${LIBVIRT_HOST_PW:+"**********"}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            LIBVIRT_HOST_PW=${input:-$LIBVIRT_HOST_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set Host FQDN")
          read -p "Enter libvirt host FQDN [${LIBVIRT_HOST_FQDN}]: " input
          LIBVIRT_HOST_FQDN=${input:-$LIBVIRT_HOST_FQDN}
          ;;

        "Set Bridge Device")
          read -p "Enter libvirt host bridge device[${LIBVIRT_HOST_BRDEV}]: " input
          LIBVIRT_HOST_BRDEV=${input:-$LIBVIRT_HOST_BRDEV}
          ;;

        "Back to Main Menu")
          break
          ;;

        "*")
          echo "That's NOT an option, try again..."
          ;;

      esac

      ##
      ##    Reprint the current settings
      ##

      current_settings

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}


# ---

network_menu () {

    PS3="Select Action: "

    current_settings

    select action in "Set ID" "Set Prefix" "Set Gateway" "Set Base Domain" "Set DNS Server" "Set TIME Server" "Back to Main Menu"
    do
      case ${action}  in
        "Set ID")
          read -p "Enter network id [${NETWORK_ID}]: " input
          NETWORK_ID=${input:-$NETWORK_ID}
          ;;

        "Set Prefix")
          read -p "Enter prefix [${NETWORK_PREFIX}]: " input
          NETWORK_PREFIX=${input:-$NETWORK_PREFIX}
          ;;

        "Set Gateway")
          read -p "Enter gateway[${NETWORK_GATEWAY}]: " input
          NETWORK_GATEWAY=${input:-$NETWORK_GATEWAY}
          ;;

        "Set Base Domain")
          read -p "Enter base domain [${NETWORK_BASEDOMAIN}]: " input
          NETWORK_BASEDOMAIN=${input:-$NETWORK_BASEDOMAIN}
          ;;

        "Set DNS Server")
          read -p "Enter dns server ipv4 address [${NETWORK_DNS_SERVER}]: " input
          NETWORK_DNS_SERVER=${input:-$NETWORK_DNS_SERVER}
          ;;

        "Set TIME Server")
          read -p "Enter time server ipv4 address [${NETWORK_TIME_SERVER}]: " input
          NETWORK_TIME_SERVER=${input:-$NETWORK_TIME_SERVER}
          ;;

        "Back to Main Menu")
          break
          ;;

        "*")
          echo "That's NOT an option, try again..."
          ;;

      esac

      ##
      ##    Reprint the current settings
      ##

      current_settings

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}


# ---

cluster_menu () {

    PS3="Select Action: "

    current_settings

    select action in "Set Name" "Set Wildcard" "Set Provisioner" "Set Loadbalancer IP" "Set API IP" "Back to Main Menu"
    do
      case ${action}  in
        "Set Name")
           read -p "Enter Cluster Name [${CLUSTER_NAME}]: " input
           CLUSTER_NAME=${input:-$CLUSTER_NAME}
           ;;

        "Set Provisioner")
           select CLUSTER_PROVISIONER in "upi" "ai"
           do
              case ${CLUSTER_PROVISIONER} in
                "upi" )
                  break ;;
                "ai" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set Wildcard")
           read -p "Enter Cluster Wildcard [${CLUSTER_WILDCARD}]: " input
           CLUSTER_WILDCARD=${input:-$CLUSTER_WILDCARD}
           ;;

        "Set Loadbalancer IP")
          read -p "Enter Cluster Loadbalancer  IP [${CLUSTER_LOADBALANCER_IP}]: " input
          CLUSTER_LOADBALANCER_IP=${input:-$CLUSTER_LOADBALANCER_IP}
          ;;

        "Set API IP")
          read -p "Enter Clsuter API IP [${CLUSTER_API_IP}]: " input
          CLUSTER_API_IP=${input:-$CLUSTER_API_IP}
          ;;

        "Back to Main Menu")
          break
          ;;

        "*")
          echo "That's NOT an option, try again..."
          ;;

      esac

      ##
      ##    Reprint the current settings
      ##

      current_settings

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}


# ---

main_menu () {

    PS3="Select Action: "

    current_settings

    select action in "Set Ansible Source" "Set Vault Password" "Set Control Host IP" "Cluster Settings" "Network Settings" "Node IP Settings" "Libvirt Settings" "Prepare Deployment" "Save & Quit" "Quit"
    do
      case ${action}  in
        "Set Ansible Source")
          if [[ "${ANSIBLE_SOURCE}" == "INSTALLED" ]]; then
            echo ""
            echo "NOTE: Ansible is already installed"
          else
            select ANSIBLE_SOURCE in "EPEL" "RHSM"
            do
              case ${ANSIBLE_SOURCE} in
                "EPEL" )
                  break ;;
                "RHSM" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          fi
          ;;

        "Set Control Host IP")
          read -p "Enter network id [${ANSIBLE_IP}]: " input
          ANSIBLE_IP=${input:-$ANSIBLE_IP}
          ;;

        "Set Vault Password")
          echo "Enter new password and press Enter"
          read -s -p "Enter ansible vault password [${ANSIBLE_VAULT_PW:+"**********"}]: " input
          echo ""
          read -s -p "Enter ansible vault password again [${ANSIBLLE_VAULT_PW:+"**********"}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            ANSIBLE_VAULT_PW=${input:-$ANSIBLE_VAULT_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Cluster Settings")
          cluster_menu
          ;;

        "Network Settings")
          network_menu
          ;;

        "Node IP Settings")
          ipaddress_menu
          ;;

        "Libvirt Settings")
          libvirt_menu
          ;;

        "Prepare Deployment")
          save_settings
          prepare_deployment
          ;;

        "Save & Quit")
          save_settings
          break
          ;;

        "Quit")
          echo "Quit"
          break
          ;;

        "*")
          echo "That's NOT an option, try again..."
          ;;       
 
      esac

      ##
      ##    Reprint the current settings
      ##

      current_settings

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



