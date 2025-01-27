
export PROJECT_NAME=""
export ANSIBLE_SOURCE=""
export ANSIBLE_IP=""
export ANSIBLE_VAULT_PW=""
export WORKSHOP_ADMIN_PW=""
export WORKSHOP_ADMIN_UID="cloud-admin"
export WORKSHOP_USER_PW=""
export WORKSHOP_USER_UID="cloud-user"
export CLUSTER_WILDCARD=""
export CLUSTER_PROVISIONER=""
export CLUSTER_LOADBALANCER_IP=""
export CLUSTER_NAME=""
export CLUSTER_API_IP=""
export CLUSTER_VERSION="4.17"
export CLUSTER_STRAPLESS="False"
export CLUSTER_SNO="False"
export BASTION_DNS="True"
export BASTION_DHCP="True"
export BASTION_HAPROXY="True"
export BASTION_NTP="True"
export BASTION_NFS="True"
export BASTION_SQUID="False"
export VIRTHOST_IP=""
export VIRTHOST_UID="root"
export VIRTHOST_PW=""
export VIRTHOST_FQDN=""
export VIRTHOST_TYPE="none"
export VIRTHOST_VTAP_DEV=""
export VIRTHOST_VTAP_VID=""
export VIRTHOST_BR_TYPE=""
export VIRTHOST_BR_DEV=""
export VIRTHOST_HW=""
export VIRTHOST_BMC=""
export VIRTHOST_BMC_UID=""
export VIRTHOST_BMC_PW=""
export VIRTHOST_MACHINE="kvm_vda"
export OVIRT_MANAGER_IP=""
export OVIRT_MANAGER_FQDN=""
export OVIRT_MANAGER_UID="admin@internal"
export OVIRT_MANAGER_PW=""
export OVIRT_DATACENTER=""
export OVIRT_STORAGE_DOMAIN=""
export OVIRT_NETWORK_DOMAIN=""
export OVIRT_MACHINE="ovirt_sda"
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
export ADDR_SNO=""
export BMC_BASTION=""
export BMC_BOOTSTRAP=""
export BMC_MASTER1=""
export BMC_MASTER2=""
export BMC_MASTER3=""
export BMC_WORKER1=""
export BMC_WORKER2=""
export BMC_SNO=""
export BMC_UID_DEFAULT="root"
export BMC_UID_BASTION=""
export BMC_UID_BOOTSTRAP=""
export BMC_UID_MASTER1=""
export BMC_UID_MASTER2=""
export BMC_UID_MASTER3=""
export BMC_UID_WORKER1=""
export BMC_UID_WORKER2=""
export BMC_UID_SNO=""
export BMC_PW_DEFAULT=""
export BMC_PW_BASTION=""
export BMC_PW_BOOTSTRAP=""
export BMC_PW_MASTER1=""
export BMC_PW_MASTER2=""
export BMC_PW_MASTER3=""
export BMC_PW_WORKER1=""
export BMC_PW_WORKER2=""
export BMC_PW_SNO=""
export MAC_BASTION=""
export MAC_BOOTSTRAP=""
export MAC_MASTER1=""
export MAC_MASTER2=""
export MAC_MASTER3=""
export MAC_WORKER1=""
export MAC_WORKER2=""
export MAC_SNO="dhcp"
export NICMODE_BASTION="dhcp"
export NICMODE_BOOTSTRAP="dhcp"
export NICMODE_MASTER1="dhcp"
export NICMODE_MASTER2="dhcp"
export NICMODE_MASTER3="dhcp"
export NICMODE_WORKER1="dhcp"
export NICMODE_WORKER2="dhcp"
export NICMODE_SNO="dhcp"
export HW_BASTION=""
export HW_BOOTSTRAP=""
export HW_MASTER1=""
export HW_MASTER2=""
export HW_MASTER3=""
export HW_WORKER1=""
export HW_WORKER2=""
export HW_SNO=""
export RES_BASTION="custom_bastion"
export RES_BOOTSTRAP="custom_bootstrap"
export RES_MASTER1="custom_master"
export RES_MASTER2="custom_master"
export RES_MASTER3="custom_master"
export RES_WORKER1="custom_worker"
export RES_WORKER2="custom_worker"
export RES_SNO="custom_sno"
export NAME_BASTION="bastion"
export NAME_BOOTSTRAP="bootstrap"
export NAME_MASTER1="master1"
export NAME_MASTER2="master2"
export NAME_MASTER3="master3"
export NAME_WORKER1="worker1"
export NAME_WORKER2="worker2"
export NAME_SNO="sno"


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
PROJECT_NAME="${PROJECT_NAME}"
ANSIBLE_SOURCE="${ANSIBLE_SOURCE}"
ANSIBLE_IP="${ANSIBLE_IP}"
CLUSTER_NAME="${CLUSTER_NAME}"
CLUSTER_WILDCARD="${CLUSTER_WILDCARD}"
CLUSTER_PROVISIONER="${CLUSTER_PROVISIONER}"
CLUSTER_LOADBALANCER_IP="${CLUSTER_LOADBALANCER_IP}"
CLUSTER_API_IP="${CLUSTER_API_IP}"
CLUSTER_VERSION="${CLUSTER_VERSION}"
CLUSTER_STRAPLESS="${CLUSTER_STRAPLESS}"
CLUSTER_SNO="${CLUSTER_SNO}"
BASTION_DNS="${BASTION_DNS}"
BASTION_DHCP="${BASTION_DHCP}"
BASTION_HAPROXY="${BASTION_HAPROXY}"
BASTION_NTP="${BASTION_NTP}"
BASTION_NFS="${BASTION_NFS}"
BASTION_SQUID="${BASTION_SQUID}"
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
VIRTHOST_UID="${VIRTHOST_UID}"
VIRTHOST_TYPE="${VIRTHOST_TYPE}"
VIRTHOST_VTAP_DEV="${VIRTHOST_VTAP_DEV}"
VIRTHOST_VTAP_VID="${VIRTHOST_VTAP_VID}"
VIRTHOST_BR_DEV="${VIRTHOST_BR_DEV}"
VIRTHOST_BR_TYPE="${VIRTHOST_BR_TYPE}"
VIRTHOST_DATACENTER="${VIRTHOST_DATACENTER}"
VIRTHOST_STORAGE_DOMAIN="${VIRTHOST_STORAGE_DOMAIN}"
VIRTHOST_NETWORK_DOMAIN="${VIRTHOST_NETWORK_DOMAIN}"
VIRTHOST_HW="${VIRTHOST_HW}"
VIRTHOST_BMC="${VIRTHOST_BMC}"
VIRTHOST_BMC_UID="${VIRTHOST_BMC_UID}"
VIRTHOST_MACHINE="${VIRTHOST_MACHINE}"
OVIRT_MANAGER_IP="${OVIRT_MANAGER_IP}"
OVIRT_MANAGER_FQDN="${OVIRT_MANAGER_FQDN}"
OVIRT_MANAGER_UID="${OVIRT_MANAGER_UID}"
OVIRT_DATACENTER="${OVIRT_DATACENTER}"
OVIRT_STORAGE_DOMAIN="${OVIRT_STORAGE_DOMAIN}"
OVIRT_NETWORK_DOMAIN="${OVIRT_NETWORK_DOMAIN}"
OVIRT_MACHINE="${OVIRT_MACHINE}"
ADDR_BASTION="${ADDR_BASTION}"
ADDR_BOOTSTRAP="${ADDR_BOOTSTRAP}"
ADDR_MASTER1="${ADDR_MASTER1}"
ADDR_MASTER2="${ADDR_MASTER2}"
ADDR_MASTER3="${ADDR_MASTER3}"
ADDR_WORKER1="${ADDR_WORKER1}"
ADDR_WORKER2="${ADDR_WORKER2}"
ADDR_SNO="${ADDR_SNO}"
BMC_BASTION="${BMC_BASTION}"
BMC_BOOTSTRAP="${BMC_BOOTSTRAP}"
BMC_MASTER1="${BMC_MASTER1}"
BMC_MASTER2="${BMC_MASTER2}"
BMC_MASTER3="${BMC_MASTER3}"
BMC_WORKER1="${BMC_WORKER1}"
BMC_WORKER2="${BMC_WORKER2}"
BMC_SNO="${BMC_SNO}"
MAC_BASTION="${MAC_BASTION}"
MAC_BOOTSTRAP="${MAC_BOOTSTRAP}"
MAC_MASTER1="${MAC_MASTER1}"
MAC_MASTER2="${MAC_MASTER2}"
MAC_MASTER3="${MAC_MASTER3}"
MAC_WORKER1="${MAC_WORKER1}"
MAC_WORKER2="${MAC_WORKER2}"
MAC_SNO="${MAC_SNO}"
NICMODE_BASTION="${NICMODE_BASTION}"
NICMODE_BOOTSTRAP="${NICMODE_BOOTSTRAP}"
NICMODE_MASTER1="${NICMODE_MASTER1}"
NICMODE_MASTER2="${NICMODE_MASTER2}"
NICMODE_MASTER3="${NICMODE_MASTER3}"
NICMODE_WORKER1="${NICMODE_WORKER1}"
NICMODE_WORKER2="${NICMODE_WORKER2}"
NICMODE_SNO="${NICMODE_SNO}"
HW_BASTION="${HW_BASTION}"
HW_BOOTSTRAP="${HW_BOOTSTRAP}"
HW_MASTER1="${HW_MASTER1}"
HW_MASTER2="${HW_MASTER2}"
HW_MASTER3="${HW_MASTER3}"
HW_WORKER1="${HW_WORKER1}"
HW_WORKER2="${HW_WORKER2}"
HW_SNO="${HW_SNO}"
RES_BASTION="${RES_BASTION}"
RES_BOOTSTRAP="${RES_BOOTSTRAP}"
RES_MASTER1="${RES_MASTER1}"
RES_MASTER2="${RES_MASTER2}"
RES_MASTER3="${RES_MASTER3}"
RES_WORKER1="${RES_WORKER1}"
RES_WORKER2="${RES_WORKER2}"
RES_SNO="${RES_SNO}"
NAME_BASTION="${NAME_BASTION}"
NAME_BOOTSTRAP="${NAME_BOOTSTRAP}"
NAME_MASTER1="${NAME_MASTER1}"
NAME_MASTER2="${NAME_MASTER2}"
NAME_MASTER3="${NAME_MASTER3}"
NAME_WORKER1="${NAME_WORKER1}"
NAME_WORKER2="${NAME_WORKER2}"
NAME_SNO="${NAME_SNO}"
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
    echo "Project Name ... ${PROJECT_NAME}"
    echo ""

    echo "[ SECURITY ]"
    echo "    Ansible Vault  ... NA/${ANSIBLE_VAULT_PW:+**********}" 

    if [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "ovirt" ]]; then
        echo "    oVirt API      ... ${OVIRT_MANAGER_UID} / ${OVIRT_MANAGER_PW:+**********}" 
    elif [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "libvirt" ]]; then
        echo "    lVirt Host     ... ${VIRTHOST_UID} / ${VIRTHOST_PW:+**********}"
        echo "    lVirt BMC      ... ${VIRTHOST_BMC_UID} / ${VIRTHOST_BMC_PW:+**********}" 
    fi

    echo "    Workshop Admin ... ${WORKSHOP_ADMIN_UID} / ${WORKSHOP_ADMIN_PW:+**********}" 
    echo "    Workshop User  ... ${WORKSHOP_USER_UID} / ${WORKSHOP_USER_PW:+**********}" 
    echo "    BMC Default    ... ${BMC_UID_DEFAULT} / ${BMC_PW_DEFAULT:+**********}" 

    echo "[ ANSIBLE ]"
    echo "    Source                ... ${ANSIBLE_SOURCE}"
    echo "    Ctrl Host IP          ... ${ANSIBLE_IP}"

    echo "[ BASTION ]"
    printf "    %-7s / %-7s / %-7s / %-7s / %-7s / %-7s\n" dns dhcp haproxy ntp nfs squid
    printf "    %-7s   %-7s   %-7s   %-7s   %-7s   %-7s\n" ${BASTION_DNS} ${BASTION_DHCP} ${BASTION_HAPROXY} ${BASTION_NTP} ${BASTION_NFS} ${BASTION_SQUID}

    echo "[ OCP CLUSTER ]"
    echo "    Name (ver)      ... ${CLUSTER_NAME} (${CLUSTER_VERSION})"
    echo "    Wildcard        ... ${CLUSTER_WILDCARD}"
    echo "    Provisioner     ... ${CLUSTER_PROVISIONER} (sno = ${CLUSTER_SNO}) (strapless = ${CLUSTER_STRAPLESS})"
    echo "    Loadbalancer IP ... ${CLUSTER_LOADBALANCER_IP}"
    echo "    API IP          ... ${CLUSTER_API_IP}"

    echo "[ NETWORK ]"
    echo "    id/pre/nm/bc ... ${NETWORK_ID} / ${NETWORK_PREFIX} / ${NETWORK_NETMASK} / ${NETWORK_BROADCAST}"
    echo "    gw/dns/time  ... ${NETWORK_GATEWAY} / ${NETWORK_DNS_SERVER} / ${NETWORK_TIME_SERVER}"
    echo "    base domain  ... ${NETWORK_BASEDOMAIN}"

    echo "[ VIRT HOST ]"
    if [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "ovirt" ]]; then
        echo "    oVirt API (ip/fqdn)         ... ${OVIRT_MANAGER_IP} / ${OVIRT_MANAGER_FQDN}"
        echo "          Datacenter            ... ${OVIRT_DATACENTER}"
        echo "          Storage Domain        ... ${OVIRT_STORAGE_DOMAIN}"
        echo "          Network Domain        ... ${OVIRT_NETWORK_DOMAIN}"
        echo "          VM machine            ... ${OVIRT_MACHINE}"
    elif [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "libvirt" ]]; then
        echo "    lVirt Host   (ip/mac/fqdn)  ... ${VIRTHOST_IP} / ${VIRTHOST_MAC} / ${VIRTHOST_FQDN}"
        echo "                 (hw/ks)        ... ${VIRTHOST_HW} / ${VIRTHOST_KS}"
        echo "          BRIDGE (type/dev)     ... ${VIRTHOST_MACHINE} / ${VIRTHOST_BR_TYPE} / ${VIRTHOST_BR_DEV}"
        echo "          VTAP   (dev/vlan-id)  ... ${VIRTHOST_VTAP_DEV} / ${VIRTHOST_VTAP_VID}"
        echo "          BMC    (ip/uid)       ... ${VIRTHOST_BMC} / ${VIRTHOST_BMC_UID}"
        echo "          VM     (machine)      ... ${VIRTHOST_MACHINE}"
    else
        echo "    vHost Type ... ${VIRTHOST_TYPE}"
    fi

    echo "[NODE SETTINGS] (mode/ip/mac/hw/resource/bmc/hostname)" 
    echo "    Bastion  : ${NICMODE_BASTION}/${ADDR_BASTION}/${MAC_BASTION}/${HW_BASTION}/${RES_BASTION}/${BMC_BASTION}/${NAME_BASTION}"
    echo "    Bootstrap: ${NICMODE_BOOTSTRAP}/${ADDR_BOOTSTRAP}/${MAC_BOOTSTRAP}/${HW_BOOTSTRAP}/${RES_BOOTSTRAP}/${BMC_BOOTSTRAP}/${NAME_BOOTSTRAP}"
    echo "    Master1  : ${NICMODE_MASTER1}/${ADDR_MASTER1}/${MAC_MASTER1}/${HW_MASTER1}/${RES_MASTER1}/${BMC_MASTER1}/${NAME_MASTER1}"
    echo "    Master2  : ${NICMODE_MASTER2}/${ADDR_MASTER2}/${MAC_MASTER2}/${HW_MASTER2}/${RES_MASTER2}/${BMC_MASTER2}/${NAME_MASTER2}"
    echo "    Master3  : ${NICMODE_MASTER3}/${ADDR_MASTER3}/${MAC_MASTER3}/${HW_MASTER3}/${RES_MASTER3}/${BMC_MASTER3}/${NAME_MASTER3}"
    echo "    Worker1  : ${NICMODE_WORKER1}/${ADDR_WORKER1}/${MAC_WORKER1}/${HW_WORKER1}/${RES_WORKER1}/${BMC_WORKER1}/${NAME_WORKER1}"
    echo "    Worker2  : ${NICMODE_WORKER2}/${ADDR_WORKER2}/${MAC_WORKER2}/${HW_WORKER2}/${RES_WORKER2}/${BMC_WORKER2}/${NAME_WORKER2}"
    echo "    SNO      : ${NICMODE_SNO}/${ADDR_SNO}/${MAC_SNO}/${HW_SNO}/${RES_SNO}/${BMC_SNO}/${NAME_SNO}"
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

