**NOTE** *This exercise is still in active development and will likely not work until flagged as completed.*

# 5. PHP Container Example

## 5.1 Create a Project

    oc new-project phpexample --description="My First PHP Application" --display-name="PHP Example"

    oc get projects
    
    oc status

## 5.2 Create an Application from a Docker Image

We are no quite ready to start building our own container images, so we will leverage an existing available container from the dockerhub registry (built by Red Hat a while back ago for demo purposes).

    oc new-app redhatworkshops/welcome-php --name=phpexample-app

Now let's have a closer inspection.

    oc status
    
    oc get pods
    
    oc get services

    curl -Is http://{ip_address}}:8080

## 5.3 Add a Route

*Be sure that you succesfully deployed a new router with sufficient replicas to have one on each node.  Dnsmasq does not support round-robin on a wildcard entry.  I am also exploring using nodeSelector to have the router run on the master*

Routers are the processes responsible for making services accessible to the outside world, so the routers must be reachable. Routers run as containers on nodes - therefore, the nodes where routers run must be reachable themselves.

    oc expose service phpexample-app --name=phpexample-svc --hostname=phpexample.cloud.example.com

    oc get routes
        
    
## 5.4 Validate Application

    curl -Is http://phpexample.cloud.example.com

## 5.4 Welcome is not "Hello, World!"

We are going to connect to the console and explore the active container.

    oc get pods

    oc rsh {{ POD NAME }}

## 5.6 Clean Up

    oc delete all --all
    
    oc delete project phpexample

## Conclusion
