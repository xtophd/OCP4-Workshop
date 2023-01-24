#!/bin/bash

export ANSIBLE_SOURCE=""
export ANSIBLE_IP=""
export ANSIBLE_VAULT_PW=""
export CLUSTER_WILDCARD=""
export CLUSTER_PROVISIONER=""
export CLUSTER_LOADBALANCER_IP=""
export CLUSTER_NAME=""
export CLUSTER_API_IP=""
export VIRTHOST_IP=""
export VIRTHOST_PW=""
export VIRTHOST_FQDN=""
export VIRTHOST_BRDEV=""
export NETWORK_ID=""
export NETWORK_GATEWAY=""
export NETWORK_PREFIX=""
export NETWORK_BROADCAST=""
export NETWORK_NETMASK=""
export NETWORK_BASEDOMAIN=""
export NETWORK_DNS_SERVER=""
export NETWORK_TIME_SERVER=""
export ADDR_BASTION=""
export ADDR_BOOTSTRAP=""
export ADDR_MASTER1=""
export ADDR_MASTER2=""
export ADDR_MASTER3=""
export ADDR_WORKER1=""
export ADDR_WORKER2=""
export BMC_BASTION=""
export BMC_BOOTSTRAP=""
export BMC_MASTER1=""
export BMC_MASTER2=""
export BMC_MASTER3=""
export BMC_WORKER1=""
export BMC_WORKER2=""
export BMC_PW_DEFAULT=""
export BMC_PW_BASTION=""
export BMC_PW_BOOTSTRAP=""
export BMC_PW_MASTER1=""
export BMC_PW_MASTER2=""
export BMC_PW_MASTER3=""
export BMC_PW_WORKER1=""
export BMC_PW_WORKER2=""
export MAC_BASTION=""
export MAC_BOOTSTRAP=""
export MAC_MASTER1=""
export MAC_MASTER2=""
export MAC_MASTER3=""
export MAC_WORKER1=""
export MAC_WORKER2=""
export HW_BASTION=""
export HW_BOOTSTRAP=""
export HW_MASTER1=""
export HW_MASTER2=""
export HW_MASTER3=""
export HW_WORKER1=""
export HW_WORKER2=""


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
VIRTHOST_IP="${VIRTHOST_IP}"
VIRTHOST_FQDN="${VIRTHOST_FQDN}"
VIRTHOST_BRDEV="${VIRTHOST_BRDEV}"
ADDR_BASTION="${ADDR_BASTION}"
ADDR_BOOTSTRAP="${ADDR_BOOTSTRAP}"
ADDR_MASTER1="${ADDR_MASTER1}"
ADDR_MASTER2="${ADDR_MASTER2}"
ADDR_MASTER3="${ADDR_MASTER3}"
ADDR_WORKER1="${ADDR_WORKER1}"
ADDR_WORKER2="${ADDR_WORKER2}"
BMC_BASTION="${BMC_BASTION}"
BMC_BOOTSTRAP="${BMC_BOOTSTRAP}"
BMC_MASTER1="${BMC_MASTER1}"
BMC_MASTER2="${BMC_MASTER2}"
BMC_MASTER3="${BMC_MASTER3}"
BMC_WORKER1="${BMC_WORKER1}"
BMC_WORKER2="${BMC_WORKER2}"
MAC_BASTION="${MAC_BASTION}"
MAC_BOOTSTRAP="${MAC_BOOTSTRAP}"
MAC_MASTER1="${MAC_MASTER1}"
MAC_MASTER2="${MAC_MASTER2}"
MAC_MASTER3="${MAC_MASTER3}"
MAC_WORKER1="${MAC_WORKER1}"
MAC_WORKER2="${MAC_WORKER2}"
HW_BASTION="${HW_BASTION}"
HW_BOOTSTRAP="${HW_BOOTSTRAP}"
HW_MASTER1="${HW_MASTER1}"
HW_MASTER2="${HW_MASTER2}"
HW_MASTER3="${HW_MASTER3}"
HW_WORKER1="${HW_WORKER1}"
HW_WORKER2="${HW_WORKER2}"
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
    echo "Ansible Control Host IP ... ${ANSIBLE_IP}"
    echo "Password Ansible Vault  ... ${ANSIBLE_VAULT_PW:+"**********"}" 
    echo "Password Virt Host      ... ${VIRTHOST_PW:+"**********"}" 
    echo "Password BMC Default    ... ${BMC_PW_DEFAULT:+"**********"}" 
    echo "Cluster Name            ... ${CLUSTER_NAME}"
    echo "Cluster Wildcard        ... ${CLUSTER_WILDCARD}"
    echo "Cluster Provisioner     ... ${CLUSTER_PROVISIONER}"
    echo "Cluster Loadbalancer IP ... ${CLUSTER_LOADBALANCER_IP}"
    echo "Cluster API IP          ... ${CLUSTER_API_IP}"
    echo "Network (id/pre/nm/bc)  ... ${NETWORK_ID} / ${NETWORK_PREFIX} / ${NETWORK_NETMASK} / ${NETWORK_BROADCAST}"
    echo "Network Gateway         ... ${NETWORK_GATEWAY}"
    echo "Network DNS Server      ... ${NETWORK_DNS_SERVER}"
    echo "Network TIME Server     ... ${NETWORK_TIME_SERVER}" 
    echo "Network Base Domain     ... ${NETWORK_BASEDOMAIN}"
    echo "Virt Host (ip/fqdn/dev) ... ${VIRTHOST_IP} / ${VIRTHOST_FQDN} / ${VIRTHOST_BRDEV}" 
    echo "NODES SETTINGS (hw/ip/mac/bmc)" 
    echo "  Bastion   ... ${HW_BASTION} / ${ADDR_BASTION} / ${MAC_BASTION} / ${BMC_BASTION}"
    echo "  Bootstrap ... ${HW_BOOTSTRAP} / ${ADDR_BOOTSTRAP} / ${MAC_BOOTSTRAP} / ${BMC_BOOTSTRAP}"
    echo "  Master1   ... ${HW_MASTER1} / ${ADDR_MASTER1} / ${MAC_MASTER1} / ${BMC_MASTER1}"
    echo "  Master2   ... ${HW_MASTER2} / ${ADDR_MASTER2} / ${MAC_MASTER2} / ${BMC_MASTER2}"
    echo "  Master3   ... ${HW_MASTER3} / ${ADDR_MASTER3} / ${MAC_MASTER3} / ${BMC_MASTER3}"
    echo "  Worker1   ... ${HW_WORKER1} / ${ADDR_WORKER1} / ${MAC_WORKER1} / ${BMC_WORKER1}"
    echo "  Worker2   ... ${HW_WORKER2} / ${ADDR_WORKER2} / ${MAC_WORKER2} / ${BMC_WORKER2}"
    echo " "
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



    echo -n "## Parsing sample-configs"



    echo -n "## Templating configuration files"
    ansible-playbook sample-configs/baremetal/_setup.yml

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

    SAVED_PROMPT="$PS3"

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

      current_settings

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}