node_submenu () {


    NODE="$1"

    SAVED_PROMPT2="$PS3"

    PS3="$NODE SETTINGS (Select Action): "

    current_settings

    select action in "Set Name" "Set NIC Mode" "Set IP Address" "Set MAC Address" "Set Hardware" "Set Resources" "Set BMC Address" "Set BMC Password" "Delete Node" "Back to Node Settings"
    do
      case ${action}  in
        "Set Name")
          MAGIC_VAR="NAME_$NODE"
          read -p "Enter Node Name [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set Hardware")
          MAGIC_VAR="HW_$NODE"
          read -p "Enter Hardware Profile [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set Resources")
          MAGIC_VAR="RES_$NODE"
          read -p "Enter Resource Profile [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set IP Address")
          MAGIC_VAR="ADDR_$NODE"
          read -p "Enter IP Address [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set NIC Mode")
          select NIC_MODE in "static" "dhcp" 
          do
            case ${NIC_MODE} in
              "static" | "dhcp" )
                MAGIC_VAR="NICMODE_$NODE"
                eval ${MAGIC_VAR}=${NIC_MODE}
                break ;;
              "*" )
                 ;;
             esac
             REPLY=
           done
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
        "Set BMC UID")
          MAGIC_VAR="BMC_UID_$NODE"
          read -p "Enter BMC User ID [${!MAGIC_VAR}]: " input
          eval ${MAGIC_VAR}=${input:-${!MAGIC_VAR}}
          ;;
        "Set BMC Password")
          MAGIC_VAR="BMC_PW_$NODE"
          echo "Enter new password and press Enter"
          read -s -p "Enter bmc password [${!MAGIC_VAR:+**********}]: " input
          echo ""
          read -s -p "Enter bmc password again [${!MAGIC_VAR:+**********}]: " input2
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

    select action in "Bastion" "Bootstrap" "Master1" "Master2" "Master3" "Worker1" "Worker2" "SNO" "Back to Main Menu"
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
        "SNO")
          node_submenu SNO
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

