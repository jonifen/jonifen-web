+++
author = "Jon"
date = "2015-06-06T08:26:00Z"
description = "About a fortnight ago, I changed to an android handset after having iPhones for the last 4 years. I had decided on an LG G3 which turns out to come preinstalled with McAfee Mobile Security... Which is fine... Or would be if it worked properly."
tags = ["mobilephones", "techsupport"]
title = "McAfee Mobile Security"
type = "post"

+++

About a fortnight ago, I changed to an android handset after having iPhones for the last 4 years. I had decided on an LG G3 which turns out to come preinstalled with McAfee Mobile Security... Which is fine... Or would be if it worked properly.

I use an app for my online banking. When I load it up, it complains that there is no security product installed.
If I open up McAfee manually, and go back into my banking app, it doesn't complain. So maybe it *does* work?!

Perhaps not. As I usually have my phone on the wireless charger overnight, I set it to perform a scheduled scan at 3am every day. One might think this is overkill, but that's irrelevant as it never runs the scheduled scan anyway. So last night, I kicked off a full scan manually before going to sleep. I woke up this morning and it tells me that it was cancelled after 3 minutes and 17 seconds. I didn't cancel it, as I fell asleep as soon as my head hit the pillow last night. I'm guessing the phone went into a deep sleep type mode and killed it off. This would certainly explain why it never runs the scheduled task at 3am then!

So, unless I sit there constantly tapping the screen to stop the phone from going to sleep (which I am doing while typing this on the computer), it'll never complete a scan. Which is pretty shite.

Which brings me to my point. How do I uninstall it to install an alternative? I've googled this for the last couple of days as I've always been suspect of it, but found nothing of use. It appears LG have a cheeky deal with McAfee and it comes installed as a system app. The only way to get rid is to root the device... something I'm not willing to do.

McAfee have provided [these instructions](http://service.mcafee.com/FAQDocument.aspx?lc=1033&id=TS101407), but they don't work as the Uninstall option is never available.

I've contacted LG Support to find out if I can get rid. I'll keep you posted.

**Update 08/06/2015**
I received an email from LG. They weren't very useful...

	Good afternoon Jon
	Thank you for your query regarding your LGD855, I will help you as best as I can.
	I do hope you are having a lovely day so far.
	Unfortunately as McAfee is a pre-installed Google application we have no control as to how to disable this feature. If you have further questions you will need to contact Google in regards to this because even that Lg made the phone Google created the OS on the handset.
	I am glad you have not decided to root your device as this will void your warranty.
	I hope my email has resolved your request. Please have a nice day and thank you for contacting LG

So, I've sent another request in, as my response didn't get a reply (unsurprisingly!) but I'm not holding my hopes up at all.
Just to add, that since I sent my initial query into LG, none of the scheduled scans have run. It always manages to check for definition updates though, but never able to run the scans.

**Update 12/06/2015**
I got the time to send in another request. I commented on the last response being complete bull and got the following response:

	Hi Jon,
	Thank you for your reply, I apologise the issue still persists.
	I regret to inform you that the programme cannot be uninstalled as it is integrated with the Android platform.
	You can however disable it and download another app of your choice which you can utilise as your AV protection.
	If it is a sole issue with the McAfee programme, it may be of benefit to you to contact them directly and see if they have a solution to the issue you are facing.
	I know this email is short and sweet but I hope I have answered your query to your satisfaction.

So, not entirely helpful. Being aware of how multiple anti-virus applications can cause other issues, I'm uncomfortable with just disabling it. I was about to reply, but decided to go to bed instead. Before I did though, I changed the settings on McAfee from a daily scheduled scan 1hr after definitions update check, to a weekly scan 15mins after the definitions update check but for the next morning. Would you believe it? It actually ran and the details to that effect show in the activity log.
Convinced it was a fluke, I changed it to run the next morning too. It ran then too, without a problem. So now I think it's settled, I'll just keep an eye on it in the future to make sure everything continues in this way. Fingers crossed.