# ---

node_submenu () {


    NODE="$1"

    SAVED_PROMPT2="$PS3"

    PS3="$NODE SETTINGS (Select Action): "

    current_settings

    select action in "Set Hardware" "Set IP Address" "Set MAC Address" "Set BMC Address" "Set BMC Password" "Delete Node" "Back to Node Settings"
    do
      case ${action}  in
        "Set Hardware")
          MAGIC_VAR="HW_$NODE"
          read -p "Enter Hardware Profile [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set IP Address")
          MAGIC_VAR="ADDR_$NODE"
          read -p "Enter IP Address [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set MAC Address")
          MAGIC_VAR="MAC_$NODE"
          read -p "Enter MAC Address [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set BMC Address")
          MAGIC_VAR="BMC_$NODE"
          read -p "Enter BMC Address [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set BMC Password")
          MAGIC_VAR="BMC_PW_$NODE"
          echo "Enter new password and press Enter"
          read -s -p "Enter bmc password [${!MAGIC_VAR:+"**********"}]: " input
          echo ""
          read -s -p "Enter bmc password again [${!MAGIC_VAR:+"**********"}]: " input2
          echo ""

          if [[ "$input" == "$input2" ]]; then
            eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;
        "Delete Node")
          read -p "DELETE $NODE ... ARE YOU SURE (Y/N): " input
          if [[ "$input" == "Y" ]]; then
            for MAGIC_VAR in HW_$NODE ADDR_$NODE MAC_$NODE BMC_$NODE BMC_PW_$NODE; do
              eval ${MAGIC_VAR}=""
            done
          fi
          ;;
        "Back to Node Settings")
          PS3=${SAVED_PROMPT2}
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

