---
author: "Jon"
date: "2015-10-24T11:30:00Z"
description: "On a fresh install of Windows 10, I found I was unable to add a second user to the system (via All Settings) and constantly got the \"Something went wrong\" screen. I tried a few reboots but to no avail."
tags: ["techsupport", "windows10"]
title: "\"Something went wrong\" - Creating users on Windows 10"
type: "post"

---

On a fresh install of Windows 10, I found I was unable to add a second user to the system (via All Settings) and constantly got the "Something went wrong" screen. I tried a few reboots but to no avail.
A quick google found that a lot of people with laptops were having this problem, and removing the battery and running on AC power only appeared to resolve their problem, but I'm on a desktop... i.e. no battery.

So I reverted to an alternative route, by running (via Windows Key+R):

	control userpasswords2

and added the new user inside there.

Funnily enough, that works fine. But when I tried the "standard" route again (via All Settings), it appears something went wrong again. Very strange! But I got my account added anyway, so it's all good :-)

**Update - 31/10/2015**
I've since found that the profile created using the above method was unable to open JPG files into the Microsoft Photos app, instead getting the error "Invalid value for registry" appearing onscreen.
I tried a few things, including a powershell command to reinstall all pre-installed Windows Store apps (Photos/Mail etc.) but it was all to no avail.
Eventually, I removed the account from the existing admin account, and it let me recreate it through the normal route (via All Settings) without any hassle. Funnily enough, everything works now! (Have I just jinxed it by saying this?!)