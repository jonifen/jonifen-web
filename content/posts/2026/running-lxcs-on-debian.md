---
type: "post"
title: "Running LXCs on Debian"
date: 2026-07-03T22:33:44Z
author: "Jon"
tags: ["linux", "homelab", "lxc"]
---

I discovered that you can run LXC containers on Debian without needing Proxmox. Sure, you miss out on the great tooling that Proxmox has, but it's useful when you're working with limited resources... which I am.

This follows on to my previous post where I talked about `keepalived` where I used it for providing resiliency to my home DNS. This time, I'll be moving my second container onto another machine.

The machine in question is a Dell Wyse 3040. Originally intended as a thin client for companies, they're a bit limited in terms of spec, with an Intel Atom Z-8350, 2GB RAM and only 8GB of eMMC flash storage. But they sip electricity, and DNS isn't that power hungry, so surely they'd be good enough for my use case here?

Proxmox isn't a fan of eMMC flash storage, and 2GB would be a struggle to run it anyway, so I needed another option.

## An explanation of my "as-is" on the Wyse 3040

**NOTE:** I should explain the setup of my Wyse 3040 before we start.

It's got a static IP of 192.168.1.9 configured in `/etc/network/interfaces` with the relevant gateway and DNS configured.

It has an SSD in a USB enclosure (labelled "wyse-ssd") connected to one of the USB 2.0 ports (the enclosure has compatibility issues with the USB 3.controller), which is set up to store the logs and the LXC containers to preserve the eMMC for as long as possible.

| Path         | SSD Path     |
| ------------ | ------------ |
| /var/log     | /mnt/ssd/log |
| /var/lib/lxc | /mnt/ssd/lxc |

And these paths were all configured in `/etc/fstab`:

```
LABEL=wyse-ssd  /mnt/ssd  ext4  defaults,noatime,nodiratime  0  2
/mnt/ssd/log  /var/log  none  bind  0  0
/mnt/ssd/lxc  /var/lib/lxc  none  bind  0  0
```

## Install the necessary packages on the host OS

But now we can start, so let's install the `lxc` package!

```bash
apt install lxc
```

I took a backup of my second Proxmox container for AdGuard Home, and copied it across to the Wyse 3040, before setting it up with a bash script courtesy of Claude and you can [view it here](https://raw.githubusercontent.com/jonifen/homelab-stuff/refs/heads/main/scripts/restore-pve-lxc.sh).

I restore the container now, but don't start it yet as I have a few other things to change first...

## Network bridge configuration

To set up the network for the container, you've got to do the following:

Install the `bridge-utils` package and create a bridge network device called `br0`

```bash
apt install bridge-utils
brctl addbr br0
```

Once you've done that, you need to set up the network side of things to use the bridge instead and you do this by updating `/etc/network/interfaces`:

Updating your existing network connection (in my case `enp1s0`) to change it to manual:

```
auto enp1s0
iface enp1s0 inet manual
```

and then adding `br0` in:

```
auto br0
iface br0 inet static
address 192.168.1.9
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 192.168.1.20
bridge_ports enp1s0
bridge_stp off
bridge_fd 0
```

And now update the network interfaces file on the LXC container (you'll find it in `/var/lib/lxc/adguard02/rootfs/etc/network/interfaces`) to be manual, as the connection will be configured by the host via `lxc` rather than configured within the container itself:

```
auto eth0
iface eth0 inet manual
```

Once this is done, we have to set up the network configuration for the container and we do that by editing `/var/lib/lxc/adguard02/config` and adding the following (of course, ensure any existing `lxc.net.0` values are replaced with the below - and adjust the IPs and names to your own setup):

```
lxc.net.0.type = veth
lxc.net.0.link = br0
lxc.net.0.name = eth0
lxc.net.0.flags = up
lxc.net.0.ipv4.address = 192.168.1.23/24
lxc.net.0.ipv4.gateway = 192.168.1.1
```

## Start the container

And now we make sure the `adguard02` container is stopped on the Proxmox machine (you don't want to encounter an IP clash!) before starting the LXC on the Wyse.

```
lxc-start -n adguard02
```

If your setup is similar to mine, and you've followed the steps, you should have the container running successfully, and you should be able to browse to the AdGuard Home web interface too.

I've found this super useful, because I'm now able to perform updates more regularly on my Proxmox machine and accept that sometimes it will need a reboot and not be concerned about the impact on DNS, because now it's more resilient, there is no impact on DNS!

## Some useful commands for interacting with `lxc`

```bash
# Start an LXC container (this starts a container called "adguard02")
lxc-start -n adguard02

# Start an LXC container with the stdout logs being written to screen
#   Note that to stop it, you must hit CTRL+C multiple times, or it'll just restart it.
lxc-start -n adguard02 --foreground 2>&1 | head -50

# Stop an LXC container
lxc-stop -n adguard02

# List all the containers "installed" on the machine with basic status in a nice format
lxc-ls --fancy

# Attach to a container (essentially, log on to a container's shell)
lxc-attach -n adguard02
```
