# Getting Started

## Official Guides

**NOTE** You are not required to reference the documentation for these exercises.  This is informational only.

Red Hat's official documentation can be found publicly with the links provided below.  It is important to note that this guide supports a very narrowly scoped and simple installation of the Openshift Container Platform (OCP).  Please refer to the official guides for complete information on the installtion procedures.

[Openshift 3.9 Documentation](https://access.redhat.com/documentation/en-us/openshift_container_platform/3.9/)

[Openshift 3.9 Installation and Configuration](https://access.redhat.com/documentation/en-us/openshift_container_platform/3.9/html/installation_and_configuration/)

With that stated, the steps of preparing and installing OCP have been condensed into 2 scripts which call a set of Ansible Playbooks.  Please follow the steps below.

## Pre Installation

### Log on to your session

Using the connection information and credentials provided by the instructor, get yourselves signed into your session.

### Become the root user

In order to execute the pre-installation steps, we need to become the administrative user 'root'

    [student@workstation ~]$ sudo -i
    [root@workstation ~]#

### Download the Workshop project from GitHub

    [root@workstation ~]# git clone https://github.com/xtophd/OCP-Workshop

### Run the pre-install script

**NOTE** It is important to be in the correct working directory for this to function properly.  This typically runs for about 3 minutes.

    [root@workstation ~]# cd OCP-Workshop
    [root@workstation ~]# bash 01-pre-install-script.sh

## Openshift Installation

**NOTE** Again, it is important to be in the correct working directory for this to function properly.  This typically runs for about 20 minutes.

    [root@workstation ~]# cd OCP-Workshop
    [root@workstation ~]# bash 02-ocp-install-script.sh

