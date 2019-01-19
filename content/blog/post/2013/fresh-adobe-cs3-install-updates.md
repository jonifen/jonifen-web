+++
author = "Jon"
date = "2013-03-24T22:38:00Z"
description = "We're not able to continually upgrade our Creative Suite version every time a new one comes out, so we're still on CS3."
tags = ["adobecs3", "photoshop", "techsupport"]
title = "Fresh install of Adobe CS3 but no updates available?"
type = "post"

+++

We're not able to continually upgrade our Creative Suite version every time a new one comes out, so we're still on CS3. Unfortunately though, I installed an SSD in the desktop yesterday which of course meant reinstalling it with CS3 from the discs. Everything seemed fine until I tried to run an update, at which point it complained with the following message:

*There are no updates available at this time.*
*Please note that some updates for the following products cannot be determined at this time: Adobe Updater*

I thought it a bit odd as I know that Photoshop has updated in the past following an install, so I couldn't understand what was wrong.

So a quick peek on the Internet and Bing came to the rescue with this link on the [Adobe Community Forum](http://forums.adobe.com/thread/941381).

It seems all I have to do is set the system clock back to before 1st June 2011 and re-run the updater and all will work fine.

Funnily enough, it did work fine so now I'm wondering who decided to hard code a date after which point the application would declare there were no updates available! Seems strange to me, but at least it sorted the problem out!
