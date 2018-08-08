NOTE: *This exercise is still in active development and will likely not work until flagged as completed*

= 11 Hello World(s) via WebUI

== 11.1 Sign-on as admin

Use Firefox to Sign-On as use admin

https://master.example.com:8443

Select Advanced button

Scroll Down

Select Add Exception button

Select Confirm Security Exception

Proceed to Sign-On as user admin with the password set during the Users and Roles unit.

== 11.1 Create a Project

Go To Front Landing Page

Select **Create Project** *{Top Right}*
Name: webui-hello
Display Name: WebUI Hello World
Description: *{leave blank}*

== 11.2 Create an Application from a Container Image

Using the Search bar, search for **httpd** and select the *QUICKSTART HTTPD*

Select **Next>**

Add to Project: WebUI Hello World

Git Repository URL: https://github.com/xtophd/OPC-Workshop

Select "Advanced Options"

Context Directory: /src/helloworld

Hostname: webui-hello.cloud.example.com

Application Hostname: webui-hello.cloud.example.com

Select **Create**


You just instructed openship to create a new application called **webui-hello**:
  - The container was deployed to a node and brought online.

Now let's have a closer inspection.

```
: [root@master ~]#

oc status
    
oc get pods
    
oc get services
```

The IP address shown for the service is the internal non-routable network for the pod.  From any node in the cluster, we can test the pod for application functionality before exposing the service to the public. 

```
: [root@master ~]#

curl -Is http://{ip_address}}:8080
```

== 11.3 Add a Route

Routers are the processes responsible for making services accessible to the outside world, so the routers must be reachable. Routers run as containers on nodes - therefore, the nodes where routers run must be reachable themselves.


== 11.4 Validate Application



== Conclusion

= End of Unit

link:https://github.com/xtophd/OCP-Workshop/tree/master/documentation[Return to Index]
