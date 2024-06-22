# SSH подключение

**SSH** - Secure Shell, сетевой протокол прикладного уровня, позволяющий производить удалённое управление операционной системой и туннелирование TCP-соединений. По умолчанию используется порт 22, но в целях безопасности порт ssh часто изменяют.

**OpenSSH** - набор програм для удаленного доступа используя протокол ssh.

### Установка

```bash
sudo apt-get install openssh-client # Клиентская часть
sudo apt-get install openssh-server # Серверная часть

sudo pacman -S openssh
```

Запуск сервера:
```bash
systemctl start sshd
systemctl is-active sshd # проверка на активность
systemctl is-enable sshd # проверка на автозагрузку
systemctl enable sshd # включить автозагрузку
systemctl disable sshd # отключить автозагрузку
```


Подключение через ssh. Дальше попросит ввести пароль пользователя.
```bash
ssh user@server
```

### SCP передача файлов

**SCP** - (Secure Copy Command) утилита для передачи файлов через ssh.

Скопировать локальный файл на сервер:
```bash
scp file.gz user@server:/home/dir
```
Скопировать файл с сервера:
```bash
scp user@server:file.txt /home/user
scp -r user@server:/path/to/folder /home/user # Копирование директорий
```

> Если не указывать полный путь, файл будет копироваться из/в домашнюю директорию

### Генерация ключей

Генераци ключей происходит в директории `~/.ssh` командой `ssh-keygen`.
```bash
ssh-keygen -t rsa -b 4096 -C "bohdan@home"
ssh-keygen -t ecdsa -b 384 -C "bohdan@home" -f bohdan
# better algorithm
ssh-keygen -t ed25519 -b 384 -C "bohdan@home" -f bohdan 
```

RSA: Equal or greater-than to 1024 bit.
ECDSA: 256, 384, or 521 bit.
ED25519: 256 bit.
DSS: 1024 bit.

* `id_rsa` - приватный ключ
* `id_rsa` - публичный ключ
* `authorized_keys` - хранит в себе публичные ключи от тех кто может подключиться

Передача публичного ключа на сервер
```bash
cat ~/.ssh/id_rsa.pub | ssh user@hostname 'cat >> .ssh/authorized_keys'
```

Чтобы постоянно не прописывать путь к ключу для специфического хоста, можно настроить `~/.ssh/config`:
```
host github.com
	HostName github.com
	IdentityFile ~/.ssh/id_rsa_github
	User git
	PreferredAuthentications publickey
```