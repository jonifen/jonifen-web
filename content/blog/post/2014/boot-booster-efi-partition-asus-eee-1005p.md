+++
author = "Jon"
date = "2014-08-18T16:41:00Z"
description = "We have an Asus EeePC 1005P netbook which comes with the Intel Atom N450 CPU. The BIOS provides a \"Boot Booster\" option which caches POST information in a special partition on the hard drive to speed up the boot process."
tags = ["techsupport", "hardware"]
title = "Boot Booster (EFI) Partition on an Asus EeePC 1005P"
type = "post"

+++

We have an Asus EeePC 1005P netbook which comes with the Intel Atom N450 CPU. The BIOS provides a "Boot Booster" option which caches POST information in a special partition on the hard drive to speed up the boot process.
Unfortunately, as part of removing all the partitions from the hard drive, this "special" partition has been lost and I needed to recreate it.

You will need:

+ Windows installation media
+ Linux live media (I'm using a Lubuntu CD)
+ Plenty of time (it is an Atom CPU afterall!)

I've cleared the disk of all partitions using GParted (using the Lubuntu CD), and I've installed Windows 7. As part of installing Windows, I've selected a "Custom Installation" and specified a 60Gb (61440Mb) partition for it to be installed to. The Windows installation process adds an additional partition of 100Mb (containing boot information for Windows).

Once Windows is installed, I shut the netbook down and reboot from the Lubuntu CD. It's time to create the EFI partition.

+ Pull up a terminal window and type the following: `sudo fdisk /dev/(your drive id - mine was 'sda')` It should load fdisk into the terminal window.
+ Select 'n' (for a new partition), choose the default partition type ('p' - it must be a primary partition), allow the default partition number (mine was #3) and allow the default start sector. For the end sector, add 32767 on to the number specified as the start sector (32767/2 = 16383.5 i.e. 16384 == 16Mb). It will return you to the main fdisk prompt.
+ Select 't' (to change a partition system ID), select the partition number you accepted in the last step and enter the hex code 'ef' (for EFI).
+ Select 'w' (to write changes to disk and exit).
I can now reboot and re-enable the "Boot Booster" option in the registry.

Credit to the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Asus_Eee_PC_1005HA) for the Asus EeePC 1005HA (a different netbook model, but the process is the same).
