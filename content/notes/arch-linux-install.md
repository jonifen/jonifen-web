---
type: "note"
title: "Arch Linux Installation"
description: "The sequence I typically follow to install Arch Linux onto a machine as of 25th April 2020)"
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

#### KDE/Plasma & SDDM

```
pacman -S plasma sddm
```

Enable the SDDM service so it's launched on boot:

```
systemctl enable sddm
```

#### Openbox
This is my choice on low powered machines, and I don't include a display manager (but you can add one if you like though). Remember that you'll need to start X yourself with `startx`.

```
pacman -S xorg-server xorg-xinit xorg-apps openbox obconf lxappearance
```

Use the example xinitrc file as your base:

```
cp /etc/X11/xinit/xinitrc ~/.xinitrc
```

edit the file to comment out the last block (starts with `twm` and includes references to `xterm` etc.) and then add the following at the bottom:

```
exec openbox-session
```

#### Terminal
Take your pick from `konsole` (my preferred in KDE), `xterm` (very simple), `sakura` (basic with some features).

## Network connectivity
You'll probably need to install some packages to help you get a network connection post-reboot. Here are a few options:

### NetworkManager
Should get installed with KDE, but if you've opted for something else, needs installing manually:

```
pacman -S network-manager network-manager-applet
```

and then the service needs enabling:

```
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

### WPA Supplicant (wifi only)

```
pacman -S dialog wpa_supplicant
```

once installed:

```
sudo wifi-menu
```

it will save your profile as a network service, view all options:

```
sudo netctl list
```

and enable the one you want:

```
sudo netctl enable {profile_name}
```

### iwd
Install the `iwd` package from the registry and start it with:

```
iwctl
```

At the interactive prompt:

```
# show the installed wifi adapters
devices list

# scan for networks
station {wlan} scan

# show the networks found in the scan
station {wlan} get-networks

# connect to a network (it will prompt for PSK)
station {wlan} connect {network_name}
```

I also had to install the `dhcp` package and then enable the daemon, along with the DNS resolver in systemd:

```
systemctl enable dhcpd
systemctl enable systemd-resolved
```


## Final steps (and reboot)

Exit from the chroot shell, unmount all partitions and reboot:

```
exit
umount -R /mnt
reboot
```


## Additional packages
There are additional packages that I tend to install after a base install. Some of these are related to software development, some are not.

- Yay (AUR helper, saves a few keypresses for installing packages via AUR)
- nvm (Node Version Manager - this is available on AUR and can be installed with Yay)
- OpenSSH (ssh - because it's not installed by default)
- Visual Studio Code - I install the MS one from AUR because some plugins that I've become pretty used to aren't in the open repository: `visual-studio-code-bin`
- docker and docker-compose (both available from official Arch Linux repositories)
- kamoso (camera utility for KDE)
- pulseaudio-equalizer (audio equaliser for pulseaudio - it sets itself up as an additional audio controller, so it affects _all_ audio output)

### Fonts
These can be installed from the standard Arch Linux package registry.

- Hack: ttf-hack
- Noto Fonts: noto-fonts noto-fonts-emoji noto-fonts-extra


## Gotchas
### Signature is unknown trust

```
signature from "{name} <{email}>" is unknown trust
```

As per the Arch docs [here](https://wiki.archlinux.org/title/Pacman#Signature_from_%22User_%3Cemail@example.org%3E%22_is_unknown_trust,_installation_failed), there are a few possible solutions but I've had success with installing the `archlinux-keyring` package and then doing a pacman update:

```
sudo pacman -Sy archlinux-keyring
sudo pacman -Su
```

