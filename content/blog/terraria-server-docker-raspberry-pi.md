---
type: "blog"
title: "Creating a Terraria server in Docker on a Raspberry Pi 4B"
description: "After much difficulty, I've finally figured out how to get a Terraria server running in Docker on my Raspberry Pi 4B..."
date: 2020-06-28T18:20:01+01:00
author: "Jon"
tags: ["blog", "gaming"]
draft: false
---

Terraria is a sandbox style game, similar in many ways to Minecraft, but yet different enough for many to argue otherwise!

When the Steam sale started, and Terraria was only £3.49, it made sense to give it a go. I'd tried it on a console in the past but found the controls a little cumbersome compared to a mouse and keyboard. My son also got it on his Steam account, as did a few of his friends, so we needed to find a way to get a server running where they could all play together or individually on a single world.

Enter the [Terraria Server](https://terraria.gamepedia.com/Server)!

I have a Raspberry Pi 4B with 4GB which I've been using as a mini-server at home, for running side projects in Docker containers and the like. I've got Ubuntu Server 20.04 LTS installed on it, and this runs great for most things, but it usually throws up some curveballs and I end up having to make things custom to get them to work properly.

At first, I thought there'll be plenty of options out there for me to follow, and after looking into several (and trying one or two out), I realised that many were aimed at the x86 architecture and wouldn't run on the ARM64v8 processor on the Raspberry Pi 4B.

I eventually settled on running it through Mono and started customising [this GitHub repository by @beardedio](https://github.com/beardedio/dcon-terraria/) whilst updating for the latest version of the Server (currently 1.4.0.5), but quickly hit difficulties for which there was very little online to assist with.

The @beardedio repository suggested using the Mono docker image, but that required me to install `gdb` and yet still threw numerous exceptions afterwards, so I ended up doing more research to see how to progress. I found several articles that suggested running TShock, but then this didn't support the latest version of the Client which we had installed through Steam, so I quickly shelved that idea and tried again with the official server.

Because of the problems with the Mono image, I opted for a safe option with an Ubuntu image, and I installed `mono-complete` in the `Dockerfile` instead. This seemed to make more progress, but still threw up exceptions suggesting mismatches of Mono versions. At this point, I removed Docker from the equation, installed `mono-complete` on my Pi and tried running it on there for faster feedback. After encountering the same exceptions, I noticed there were a lot of `System.*` DLLs included in the official Server directory, which needed deleting to allow it to use the versions installed as part of the `mono-complete` package instead. So I zipped up my "amended" server folder, pointed my `Dockerfile` at it and it solved that problem.

So I was making progress! But then because the Terraria Server uses stdin to allow options to be entered at any time, Docker doesn't support this out of the box. I spent over an hour tinkering with `screen` (favoured at the time to `tmux`), but this never seemed to work at all. Plus, because all output was directed through `screen`, I was getting nothing from `docker logs {container_name}` which was particularly frustrating as the container wouldn't stay running anyway.

Suggestions online ([like here](https://forums.terraria.org/index.php?threads/server-crash-with-system-nullreferenceexception.55032/)) were around making a service file and enabling/starting it with `systemctl` in the runtime script, which also then needed to have a process running to keep Docker happy. It all seemed like a bit of a hack, and in the end that was irrelevant because it didn't work for me anyway! The container wouldn't stay running, even if I had the run script running a tail follow on `/dev/null` as suggested [here](https://stackoverflow.com/a/42873832/3157725).

So I ended up rolling back those changes, and then encountered a forum thread about a similar situation, where someone mentioned the `-t` argument for when I run the Docker container. A-ha! This worked perfectly! Great news, yet frustrating that I'd spent over 2 hours at this point, and it could've been avoided by me knowing about that one single character `'t'`. Sigh...

So we were really cooking on gas now, we had a working server running in a Docker container on the Pi! Oh, but what if I wanted to stop the server for whatever reason? Would it save the world changes if I just stopped it? Nope! It wouldn't. So after a night's sleep, I started looking into that this morning, seeing if I could get access to the pty session of the process when I accessed the container.

I came across numerous forum threads, blog posts etc. which all suggested `screen` again. Once bitten, twice shy and all that, but I had another go and encountered the same problems I had the evening before - so much for thinking it might've just been tiredness-induced mistakes why it didn't work!

Eventually, after re-reading the Docker `run` documentation and reading some forum threads about it, I realised I could use the `-i` argument in my `docker run` command and it should all work great, and I'd be able to get access to the stdin/out stream using `docker attach`, and this worked brilliantly.

So to cut a long story short, I started with cloning an existing repository, getting stuck, amending it, getting more stuck, throwing it all away and starting again, getting stuck some more and then slowly got things working. But, to assist others, I ended up with the following folder structure on my host (I used my local version of the server to create the world file, as once the config points to a world, it removes the demand on needing to respond to the menus):

```
terraria-server/
  configs/
    banlist.txt
    serverconfig.txt
  worlds/
    world_file.wld
  Dockerfile
  run-server.sh
```

I thought it important to keep the world and config files out of the container, as they should remain if the container is rebuilt or whatever. I'll map those directories into the container later.

The files are as follows:

_Dockerfile_
```
FROM ubuntu

LABEL maintainer="jonifen"

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vim zip curl mono-complete && \
    apt-get clean

RUN mkdir /tmp/terraria && \
    cd /tmp/terraria && \
    curl -sL https://www.terraria.org/system/dedicated_servers/archives/000/000/039/original/terraria-server-1405.zip --output terraria-server-1405.zip && \
    unzip -q terraria-server-1405.zip && \
    mv */Linux /terraria && \
    rm -R /tmp/* && \
    rm /terraria/Mono.* && \
    rm /terraria/System.* && \
    rm /terraria/WindowsBase.dll && \
    chmod +x /terraria/TerrariaServer* && \
    if [ ! -f /terraria/TerrariaServer ]; then echo "Missing /terraria/TerrariaServer"; exit 1; fi

COPY run-server.sh /terraria/run.sh

WORKDIR /terraria
CMD ["./run.sh"]
```

_run-server.sh_
```
#!/bin/bash
set -euo pipefail

exec mono TerrariaServer.exe -config "/terraria/configs/serverconfig.txt"
```

I referred to a configuration file in the `run-server.sh` file too. I've removed all the comments from the file for brevity:

_serverconfig.txt_
```
world=/terraria/worlds/world_file.wld
maxplayers=8
port=7777
worldpath=/terraria/worlds
worldrollbackstokeep=2
banlist=/terraria/configs/banlist.txt
```

I used the following Docker commands to build and run the container:

_build_
```
docker build -t jonifen/terraria .
```

_run_
```
docker run -itd -v {path_to_repo}/worlds:/terraria/worlds -v {path_to_repo}/configs:/terraria/configs -p 7777:7777/tcp --name terraria_server jonifen/terraria
```

You'll notice that I'm mapping the config and world directories from the host into the container. This means they're kept safe should the container get trashed. I've also removed my paths from the _run_ step to avoid any confusion.

You'll need access to the process to instruct it to save/exit etc. when you need to. For example, the server only saves every 24 minutes, but this appears to only be every 24 minutes **if a player is on the server at the time** so you'll likely want to save before stopping the container to avoid any data loss. Luckily, by proving the `-i` argument to `docker run`, it's easy to do this using the following command:

```
docker attach terraria_server
```

It will appear like it's frozen at first, but pressing Enter will give you the colon prompt `:` and you'll be able to type your commands in here as you wish. Note that exiting the server through this will also stop the Docker container!

You can view the files in [my GitHub repository](https://github.com/jonifen/terraria-docker-raspberry-pi). I'm fully aware that it might not be the most efficient container (many people would suggest using Alpine rather than Ubuntu), and I'll likely look into that in the future - the most important thing was to get it working! And in any case, PRs are always welcome :)
