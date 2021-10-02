## AWS

## Insatll aws-cli
Установка aws-cli для **Arch Linux**
```bash
sudo pacman -S aws-cli
```

## Configure aws-cli
Чтобы различные программы могли общаться с aws нужно настроить конфиг aws:
```bash
aws configure
# AWS Access Key ID [None]: AWS Secret Access Key [None]:
# Default region name [None]:
# Default output format [None]:
```

## Extend the file system of EBS volumes
aws documentation: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recognize-expanded-volume-linux.html

```bash
df -hT  # To verify the file system in use for each volume
lsblk   # To check whether the volume has a partition that must be extended
```

Modify ebs volumes on aws
```bash
growpart /dev/nvme0n1 1
# ext4
resize2fs /dev/nvme0n1p1
```

Change terraform config `volume_size`, `volume_ipos`. Apply new terraform, result must be `0 changes`
