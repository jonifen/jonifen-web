---
title: "Linux"
type: "note"
---

Most of the notes in here are Arch Linux specific, as this is the distro I use most and the one which tends to give me the most curveballs to deal with! But this is what's so good about it, as it gives me a way to learn things better than I would do with one of the more common distros like Ubuntu.

_If anyone reads any of these notes and thinks there's a better way, please let me know - any help is always appreciated. Maybe you'd prefer to submit a PR?_

-----

## Useful file locations

These are a few files/paths I always forget because I rarely need to look at them when my Linux machine is working fine.

| | Location |
|---|---|
| Pacman logs | `/var/log/pacman.log` |
| Pacman cache | `/var/cache/pacman/pkg/` |

-----

## Mounting the current installation from a live environment

I tend to keep my `/home` directory on a separate partition, so I do the following:

```
mkdir /mnt/root
mkdir /mnt/root/home

mount /dev/sda1 /mnt/root
mount /dev/sda3 /mnt/root/home

chroot /mnt/root
```

This gives me the `zsh` shell logged in as root into my current Arch installation so I can do any diagnosis.
Once I'm finished, I exit my installation, unmount and reboot.

```
exit
umount /mnt/root/home
umount /mnt/root
reboot
```

-----

## UFW (Uncomplicated FireWall)

This is a pretty simple to configure firewall on Linux (I guess that's where the `Uncomplicated` part of the name came from!)

It is typically installed on Ubuntu Server by default, but if not, you can install it through Aptitude:

```
sudo apt install ufw
```

Once you've got it installed, you can check the status...

```
$ sudo ufw status verbose
Status: inactive
```

And after this, making sure that SSH access is allowed...

```
$ sudo ufw allow ssh
Rules updated
Rules updated (v6)
```

you can enable it...

```
$ sudo ufw enable
Command may disrupt existing ssh connections. Proceed with operation (y|n)? y
Firewall is active and enabled on system startup
```

At any time you can see what apps are available to grant/block through the firewall (I don't have many on mine so far!):

```
$ sudo ufw app list
Available applications:
  OpenSSH
```