password_menu () {

    SAVED_PROMPT="$PS3"

    PS3="PASSWORD MENU: "

    current_settings

    select action in "Set Ansible Vault Password" "Set Workshop Admin Password" "Set Workshop User Password" "Set vHost Password" "Set vHost BMC Password" "Set oVirt Password" "Set Default BMC Password" "Back to Main Menu"
    do
      case ${action}  in

        "Set Ansible Vault Password")
          echo "Enter new password and press Enter"
          read -s -p "Enter ansible vault password [${ANSIBLE_VAULT_PW:+**********}]: " input
          echo ""
          read -s -p "Enter ansible vault password again [${ANSIBLLE_VAULT_PW:+**********}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            ANSIBLE_VAULT_PW=${input:-$ANSIBLE_VAULT_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set Workshop Admin Password")
          read -p "Enter Workshop Admin Username [${WORKSHOP_ADMIN_UID}]: " input
          WORKSHOP_ADMIN_UID=${input:-$WORKSHOP_ADMIN_UID}

          echo "Enter new password and press Enter"
          read -s -p "Enter Workshop Admin password [${WORKSHOP_ADMIN_PW:+**********}]: " input
          echo ""
          read -s -p "Enter Workshop Admin password again [${WORKSHOP_ADMIN_PW:+**********}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            WORKSHOP_ADMIN_PW=${input:-$WORKSHOP_ADMIN_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set Workshop User Password")
          read -p "Enter Workshop User Username [${WORKSHOP_USER_UID}]: " input
          WORKSHOP_USER_UID=${input:-$WORKSHOP_USER_UID}

          echo "Enter new password and press Enter"
          read -s -p "Enter Workshop User password [${WORKSHOP_USER_PW:+**********}]: " input
          echo ""
          read -s -p "Enter Workshop User password again [${WORKSHOP_USER_PW:+**********}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            WORKSHOP_USER_PW=${input:-$WORKSHOP_USER_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set vHost Password")
          read -p "Enter vHost User Username [${VIRTHOST_UID}]: " input
          VIRTHOST_UID=${input:-$VIRTHOST_UID}

          echo "Enter new password and press Enter"
          read -s -p "Enter libvirt host password [${VIRTHOST_PW:+**********}]: " input
          echo ""
          read -s -p "Enter libvirt host password again [${VIRTHOST_PW:+**********}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            VIRTHOST_PW=${input:-$VIRTHOST_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set vHost BMC Password")
          read -p "Enter vHost BMC Username [${VIRTHOST_BMC_UID}]: " input
          VIRTHOST_BMC_UID=${input:-$VIRTHOST_BMC_UID}

          echo "Enter new password and press Enter"
          read -s -p "Enter libvirt host BMC password [${VIRTHOST_BMC_PW:+**********}]: " input
          echo ""
          read -s -p "Enter libvirt host BMC password again [${VIRTHOST_BMC_PW:+**********}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            VIRTHOST_BMC_PW=${input:-$VIRTHOST_BMC_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set oVirt Password")
          read -p "Enter vHost BMC Username [${OVIRT_MANAGER_UID}]: " input
          OVIRT_MANAGER_UID=${input:-$OVIRT_MANAGER_UID}

          echo "Enter new password and press Enter"
          read -s -p "Enter ovirt manager password [${OVIRT_MANAGER_PW:+**********}]: " input
          echo ""
          read -s -p "Enter ovirt manager password again [${OVIRT_MANAGER_PW:+**********}]: " input2
          echo ""
          echo ""

          if [[ "$input" == "$input2" ]]; then
            OVIRT_MANAGER_PW=${input:-$OVIRT_MANAGER_PW}
          else
            echo "WARNING: Passwords do not match ... unchanged"
          fi
          ;;

        "Set Default BMC Password")
          read -p "Enter Default BMC User [${BMC_UID_DEFAULT}]: " input 
          BMC_UID_DEFAULT=${input:-$BMC_UID_DEFAULT}

          echo "Enter new password and press Enter"
          read -s -p "Enter BMC default password [${BMC_PW_DEFAULT:+**********}]: " input
          echo ""
          read -s -p "Enter BMC default password again [${BMC_PW_DEFAULT:+**********}]: " input2
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

    action=""

    until [ "${action}" == "Back to Main Menu" ] 
    do

      if [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "ovirt" ]]; then
        TYPE_ACTIONS=("Set Manager IP" "Set Manager FQDN" "Set Datacenter" "Set Storage Domain" "Set Network Domain" "Set VM Type" "Clear vHost Settings")
      elif [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "libvirt" ]]; then
        TYPE_ACTIONS=("Set vHost IP" "Set vHost MAC" "Set vHost FQDN" "Set vHost User" "Set Bridge Device" "Set Bridge Type" "Set VTAP device" "Set VTAP vlan-id" "Set HW Type" "Set KS Profile" "Set BMC FQDN" "Set BMC User" "Set VM Type" "Clear vHost Settings")
      fi

      select action in "Set vHost Type" "${TYPE_ACTIONS[@]}" "Back to Main Menu"
      do
        case ${action}  in

          "Set vHost User")
            read -p "Enter libvirt host hardware BMC User [${VIRTHOST_UID}]: " input
            VIRTHOST_UID=${input:-$VIRTHOST_UID}
            ;;

          "Set BMC User")
            read -p "Enter libvirt host hardware BMC User [${VIRTHOST_BMC_UID}]: " input
            VIRTHOST_BMC_UID=${input:-$VIRTHOST_BMC_UID}
            ;;

          "Set BMC FQDN")
            read -p "Enter libvirt host hardware BMC FQDN or IP [${VIRTHOST_BMC}]: " input
            VIRTHOST_BMC=${input:-$VIRTHOST_BMC}
            ;;

          "Set HW Type")
            read -p "Enter libvirt host hardware type [${VIRTHOST_HW}]: " input
            VIRTHOST_HW=${input:-$VIRTHOST_HW}
            ;;

          "Set KS Profile")
            read -p "Enter libvirt host kickstart profile [${VIRTHOST_KS}]: " input
            VIRTHOST_KS=${input:-$VIRTHOST_KS}
            ;;

          "Set vHost IP")
            read -p "Enter libvirt host IP [${VIRTHOST_IP}]: " input
            VIRTHOST_IP=${input:-$VIRTHOST_IP}
            ;;

          "Set vHost MAC")
            read -p "Enter libvirt host MAC [${VIRTHOST_MAC}]: " input
            VIRTHOST_MAC=${input:-$VIRTHOST_MAC}
            ;;

          "Set vHost FQDN")
            read -p "Enter libvirt host FQDN [${VIRTHOST_FQDN}]: " input
            VIRTHOST_FQDN=${input:-$VIRTHOST_FQDN}
            ;;

          "Set vHost Type")
            SUB_PROMPT="${PS3}"
            PS3="Select vHost Type: "
            select VIRTHOST_TYPE in "libvirt" "ovirt" "none"
            do
              case ${VIRTHOST_TYPE} in
                "libvirt" )
                  break ;;
                "ovirt" )
                  break ;;
                "none" )
                  break ;;
                "*" )
                   ;;
              esac
              REPLY=
            done
            PS3="${SUB_PROMPT}"

            current_settings
            REPLY=

            break
            ;;

          "Set Bridge Device")
            read -p "Enter libvirt host bridge device[${VIRTHOST_BR_DEV}]: " input
            VIRTHOST_BR_DEV=${input:-$VIRTHOST_BR_DEV}
            ;;

          "Set VTAP device")
            read -p "Enter libvirt host macvtap device[${VIRTHOST_VTAP_DEV}]: " input
            VIRTHOST_VTAP_DEV=${input:-$VIRTHOST_VTAP_DEV}
            ;;

          "Set VTAP vlan-id")
            read -p "Enter libvirt host macvtap vlan-id${VIRTHOST_VTAP_VID}]: " input
            VIRTHOST_VTAP_VID=${input:-$VIRTHOST_VTAP_VID}
            ;;

          "Set Bridge Type")
             select VIRTHOST_BR_TYPE in "bridge" "macvtap" "nat"
             do
                case ${VIRTHOST_BR_TYPE} in
                  "bridge" )
                    break ;;
                  "macvtap" )
                    break ;;
                  "nat" )
                    break ;;
                  "*" )
                    ;;
                esac
                REPLY=
              done
            ;;

          "Set Manager User")
            read -p "Enter oVirt Manager User [${OVIRT_MANAGER_UID}]: " input
            OVIRT_MANAGER_UID=${input:-$OVIRT_MANAGER_UID}
            ;;

          "Set Manager IP")
            read -p "Enter oVirt Manager IP[${OVIRT_MANAGER_IP}]: " input
            OVIRT_MANAGER_IP=${input:-$OVIRT_MANAGER_IP}
            ;;

          "Set Manager FQDN")
            read -p "Enter oVirt Manager FQDN[${OVIRT_MANAGER_FQDN}]: " input
            OVIRT_MANAGER_FQDN=${input:-$OVIRT_MANAGER_FQDN}
            ;;

          "Set Datacenter")
            read -p "Enter oVirt Datacenter[${OVIRT_DATACENTER}]: " input
            OVIRT_DATACENTER=${input:-$OVIRT_DATACENTER}
            ;;

          "Set Network Domain")
            read -p "Enter oVirt Network Domain[${VIRTHOST_NETWORK_DOMAIN}]: " input
            OVIRT_NETWORK_DOMAIN=${input:-$OVIRT_NETWORK_DOMAIN}
            ;;

          "Set Storage Domain")
            read -p "Enter oVirt Storage Domain[${OVIRT_STORAGE_DOMAIN}]: " input
            OVIRT_STORAGE_DOMAIN=${input:-$OVIRT_STORAGE_DOMAIN}
            ;;

          "Clear vHost Settings")
            read -p "Clear vHost Settings ... ARE YOU SURE (Y/N): " input
            if [[ "$input" == "Y" ]]; then
              if [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "libvirt" ]]; then
                  VIRTHOST_IP=""
                  VIRTHOST_PW=""
                  VIRTHOST_FQDN=""
                  VIRTHOST_BR_TYPE=""
                  VIRTHOST_BR_DEV=""
                  VIRTHOST_VTAP_DEV=""
                  VIRTHOST_VTAP_VID=""
                  VIRTHOST_HW=""
                  VIRTHOST_MACHINE=""
                  VIRTHOST_BMC=""
                  VIRTHOST_BMC_UID=""
                  VIRTHOST_BMC_PW=""
              elif [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "ovirt" ]]; then
                  OVIRT_MANAGER_IP=""
                  OVIRT_MANAGER_FQDN=""
                  OVIRT_MANAGER_UID=""
                  OVIRT_MANAGER_PW=""
                  OVIRT_DATACENTER=""
                  OVIRT_STORAGE_DOMAIN=""
                  OVIRT_NETWORK_DOMAIN=""
                  OVIRT_MACHINE=""

              fi
            fi
            ;;
  
          "Set VM Type")
            if [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "libvirt" ]]; then
              read -p "Enter libVirt VM Type[${VIRTHOST_MACHINE}]: " input
              VIRTHOST_MACHINE=${input:-$VIRTHOST_MACHINE}
            elif [[ ! -z ${VIRTHOST_TYPE} && "${VIRTHOST_TYPE}" == "ovirt" ]]; then
              read -p "Enter oVirt VM Type[${OVIRT_MACHINE}]: " input
              OVIRT_MACHINE=${input:-$OVIRT_MACHINE}
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

