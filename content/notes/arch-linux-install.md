---
type: "note"
title: "Arch Linux Installation"
---

This is a list of the commands I'd run to set up a machine with Arch Linux as of today (25th April 2020).

First of all, create a bootable USB (or CD) based on the ISO downloaded from the main Arch Linux website and boot it up.

## Initial steps

### Set keyboard layout to UK

```
loadkeys uk
```

Connect to the Internet (Ethernet is easier, but Wireless is just as easy) before continuing...

### Set timezone and enable NTP

Set the time zone to London and enable NTP for keeping the time/date synchronised.

```
timedatectl set-timezone Europe/London
timedatectl set-ntp true
```

## Disk setup

Create your disk partition layouts at this point using the preferred disk partition tool (fdisk, cfdisk, parted etc.) but remember that if you're enabling encryption, create the partitions accordingly.

Remember that I always recommend `/home` being on a separate partition!

### Formatting a partition (assuming `ext4` which is most common)

```
mkfs.ext4 /dev/sda1
```

or without journaling enabled

```
mkfs.ext4 -O "^has_journal" /dev/sda1
```

or with BTRFS instead

```
mkfs.btrfs /dev/sda1
```

### Formatting the swap partition

```
mkswap /dev/sda2
```

## Get ready to install (mount drives)

```
mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sda4 /home
```

and if you created a separate `/boot` partition

```
mkdir /mnt/boot
mount /dev/sda1 /boot
```

and finally enable the `swap` partition

```
swapon /dev/sda2
```

## Install the basics

```
pacstrap /mnt base base-devel linux linux-firmware
```

## Create the fstab file

```
genfstab -U /mnt >> /mnt/etc/fstab
```

## Chroot into the installed OS

```
arch-chroot /mnt
```

## Next steps...

Set the root password - **make it secure!**

```
passwd
```

### Set the locale

Edit `/etc/locale.gen` to uncomment any `en_GB` entries before generating the locale file

```
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
echo KEYMAP=uk > /etc/vconsole.conf
```

### Set the hardware clock

```
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
```

### Name the computer (set up hostname)

```
echo {name} > /etc/hostname
echo 127.0.1.1 {name}.localdomain {name} >> /etc/hosts
```

### Install zsh (if you prefer it to bash)

```
pacman -S zsh
```

### Add your everyday user account and set the password

(replace `zsh` with `bash` if you skipped the last step)

```
useradd -m -g users -G wheel -s /bin/zsh {username}
passwd {username}
```

### Add user to sudoers (optional)

Replace {editor} with the editor of choice - `nano` should already be installed.

```
EDITOR={editor} visudo
```

Uncomment the line below to allow all users in `wheel` group to run root commands

```
%wheel ALL=(ALL) ALL
```

### Create a new initramfs file

Remember to update `/etc/mkinitcpio.conf` if you're using an encrypted disk to make sure the correct things are loaded before running the following:

```
mkinitcpio -P
```

### Set up grub (bootloader)

```
pacman -S grub
grub-install /dev/sda
```

If you have any customisations to make to the boot command line, make them in `/etc/default/grub` now!

```
grub-mkconfig -o /boot/grub/grub.cfg
```

### Install any additional utilities, window managers etc.

I use the KDE/Plasma desktop and use SDDM as my display manager, so I'll install these now.

```
pacman -S plasma sddm
```

And I need to enable the SDDM service so it'll auto-load on boot:

```
systemctl enable sddm
```

I'll also want to have a terminal installed for use in Plasma, I've been using Konsole for that:

```
pacman -S konsole
```

## Final steps (and reboot)

Exit from the chroot shell, unmount all partitions and reboot:

```
exit
umount -R /mnt
reboot
```

Once you've rebooted and logged in, you may find you can't get a network connection. If so, you'll need to enable and start the `NetworkManager` service:

```
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```
