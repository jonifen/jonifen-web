+++
author = "Jon"
date = "2016-03-12T18:43:12Z"
description = "Reinstalling a computer is usually simple. So why have Samsung made it difficult?"
tags = ["techsupport", "hardware", "family"]
title = "Reinstalling a Samsung NC10+ Netbook = Painful"
type = "post"

+++
I've had to do a restore on a Samsung NC10+ which is an Atom N450 based netbook from a few years back. But for some reason, the recovery stuff just won't work and I've had to do a clean install of Windows. And the Samsung support website... well, it's not much support at all. In fact, I don't think they even remember releasing the NC10+. Only the original NC10.

Luckily, Windows 7 installs drivers for most things, but missing the two important ones... Video and Wireless. So after a long hunt, I've found the needed drivers to be:

### Wireless
The wireless adapter is the Broadcom BC4313. It has Hardware Ids of:

	PCI\VEN_14E4&DEV_4727&SUBSYS_051A185F&REV_01
	PCI\VEN_14E4&DEV_4727&SUBSYS_051A185F
	PCI\VEN_14E4&DEV_4727&CC_028000
	PCI\VEN_14E4&DEV_4727&CC_0280

Lenovo have drivers for it: http://support.lenovo.com/gb/en/downloads/ds008111

### Video
The video adapter is the Intel GMA 3150. I found a driver for Windows 7 32-bit on the Intel website (which I could get to once the wireless was up and running!)

### Bluetooth
Bluetooth is Broadcom BCM2070 Bluetooth 3.0 + HS USB Device. Windows 7 installs it using the Microsoft driver by default.

### Chipset
The main chipset is Intel's NM10. Windows appears to install pretty much everything that is needed. But I installed the Intel INF chipset utility for the NM10 chipset anyway to be on the safe side.

<br/><br/>
This has probably been my most painful reinstall job of all time... and I've reinstalled a lot of PCs over the years! Just when I thought all was going well, Windows Update decided to play up too. Argh!
