---
author: "Jon"
date: "2014-01-18T22:36:00Z"
description: "Earlier today I booked places for me and my son on a Raspberry Pi day in Manchester and then realised I might struggle to get the TV there as it's pretty heavy, plus I doubt we'd be allowed it on a bus! Luckily, we still have the 19\" widescreen from the old living room PC, so I looked at using that instead."
tags: ["raspberrypi"]
title: "Raspberry Pi on a 19\" Widescreen (16:10) LCD Monitor"
type: "post"

---

Earlier today I booked places for me and my son on a Raspberry Pi day in Manchester and then realised I might struggle to get the TV there as it's pretty heavy, plus I doubt we'd be allowed it on a bus! Luckily, we still have the 19" widescreen from the old living room PC, so I looked at using that instead.

The monitor was made by Daewoo, I got it about 6 years ago (or there abouts) and it has a native resolution of 1440x900 at a refresh rate of 60Hz.

I dug out the HDMI-to-DVI cable and got to work trying to get it going. First of all, I checked the

	/boot/config.txt

file and (following the same page as when I got it going on the TV) made the following changes:

	hdmi_group=2
	hdmi_mode=47

to enable DMT mode (for a monitor) and set the resolution to 1440x900@60Hz.

Once that was saved, and a quick

	sudo shutdown -r now

later, I was greeted with the splash screen and then "No Signal". Bah! Something wasn't right. So I plugged it back into the TV and a reboot later, was back at the prompt to try again.

I tried

	tvservice -m DMT

to see what DMT modes the monitor supported, but it didn't find any. So I tried

	tvservice -m CEA

just in case and also got the prompt that no modes were found. So I eventually did a

	tvservice -d edid.dat

to dump the available options to file, then did a

	edidparser edid.dat

to parse the file onto the screen. Funnily enough, it told me the preferred mode was 1440x900@60Hz (DMT mode 47), so something wasn't right and further research was needed.

I tried several things according to the various forums and websites all to no avail before stumbling across this gem of information by popcornmix on STM Labs forum (link) which said:

	Simple solution is to add:
	avoid_safe_mode=1

Other people on the thread seemed to think that the OP was struggling with the Pi always booting in safe mode, so the trick was to stop it from doing that. I put into the bottom of my

	/boot/config.txt

file along with the following:

	hdmi_ignore_edid=0xa5000080
	config_hdmi_boost=4

After a reboot, I was in business! However, forcing the Pi to skip safe mode is obviously hiding a problem (why else would the Pi want to boot into safe mode otherwise?) so I have much more research to do, but at the very least I'm up and running in time for the Pi day next week. If anyone has any ideas as to where I'm going wrong, please let me know (catch me on twitter).