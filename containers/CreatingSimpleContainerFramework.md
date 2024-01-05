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

Now let’s get our hands dirty and create a Go class called myuts.go. Copy the following snippet and use go build 
myuts.go to get the myuts binary. Also execute the myuts binary as the root user.
