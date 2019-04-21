+++
type = "post"
description = ""
date = "2019-04-19T22:15:18Z"
title = "HP DM1-4027 and Arch Linux"
author = "Jon"
tags = [
	"techsupport",
	"linux"
]
+++

I've been using an Asus Eee 1005P netbook as a small lightweight device for using while watching TV etc. but the 2Gb RAM limit and the dual core Atom CPU meant things were often a little laggy, especially when downloading npm modules or loading pages which are script or image heavy.

So, enter the HP DM1-4027ea. I originally bought this back in 2011, but it's been passed around the family a bit, and I got it back late last year so jumped at the chance to drop Windows and install Linux on it, so it could be the replacement for the Eee.

The HP has an AMD E-450 APU (dual core 1.6GHz CPU with a Radeon HD6320 GPU), 4Gb RAM with an 11.6" screen offering a resolution of 1366x768, so is an improvement over the Atom N450 with Intel 945GM graphics and 2GB ram with a 10.1" screen at 1024x600. However, things didn't go quite according to plan...

First of all, it would completely lock up seemingly at random, and I'd have to fully power it off before powering it back on. After digging around online, I found other people with a similar issue, and the solution was to edit the grub entry to add `thermal.off=1` at the end of the linux boot line.