node_menu () {

    SAVED_PROMPT="$PS3"

    PS3="NODE SETTINGS (select node): "

    current_settings

    select action in "Bastion" "Bootstrap" "Master1" "Master2" "Master3" "Worker1" "Worker2" "Set Default BMC Password" "Back to Main Menu"
    do
      case ${action}  in
        "Bastion")
          node_submenu BASTION
          ;;
        "Bootstrap")
          node_submenu BOOTSTRAP
          ;;
        "Master1")
          node_submenu MASTER1
          ;;
        "Master2")
          node_submenu MASTER2 
          ;;
        "Master3")
          node_submenu MASTER3
          ;;
        "Worker1")
          node_submenu WORKER1
          ;;
        "Worker2")
          node_submenu WORKER2
          ;;
        "Set Default BMC Password")
          echo "Enter new password and press Enter"
          read -s -p "Enter BMC default password [${BMC_PW_DEFAULT:+"**********"}]: " input
          echo ""
          read -s -p "Enter BMC default password again [${BMC_PW_DEFAULT:+"**********"}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            BMC_PW_DEFAULT=${input:-$BMC_PW_DEFAULT}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;
        "Back to Main Menu")
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

      current_settings

      ##
      ##    The following causes the select
      ##    statement to reprint the menu
      ##

      REPLY=

    done

}



# ---

virthost_menu () {

    SAVED_PROMPT="$PS3"

    PS3="VIRT HOST MENU: "

    current_settings

    select action in "Set Host IP" "Set Host Password" "Set Host FQDN" "Set Bridge Device" "Back to Main Menu"
    do
      case ${action}  in
        "Set Host IP")
          read -p "Enter libvirt host IP [${VIRTHOST_IP}]: " input
          VIRTHOST_IP=${input:-$VIRTHOST_IP}
          ;;

        "Set Host Password")
          echo "Enter new password and press Enter"
          read -s -p "Enter libvirt host password [${VIRTHOST_PW:+"**********"}]: " input
          echo ""
          read -s -p "Enter libvirt host password again [${VIRTHOST_PW:+"**********"}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            VIRTHOST_PW=${input:-$VIRTHOST_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set Host FQDN")
          read -p "Enter libvirt host FQDN [${VIRTHOST_FQDN}]: " input
          VIRTHOST_FQDN=${input:-$VIRTHOST_FQDN}
          ;;

        "Set Bridge Device")
          read -p "Enter libvirt host bridge device[${VIRTHOST_BRDEV}]: " input
          VIRTHOST_BRDEV=${input:-$VIRTHOST_BRDEV}
          ;;

        "Back to Main Menu")
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

    SAVED_PROMPT="$PS3"

    PS3="NETWORK MENU: "

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

    SAVED_PROMPT="$PS3"

    PS3="CLUSTER MENU: "

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

    PS3="MAIN MENU (select action): "

    current_settings

    select action in "Set Ansible Source" \
                     "Set Vault Password" \
                     "Set Control Host IP" \
                     "Cluster Settings" \
                     "Network Settings" \
                     "Virt Host Settings" \
                     "Node Settings" \
                     "Prepare Deployment" \
                     "Save & Quit"
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
        "Virt Host Settings")
          virthost_menu
          ;;
        "Node Settings")
          node_menu
          ;;
        "Prepare Deployment")
          save_settings
          prepare_deployment
          ;;
        "Save & Quit")
          save_settings
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



