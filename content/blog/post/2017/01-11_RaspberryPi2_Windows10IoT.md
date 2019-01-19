+++
author = "Jon"
tags = [
  "raspberrypi",
  "hardware",
  "iot"
]
date = "2017-01-11T06:30:33Z"
title = "Windows 10 IoT on a Raspberry Pi 2"
type = "post"
description = "I thought it a good idea to spend some time looking at Windows 10 IoT edition on my Raspberry Pi 2, this post describes my experiences in getting it set up..."

+++

I thought it a good idea to spend some time looking at Windows 10 IoT edition on my Raspberry Pi 2. I've been looking at this since it was first announced a while back, but never actually got around to having a proper look into it and getting it installed on one of our Pis.

What kit do I have then?

* Raspberry Pi 2
* Edimax EW-7811Un Nano USB Wireless Dongle (which turned out to be unsupported, but there is a workaround - details to come later)
* Official Power Supply (the white Raspberry Pi 2.1A model)

First of all I need to get the operating system downloaded. I found the Windows IoT Dashboard software available for free from Microsoft (I downloaded it from https://developer.microsoft.com/en-us/windows/iot/Downloads.htm) and installed it onto my laptop ready to go. This software allowed me to specify that it is intended for running on a Raspberry Pi (it lists the Pi 2 and 3 - I assume the Pi 1 isn't powerful enough?) so I followed the steps and created my MicroSD card ready to go.

I booted up the Pi with my keyboard and mouse attached, it quickly loaded to the splash screen (which "regular" Windows 10 will be familiar with), but it hung around on this splash screen for some time (my Pi took a few minutes - I think part of this delay may be related to my choice of MicroSD, so I may start again with a quicker SD card at a future date).

I was eventually presented with the Windows 10 IoT screen, but I was unable to connect to my wireless network as it could not see my Wifi adapter because it was unsupported. I plugged in an ethernet cable instead and it got a connection fine, but I might need wifi, so I spent a bit of time figuring that out. It turned out, I wasn't alone with my hardware configuration. A lot of people own a Pi with the Edimax adapter and were campaigning for Microsoft to add support on various forums and websites (such as https://social.msdn.microsoft.com/Forums/en-US/05fe7028-3d1b-454e-a4e8-f614374390a1/installing-usb-wireless-edimax-driver?forum=WindowsIoT). Luckily, Edimax has released a driver specifically for the Raspberry Pi 2 for use with Windows 10 IoT!

On the Microsoft forum, Dano63 compiled all previous advice in the thread into the following steps:

1. Download the driver zip from http://www.edimax.com/edimax/download/download/data/edimax/global/download/for_home/wireless_adapters/wireless_adapters_n150/ew-7811un
2. Put SD card in PC and copy the 3 files that were in the zip to <sdcard>:\temp. Then eject.
3. Put SD card in the Pi and boot.
4. Connect with Powershell (detailed in https://ms-iot.github.io/content/en-US/win10/samples/PowerShell.htm)
5. cd to c:\efisp\temp
6. Run the command below.
devcon install netrtwlanu.inf "USB\VID_7392&PID7811"
I got a "RemoteException" but it worked anyway.
7. exit powershell session
8. Restart Pi
9. Go to http://minwinpc:8080/wifimanager.htm to configure.

I called my Pi "jonpi2", so would need to use this name in place of "minwinpc" for step 9 above.

Ok, so let's go through how it went for me (it wasn't entirely straight forward)...
Steps 1 to 3 worked fine. However, when I reached step 4, I opened Powershell **as admin** and entered the following:

	Enter-PSSession -ComputerName jonpi2 -Credential localhost\Administrator

However, this failed with the following error message:

	Enter-PSSession : Connecting to remote server jonpi2 failed with the following error message : The WinRM client cannot
	process the request because the server name cannot be resolved. For more information, see the
	about_Remote_Troubleshooting Help topic.
	At line:1 char:1
	+ Enter-PSSession -ComputerName jonpi2 -Credential localhost\Administra ...
	+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	+ CategoryInfo : InvalidArgument: (jonpi2:String) [Enter-PSSession], PSRemotingTransportException
	+ FullyQualifiedErrorId : CreateRemoteRunspaceFailed

Maybe WinRM isn't set up properly? So I tried the following:

	winrm quickconfig

And allowed it to make any changes suggested before adding my Pi to the trusted hosts list (remember what you named your Pi here!):

	winrm set winrm/config/client '@{TrustedHosts="jonpi2"}'

I tried to connect via Remote Powershell again. It took a little while to connect but I got a powershell prompt.

So I continued with Steps 5 and 6, which worked fine (step 6 took a while), and I rebooted the Pi afterwards and went to the WifiManager page while still connected over Ethernet. Once I had connected to my wireless router, I pulled the Ethernet cable and it all worked fine!

Hope this helps anyone in the same situation anyway.
