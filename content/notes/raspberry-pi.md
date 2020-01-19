---
title: "Raspberry Pi"
type: "note"
---

### Laggy mouse on Raspberry Pi (Model 1b)

A few weeks ago I installed the latest (at the time) version of Raspbian onto a 4Gb SD Card thinking that I'd see whether it was worthwhile updating my main SD card or not.
I gave it a quick run and while it seemed quicker, the mouse was quite laggy as if the cursor was moving through treacle. After a quick search, I came across a report on the RaspberryPi Github where someone else was having the exact same problem where the mouse was moving "in slow motion".
To fix it, they did a kernel update on the Pi by doing:

	sudo rpi-update

and then once it was complete, I edited the

	/boot/cmdline.txt

file to add the following as the penultimate item (although I don't think the position of it really matters):

	usbhid.mousepoll=0

Once I had done that, I rebooted the Pi and the mouse issue was sorted!

For reference, I have the [TeckNet X500](http://www.amazon.co.uk/TeckNet-Wireless-Touch-Keyboard-Smart-White/dp/B00GSV6P18) which isn't a bad keyboard, but the touchpad takes a little getting used to. Plus, there's no back-slash '\' key once it's set up to the UK format (the keyboard is actually in US format) which disappointing, but not a deal breaker at that price.
