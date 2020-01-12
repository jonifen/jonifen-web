---
author: "Jon"
date: "2015-10-31T20:31:00Z"
description: "Google brings up a complete bag of results when you search for \"svchost high cpu\" as it's been a well documented issue with the Windows Update service across the last couple of Windows versions (way back to XP as it happens!)"
tags: ["techsupport", "windows10", "windowsupdate", "svchost"]
title: "heavy cpu usage svchost windows10"
type: "blog"

---

Google brings up a complete bag of results when you search for "svchost high cpu" as it's been a well documented issue with the Windows Update service across the last couple of Windows versions (way back to XP as it happens!) so it was little surprise to find that the instance of svchost.exe that was eating CPU cycles was the one that was hosting the Windows Update service.

Dipping into the Settings screens of Windows 10, I got to the Windows Update section, only for it to show that it was on "Downloading Updates 0%" and remained at this point for a couple of hours without moving. I couldn't remember the process for fixing this issue in Windows 8 (as I have had it on another PC in the past), hence the need for Google.

Anyway, I found the advice I needed here.

I've shortened the post into a more brief style, which is as follows:

+ Run Command Prompt as admin (right click the Start button, select "Command Prompt (Admin)" and follow the UAC prompts until you get to the prompt.
+ Stop the Windows Update service - type `net stop wuauserv` (and press Enter)
+ Stop the BITS service - type `net stop bits` (and press Enter)
+ Go to `C:\Windows\SoftwareDistribution` in Explorer and delete everything inside (both folders and files)
+ Start the Windows Update service - type `net start wuauserv` (and press Enter)
+ Start the BITS service - type `net start bits` (and press Enter)
+ Go back into Windows Update, you should find that it starts downloading OK. If you're prompted to "Check Now" for updates, select that option.

Depending on how good your machine is, you may be waiting for some time for it to complete! Zzzzzz...