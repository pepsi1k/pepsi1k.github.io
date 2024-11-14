

# recovery file if it's open by another process

```bash
# find specific pid
ps -u <user> | grep <program>

# list files by a specific process
lsof -p <PID>
lsof -p <PID> | grep filename

# we need to see the list of opened file descriptors
ls -l /proc/<PID>/fd

# copy opend file
cp /proc/<PID>/fd/<fd-id> <path>
```

# recovery deleted files with ext4
https://gist.github.com/pepsi1k/d6b326675f711c6ad338cdd09869e43c


```bash
sudo debugfs -R "dump <8> /opt/sda6.journal" /dev/sda6
sudo apt-get install ext4magic

# unmount the partition and list recoverable files.
umount /home
ext4magic /dev/sda6 -a $(date -d "-6hours" +%s) -f user/folder -j /opt/sda6.journal -l

# to actually recover the file 
ext4magic /dev/sda6 -a 1332606716 -f user/folder -j /tmp/sda6.journal -r -d /opt/RECOVER
```