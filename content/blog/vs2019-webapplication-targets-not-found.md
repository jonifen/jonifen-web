---
type: "blog"
title: "The imported project \".../Microsoft.WebApplication.targets\" was not found"
date: 2019-06-17T21:59:33+01:00
author: "Jon"
tags: ["programming", "visualstudio"]
description: "We have an existing web application project at work which was failing to open in Visual Studio 2019 with the following error..."
---

We have an existing web application project at work which was failing to open in Visual Studio 2019 with the following error:

```
The imported project "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Microsoft\VisualStudio\vCurrent\WebApplications\Microsoft.WebApplication.targets" was not found.
```

After some research, I came across this a [VS Community post](https://developercommunity.visualstudio.com/content/problem/414282/vs-2019-webapplication-projects-fail-to-load.html) where Microsoft have deemed it to be under consideration, but after a few months, it's still outstanding.

Figuring out that the issue could surround the `vCurrent` part of the path, I did a bit more research, coming across another [VS Community post](https://developercommunity.visualstudio.com/content/problem/404485/vs2019-msbuildtoolsversion-is-not-a-version.html) which discusses this point, and it turns out that Microsoft have changed the `MSBuildToolsVersion` variable to output `Current` rather than the version (as it did previously). Luckily, Jim Waite has posted [a useful workaround](https://developercommunity.visualstudio.com/comments/477080/view.html) which appears to have fixed the problem I was having (which I quote):

```
The MSBuild folder has indeed been renamed to "Current", however there are still sub-folders in there that are using the old numeric convention.

For example, this one:

C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Microsoft\VisualStudio\v16.0

Any build scripts that refer to this folder using ...\VisualStudio\v$(MSBuildToolsVersion) will no longer work.

Shouldnt the sub-folders all follow the same "Current" convention?

So above folder would become:

C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Microsoft\VisualStudio\vCurrent

In the meantime, it can be worked around (but this is not very nice) by replacing $(MSBuildToolsVersion) with $(MSBuildAssemblyVersion) in build scripts.
```

So looking in our *.csproj file, I found an import element as follows:

```
<Import Project="$(MSBuildExtensionsPath32)\Microsoft\VisualStudio\v$(MSBuildToolsVersion)\WebApplications\Microsoft.WebApplication.targets" />
```

which just needed changing to:

```
<Import Project="$(MSBuildExtensionsPath32)\Microsoft\VisualStudio\v$(MSBuildAssemblyVersion)\WebApplications\Microsoft.WebApplication.targets" />
```

and it looks like the problem has gone away.