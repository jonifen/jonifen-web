+++
title = "Intel Graphics Driver Crashes on XPS15"
description = "On my XPS15, I've noticed recently that the Intel graphics driver crashes a quite a bit (mainly when using Google Chrome). Although it recovers successfully, it's still pretty annoying."
type = "post"
author = "Jon"
tags = [
  "techsupport",
  "xps",
	"hardware"
]
date = "2017-01-10T21:43:11Z"

+++

On my XPS15, I've noticed recently that the Intel graphics driver crashes a quite a bit (mainly when using Google Chrome). Although it recovers successfully, it's still pretty annoying. A couple of days ago, I finally reached the end of my tether and started seriously looking for a solution (as compared to a quick Google search and then get distracted).

I came across a thread on Dell's community forum: http://en.community.dell.com/support-forums/laptop/f/3519/t/19658452 which discussed this problem.
Bas66 commented on here and provided instructions to obtain Beta version Intel drivers which should resolve the problem, and also how to install them (via a tutorial intended for MS Surface - http://www.windowscentral.com/how-install-intel-beta-graphics-drivers-surface, but it still applies albeit for a different graphic adapter model).

I've downloaded the 15.40 drivers from https://downloadcenter.intel.com/download/26229/Intel-Graphics-Driver-for-Windows-10-15-40-4th-Gen-?v=t (the zip file as per the instructions), unzipped to a local directory and manually installed the driver through Device Manager (opting to Update Driver in the Intel graphics adapter properties).

I've been running the new graphics drivers for a few days now, and so far all seems good! Hopefully it'll continue in this way. I'll keep this post updated with any changes in the future.
