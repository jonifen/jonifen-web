---
type: "post"
title: "HP DM1-4027 Netbook locks up in Linux due to Thermal Event"
description: "Sometimes in Linux I've noticed that the laptop will lock up, often in high CPU situations."
date: "2020-01-01T00:00:00Z"
author: "Jon"
tags: ["techsupport", "dm1", "notes"]
---

Sometimes in Linux I've noticed that the laptop will lock up, often in high CPU situations. This appears to be caused by some sort of thermal support (or lack of) and after some research, you can disable the thermal support within the OS and allow the BIOS to take over instead.

This is done by editing the grub entry to add `thermal.off=1` at the end of the linux boot line which would result in the following (replacing `{uuid}` with your own UUID):

```
echo 'Loading Linux linux ...'
linux /boot/vmlinuz-linux root=UUID={uuid} rw quiet thermal.off=1
```

To make the change permanent, edit `/etc/default/grub` to update the following line with the `thermal.off=1` entry:

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet thermal.off=1"
```

and regenerate the grub config with

```
grub-mkconfig -o /boot/grub/grub.cfg
```


The laptop has an AMD E-450 APU installed and supports a maximum of 8GB ram.

Some other (perhaps useful) bits of info (according to `lspci`):
- GPU "element": AMD Radeon HD 6320 (Wrestler)
- wireless: Qualcomm Atheros AR9485 Wireless (rev 01)
- Ethernet: Realtek RTL8111/8168/8411 PCI Express Gigabit (rev 06)
