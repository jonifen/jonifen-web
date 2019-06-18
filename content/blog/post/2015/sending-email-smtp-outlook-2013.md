---
author: "Jon"
date: "2015-08-28T00:09:00Z"
description: "Recently I've noticed that I've not been able to send emails in Outlook 2013 on the desktop computer. It's been working fine on my laptop, but the desktop no such luck."
tags: ["techsupport", "email"]
title: "Sending email via SMTP on Outlook 2013"
type: "post"

---

Recently I've noticed that I've not been able to send emails in Outlook 2013 on the desktop computer. It's been working fine on my laptop, but the desktop no such luck.

The error I was getting was "Error 0x800CCC13 Cannot connect to the network". I tried a few different things, but to no avail.

After researching online, I found that doing the following fixes it:
+ Close Outlook before continuing.
+ Run a command prompt as administrator
+ Run sfc /scannow and allow to complete.

Reload Outlook now, and try sending an email.