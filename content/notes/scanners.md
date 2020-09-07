---
type: "note"
title: "Scanners"
description: "Drivers and platform specific info."
---

## PrimeFilm 1800u Film Scanner

The drivers on the enclosed CD don't work in Windows 10.

I had a nosey around online and found [this post on the Microsoft Forum](https://answers.microsoft.com/en-us/windows/forum/windows_8-hardware/primefilm-1800u-film-scanner-need-windows-8-driver/577b09f0-dfa3-4a85-a661-28d3f1b6f669) where Jack Moorhouse gave some excellent advice (copied below for safety):

 * Google "How to install unsigned drivers on Windows 10 - By TotallydubbedHD" and follow instructions
 * Download & run the installer for the slide viewer (SF_ENG_1.3.exe) which is for windows up to 7. I ran it in vista sp2 compatibility mode.AT THIS POINT IT STILL DOESN'T WORK
 * Go to control panel -> device manager ->imaging devices and update the driver for the slide viewer from the folder c:\windows\Twain_32\cyberviewX_SF

I'll tweak the above to what worked for me:

 * I found the advised instructions by TotallydubbedHD on YouTube [video link](https://www.youtube.com/watch?v=StkR3D2d5WI)
 * I downloaded the drivers from [this website](http://www.avegene.com/sd.php) selecting "Driver/Firmware" > "Film Scanners" > "PrimeFilm 1800u/i & 1800 Silver-DISCONTINUED" and then after searching, downloading the Windows driver.
 * I then installed the drivers - I didn't have to run in compatibility mode as it seemed to cope just fine. However, in Device Manager, it said the drivers hadn't been loaded as they weren't signed.
 * I followed the TotallydubbedHD advice at this point.
 * Once I rebooted (after the instructions), I chose to update the driver (via Device Manager) and it installed fine.

The only problem I had was with the ButtonKey software - I had to run it as Administrator for it to save the settings (I suspect it's the classic issue where legacy programs are written to save to the registry in HKEY_LOCAL_MACHINE and non-Administrator accounts can't write to this location in Windows Vista and newer). It does work fine through Photoshop though, and the images are scanning in just fine!

-----
