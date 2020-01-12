---
date: "2017-05-21T21:09:27+01:00"
title: "iPad appears in Windows 10, but not showing in iTunes"
type: "blog"
author: "Jon"
description: "I have an aging iPad2 which is getting on a bit but still works fine, but often won't appear in iTunes, but is showing in Windows 10 as a device in 'This PC'..."
tags: [
  "techsupport",
  "hardware"
]

---

I have an aging iPad2 which is getting on a bit but still works fine, but often won't appear in iTunes, but is showing in Windows 10 as a device in 'This PC'.

I find it usually happens after an iTunes update when the iPad was plugged in already, and it seems Windows throws in a generic driver when the Apple drivers are removed as part of the upgrade process. To solve the problem, I do the following:

 * Unplug the iPad from the computer and close iTunes.
 * Go to "Apps & Features" (or "Programs & Features" in an earlier Windows version) and find "Apple Mobile Device Support". Click it and choose "Modify".
 * In the screens that appear, select "Repair" and continue. It should reinstall the drivers needed for iTunes to recognise the iPad.
 * Once complete, plug the iPad back in and enjoy being able to sync the iPad in iTunes again!

This is how I got it to work, if you're finding other ways also work well, give me a shout through Twitter and I'll give credit on here for any alternative solutions.