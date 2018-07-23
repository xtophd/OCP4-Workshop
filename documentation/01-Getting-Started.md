# Getting Started

## Additional Reference Materials

**NOTE** You are not required to reference the documentation for these exercises.  This is informational only.

Red Hat's official documentation can be found publicly with the links provided below.  It is important to note that this workshop guide supports a very narrowly scoped and simple installation of the Openshift Container Platform (OCP).  Please refer to the official Red Hat documentation for complete information on the installation procedures.

[Openshift 3.9 Documentation](https://access.redhat.com/documentation/en-us/openshift_container_platform/3.9/)

[Openshift 3.9 Installation and Configuration](https://access.redhat.com/documentation/en-us/openshift_container_platform/3.9/html/installation_and_configuration/)

With that stated, the steps of preparing and installing OCP have been condensed into 2 scripts which call a set of Ansible Playbooks.  Please follow the steps below to begin your installation of the Openshift Container Platform.

## 1. Pre Installation

### 1.1 Log on to your session

Using the connection information and credentials provided by the instructor, get yourselves signed into your session.

### 1.2 Become the root user

In order to execute the pre-installation steps, we need to become the administrative user 'root'

    [student@workstation ~]$ sudo -i
    [root@workstation ~]#

### 1.3 Download the Workshop project from GitHub

    [root@workstation ~]# git clone https://github.com/xtophd/OCP-Workshop

### 1.4 Run the pre-install script

**NOTE** It is important to be in the correct working directory for this to function properly.  This typically runs for about 3 minutes.

#

    [root@workstation ~]# cd OCP-Workshop
    [root@workstation ~]# bash 01-pre-install-script.sh

### 1.4 Pre-Install Results

**NOTE** Please verify that PLAY RECAP reports 0 errors for all hosts.  If you encountered errors, stop here and notify an instructor.

Here is the tail end of a sample output following a successfull run of the pre-install script and ansible playbooks.

    PLAY RECAP **********
    master.example.com         : ok=16   changed=12   unreachable=0    failed=0
    node1.example.com          : ok=14   changed=11   unreachable=0    failed=0
    node2.example.com          : ok=14   changed=11   unreachable=0    failed=0

## 2. Openshift Installation

### 2.1 Run the ocp-install script

**NOTE** Again, it is important to be in the correct working directory for this to function properly.  This typically runs for about 20 minutes.

    [root@workstation ~]# cd OCP-Workshop
    [root@workstation ~]# bash 02-ocp-install-script.sh

### 2.2 Installation Results

**NOTE** Please verify that PLAY RECAP reports 0 errors for all hosts.  If you encountered errors, stop here and notify an instructor.

Here is the tail end of a sample output following a successfull installation of the Openshift Container Platform.

    PLAY RECAP **********
    localhost                  : ok=13   changed=0    unreachable=0    failed=0   
    master.example.com         : ok=612  changed=260  unreachable=0    failed=0   
    node1.example.com          : ok=135  changed=54   unreachable=0    failed=0   
    node2.example.com          : ok=135  changed=55   unreachable=0    failed=0   
    workstation.example.com    : ok=20   changed=0    unreachable=0    failed=0

    INSTALLER STATUS ****************
    Initialization             : Complete (0:00:26)
    Health Check               : Complete (0:00:28)
    etcd Install               : Complete (0:01:08)
    NFS Install                : Complete (0:00:17)
    Master Install             : Complete (0:03:45)
    Master Additional Install  : Complete (0:01:34)
    Node Install               : Complete (0:04:33)
    Hosted Install             : Complete (0:03:09)
    Web Console Install        : Complete (0:00:43)
    Service Catalog Install    : Complete (0:03:12)

## Conclusion

The installation of Red Hat Openshift Container Platform is now complete and you should be ready to begin with the exercises.  A couple of remaining words of advice:

1.  Some exercises are dependant on the successful completion of other exericses.  Those dependencies will be noted at the top of each unit.
2.  Pay attention to which linux login to use
3.  Pay attention to which ocp user to use
4.  Also be sure to pay close attention to which host you are executing tasks from
