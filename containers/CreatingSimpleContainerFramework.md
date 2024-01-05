# Creating a Simple Container Framework

## The UTS Namespace
```shell
unshare -u /bin/bash
hostname
echo you should see your old hostname

# let us change the UTC namespace hostname
hostname test
hostname 
echo you should see test

# before you exit open another terminal 
lsns | grep /bin/bash
echo you should see
echo uts         1 125288 root             /bin/bash
# close the terminal

# exit namespace
exit
```

The command **unshare -u /bin/bash** creates the uts namespace and executes our process (/bin/bash) within that 
namespace. The careful reader might observe that if we don’t change the hostname after entering the namespace, 
we still get the hostname of the host. This is not desirable, as we need a way to set this before executing our 
program within the namespace.

This is where we will explore writing a container using Golang (also called Go) and then set up namespaces before 
we launch the process within the container.

## Building a Container with a Namespace
Let’s revisit Linux namespaces briefly before we build the container. Namespaces are in the Linux kernel, similar to 
sandbox kernel resources like file systems, process trees, message queues, and semaphores, as well as network 
components like devices, sockets, and routing rules.

Namespaces isolate processes within their own execution sandbox so that they run completely isolated from other 
processes in different namespaces.

There are six namespaces:
* PID namespace: The processes within the PID namespace have a different process tree. They have an init process with a PID of 1.
* Mount namespace: This namespace controls which mount points a process can see. If a process is within a namespace, 
it will only see the mounts within that namespace.
* UTS namespace: This allows a process to see a different namespace than the actual global namespace.
* Network namespace: This namespace gives a different network view within a namespace. Network constructs like ports, 
iptables, and so on, are scoped within the namespace.
* IPC namespace: This namespace confines interprocess communication structures like pipes within a specific namespace.
* User-namespace: This namespace allows for a separate user and group view within the namespace.

We don’t discuss the cgroup namespace here, which also allows the cgroups to be scoped into their own namespaces.

### Run utc example
```shell
cd containers/container-framework
go build utc.go
sudo ./utc

# list name space run this command from another terminal
lsns | grep /bin/bash
echo you should see: uts         3 126091 root             /bin/bash

# another way of getting same result
ls -li /proc/self/ns/uts

##clean up
exit
```

### Adding More Namespaces
```shell
cd containers/container-framework
go build manyns.go
sudo ./manyns

lsns | grep /bin/bash
echo you should see: 
echo        NS TYPE   NPROCS    PID USER   COMMAND
echo 4026531834 time        2 127335 nobody /bin/bash
echo 4026531835 cgroup      2 127335 nobody /bin/bash
echo 4026532822 user        2 127335 nobody /bin/bash
echo 4026534863 mnt         2 127335 nobody /bin/bash
echo 4026534864 uts         2 127335 nobody /bin/bash
echo 4026534865 ipc         2 127335 nobody /bin/bash
echo 4026534866 pid         2 127335 nobody /bin/bash
echo 4026534867 net         2 127335 nobody /bin/bash

# another way of getting same result
ls -li /proc/self/ns/uts

##clean up
exit
```
We have the namespaces this container belongs to. Now we see that the ownership belongs to **nobody**. This is because we 
also used a user-namespace as a clone flag. The container is now within a new user-namespace. User-namespaces require 
that we map the user from the namespace to the host. Since we have not done anything yet, we still see nobody as the user.

### user mapping
```shell
cd containers/container-framework
go build manyns.go
sudo ./manyns

lsns | grep /bin/bash
echo you should see: 
echo 4026531834 time        3 128861 root /bin/bash
echo 4026531835 cgroup      3 128861 root /bin/bash
echo 4026532822 user        3 128861 root /bin/bash
echo 4026534860 mnt         3 128861 root /bin/bash
echo 4026534863 uts         3 128861 root /bin/bash
echo 4026534864 ipc         3 128861 root /bin/bash
echo 4026534865 pid         3 128861 root /bin/bash
echo 4026534866 net         3 128861 root /bin/bash

# another way of getting same result
ls -li /proc/self/ns/uts

# see users
whoami
echo you should see root

id
echo you should see: uid=0(root) gid=0(root) groups=0(root)



##clean up
exit
```
You can see that we have UidMappings and GidMappings. We have a field called ContainerID , which we are setting to 0. 
This means we are mapping the uid and gid 0 within the container to the uid and gid of the user who launched the process.

There is one interesting aspect I would like to touch upon in the context of user-namespaces. We don’t need to be the 
root on the host in order to create a user-namespace. This provides a way to create namespaces and thereby containers 
without being the root on the machine, which means it’s a big security win as providing root access to a process can 
be hazardous. If programs are launched as the root, any compromise to those programs can give root privileges to the 
attacker. In turn, the whole machine gets compromised.

We can technically be non-root on the host and then create a user-namespace and other namespaces within that 
user-namespace. Mind you, all the other namespaces, if launched without a user-namespace, will need root access.

If we take the previous example, where we are passing all the flags together, the system first creates a user-namespace 
and places all the other namespaces within that user-namespace.

The same holds for setting up virtual network devices like veth pairs in order to wire containers to the host. Having 
said that, there has been momentum in the area of rootless containers, which allow developers to run containers without 
the root. If you want to read about this in more detail, you can explore this topic at the following: 
https://rootlesscontaine.rs/ and https://github.com/rootless-containers.


