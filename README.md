# Microproject - Cloud Computing

In this project, three virtual machines are created using Vagrant. The objective of this project is to implement a service mesh (cluster) with the help of Hashicorp Consul. For this, Consul agents are run on two nodes (two virtual machines), each of which hosts a web application (NodeJS). In this way, a cluster with two nodes will be implemented. 

In addition, load balancing is implemented using HAProxy. Clients send requests to the HAProxy load balancer and get a response from the two web servers. That is, the requests are not made directly to the web servers, but the load balancer decides which server will be in charge of processing the request. This load balancer is implemented in the third Vagrant virtual machine. 

Finally, the Shell provisioner is used to automatically provision the virtual machines running the web servers and the HAProxy.
