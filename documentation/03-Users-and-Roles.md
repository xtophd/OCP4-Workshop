# 3 Users & Roles

## 3.1 Configure Admin User

At this time, we have not configured any additional user accounts or roles.  So our first activity will be to do just that.

The OCP installation parameters used to install this cluster automatically configured user credentials to be defined in **/etc/origin/master/openshift-passwd** and managed  by the commandline utility **htpasswd** (ie: httpd-tools).  This configuration is defined in **/etc/origin/master/master-config.yaml** on the host **master.example.com**.

### Inspect the master-config.yaml

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

### Add admin user

Add the user *admin* with password *redhat*

    [root@master master]# htpasswd -b /etc/origin/master/htpasswd admin redhat

## Assign cluster-admin role

Provide the *admin* user with the *cluster-admin* role

    [root@master master]# oc adm policy add-cluster-role-to-user cluster-admin admin

## Use new admin credential

Now you can use this new credential to log into Openshift.  Remember that you declared the password for use *admin* above when you ran **htpasswd**.

    oc login -u admin
    password: ********
