---
type: "post"
title: "Pantheon Code on Arch Linux"
date: 2026-03-23T21:39:32Z
author: "Jon"
tags: ["tools", "programming", "linux"]
---
Prior to getting the MacBook Air as my portable beater machine, I was temporarily using my old HP DM1-4027. As expected, despite having 8GB RAM, it wasn't very quick so I wasn't going to get away with using VSCode as it's not exactly resources friendly is it?

Enter "Pantheon Code", a text editor that is built into ElementaryOS. It looks simplistic, offers syntax highlighting, git integration and it can load a terminal window into a panel at the bottom. What more do you want when you're on the move!?

So it's fairly straight forward to get going, by installing `pantheon-code` through pacman:

```bash
sudo pacman -S pantheon-code
```

It'll add a shortcut to the Development menu, but you may be unlucky in that it doesn't load first time. And you don't get any messages either. So let's run `io.elementary.code` manually and see if it spits any errors out to the terminal.

```text
io.elementary.code: error while loading shared libraries: libvte-2.91.so.0: cannot open shared object file: No such file or directory
```

Ah, so there's a dependency that it needs which isn't included as part of the original install. Let's install that (and this is where I stumbled and the reason for this post) by installing the `vte3` package:

```bash
sudo pacman -S vte3
```

Once that's installed, everything is working fine. Hope that helped you, as it tripped me up and even ChatGPT couldn't help at the time!

