---
author: "Jon"
date: "2016-01-08T22:54:03Z"
description: "Getting my fibre connection installed by an engineer meant I needed an ethernet router that supported PPPoE. 'Great!' I thought, as it meant I could dust off my trusty Buffalo router..."
tags: ["techsupport", "connectivity", "router"]
title: "Buffalo WHR-HP-G54 Fun (or not...)"
type: "post"

---
Out of contract with my previous supplier, I was free to find a new supplier. Luckily, one of the benefits of my job is that I get free fibre broadband, so it was a simple decision :)

Anyway, back to the point of my post.

I last used the Buffalo a few years back when on Virgin Media's "National" service (no longer available - a good thing as it was trash) when their supplied Netgear had weak wi-fi. Since then, there's been well documented problems with OpenSSL and the [Heartbleed](http://heartbleed.com) vulnerability and I was sure that the Tomato firmware running on the Buffalo would be affected. It turned out that as I was using an official release, [I was OK](http://wisercoder.com/router-affected-heartbleed-bug) but I still fancied trying [DD-WRT](http://www.dd-wrt.com) as it was the original reason for me buying the Buffalo in the first place.

To make the switch, I had to reset the NVRAM on the router, and then [re-flash back to stock Buffalo firmware](http://www.dd-wrt.com/phpBB2/viewtopic.php?t=71220), reset the NVRAM again, flashing DD-WRT and finally resetting the NVRAM *again* afterwards.

Everything went well and I was ready for installation day!

### Installation Day!
The Openreach engineer came and installed their modem and said everything was up and running and I should expect speeds of around 74/20 based off his line tests. Errr... nope! However, I've since found that the Buffalo router is struggling a little with performance. Wireless **coverage** is very good (as expected) but throughput is *very* weak, often dropping to 16Mbps (the router is G rated i.e. 54Mbps).

Unfortunately, it didn't stop there as wired performance was equally weak, maxing out at ~32Mbps downstream, but upstream wasn't around expected at around 18Mbps.

So I took the Buffalo out of the equation, plugging the PC into the modem and firing up a PPPoE connection and ran the tests. Wow, what a difference! I'm now looking at ~68Mbps downstream, but the same sort of upstream (~18Mbps). As experienced by [other](http://www.dd-wrt.com/phpBB2/viewtopic.php?t=28049) [people](http://www.linksysinfo.org/index.php?threads/whr-hp-g54-deadly-slow-and-weak.69741) on the Internet, it's becoming obvious the Buffalo can't cope and needs replacing :'(

### Router Replacements

So as I'm looking at replacements, I want to make sure I get something that'll do a decent job for a long time. My requirements are:

* Gigabit Ethernet connections
* Wireless-N (as a minimum)
* Must be capable of a PPPoE connection over Ethernet (so this meant it was essentially a "cable router")
* Must be capable of restricting Internet access to certain devices (so my son can't spend all night watching Minecraft videos on YouTube on his tablet)

Since looking into new routers, I've found the following out:

* 5GHz was finally "a thing" available to the mass market
* It was possible to have a router running on 2.4GHz and 5GHz simultaneously
* I could get a router with USB ports in to create mini-servers for hosting stuff on FTP (this would be *very* useful!) or making a regular USB printer accessible wirelessly (I wish I'd known this a few months ago :angry:)

So my requirements list grew... and eventually I ended up looking at £100+ routers. Ouch. Best drag that back a bit!

A recommendation from a colleague means that I'll try to pick up a TP-Link router tomorrow - it seems to have everything on my requirements list. Watch this space!
