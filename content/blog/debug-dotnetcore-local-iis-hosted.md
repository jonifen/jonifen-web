---
type: "blog"
description: "When debugging a dotnet framework application that is hosted in a local IIS server, you would usually identify the w3wp.exe instance running the Application Pool and attach your Visual Studio instance to it..."
date: 2020-09-04T22:28:13+01:00
title: "Debugging a dotnetcore application hosted in a local IIS server"
author: "Jon"
tags: [ "programming", "visualstudio", "dotnet", "core" ]
---
When debugging a dotnet framework application that is hosted in a local IIS server, you would usually identify the `w3wp.exe` instance running the Application Pool and attach your Visual Studio instance to it. Sure you might get some issues with modules not loading, but on the whole this technique allows you to debug your application through IIS.

However, with dotnet core applications, things are a little different as they're not ran as managed code from within a `w3wp.exe` instance but instead from within a `dotnet.exe` instance, so this is the process you should attach your Visual Studio instance to when debugging dotnet core.

The tricky part here is identifying which process to attach to. You can usually use the username which is running the Application Pool as reference, and if you're unable to whittle them down enough, you can always just attach to multiple `dotnet.exe` processes and this will do the same thing.