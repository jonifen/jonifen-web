---
type: "post"
title: "Arch Linux on Macbook Air"
date: 2026-03-18T20:32:05Z
author: "Jon"
tags: ["linux", "arch", "macbookair"]
---
A few months back I was looking for a "beater" laptop - a cheap device that can go (almost) anywhere and take a few bumps along the way that I'm not too bothered about. Sure I have my MacBook Pro, but even after 4 years, it's still in great condition and I'd like to keep it that way.

After the usual hunt for Lenovos, and realising they hold their value better than they used to, I needed to think outside of the box. And that's when I saw the MacBook Airs from 2015. After a few attempts, I managed to find one on eBay that was near to home and already had a bump or two but was in good working condition. I got lucky with the spec too... a 2015 MacBook Air with an i7-5650U processor, 8GB RAM, 1TB NVMe and a battery with only 11 charge cycles.

I deliberated with OCLP to install a more recent MacOS, but then decided to go with Arch with KDE Plasma. I wanted to retain a fresh install of MacOS Monterey though in a dual boot setup, just in case, so I partitioned the drive and got going by following a mix of the directions on the official Arch Linux installation guide, and steps from [AdhamNasr on GitHub](https://github.com/AdhamNasr/MacBookAir-ArchLinux-i3)'s guide. I didn't go with i3 as I'm not a tiling environment fan and I've used KDE for over 20 years.

## Internet access while installing the OS

I had to plug in a USB to Ethernet adapter to get internet access whilst installing Arch Linux. This wasn't a big deal as my desk is close to a switch anyway.

## For wifi

Install the `broadcom-wl-dkms` package via pacman.

## Boot menu

You'll find that MacOS will appear in the systemd-boot OS list. You can't chain load into MacOS this way - I didn't spend long trying to fix it, because it wasn't important to me, and I ended up setting the following in my `/boot/loader/loader.conf` file:

```bash
default Arch
timeout 0
editor no
auto-entries no
auto-firmware no
```

Now, it just boots Arch straight away and I can hold the `Option` key when powering on if I need to boot MacOS.

## Keyboard layout

My MacBook Air is a standard UK model, so it has the UK ISO layout, with the `@` above the `2` and `#` on the `3` key with `£`. In Plasma, I went to System Settings, Keyboard and then selected the "Apple | Apple Aluminium (ISO)" option from the "Model" dropdown.

It took me a while to figure out that the hash key wasn't on `Option`+`3` like on MacOS. But actually, if you use the `Right Option` key (Linux sees this key as `AltGr`) with `3`, it works a treat! It is a quirk of course, but I'm OK with that.

## Conclusion

I've been using the MacBook Air for about 3 months now, and it's been absolutely spot on for what I need - a machine that I can take to a coffee shop, leave on the arm of the sofa when the dog's having a mad half hour, and have in the boot of my car when I've nipped into the shops. There's quite a few of them out there with similar spec for sub-£100, and for the size and weight and if you replace the battery, you'll have a device that can last hours.
