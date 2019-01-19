+++
author = "Jon"
date = "2014-05-22T21:34:00Z"
description = "The genuine battery died a few months back on the \"bricktop\" (a Sony Vaio C2M/W), and with the hard drive starting to click, I just dumped it on the side and gave up with it. After trying to persist with an Atom N450 netbook (Visual Studio usage is soul-destroying on an Atom CPU!), I've dug it back out and ordered a new battery from Amazon and the Intel 40Gb SSD that was on offer at Ebuyer for 20 quid."
tags = ["techsupport"]
title = "Sony Vaio C2M/W, Lubuntu 14.04 and a new battery"
type = "post"

+++

The genuine battery died a few months back on the "bricktop" (a Sony Vaio C2M/W), and with the hard drive starting to click, I just dumped it on the side and gave up with it. After trying to persist with an Atom N450 netbook (Visual Studio usage is soul-destroying on an Atom CPU!), I've dug it back out and ordered a new battery from Amazon and the Intel 40Gb SSD that was on offer at Ebuyer for 20 quid.

Anyway, the SSD is yet to arrive, but the battery arrived today. Clipped it in and it's not a perfect fit (the clips don't fully engage and it's a black battery in an otherwise silver chassis) but that's not too big an issue... as long as it works right?

So, the laptop powered on but Lubuntu wouldn't boot. It seemed to be hanging after grub with a black screen. Plugging the AC Adapter in to reboot sorted it, and I can unplug after it's booted and run on battery OK. It just wouldn't boot on battery.

Eventually, I tried a few different things. Amending the /etc/default/grub file to remove "quiet splash" from the GRUB\_CMDLINE\_LINUX\_DEFAULT property didn't solve the problem. I've found setting it to "acpi=off" works, but that's a little drastic as I lose battery details, so I've changed it to "nolapic" and all seems fine. So in the end, I had to do the following:

	sudo nano /etc/default/grub

Change the GRUB\_CMDLINE\_LINUX\_DEFAULT property to be "nolapic", save the file (CTRL+O) and exit back to bash (CTRL+X). Then run:

	sudo update-grub

Which updates the grub menu list with the new setting, and then I rebooted with the AC Adapter unplugged.

So far, so good... I have battery info and I can even change screen brightness from the keyboard shortcuts (Fn+F5/F6) - something I couldn't do in Windows without a load of Sony crapware!