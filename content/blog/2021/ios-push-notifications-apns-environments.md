---
title: "iOS APNs/APS Environments"
description: "I wanted to get to a situation where we can point the build in App Center to sandbox, and the build in App Store & TestFlight to production. Sadly, after much investigation and trying things out, I came out with the following conclusion..."
date: "2021-06-17T15:11:12+01:00"
author: "Jon"
tags: [
  "programming",
  "reactnative",
  "ios",
  "javascript"
]
type: "blog"
---

At work, we're working on a React Native mobile app. For our iOS deployment, we have our test builds (that consumes APIs in a testing environment) going to MS App Center, and production builds going to TestFlight, eventually being promoted to the App Store.

We use MS Notification Hub to handle our push notifications that are triggered by internal systems etc. but we wanted to achieve a situation where we were using a testing APNs environment (i.e. the sandbox) for our App Center builds, and the production APNs environment for our TestFlight/App Store builds.

Sadly, after much investigation and trying various things out, I came out with the following conclusion:

> Production APS will be used everywhere *except* in a development build.

Considering it's quite an important piece of information, and it's discussed at length across various forums, It took me a while to find anything official from Apple to confirm this was the case, until I eventually stumbled across some old documentation which explains it better. I repeat, this is the only official place where I've seen this documented.

https://developer.apple.com/library/archive/technotes/tn2265/_index.html

In particular the note where it details:

*"There is a separate persistent connection to the push service for each environment. The operating system establishes a persistent connection to the sandbox environment for development builds, while ad hoc and distributon builds connect to the production environment."*

And there we have it! So I looked into things in a bit more detail; could we use a development provisioning profile in App Center?

Seemingly not.

We have our App Center configured that it will auto-provision any new devices that request to download a build - App Center handles all this with Apple for us - but that's the nature of an ad-hoc profile, extra devices *can* be added later whereas a development profile requires us to do this manually. This is the scenario we wanted to avoid, as it would require us to add devices upfront and amend the profile as and when any further devices needed to be provisioned.
