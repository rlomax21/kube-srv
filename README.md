# How To
## Prerequisites
- GNU/make: requires make to utilize the wrapper command to build the stack
- docker: the stack uses the docker kubernetes driver but will work with others
- kubectl: the stack requires the kubectl command be installed locally
- minikube: the stack works well with the minikube cluster, but can work with others
- git: git is required to setup the codebase

## Setup
- cd into the repository root folder and run `make setup` to run the stack
- run `make destroy` in order to destroy the stack

## How it works:
The Makefile acts as a wrapper for the kubectl commands to create and destroy the stack using all required files in the `conf.d` folder and remove all expected modules that are created by the wrapper<br>
There are 2 images with matching dockerfiles that are created:
- The nginx container installs the nginx apk and copies a config file
- The monitoring agent installs kubectl and copies over a shell script that will be used to monitor the nginx service
The yaml files are used to configure the kubernetes stack<br>
The yaml files in the meta folder refer to shared resources; the filesystem and the role<br>
The nginx service runs with init containers that spawn the html file used to show the static web page; this file is stored in a persistent file system that is shared by the 2 deployments<br>
The monitor deployment runs a script that will check the IP addresses of the pods and modify the html file<br>
The monitoring agent uses the rbac permissions to gain access to the kubectl api and resources<br>
After running the `make setup` command you can run `kubectl get services` to find the exposed port for the nginx service<br>
You can then reach the web page at `http://$(minikube ip):$(service Nodeport)`

## Notes:
- The app was originally intended to use local storage mapping but the docker driver provisioner overrides the `no-provisioner` storage class and thusly that went unused
- Using the storage class, the wrapper was originally intended to manage the files and copy them from te repo into the shared filesystem which rendered the `www` folder contents unused. They are instead created on the fly with the init container

# Bonus
## Availability:
Availability can be achieved with a customized replicaset configuration, coupled with a horizontal autoscaling policy, and using a loadbalancer configuration in the cloud rather than using the Nodeport
## Response SLA:
This setup would be capable of handling high amounts of traffic if spawned on a node with high network speeds due to the low processing power behind the app, the scale could increase many times over with no overhead. This app does not allow successful failover in emergency situations and would require the differing modules for the load balancing and storage management to allow true HA between nodes
## Monitoring:
A monitoring agent could run alongside any of the services running similarly to the IP monitor setup. Even in a clustered setup a monitoring agent could connect to the kubectl manager to track details of nodes and kubernetes metrics for the entire cluster