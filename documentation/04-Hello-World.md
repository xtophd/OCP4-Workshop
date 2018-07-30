**NOTE** *This exercise is still in active development and will likely not work until flagged as completed.*

# 4. Hello World

A "Hello, World!" program is traditionally used to illustrate the basic syntax of a programming language.  The program merely outputs or displays "Hello, World!" to a user. Due to it's simplicity in nature, it is often the very first program people write when learning a new language or platform.

This exercise will step through everything needed to bring a "Hello, World!" program online in our Openshift Container Platform.

## 4.1 Sign-on as admin

In Unit 3, you created an admin user which we will utilize for this exercise.

    ssh master.example.com

    oc login admin
    password: ********
    
    oc project default
    

## 4.1 Create a Project

The **project** is openshift's ... yada yada ...  Users, roles, applications, services, routes, et al... are all tied together in a **project** definition.  

    oc new-project helloworld --description="My First OCP App" --display-name="Hello World"

    oc get projects
    
    oc describe project helloworld
    
## 4.2 Create an Application from a Docker Image

We are not quite ready to start building our own container images, so we will leverage an existing one available from the RedHat's Container Registry.

    oc new-app registry.access.redhat.com/rhscl/httpd-24-rhel7 --name=hello-app

You just instructed openship to create a new application call **hello-app**:
  - Openshift check the local registry for a copy of the image
  - Wasn't available, so Openshift fetched it from Red Hat and added it to the local registry
  - The container was deployed to a node and brought online.

Now let's have a closer inspection.

    oc status
    
    oc get pods
    
    oc get services

    curl -Is http://{ip_address}}:8080

## 4.3 Add a Route

*Be sure that you succesfully deployed a new router with sufficient replicas to have one on each node.  Dnsmasq does not support round-robin on a wildcard entry.  I am also exploring using nodeSelector to have the router run on the master*

Routers are the processes responsible for making services accessible to the outside world, so the routers must be reachable. Routers run as containers on nodes - therefore, the nodes where routers run must be reachable themselves.

    oc expose service hello-app --name=hello-svc --hostname=helloworld.cloud.example.com

We can also monitor the deployment of the application by running the following command.  This command will exit once the deployment has completed and the web application is ready.

    oc rollout status dc/hello-app



    oc get routes
        
    
## 4.4 Validate Application

    curl http://helloworld.cloud.example.com

## 4.5 Exploring the Container

Now we will take a moment to poke around the container namespace.  We need the pods full name in order to connect to a shell within the container.

    oc get pods

    oc rsh {{ POD NAME }}

Now that you have connected to the active container, have a look around

    id
    uid=1000120000 gid=0(root) groups=0(root),1000120000
    
    
    ps -ef
    UID         PID   PPID  C STIME TTY          TIME CMD
    default       1      0  0 14:26 ?        00:00:03 httpd -D FOREGROUND
    default      24      1  0 14:26 ?        00:00:00 /usr/bin/cat
    default      25      1  0 14:26 ?        00:00:00 /usr/bin/cat
    default      26      1  0 14:26 ?        00:00:00 /usr/bin/cat
    default      27      1  0 14:26 ?        00:00:00 /usr/bin/cat
    default      28      1  0 14:26 ?        00:00:18 httpd -D FOREGROUND
    default      29      1  0 14:26 ?        00:00:18 httpd -D FOREGROUND
    default      31      1  0 14:26 ?        00:00:18 httpd -D FOREGROUND
    default      35      1  0 14:26 ?        00:00:18 httpd -D FOREGROUND
    default      37      1  0 14:26 ?        00:00:18 httpd -D FOREGROUND
    default      74      0  0 17:50 ?        00:00:00 /bin/sh
    default      84     74  0 17:50 ?        00:00:00 ps -ef

Normally files serverd by httpd go into /var/www/html, but security-conscious random uid does not have permissions to write to this directory (or any other directory than the tmp dirs).

    cd /var/www/html/

