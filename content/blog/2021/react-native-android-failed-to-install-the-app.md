---
type: "blog"
title: "React Native & Android: \"Failed to Install the App\""
description: "I've been setting up a MacBook Pro to be able to work on a React Native mobile app and hit a stumbling block when running the Android app locally..."
date: 2021-08-24T19:38:26+01:00
author: "Jon"
tags: ["programming", "mobile", "android", "react-native"]
---

I've been setting up a MacBook Pro to be able to work on a React Native mobile app and hit a stumbling block when running the Android app locally.

I had already installed all the relevant applications needed (Android Studio, a JDK etc.) but when I ran `react-native run-android`, it would give me the following error:

```
error Failed to install the app. Make sure you have the Android development environment set up
```

I tried a few different things until I came across [a solution proposed by Menon Hasan on Stack Overflow](https://stackoverflow.com/a/67360611/3157725) where they proposed the following command to set the executable permission on the `gradlew` file:

```
chmod +x gradlew
```

This solved my problem, so I just needed to update the index for the file in git so that nobody else will encounter the issue in the future.
