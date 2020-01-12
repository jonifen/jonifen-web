---
author: "Jon"
date: "2016-06-16T22:32:00+01:00"
description: "Dell say they haven't carried out Windows 10 testing on their Vostro 3350 laptop, so owners are to continue at their own risk..."
tags: ["techsupport", "windows"]
title: "Dell Vostro 3350 Laptop with Windows 10"
type: "blog"

---

So this week I've bought an ex-corporate Dell Vostro 3350 with the intention of it replacing Di's aged Pentium D desktop which is struggling since the Windows 10 upgrade.
The laptop came pre-installed with Windows 10 Professional (a digital entitlement upgrade from the Windows 7 Pro that came on the laptop), and seemed quick enough. However, I'm not one to use a laptop as it comes, especially when it's not brand new. Plus I noticed some of the devices weren't installed correctly, so I took the opportunity to reinstall on the mechanical disk to ensure I have the right drivers before reinstalling onto the SSD that'll come out of the desktop.

Let the fun begin!

So I started by installing Windows 10 Professional x64. So far so good, except I need drivers as nothing seems to be working correctly. Including the wireless. Bizarre.

So first of all, let's check the BIOS version. Latest version is A10, which is installed. Excellent.

The wireless adapter detected my SSID, connected to it and even got an IP from DHCP, but had no throughput once connected. I got the drivers from the Dell site (R312132-Intel-Wireless-1702-Wifi-BT3.exe) and installed them. No joy though, it just seemed to kill the wireless adapter entirely. So I plugged in my Edimax nano USB adapter instead which worked great. I'll come back to the wireless later.

Windows updates kicked in as soon as it got online, it pulled down drivers for the Intel video adapter, and an AMD driver too? I didn't know it had switchable graphics? (It certainly wasn't installed pre-format). But yes, it does have switchable graphics!

The drivers seemed to work fine, until rebooting the laptop at which point the screen would show the Windows 10 splash screen, before going black for exactly a minute, then re-displaying the splash screen for about 2 seconds and then giving me the login screen. Weird, but definitely driver related. So I grabbed (from the Dell website):

* Vedio_Intel_W84_X00_A01_Setup-5PFY2_ZPE.exe
* Video_ATI_W8_X02_A00_Setup-HJNJ1_ZPE.exe

and installed them in that order. That fixed the black screen issue during boot-up. Nice!

Windows update also installed a driver for the Bluetooth/Wireless adapter too, and it revived the adapter, but still with no throughput (back at square one!) so I tried rolling back the driver through Device Manager, and the wireless sprung into life! Very strange, and I can't explain it (as the previous driver version was junk), but it has been working perfectly ever since.

I continued on to install the other devices, including the fingerprint sensor (which I can't work out how to configure and use!) and the free-fall sensor too.

So, now it's up and running, what have I got for my money and how does it improve the desktop? Ok, so...

<table>
  <thead>
    <tr>
      <td></td>
      <td>Laptop</td>
      <td>Desktop</td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Processor (CPU)</td>
      <td>Intel i3-2310M (2 Cores, 4 Threads)</td>
      <td>Intel Pentium D 950 (2 Cores, 2 Threads)</td>
    </tr>
    <tr>
      <td>Memory (RAM)</td>
      <td>2Gb (1x 2Gb) DDR3 SODIMM</td>
      <td>4Gb (4x 1Gb) DDR2</td>
    </tr>
    <tr>
      <td>Video</td>
      <td>Intel HD3000 & AMD 7640M</td>
      <td>AMD HD6670</td>
    </tr>
    <tr>
      <td>Storage (HDD)</td>
      <td>750Gb 5400rpm</td>
      <td>250Gb Sandisk SSD</td>
    </tr>
    <tr>
      <td>Size</td>
      <td>13" laptop, so quite small<br/>and surprisingly light!</td>
      <td>Massive.</td>
    </tr>
  </tbody>
</table>

So I've got 8Gb RAM on order (due in a few days). Once that arrives, I'll grab the SSD from the desktop too and reinstall it again. Luckily, the steps I detailed above have been recreated (I reinstalled the laptop again to prove I had the right drivers to create this post!), so all will/should (hopefully!) go according to plan.
