# ClusterControlNode

Creates a debian node container to connect with cluster control via SSH.
This 'tutorial' was created using docker in rootless mode, so not make use
of swarm.

## Run ClusterControl image with SSH Port

To this case, the port host:5000 show the SSL interface of Cluster Control (CC),
and the host:7000 allow us to connect in container SSH port.

```
docker run -d \
	--name cc \
	-p 5000:443 \
	-p 7000:22 \
	severalnines/clustercontrol
```

To permit connections, we need to configure a password to root inside the
CC container.

```
docker exec -it cc bash
passwd
```

## Build the Node image

On root folder, run:

```
docker build -t node .
```

This will build a Debian image with SSH. In the next steps, is needed 
configure the SSH.

## Running and Configuring the node

Before run the node, is needed to map the SSH port, to allow connections
with SSH. In this case, the SSH is mapping in port 7000, like the CC container.
You need to choose a different port of CC Container SSH if you intent to run
in images on the same machine.  

```
docker run -itd -p 7000:22 --name node_cc node bash
```

The next step is create the certificates, and change the root password of each
Node container.

```
docker exec -it node_cc bash
ssh-keygen
passwd
```

To give acess to CC container, apply this configuration in each node:
In this case, port_ssh_cc = 7000

```
docker exec -it node_cc bash
ssh-copy-id <ip_host_cc> -p <port_ssh_cc>
```
