+++
author = "Jon"
date = "2016-07-16T13:38:42+01:00"
description = "iPhone requires the Apple Id password to be entered on every free download (new free apps and updates)"
tags = ["techsupport", "apple", "mobilephones"]
title = "iPhone requires Apple Id password on free downloads"
type = "post"

+++

For a while my son's iPhone 5 has prompted for my Apple Id password everytime he tries to download a free app, or when updating his existing apps. It hasn't always done this, so something must have changed. I had a look around online, comparing advice to the settings on his phone, and all seemed fine, but it still asked for this password.

Earlier this morning, I did a backup, a factory reset and a backup restore. This didn't fix the problem either. Luckily, I came across this [Apple forum thread](https://discussions.apple.com/thread/7228121) where "Tunedport350" advises to do the following:

 * Go to Settings > General > Reset > Reset all settings

 And once the phone has reset and is ready for use again:

 * Go to Settings > General > Restrictions
 * Check the following:
  * iTunes Store: Enabled
  * Installing Apps: Enabled
  * Deleting Apps: Enabled
  * In-App Purchases: Disabled

 * Go to [ Settings > General > Restrictions > ] Password Settings
  * Required after 15 Minutes: Checked
  * Free Downloads: Enabled

I didn't want to have it prompt for my password for free downloads, so I left this last option disabled, but it looks to have fixed the problem!

Now all I need to do is figure out why his phone rarely seems to load Pokémon Go up correctly...
