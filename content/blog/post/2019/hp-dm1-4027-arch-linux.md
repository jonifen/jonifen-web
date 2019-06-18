---
type: "post"
description: "I've recently started to use a HP DM1-4027ea as a replacement for the Asus Eee 1005P netbook. The 4Gb RAM (upgradable to 8Gb) and more powerful CPU/GPU combo meant that it should give reasonable performance where the Eee struggles (downloading npm modules and browsing script/image heavy websites)..."
date: "2019-04-19T22:15:18Z"
title: "HP DM1-4027 and Arch Linux"
author: "Jon"
tags: [
	"techsupport",
	"linux"
]
---

I've recently started to use a HP DM1-4027ea as a replacement for the Asus Eee 1005P netbook. The 4Gb RAM (upgradable to 8Gb) and more powerful CPU/GPU combo meant that it should give reasonable performance where the Eee struggles (downloading npm modules and browsing script/image heavy websites).

The HP DM1-4027ea comes with an AMD E-450 APU which consists of a dual core 1.6GHz CPU and a Radeon HD6320 GPU, so on paper should still be acceptable for current mobile demands.

The HP works _okay_ in Windows 7 and 10, but I thought with an SSD and Arch Linux, it could be a perfect mobile workhorse. However, things didn't go quite according to plan as first of all, it gets pretty warm very quickly, and it would completely lock up seemingly at random, and I'd have to fully power it off before powering it back on.

After digging around online, I found other people with a similar issue (AMD E-450 APU locking up in Linux), and the solution was to edit the grub entry to add `thermal.off=1` at the end of the linux boot line which would result in the following (replacing `{uuid}` with your own UUID):

```
echo 'Loading Linux linux ...'
linux /boot/vmlinuz-linux root=UUID={uuid} rw quiet thermal.off=1
```
