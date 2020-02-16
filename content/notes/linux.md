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

