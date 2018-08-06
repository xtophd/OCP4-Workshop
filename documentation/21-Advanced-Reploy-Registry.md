# 21 Advanced: Deploy Registry with Persistent Volume


*These steps merely delete and redeploy a registry with default settings*


    [root@master master]#  oc get pods
    [root@master master]#  oc delete all -l docker-registry=default
    [root@master master]#  oc get pods
    [root@master master]#  oc adm registry
    [root@master master]#  oc get pods

Instructions for PV backed Registry coming soon
