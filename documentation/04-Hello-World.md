**NOTE** *This exercise is still in active development and will likely not work until flagged as completed.*

# 4. Hello World

A "Hello, World!" program is traditionally used to illustrate the basic syntax of a programming language.  The program merely outputs or displays "Hello, World!" to a user. Due to it's simplicity in nature, it is often the very first program people write when learning a new language or platform.

This exercise will step through everything needed to bring a "Hello, World!" program online in our Openshift Container Platform.

## 4.1 Create a Project

The **project** is openshift's highest level construct.  Users, roles, applications, services, routes, et al... are all tied together in a **project** definition.  

    oc new-project helloworld --description="My First OCP App" --display-name="Hello World"

    oc get projects
    
    oc describe project helloworld
    
## 4.2 Create an Application from a Docker Image

We are not quite ready to start building our own container images, so we will leverage an existing available container from the dockerhub registry (built by Red Hat a while back ago for demo purposes).

    oc new-app registry.access.redhat.com/rhscl/httpd-24-rhel7 --name=hello-app

So here What just happened?  We specifed the create of a new application call **hello-app**.  Openshift examined the specified container lable and likely determined it was not available locally. So OCP reached out to dockerhub, initiated a download and stored the image in our local registry.  Once that was completed, the container was deployed to a node and brought online.

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


## 4.6 Making an authentic "Hello, World!"

### Solution #1 - Change Security Attributes

For our first solution, we are going to adjust the current project's security attribute to enable some minor modifications to a running pods.  We begin by connecting to the console of our current running application and exploring inside the active container.

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

So first things first, we need to adjust the uid used to run this container.  So, exit the containers shell and return back to the prompt on master.example.com.  Next edit the project attributes to adjust the uid for the container process.

    exit
    
    oc edit namespace helloworld
    
Adjust the following parameter

    openshift.io/sa.scc.uid-range: 1001/10000

Delete and Redeploy our Pod

    oc delete all --all
    
    oc get pods

    oc rsh {{ POD NAME }}

    id
    
    exit

Notice how we did not need to rerun "oc new-app"?

To save time and avoid the complexity of editing an HTML file, we will just copy an exist file into the running container.

    oc cp /var/tmp/helloworld.html {{ POD NAME }}:/var/www/html/index.html
    
    curl http://helloworld.cloud.example.com


### Solution #2 - Use emptyDir

    oc new-project helloworld2 --description="My First OCP App" --display-name="Hello World"
    oc new-app registry.access.redhat.com/rhscl/httpd-24-rhel7 --name=hello-app2
    oc set volume dc/hello-app2 --add --mount-path /var/www/html --type emptyDir
    
    oc expose service hello-app2 --name=hello-svc2 --hostname=helloworld2.cloud.example.com
    
    oc get pods
       
    oc cp /var/tmp/hello-world.html {{ POD NAME }}:/var/www/html
    
    curl http://helloworld.cloud.example.com


### Solution #3 - Use NFS


### Solution #4 - Use Source Control (git)


## 4.7 Clean Up

    oc delete all --all
    
    oc delete project helloworld

## Conclusion
