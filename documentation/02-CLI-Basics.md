# 2. Command Line Basics

The default and recommended method for interacting with the Openshift Container Platform with the `oc` command.  In limited circumstances you could be directed to use other tools to invoke action or retrieve data from OCP.

## 2.1 Become the root user

Your workshop environment is preconfigured with distributed ssh-keys to ease the management of sessions from one host to another.  As the user *root* you can easily login to any host in your cluster.  With that said, ensure your session is user *root* on the host *workstation.example.com*.

    [student@workstation ~]$ sudo -i
    [root@workstation ~]#

## 2.2 Connect to host master.example.com

As mentioned, ssh keys have been distributed within the cluster to allow seemless connections without requiring the constant prompting for passwords.  If you are being promp

    [root@workstation ~]# ssh master
    [root@master ~]#

## 2.3 Establish OCP Admin session

    [root@master ~]# oc login -u system:admin
    
Now that you have logged in to Openshift uing the *oc* command, you are ready to start interacting with the Openshift Container Platfrom

## 2.4 Verify Cluster Status

### Check Projects

    [root@master ~]# oc get projects

Your output should look like this


### Check Cluster Status

    [root@master ~]# oc status

Your output should look like this

    



### Check Node Status

    [root@master ~]# oc get nodes

Your output should look like this

    NAME                 STATUS    ROLES     AGE       VERSION
    master.example.com   Ready     master    1h        v1.9.1+a0ce1bc657
    node1.example.com    Ready     compute   1h        v1.9.1+a0ce1bc657
    node2.example.com    Ready     compute   1h        v1.9.1+a0ce1bc657


### Check Pod Status

    [root@master ~]# oc get pods

Your output should look like this

    NAME                       READY     STATUS    RESTARTS   AGE
    docker-registry-1-52lk5    1/1       Running   0          1h
    registry-console-1-8qlb2   1/1       Running   0          1h
    router-1-q92xl             1/1       Running   0          1h

### Check the Logs

    [root@master ~]#

## 2.5 Configure Admin User

At this time, we have not configured any additional user accounts or roles.  So our first activity will be to do just that.

The OCP installation parameters used to install this cluster automatically configured user credentials to be defined in **/etc/origin/master/openshift-passwd** and managed  by the commandline utility **htpasswd** (ie: httpd-tools).  This configuration is defined in **/etc/origin/master/master-config/yml** on the host **master.example.com**.

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

### Add admin user

Add the user *admin* with password *redhat*

    [root@master master]# htpasswd -b /etc/origin/master/htpasswd admin redhat

### Assign cluster-admin role

Provide the *admin* user with the *cluster-admin* role

    [root@master master]# oc adm policy add-cluster-role-to-user cluster-admin admin

### Use new admin credential

Now you can use this new credential to log into Openshift

    [root@master master]# oc login -u admin
    
## Deploy a fresh OCP router

An OpenShift route is a way to expose a service by giving it an externally-reachable hostname like **appname.cloud.example.com**.  The HAProxy template router implementation is the reference implementation for a template router plug-in. It uses the openshift3/ose-haproxy-router repository to run an HAProxy instance alongside the template router plug-in.

Before running `oc delete` try running `oc get pods` to verify a router pod is running.  Afterwards, inpect the pods again to verify the pod it was terminated.  Finally, restart a fresh router.  Again, you can use `oc get pods` to verify the pods were started and successfully enter a **Running** state

    [root@master master]#  oc get pods
    [root@master master]#  oc delete all -l router=router
    [root@master master]#  oc get pods
    [root@master master]#  oc adm router --replicas=1 --service-account=router
    [root@master master]#  oc get pods

## Deploy a fresh OCP registry

Likewise, delete and recreate a registry.

    [root@master master]#  oc get pods
    [root@master master]#  oc delete all -l docker-registry=default
    [root@master master]#  oc get pods
    [root@master master]#  oc adm registry
    [root@master master]#  oc get pods
    
    
## Conclusion

    You now have a running cluster with an appropriate administrative user with proper credentials.
