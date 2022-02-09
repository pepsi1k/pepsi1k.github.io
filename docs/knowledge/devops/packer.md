### Bring your own image

1. Install hashicorp packer 
    ```bash
    sudo pacman -S packer
    ```

1. Download some image, for example **ubuntu server** https://wiki.ubuntu.com/Releases

1. Prepare virtualizator 
    
    Install [qemu](https://wiki.archlinux.org/title/QEMU)
    ```bash
    # main package
    sudo pacman -S qemu
    # extra architectures support 
    sudo pacman -S qemu-arch-extra 
    ```

    Create virtual image with specific format, [raw qcow2 lvm](https://ivirt-it.ru/raw-qcow2-lvm/)
    ```bash
    qemu-img create -f qcow2 ubuntu-server.qcow2 6G
    ```

    Test image
    ```bash
    qemu-system-x86_64 \
      -enable-kvm \
      -cdrom ubuntu-20.04.3-live-server-amd64.iso \
      -boot order=d \
      -drive file=ubuntu-server.qcow2,media=disk
    ```

