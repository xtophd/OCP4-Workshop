**NOTE** *This exercise is still in active development and will likely not work until flagged as completed.*

# 4. PHP Container Example

A "Hello, World!" program is traditionally used to illustrate the basic syntax of a programming language.  The program merely outputs or displays "Hello, World!" to a user. Due to it's simplicity in nature, it is often the very first program people write when learning a new language or platform.

This exercise will step through everything needed to bring a "hello world" program online in our Openshift Container Platform.

## 4.1 Create a Project

The **project** is openshift's highest level construct.  Users, roles, applications, services, routes, et al... are all tied together in a **project** definition.  

    oc new-project helloworld --description="My First OCP App" --display-name="Hello World"

    oc get projects
    
    oc status

## 4.2 Create an Application from a Docker Image

We are no quite ready to start building our own container images, so we will leverage an existing available container from the dockerhub registry (built by Red Hat a while back ago for demo purposes).

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

    curl -Is http://helloworld.cloud.example.com

## 4.4 Welcome is not "Hello, World!"

We are going to fix the running application by connecting to the console and exploring inside the active container.

    oc get pods

    oc rsh {{ POD NAME }}

    id
    uid=1000120000 gid=0(root) groups=0(root),1000120000
    
Normally things go here, but this filesystem is read only.  And my 'id' is *root*.  How strange!

    cd /var/www/html/

Let's edit the file here instead


     cd /opt/rh/httpd24/root/var/www

     oc cp {{ src }} {{ pod:/dst }}

OR, set the UID for the proces

spec.template.spec.containers.securityContext.runAsUser



    vi index.html

Contents of the file should read as follows.  Save your file when complete.

    <html>
    Hellow, World!
    </html>
    
    
    
    
    

    


## 4.6 Clean Up

    oc delete all --all
    
    oc delete project helloworld

## Conclusion
