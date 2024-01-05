# Packet Handling in the Kernel
The Linux kernel is responsible for translating between packets, and a coherent stream of data for programs. In 
particular, we will look at how the kernel handles connections because routing and firewalling, key things in 
Kubernetes, rely heavily on Linux’s underlying packet management.