When you are done exporing, exit the shell and return to command-line of master.example.com

    exit

## 4.6 Making an authentic "Hello, World!"

### Solution #1 - Change Security Attributes

For our first solution, we are going to adjust the current project's security attribute to enable some minor modifications to a running pods.  We begin by connecting to the console of our current running application and exploring inside the active container.
    
    oc edit namespace helloworld
    
Adjust the following parameter

    openshift.io/sa.scc.uid-range: 1001/10000

Delete and Redeploy our Pod

    oc delete all --all
    
    oc get pods

    oc rsh {{ POD NAME }}

    id
    
    exit

To save time and avoid the complexity of editing an HTML file, we will just copy an exist file into the running container.

    oc cp /var/tmp/helloworld.html {{ POD NAME }}:/var/www/html/index.html
    
    curl http://helloworld.cloud.example.com

**REMINDER** The solution you just completed is NOT a recommended solution on how to deploy a container for production use.  This solution was provided to touch on a few concepts unique to the Openshift Container Platform: container design, project attributes, process uid/gid in a containerized environment, etc...

### Solution #2 - Use emptyDir

    oc new-project helloworld2 --description="My Second OCP App" --display-name="Hello World II"
    oc new-app registry.access.redhat.com/rhscl/httpd-24-rhel7 --name=hello-app2
    oc set volume dc/hello-app2 --add --mount-path /var/www/html --type emptyDir
    
    oc expose service hello-app2 --name=hello-svc2 --hostname=helloworld2.cloud.example.com
    
    oc get pods
       
    oc cp /var/tmp/helloworld.html {{ POD NAME }}:/var/www/html
    
    curl http://helloworld2.cloud.example.com

If you happen to rsh into the container namespace, have a look at the permissions of /var/www/html.  You will notice that it matches the process uid.

Although it is not considered a best practice to inject files into a container during runtime, this method has it's niche applications.  What it important to note is the any filesystems mounted with emptyDir and non-persistant and will be destoyed when the container is stoppped.


### Solution #3 - Use Source Control (git)


    oc new-project helloworld3 --description="My Third OCP App" --display-name="Hello World III"
    oc new-app registry.access.redhat.com/rhscl/httpd-24-rhel7~https://github.com/OCP-Workshop-HelloWorld --name=hello-app3
    
    oc expose service hello-app4 --name=hello-svc4 --hostname=helloworld4.cloud.example.com
    oc get pods
    
    oc rollout status dc/hello-app
    
    curl http://helloworld3.cloud.example.com


### Solution #4 - Use NFS


**NOTE** This section is not verified yet and does not work 100%

The purpose is not to boil the ocean with "Hello, World!".  Rather we are trying to provide basic principals of how a container functions.  So with that in mind, our last solution will be to utilize some network storage (ie: NFS) to provide the common source for our helloworld web server.

During the pre-installation phase of this lab, the host workshop.example.com was configured with an NFS server and an export called /exports/helloworld.  Let's simply mount that within the container to demonstrate our "Hello, World!" again.

    oc new-project helloworld4 --description="My Fourth OCP App" --display-name="Hello World IV"
    oc new-app registry.access.redhat.com/rhscl/httpd-24-rhel7 --name=hello-app4
    
    oc create -f nfs-pv.yml
    oc create -f nfs-claim.yml
    
    oc set volume dc/hello-app4 --add --mount-path /var/www/html --type persistentVolumeClaim --claim-name=nfs-claim1

    oc expose service hello-app4 --name=hello-svc4 --hostname=helloworld4.cloud.example.com

    oc get pods

    curl http://helloworld4.cloud.example.com



## 4.7 Clean Up

One last view of everything we have done thus far.

    oc get pod --all-namespaces -o wide

Now it is time to clean everything up.

    oc project default
    
    oc delete project helloworld
    oc delete project helloworld2
    oc delete project helloworld3
    oc delete project helloworld4

    oc get pod --all-namespaces -o wide

## Conclusion
