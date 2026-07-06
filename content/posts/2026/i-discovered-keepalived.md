---
type: "post"
title: "I discovered keepalived"
date: 2026-07-03T22:33:43Z
author: "Jon"
tags: ["linux", "homelab", "networking"]
---
I've wanted to provide some resiliency to our home DNS setup for a while, mainly to stop needing to schedule any maintenance on my Proxmox "server", but also because it makes sense.

So after some investigation, and conversing with Claude, I discovered `keepalived`.

## What is keepalived?

Keepalived is a Linux daemon that provides high availability (HA) and load balancing for server clusters using the Virtual Router Redundancy Protocol (VRRP) to manage a virtual IP address, ensuring seamless failover and continuous service availability. It is commonly used in conjunction with other services like HAProxy and Nginx to enhance network resilience.

## Let's get it set up then!

To preserve our current DNS setup, I decided to set up 2 new AdGuard Home instances, and set them both up to use my existing Unbound instance for upstream DNS because it's already there and can handle the extra traffic at this stage.

The way that it works is that you'd set up the containers like normal with their own IPs, and then you select another IP which is a "virtual" IP which is handled by the keepalived daemon. In my setup, I created the first container on `x.x.x.21` and the second on `x.x.x.22` with the intention of using `x.x.x.20` as the "virtual" IP.

### The first container `x.x.x.21`

```bash
apt install keepalived
vim /etc/keepalived/keepalived.conf
reboot
```

And then I set up the keepalived config located at `/etc/keepalived/keepalived.conf` with the following content:

```
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass DnsPass1
    }

    virtual_ipaddress {
        192.168.1.20/24
    }
}
```

And then I rebooted the machine before checking the IP data (I have anonymised some aspects below):

```bash
root@adguard01:~# ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: eth0@if313: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether aa:aa:aa:aa:aa:aa brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.1.21/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet 192.168.1.20/24 scope global secondary proto keepalived eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::fe80:fe80:fe80:fe80/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
```

And as simple as that, we're good to go!

Well, not quite... we've only got one container set up!

### The second container `x.x.x.22`

I just shutdown the first container in Proxmox, and cloned it before updating the IP from .21 to .22 through the Proxmox UI and starting it up.

Now I need to update the `/etc/keepalived/keepalived.conf` file to configure it as the backup instance.

```
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 90
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass DnsPass1
    }

    virtual_ipaddress {
        192.168.1.20/24
    }
}
```

You might be saying that the two configs are very similar, and you'd be right.

The only differences are:

- the `state` property which can be "MASTER" or "BACKUP". `.21` is the master, so `.22` is the backup.
- the `priority` which should be set to 100 for the master, and something less than that for the backup (you can prioritise multiple backup nodes with this property too).

The virtual_router_id property and authentication password must be the same on both nodes for it to work.

After updating the config, I rebooted the second node, and checked the ip data afterwards (again, slightly anonymised).

```bash
root@adguard01:~# ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host noprefixroute 
       valid_lft forever preferred_lft forever
2: eth0@if313: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether aa:aa:aa:aa:aa:aa brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 192.168.1.22/24 scope global eth0
       valid_lft forever preferred_lft forever
    inet 192.168.1.20/24 scope global secondary proto keepalived eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::fe80:fe80:fe80:fe80/64 scope link proto kernel_ll 
       valid_lft forever preferred_lft forever
```

Hang on a sec, this container has the `.20` IP too? Yes, that's right. I'd stopped the `.21` container earlier, so despite this container being configured as the backup for `.20`, it proves that it works.
Starting the first container up again causes the `.20` IP to disappear from the second container's IP data though.

I then updated my router to issue the DNS in any DHCP response as `x.x.x.20`, and I was able to stop either container individually, and everything kept working!

Yes, you're right... there's 2 problems here.

1. I *do* have both containers running on the same machine, so if the machine reboots, then I'm still in the same situation that I was before I started! This was to prove it worked first, and I have plans to sort this out which I'll document separately.
2. When you don't specify a second DNS IP, sometimes a device might select its own. I'll go onto this next.

## Fixing the problem with only 1 DNS IP.

I mean, sure... I could just add each container with `.21` as primary and then `.22` as secondary. But it doesn't failover like keepalived does, so I looked into whether I could reverse the keepalived setup as an additional IP. And it turns out I can!

The plan is to have the following setup:

| IP | Master | Backup |
|--|--|--|
| `.20` | `.22` | `.23` |
| `.21` | `.23` | `.22` |

So this meant reconfiguring both DNS containers to free up the `.21` IP (because I'm a bit of a perfectionist, and because with 2 containers, I already have resiliency which gives me capacity to do the change!)

I changed the second container to `.23` first (had to also update the AdGuardHome.yaml content too). And then when I changed the first container to `.22`, the second container took the traffic.

So now I had `.21` free... and here we go with config changes again!

### First container keepalived.conf

```
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass DnsPass1
    }

    virtual_ipaddress {
        192.168.1.20/24
    }
}

vrrp_instance VI_2 {
    state BACKUP
    interface eth0
    virtual_router_id 52
    priority 90
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass DnsPass2
    }

    virtual_ipaddress {
        192.168.1.21/24
    }
}
```

### Second container keepalived.conf

```
vrrp_instance VI_1 {
    state MASTER
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass DnsPass1
    }

    virtual_ipaddress {
        192.168.1.20/24
    }
}

vrrp_instance VI_2 {
    state BACKUP
    interface eth0
    virtual_router_id 52
    priority 90
    advert_int 1

    authentication {
        auth_type PASS
        auth_pass DnsPass2
    }

    virtual_ipaddress {
        192.168.1.21/24
    }
}
```

So again, the additions to both configs look very similar again! They just need to have the same virtual_router_id and password values, and obviously the new virtual IP.

But after rebooting the containers, I had both .20 and .22 on the first container, and .21 and .23 on the second container. Exactly what I wanted!

Now I had this resiliency set up, I needed to progress to getting one of the AdGuard Home instances onto another machine. But I only have one Proxmox machine... so I needed to discover another option.

I have a Dell Wyse 3040... maybe this could work? I go into that in more detail in another post though.
