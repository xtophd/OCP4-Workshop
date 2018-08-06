
# Glossary

## Terms

| Term |  |
|-----:|--|
| **kubernetes**            | Technology used by the Red Hat OpenShift Container Platform to deploy, maintain, and scale containerized applications across a set of containers or hosts. |
| **container runtime**     | An implementation of Container Specification.  The implementation deals with packaging, instantiating, and running containerized applications.
| **master**                |   |
| **node**                  |   |
| **haproxy**               |   |
| **etd**                   |   |
| **pod**                   |   |
| **service**               |   |
| **service end point**     |   |
| **pv**                    |   |
| **pvc**                   |   |
| **role**                  |   |
| **project**               |   |
| **attribute**             |   |
| **label**                 |   |
| **image**                 |   |
| **image-stream**          |   |
| **image-registry**        | Service responsible for hosting and distributing images |
| **image-repository**      | Collection of images |
| **image-tag**             | Alphanumeric identifier attached to images within a repository |
| **docker**                |   |
| **source-to-image (S2I)** |   |
| **CRI-O**                 | implementation of the Kubernetes CRI (Container Runtime Interface) to enable OCI compatible runtimes (ie: it's is a lightweight alternative to using Docker) |


## Component Relationships

|Cluster Components|                             |
|------------------|-----------------------------|
|**master(s)**     | API Server<br>etcd<br>Controller Manager Server<br>HAProxy - API load balancer |
|                  |                             |                 
|**nodes**         | HPProxy - Service Routers   |

