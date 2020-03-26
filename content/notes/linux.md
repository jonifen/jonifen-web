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

## Installing KDE and tools

`plasma-desktop` (The KDE desktop - seems to be referenced as `plasma` nowadays)
`plasma-nm` (NetworkManager for plasma/KDE - enable it through `sudo systemctl enable NetworkManager`)
`kde-applications` (gives you a bunch of KDE apps, konsole etc.)
`kgpg` (for encrypting the KDE wallet for wifi keys etc.)
`powerdevil` (configuring power settings and/or power savings)

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

Other commands:

| Command | Description |
|---|---|
| `allow http` | Grant http access over port 80 |
| `allow 80/tcp` | Same as above, but very explicit to the port and protocol |
| `allow https` | Grants https access over port 443 |
| `allow 8000:8100/tcp` | Grant access on all ports between the specified range |
| `allow from {ip}` | Grant access to all ports from a specified ip |
| `allow from {ip} to any port 8000` | Grants access from the specific IP to port 8000 |
| `allow from 192.168.10.0/24 to any port 8000` | Grants access from any IP in the specified subnet to port 8000 |
| `deny from {(ip|subnet range)}` | Blocks access to any port from the specified IP or subnet range |

**Note:** All `allow` rules can be `deny` rules by simply changing the wording.

Ok, so I'd like to delete some rules now... how would I do that?

Delete the rule by specifying what you added:

```
sudo ufw delete allow ssh
```

Or, you can list all the rules with associated IDs by getting the numbered status:

```
$ sudo ufw status numbered
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 22/tcp                     ALLOW IN    Anywhere
[ 2] 22/tcp (v6)                ALLOW IN    Anywhere (v6)
```

and then deleting the one you no longer want:

```
sudo ufw delete 2
```

Finally, want to disable UFW and reset it to defaults?

```
sudo ufw reset
```

-----

## MDADM (Mounting RAID devices)

This was from mounting the drive from a single disk Zyxel NSA310 NAS.

It appears the disk is actually in its own RAID array. Never seen this before!

Advice online suggested doing the following:

```
$ sudo mdadm --assemble --force /dev/md0 /dev/sdc2
mdadm: /dev/sdc2 is busy - skipping
```

So I had to figure out what was making the disk busy...

```
$ cat /proc/mdstat
Personalities : [linear] [multipath] [raid0] [raid1] [raid6] [raid5] [raid4] [raid10]
md127 : active linear sdc2[0]
      487868928 blocks super 1.2 0k rounding

unused devices: <none>
```

Ok, so it's already configured and ready to go, so there must be a file in `/dev/` for it...

```
$ ls /dev/md*
/dev/md127

/dev/md:
nsa310:0
```

Yup, there is one! So I just have to mount it now...

```
$ sudo mount /dev/md127 /mnt/nas
```

Works a treat!
