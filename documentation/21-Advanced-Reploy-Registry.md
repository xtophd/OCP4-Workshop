# 21 Advanced: Delete and Redeploy Registry with Persistent Volume


*These steps merely delete and redeploy a registry with default settings*  Goal is to rewrite this unit to delete the default registry and redeploy with persistent storage on the backend.


    [root@master master]#  oc get pods
    [root@master master]#  oc delete all -l docker-registry=default
    [root@master master]#  oc get pods
    [root@master master]#  oc adm registry
    [root@master master]#  oc get pods

Instructions for PV backed Registry coming soon

== End of Unit

link:https://github.com/xtophd/OCP-Workshop/tree/master/documentation[Return to Index]
