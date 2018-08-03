
# 5 Openshift Infrastructure Overview

## 5.1 Glossary of Terms

| Term |  |
|-----:|--|
| **kubernetes**          | technology used by the Red Hat OpenShift Container Platform to deploy, maintain, and scale containerized applications across a set of containers or hosts. |
| **container runtime**   | packages, instantiates, and runs the containerized applications
| **master**              |   |
| **node**                |   |
| **haproxy**             |   |
| **etd**                 |   |
| **pod**                 |   |
| **service**             |   |
| **service end point**   |   |
| **pv**                  |   |
| **pvc**                 |   |
| **role**                |   |
| **project**             |   |
| **attribute**           |   |
| **label**               |   |
| **image**               |   |
| **image-stream**        |   |
| **docker**              |   |
| **source-to-image (S2I) |   |
| **CRI-O**               | implementation of the Kubernetes CRI (Container Runtime Interface) to enable OCI compatible runtimes (ie: it's is a lightweight alternative to using Docker) |


## Component Relationships

|Cluster Components|                             |
|------------------|-----------------------------|
|**master(s)**     | API Server<br>etcd<br>Controller Manager Server<br>HAProxy - API load balancer |
|                  |                             |                 
|**nodes**         | HPProxy - Service Routers   |



