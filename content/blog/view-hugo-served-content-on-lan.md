---
type: "blog"
title: "View Hugo served content on another device on network"
description: "When you want to view content served by a locally running instance of Hugo on another device, you have to specify a few extra things..."
date: 2020-09-06T14:18:01+01:00
author: "Jon"
tags: ["blog", "gohugo.io", "web"]
---
When you want to view content served by a locally running instance of Hugo on another device, you have to specify a few extra things so it will work correctly.

When you start the Hugo server locally, it will show the following output:

```
$ hugo server -w
...
(some output omitted here for brevity)
...
Web Server is available at //localhost:1313/ (bind address 127.0.0.1)
Press Ctrl+C to stop
```

Because it's bound to your localhost IP, you can't just open port 1313 on your computer via a firewall and access Hugo from another device. You have to bind Hugo to the network IP instead (To find out the IP, try `ipconfig` on Windows or `ip a` on Linux).

Then you start Hugo up again providing some extra details:

```
$ hugo server -w --bind "0.0.0.0" --baseUrl={YOUR_NETWORK_IP_HERE}
...
(some output omitted here for brevity)
...
Web Server is available at //{YOUR_NETWORK_IP_HERE}:1313/ (bind address 0.0.0.0)
Press Ctrl+C to stop
```

You can also override the port by providing `--port {port}` if you so wish.

It's much more useful to test on mobile devices etc. without having to push the whole site and hope it works.