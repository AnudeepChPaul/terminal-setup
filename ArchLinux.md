# Arch Linux

## Set keyboard Layout
```
loadkeys us
```

## Validate the bootmode
```
efibootmgr -v
ls /sys/firmware/efi/efivars
```

# Set timezone
```
timedatectl set-timezone Asia/Kolkata
timedatectl set-ntp true
timedatectl status
```

## Validate internet connection
```
ip link
ip addr show
ping google.com
```

## Setup filsystem mount
```
cgdisk /dev/mmcblk0
delete everything first

create p1 (500M) for boot
create p2 (550M) for swap
create p3 (100%) for arch

mkfs.ext4 /dev/p3
mkfs.fat -F 32 /dev/p1 
mkswap /dev/p2

mount /dev/p3 /mnt
mount --mkdir /dev/p1 /mnt/boot/efi
swapon /dev/p2

lsblk
```

## Prepare important configurations
```
pacstrap /mnt base linux linux-firmware sof-firmware grub efibootmgr nano vim networkmanager htop base-devel openssh sipcalc udev

genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab 
# Verify if the partitions are correctly mentioned
```

## Take over access to archlinux installation
```
arch-chroot /mnt

nano /etc/locale.gen
# uncomment the required locale & save the file

locale-gen

ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc
```

## Update configurations
```/etc/locale.conf
LANG=en_IN.UTF-8

/etc/vconsole.conf
KEYMAP=us

/etc/hostname
archcp
```

## Setup user and root password
```
passwd

useradd -m -g users -G wheel acp
passwd acp

EDITOR=nano visudo 
# uncomment %wheel=(ALL:ALL) ALL
```


## Setup uefi boot system
```
grub-install /dev/p3
grub-mkconfig -o /boot/grub/grub.cfg
```

## prepare for reboot
```
systemctl enable sshd
systemctl enable NetworkManager

exit
umount -a

reboot
```

## Setting up router
> intern0: the network card connected to the LAN. On an actual computer it will probably have the name enp2s0, enp1s1, etc.
> extern0: the network card connected to the external network (or WAN). It will probably have the name enp2s0, enp1s1, etc.

### Rename network interfaces
> Change interface name 
  `https://wiki.archlinux.org/title/Network_configuration#Change_interface_name`
  ``` sudo nano /etc/udev/rules.d/10-network.rules

  SUBSYSTEM="net", ACTION="add", ATTR{address}=="00:e0:4c:68:01:26", NAME="lan0"
  SUBSYSTEM="net", ACTION="add", ATTR{address}=="00:e0:4c:68:01:27", NAME="wan0" ```

> Share packets between interfaces
  `https://wiki.archlinux.org/title/Internet_sharing#Enable_packet_forwarding`

> ip forwarding

```
/etc/netctl/lan0-profile
Description='Lan Interface.'
Interface=enp2s0
Connection=ethernet
IP='dhcp'
```

```
/etc/netctl/wan0-profile
Description='Wan Interface'
Interface=enp3s0
Connection=ethernet
IP='static'
Address=('10.0.0.1/24')
```
