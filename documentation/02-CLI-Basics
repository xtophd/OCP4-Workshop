# 2. Command Line Basics

The default and recommended method for interacting with the Openshift Container Platform with the `oc` command.  In limited circumstances you could be directed to use other tools to invoke action or retrieve data from OCP.

## 2.1 Become the root user

Your workshop environment is preconfigured with distributed ssh-keys to ease the management of sessions from one host to another.  As the user `root` you can easily login to any host in your cluster.  With that said, ensure your session is user `root` on the host `workstation`.

    [student@workstation ~]$ sudo -i
    [root@workstation ~]#

## 2.2 Connect to host master.example.com

    [root@workstation ~]# ssh master
    [root@master ~]#

## 2.3 Establish OCP Admin session

    [root@master ~]# oc login -u system:admin
    [root@master ~]#
    [root@master ~]#
    [root@master ~]#

## 2.4 Verify Cluster Status

### Check the Nodes

    [root@master ~]# oc get nodes

### Check the Pods

    [root@master ~]# oc get pods

### Check the Logs

    [root@master ~]#
    [root@master ~]#

## 2.5 User Accounts and Roles

At this time, we have not configured any additional user accounts or roles.  So our first activity will be to do just that.

The installation parameters used to install this cluster automatically configured user credentials to be defined in `/etc/origin/master/openshift-passwd` and managed  by the commandline utility `htpasswd`.  This configuration is defined in `/etc/origin/master/master-config/yml` on the host master.example.com

### Inspect the master-config.yml

If you are not familiar with grep, the parameter `-6` will provide the 6 lines above and 6 lines below the requested matched.  Thus we can easily inspect the entire stanza defining the IdentityProviders. 

    [root@master master]# grep -6 htpasswd_auth master-config.yaml

Your results should look like this.  Pay attention to `file: /etc/origin/master/htpasswd` and `kind: HTPasswdPasswordIdentityProvider`.

    grantConfig:
      method: auto
    identityProviders:
    - challenge: true
      login: true
      mappingMethod: claim
      name: htpasswd_auth
      provider:
        apiVersion: v1
        file: /etc/origin/master/htpasswd
        kind: HTPasswdPasswordIdentityProvider
    masterCA: ca-bundle.crt
    masterPublicURL: https://master.example.com:8443


