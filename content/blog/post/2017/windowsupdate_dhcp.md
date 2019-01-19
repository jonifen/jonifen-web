+++
type = "post"
description = "I have had a fair few people lately telling me that their Windows computers are struggling to connect to the Internet..."
date = "2017-01-30T20:13:29Z"
title = "Windows 8/10 computer not connecting to your network?"
author = "Jon"
tags = [
	"techsupport",
	"windowsupdate",
	"windows"
]

+++

I have had a fair few people lately telling me that their Windows computers are struggling to connect to the Internet. After doing some digging into the problem, it turns out that it could be related to a failed Windows Update that Microsoft initially issued in December 2016, but some computers are slow in picking up the update (or the owners are similar to me, and don't reboot very often to let updates take effect!)

One thing I must note though, is that while I have seen a PC affected by this, I haven't had the problem on any of my own computers, which puzzled me. However, I did realise that none of my computers are running an upgraded Windows 10 installation, they are all fresh installations of Windows 10. So perhaps this is part of the make-up of the issue?

The Register have created a few posts which give some useful information to get to the bottom of the problem, the best one being this one: http://www.theregister.co.uk/2016/12/12/ongoing_windows_8_10_dhcp_problems_affecting_all_isps/

So the official resolution is to reboot the computer... and if that doesn't resolve the issue, reboot again... and so on... until it fixes the issue. Which seems a bit crazy. So the alternative solution offered on The Register's article is probably a nicer option, so let's try that.

You need to open a Command Prompt window as an Administrator, which you can do as follows:

 * Click your Start button and type in `cmd` before pressing CTRL+ALT+ENTER together. This will pop up the UAC prompt to ensure that you do want to run the process as an Administrator. Click Yes to continue.
 * In the window that appears, type in the following commands. One line at a time, pressing Enter after each line:

		netsh winsock reset catalog
		netsh int ipv4 reset reset.log

 * Now reboot your computer. Make sure you actually restart the computer (as compared to doing a Shutdown/Power off and then power it back on).

In the cases I've had to look at, it's been a successful fix, so you *should* hopefully be back in business once the computer loads back up. However, if it hasn't resolved your problem, then head back to the website I linked to above (The Register) and see if there are any updates from people in the comments section at the bottom of the page.

Enjoy!