bastion_menu () {

    SAVED_PROMPT="$PS3"

    PS3="BASTION MENU: "

    current_settings

    select action in "Set DNS" "Set DHCP" "Set HAPROXY" "Set NTP" "Set NFS" "Set SQUID" "Back to Main Menu"
    do
      case ${action}  in
        "Set DNS")
          select BASTION_DNS in "True" "False"
            do
              case ${BASTION_DNS} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set DHCP")
          select BASTION_DHCP in "True" "False"
            do
              case ${BASTION_DHCP} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set HAPROXY")
          select BASTION_HAPROXY in "True" "False"
            do
              case ${BASTION_HAPROXY} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set NTP")
          select BASTION_NTP in "True" "False"
            do
              case ${BASTION_NTP} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set NFS")
          select BASTION_NFS in "True" "False"
            do
              case ${BASTION_NFS} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set SQUID")
          select BASTION_SQUID in "True" "False"
            do
              case ${BASTION_SQUID} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
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

    select action in "Set Name" "Set Version" "Set Wildcard" "Set LB IP" "Set API IP" "Set Provisioner" "Set SNO" "Set Strapless" "Back to Main Menu"
    do
      case ${action}  in
        "Set Name")
           read -p "Enter Cluster Name [${CLUSTER_NAME}]: " input
           CLUSTER_NAME=${input:-$CLUSTER_NAME}
           ;;

        "Set Version")
           select CLUSTER_VERSION in "4.17" "4.16" "4.15" "4.14" "4.13" "4.12" "4.11" "4.10" "4.9" "4.8" "4.7" "4.6" "4.5" "4.4" "4.3" "4.2"
           do
              case ${CLUSTER_VERSION} in
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
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set Provisioner")
           select CLUSTER_PROVISIONER in "upi-pxe" "upi-vmedia" "ai"
           do
              case ${CLUSTER_PROVISIONER} in
                "upi-pxe" )
                  break ;;
                "upi-vmedia" )
                  break ;;
                "ai" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
          ;;

        "Set Strapless")
           select CLUSTER_STRAPLESS in "True" "False"
           do
              case ${CLUSTER_STRAPLESS} in
                "True" )
                  break ;;
                "False" )
                  break ;;
                "*" )
                  ;;
              esac
              REPLY=
            done
           ;;

        "Set SNO")
           select CLUSTER_SNO in "True" "False"
           do
              case ${CLUSTER_SNO} in
                "True" )
                  break ;;
                "False" )
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

        "Set LB IP")
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

ansible_menu() {

    SAVED_PROMPT="$PS3"

    PS3="ANSIBLE SETTINGS (select node): "

    current_settings

    select action in "Set Ansible Source" "Set Control Host IP" "Back to Main Menu"
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

    select action in "Set Project Name" \
                     "Security Settings" \
                     "Ansible Settings" \
                     "Bastion Settings" \
                     "Cluster Settings" \
                     "Network Settings" \
                     "Virt Host Settings" \
                     "Node Settings" \
                     "Prepare Deployment" \
                     "Save & Quit"
    do
      case ${action}  in

        "Set Project Name")
          read -p "Enter Prooject Name [${PROJECT_NAME}]: " input
          PROJECT_NAME=${input:-$PROJECT_NAME}
          ;;
        "Security Settings")
          password_menu
          ;;
        "Ansible Settings")
          ansible_menu
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



