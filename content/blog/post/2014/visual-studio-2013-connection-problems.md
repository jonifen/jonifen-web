+++
author = "Jon"
date = "2014-05-29T12:31:00Z"
description = "Since installing Update 2 on the work laptop, I've been unable to check for available updates through the Tools > Extensions & Updates screen as it always timed out."
tags = ["techsupport", "c#", "visualstudio"]
title = "Connection problems in Visual Studio 2013"
type = "post"

+++

Since installing Update 2 on the work laptop, I've been unable to check for available updates through the Tools > Extensions & Updates screen as it always timed out.
If I continued working (without closing the IDE), it would eventually prompt me through the Notifications pane that it required credentials for the company proxy. Once I did that, it'd report updates etc. but over the last couple of days, that is no longer happening either.

I ended up going into the devenv.exe.config file in the installation folder and editing the system.net child element for IPv6 to set the attribute value to false (was previously set to true). On reloading VS2013, all worked fine without even prompting for credentials.

What bugs me is that it only started since installing Update 2, yet there's very little out there to suggest it's a bigger issue than the odd one or two.