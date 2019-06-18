---
author: "Jon"
date: "2014-01-01T18:30:00Z"
description: "I was lucky enough at Christmas for my wife to surprise me with a Raspberry Pi. I've wanted one for some time but never got around to actually ordering one."
tags: ["raspberrypi"]
title: "Raspberry Pi & Hannspree 37\" TV"
type: "post"

---

I was lucky enough at Christmas for my wife to surprise me with a Raspberry Pi. I've wanted one for some time but never got around to actually ordering one. My wife always asks me when she's faced with techie decisions which made it an even bigger surprise.

Anyway, I've spent the last few days getting it up and running but my son realised earlier that it didn't seem to have any sound coming through the TV set, so I've spent the last couple of hours reading and trying stuff out and I think I've gotten to the bottom of the problem.

I started by running the following command:

	sudo amixer cset numid=3 2

I needed to edit the /boot/config.txt file to include the following:

	hdmi_group=1
	hdmi_mode=20
	hdmi_force_edid_audio=1

To quickly explain each line (from what I understand of things at least):
* hdmi_group - this defines whether it should run in 16:9 or 4:3 mode and affects what modes are available.
* hdmi_mode - this defines the resolution you're after using. I picked 20 based on my TV supporting 1080i @ 50Hz.
* hdmi_force_edid_audio - this forces the Pi to send audio down the HDMI cable whether the TV reports support for it or not. This is what solved my sound problems, the others just made things clearer.

At this point I realised that the first character of every line was missing off the edge of the screen, so I went back into the /boot/config.txt file and added the following lines:

	overscan_left=16
	overscan_right=16
	overscan_top=0
	overscan_bottom=0

This solved the hidden text off the sides but I still had black borders top and bottom. I tried using negative values for the top and bottom overscan entries but I found the console text got slightly distorted so I reverted back to 0. I'll tackle that another day, as it looks great for now.

References
Thanks to svennefenne at the RaspberryPi.org forums (link) as their response got me onto the right track for fixing my problem.

The elinux.org website (link) contains a list of available hdmi_mode values and what they represent. They also briefly describe the overscan entries in the file too.