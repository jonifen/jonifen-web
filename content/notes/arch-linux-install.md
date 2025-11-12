---
type: "note"
title: "Arch Linux Installation"
description: "The sequence I typically follow to install Arch Linux onto a machine (updated 12 November 2025)"
---

First of all, create a bootable USB (or CD) based on the ISO downloaded from the main Arch Linux website and boot it up.

The Arch Linux wiki is probably one of the best I've ever used, so the latest basic installation steps can be found [here](https://wiki.archlinux.org/title/Installation_guide).

## Initial steps

### Set keyboard layout to UK

```bash
loadkeys uk
```

Connect to the Internet before you continue. For my arch linux laptop, I can use ethernet which is the simplest method.

### Set timezone and enable NTP

_I haven't had to run these steps in the most recent installation (November 2025) but YMMV_

Set the time zone to London and enable NTP for keeping the time/date synchronised.

```bash
timedatectl set-timezone Europe/London
timedatectl set-ntp true
```

## Disk setup

Create your disk partition layouts at this point using the preferred disk partition tool (fdisk, cfdisk, parted etc.) but remember that if you're enabling encryption, create the partitions accordingly.

I recommend `/home` being on a separate partition, as if you need to trash your install and start again, your files should be safe.

### Formatting a data partition

```bash
# If you're using ext4
mkfs.ext4 /dev/sdaX

# or if you prefer btrfs
mkfs.btrfs /dev/sdaX
```

### Formatting the swap partition

```bash
mkswap /dev/sda2
```

## Get ready to install (mount drives)

```bash
mount /dev/sda3 /mnt
mkdir /mnt/home
mount /dev/sda4 /mnt/home
```

and if you created a separate `/boot` partition

```bash
mkdir /mnt/boot
mount /dev/sda1 /boot
```

and finally enable the `swap` partition

```bash
swapon /dev/sda2
```

## Install

This is the main installation step, so you should always include `base linux linux-firmware` at the bare minimum. But you can include any other packages that you'll definitely want installing. I tend to leave `grub` until after I've chrooted onto the installation, I'm not sure if it makes any difference though.

```bash
pacstrap /mnt base base-devel linux linux-firmware sudo git
```

## Create the fstab file

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

## Chroot into the installed OS

```bash
arch-chroot /mnt
```

Now you're running commands on your installation!

## Next steps...

Set the root password - **make it secure!**

```bash
passwd
```

### Set the locale

Edit `/etc/locale.gen` to uncomment any `en_GB` entries before generating the locale file

```bash
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
echo KEYMAP=uk > /etc/vconsole.conf
```

### Set the hardware clock

```bash
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
hwclock --systohc
```

### Name the computer (set up hostname)

```bash
echo {name} > /etc/hostname
echo 127.0.1.1 {name}.localdomain {name} >> /etc/hosts
```

### Install zsh (if you prefer it to bash)

```bash
pacman -S zsh
```

### Add your everyday user account and set the password

(replace `zsh` with `bash` if you skipped the last step)

```bash
useradd -m -g users -G wheel -s /bin/zsh {username}
passwd {username}
```

### Add user to sudoers (optional)

Replace {editor} with the editor of choice - `nano` should already be installed.

```bash
EDITOR={editor} visudo
```

Uncomment the line below to allow all users in `wheel` group to run root commands

```bash
%wheel ALL=(ALL) ALL
```

### Create a new initramfs file

Remember to update `/etc/mkinitcpio.conf` if you're using an encrypted disk to make sure the correct things are loaded before running the following:

```bash
mkinitcpio -P
```

### Set up grub (bootloader)

```bash
pacman -S grub
grub-install /dev/sda
```

If you have any customisations to make to the boot command line, make them in `/etc/default/grub` now!

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

### Install any additional utilities, window managers etc.

#### KDE/Plasma & SDDM

```bash
pacman -S plasma sddm
```

Enable the SDDM service so it's launched on boot:

```bash
systemctl enable sddm
```

#### IceWM

I've started using this WM on my HP DM1 (I still use it as it comes in useful for ethernet access on the go), and it's quite performant.

```bash
pacman -S xorg xorg-xinit icewm
```

And then I've been using `lightdm` as the display manager to handle my log in screen:

```bash
pacman -S lightdm lightdm-gtk-greeter
```

#### Terminal
Take your pick from `konsole` (my preferred in KDE), `xterm` (very simple), `sakura` (basic with some features).

There's also `alacritty` which is rendered by the GPU, but still works really well on the HP.

## Network connectivity

With more recent versions of Arch, it comes with `systemd` included, so you can use `systemd-networkd` (already installed) and `wpa_supplicant` (needs to be installed) to handle your network needs:

```bash
pacman -S wpa_supplicant
```

Run `networkctl` to get your device names before you start.

### Ethernet

Create `/etc/systemd/network/20-wired.network` and paste the following into it (with the necessary changes):

```toml
[Match]
Name=YOUR_ETHERNET_DEVICE_NAME

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
```

And then start+enable (or restart) the following:

```bash
systemctl enable systemd-networkd systemd-resolved
```

### Wireless

Create `/etc/systemd/network/10-wireless.network` and paste the following into it (again, with the necessary changes):

```toml
[Match]
Name=YOUR_WIRELESS_DEVICE_NAME

[Link]
RequiredForOnline=routable

[Network]
DHCP=ipv4
```

Now you'll need to connect to your wireless network. In the following steps, it's recommended to replace `wlo1` with your wireless device name for clarity in the future.

```bash
wpa_passphrase mySSID

# Copy the content out and paste into the file created through this:
sudo nvim /etc/wpa_supplicant/wpa_supplicant-wlo1.conf

# And finally, start the wpa_supplicant service and restart systemd-networkd
sudo systemctl start wpa_supplicant@wlo1.service
sudo systemctl restart systemd-networkd.service
sudo systemctl enable wpa_supplicant@wlo1.service
```

## Final steps (and reboot)

Exit from the chroot shell, unmount all partitions and reboot:

```bash
exit
umount -R /mnt
reboot
```


## Additional packages

There are additional packages that I might install after a base install. Some of these are related to software development, some are not.

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

### After rebooting into the fresh install, the keyboard layout reverts to US

This one puzzled me for longer than it should have done, but eventually I figured it out.

```bash
setxkbmap gb
```

### Signature is unknown trust

> signature from "{name} <{email}>" is unknown trust

As per the Arch docs [here](https://wiki.archlinux.org/title/Pacman#Signature_from_%22User_%3Cemail@example.org%3E%22_is_unknown_trust,_installation_failed), there are a few possible solutions but I've had success with installing the `archlinux-keyring` package and then doing a pacman update:

```bash
sudo pacman -Sy archlinux-keyring
sudo pacman -Su
```

