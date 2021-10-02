# Install Arch Linux

Скачиваем дистрибутив с [сайта](https://www.archlinux.org/download/). Сравниваем образ через sha1sum.

Перед тем как записать образ на влешку, нужно удалить сигнатуру диска:
```console
sudo wipefs --all /dev/sdx
```
> Чтобы определить имя устройства можно использовать команду **lsblk** (list block devices) 


Run the following command, replacing **/dev/sdx** with your drive, e.g. **/dev/sdb**. 
(Do not append a partition number, so do not use something like **/dev/sdb1**)
```console
dd bs=4M if=path/to/archlinux.iso of=/dev/sdx status=progress oflag=sync
```

So, plug your flash drive and turn on your PC. 
If everything is fine and you successfully boot from flash first of all check your internet

```console
ping 8.8.8.8
```

## Разметка диска
Узнать информацию о разделах можно спомощью:
```console
fdisk -l
```

или 
```console
lsblk -f
```

|                     | MBR           | GPT                  |
| ---                 | ---           | ---                  |
| **Dialog**          | fdisk parted  | fdisk gdisk parted   |
| **Pseudo-graphics** | cfdisk        | cfdisk cgdisk        |
| **Non-interactive** | sfdisk parted | sfdisk sgdisk parted |

Пример запуска некоторых програм:
```bash
fdisk /dev/sda
gdisk /dev/sda
```

## Пример разметки

#### UEFI/GPT example layout

| Mount point                | Partition | Partition type GUID   | Suggested size          | File system |
| ---                        | ---       | ---                   | ---                     | ---         |
| /boot or /efi or /boot/efi | /dev/sda1 | EFI system partition  | 260Mb                   | vfat        |
| /                          | /dev/sda2 | Linux x86-64 root (/) | 23-32Gb                 | ext4        |
| [SWAP]                     | /dev/sda3 | Linux swap            | More thab 512Mb         | swap        |
| /home                      | /dev/sda4 | Linux /home           | Remainder of the device | ext4        |

#### BIOS/MBR example layout

| Mount point | Partition | Partition type GUID | Boot flag | Suggested size          | File system |
| ---         | ---       | ---                 | ---       | ---                     | ---         |
| /           | /dev/sda1 | Linux               | Yes       | 23-32Gb                 | ext4        |
| [SWAP]      | /dev/sda2 | Linux swap          | No        | More than 512M          | swap        |
| /home       | /dev/sda3 | Linux               | No        | Remainder of the device | ext4        |

#### BIOS/GPT example layout

| Mount point | Partition | Partition type GUID          | Partition attributes | Suggested size          | File system |
| ---         | ---       | ---                          | ---                  | ---                     | ---         |
| None        | /dev/sda1 | BIOS boot partition *ef02*   |                      | 1Mb                     | None        |
| /           | /dev/sda2 | Linux x86-64 root (/) *8304* | Legacy BIOS bootable | 23-32Gb                 | ext4        |
| [SWAP]      | /dev/sda3 | Linux swap *8200*            |                      | More than 512Mb         | swap        |
| /home       | /dev/sda4 | Linux /home *8302*           |                      | Remainder of the device | ext4        |

## Format the partitions

Форматирование в ext4:
```console
mkfs.ext4 /dev/sda1
```
Форматирование swap раздела:
```console
mkswap /dev/sda2
```

Перед установкой нужно примонтировать созданные разделы в **/mnt**.
```console
mount /dev/sda1 /mnt
```

Mount swap:
```console
swapon /dev/sda2
```

> Unmount swap:
```console
swapoff /dev/sda2
```

#### Монтирование NTFS
Для того чтобы смонтировать раздел ntfs нужно установить пакет **ntfs-3g**:
```bash
sudo pacman -S ntfs-3g
```
Если будет возникать такая ошибка. Требуется перезагрузить PC.
```bash
FATAL: Could not load /lib/modules/2.6.34-ARCH/modules.dep: No such file or directory
fuse: device not found, try 'modprobe fuse' first
```

## Installation

#### Select the mirrors

Перед установкой можно настроить mirror servers, они находятся в **/etc/pacman.d/mirrorlist**.
Можно перетащить mirrors на верх списка. Этот файл будет скопирован в новую систему через *pacstrap*

Если нужен файл ***/etc/pacman.d/mirrorlist***, его можно скачать:
```console
curl -o /etc/pacman.d/mirrorlist https://www.archlinux.org/mirrorlist/all/
```
Создаем бекап существуещего ***/etc/pacman.d/mirrorlist***:
```console
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
```
Далее поочередно запускаем команды:
```console
awk '/^## Country Name$/{f=1}f==0{next}/^$/{exit}{print substr($0, 2)}' /etc/pacman.d/mirrorlist.backup
sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist
```

!> **ERROR:** rankmirrirs command not found. Значит нужно установить паке **pacman-contrib**:
```console
pacman -Sy pacman-contrib
```


#### Install the base packages

Use the **pacstrap** script to install the **base** package group:
```console
pacstrap /mnt base base-devel
```

## Настройка системы

Продолжить найстройку можно [тут](https://wiki.archlinux.org/index.php/Installation_guide#Configure_the_system)

Убрать звук спикера **beep**. Нужно в файл ***/etc/inputrc*** или ***~/.inputrc*** добавить:
```console
set bell-style none
```

## Загрузчик GRUB

If you boot OS from usb, you must mount and change rootpath
```console
mount /dev/sdaN /mnt
mount --rbind /dev  /mnt/dev
mount --rbind /proc /mnt/proc
mount --rbind /sys  /mnt/sys
chroot /mnt bash
```

```console
pacman -S grub
grub-install /dev/sda
```

Поумолчанию grub будет отображаться в командной строке, для графического интерфейса нужно
сгенерировать **/boot/grub/grub.cfg** 
```console
grub-mkconfig -o /boot/grub/grub.cfg
```

## Настройка времени
https://wiki.archlinux.org/index.php/Systemd-timesyncd

Время бедет синхронизироватся через NTP (Network Time Protocol).
Для этого понадобится сервис `systemd-timesyncd`.

Перед тем как запустить его необходимо в конфиг `/etc/systemd/timesyncd.conf` дописать:
```bash
[Time]
NTP=0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.fr.pool.ntp.org
```

Чтобы проверить конфигурации можно выполнить это команду `timedatectl show-timesync --all`

Для запуска его просто запускаем `timedatectl set-ntp true`

## Разноцветный вывод
https://wiki.archlinux.org/index.php/User:Grufo/Color_System%27s_Bash_Prompt

`pacman`, также как `ls` и `grep`, выводит все одним цветом, чтобы сделать вывод разноцветным, нужно кое-что изменить в конфигах.

* для `pacman` нужно разкоментировать `#Color` в `/etc/pacman.conf`
* для `ls` & `grep` можно создать `alias ls="ls --color="auto"` в `.bashrc`





