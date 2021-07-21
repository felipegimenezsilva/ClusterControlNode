# ClusterControlNode

Creates a debian node container to connect with cluster control via SSH.
This 'tutorial' was created using docker in rootless mode, so not make use
of swarm.

## Run ClusterControl image with SSH Port

To permit the Cluster Control connect with others containers, we need to get the public
key, and include in authorized_keys file. To get the public key of Cloud Control, use:

```
docker exec -it cluster_control_container bash
cat /root/.ssh/id_rsa.pub
```
Copy the content, and put in 'authorized_keys' file.

## Build the Node image

On root folder, run:

```
docker build -t node .
```

This will build a Debian image with SSH. In the next steps, is needed 
configure the SSH.

## Running and Configuring the node

Before run the node, is needed to map the SSH port, to allow connections
with SSH. In this case, the SSH is mapping in port 7000. All containers
must have SSH configured in the same PORT, becauses Cluster Control
apply the same configuration to connect for each node. The port 35000
is used to permit connection with the DATABASE SERVICE. 

```
docker run -itd -p 7000:22 -p 35000:35000 --name node_cc node bash
```

The next step is create the certificates, and change the root password of each
Node container.

```
docker exec -it node_cc bash
ssh-keygen
passwd
service ssh restart
```

Add each node in Cluster Control Service:

```
ssh-copy-id <container-ip> -p 7000
```
