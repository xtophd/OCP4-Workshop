## Deploy a fresh OCP router

An OpenShift route is a way to expose a service by giving it an externally-reachable hostname like **appname.cloud.example.com**.  The HAProxy template router implementation is the reference implementation for a template router plug-in. It uses the openshift3/ose-haproxy-router repository to run an HAProxy instance alongside the template router plug-in.

Before running `oc delete` try running `oc get pods` to verify a router pod is running.  Afterwards, inpect the pods again to verify the pod it was terminated.  Finally, restart a fresh router.  Again, you can use `oc get pods` to verify the pods were started and successfully enter a **Running** state

    [root@master master]#  oc get pods
    [root@master master]#  oc delete all -l router=router
    [root@master master]#  oc get pods
    [root@master master]#  oc adm router --replicas=2 --service-account=router
    [root@master master]#  oc get pods

## Deploy a fresh OCP registry

Likewise, delete and recreate a registry.

    [root@master master]#  oc get pods
    [root@master master]#  oc delete all -l docker-registry=default
    [root@master master]#  oc get pods
    [root@master master]#  oc adm registry
    [root@master master]#  oc get pods
