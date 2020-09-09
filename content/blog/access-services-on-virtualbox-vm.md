---
author: "Jon"
date: "2015-05-22T22:15:00Z"
description: "In my current job I use a lot of virtual machines due to the variety of applications we support and the demand for them to work on many versions of Windows."
tags: ["techsupport", "virtualisation"]
title: "Access services on VirtualBox VM"
type: "blog"

---

In my current job I use a lot of virtual machines due to the variety of applications we support and the demand for them to work on many versions of Windows.
As a result, we do have web services that I'd run on a VM, but it's not possible to bridge the adapters (to allow external access to the VM) due to security guidelines at work, so I have to try something else.

All my VMs run using NAT for networking. I've set it to forward ports onto the guest OS from the host OS to get around the problems I've been having.

+ Load up the VM settings
+ Go to "Network" and expand the "Advanced" section to expose the "Port Forwarding" button.
+ Click that button
+ Add a new rule and give it a name
+ Leave the Host IP blank (unless your machine has multiple active network connections!), and insert a port number to use externally (I tend to use ports between 50000 and 51000 to avoid clashes).
+ Leave the Guest IP blank, and insert the port for the service (3389 for Remote Desktop, 80 for a website etc.)
+ Click OK etc. to get out of the options screen.

Now, on the external machine you connect to your host machine, but using the port number specified earlier for Host. All going according to plan, the request should forward onto the VM!