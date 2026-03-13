---
author: "Jon"
date: "2014-02-09T14:47:00Z"
description: "I have a Canon 350D which I was struggling to download the photos from onto the computer since upgrading it to Windows 7 64-bit."
tags: ["photography", "techsupport"]
title: "Installing a Canon 350D on Windows 7 x64"
type: "post"

---

I have a Canon 350D which I was struggling to download the photos from onto the computer since upgrading it to Windows 7 64-bit. I'd looked around for drivers, but Canon haven't made any 64-bit drivers for that camera (we have had it nearly 8 years) so I was wondering how I'd get around the problem. I eventually came across the site of someone else in the same situation who has blogged the following:

Quote from [helgeklein.com](http://helgeklein.com/blog/2009/08/canon-eos-350d-and-windows-7-x64-where-are-the-drivers-canon/)

	After neglecting my good old Canon EOS 350D for some time, I took some pictures with it yesterday, which I wanted to transfer to my laptop, of course. And there the trouble started.

	My instinctive action (remove the memory card and insert it into the laptop’s card reader) did not work. I remembered that Canon sticks to the compact flash format for some reason, for which no laptop know to man has a built-in reader.

	OK, second try: connect the camera via USB (luckily it has a standard micro USB socket). I still knew that the EOS 350D does not present its data via a simple Windows drive letter (that would probably be too easy). No, you have to install a driver from Canon . So I waited while Windows 7 contacted Windows Updated, only to report that no driver was available. Hmpf!

	Then I visited Canon’s German driver site, found no driver for Windows 7 (who would have thought otherwise, by now?) but decided to try my luck with the Vista driver. Downloaded it, ran the installer, but it reported it did not support my Windows version. Thinking I could still outsmart the thing I activated the Vista compatibility mode for the installer, but still no luck.

	Then it struck me: I am using the 64-bit version of Windows 7. I went to Canon’s driver site again only to find that they do not have a single 64-bit driver! Where are those guys living, or better: when? Last millenium?

	With my hopes down, I turned to Google as a last resort, not expecting much. How mistaken I had been! The very first hit pointed to the forums at vistax64.com, where a very simple solution was offered:

	Change the camera’s USB connection mode from “PC” to “Print/PTP”.

	While this sounds illogical, it works like a charm. Windows 7 instantly recognized the device and I had no problem whatsoever copying my images over.

So I gave it a go and voila! All working fine and the photos pulled down onto the computer without any issues.
