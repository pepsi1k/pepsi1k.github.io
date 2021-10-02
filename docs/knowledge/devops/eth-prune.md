# Overview

Geth (Go-Ethereum) as of March 2021 takes about 350 GiB of space on a fast/snap sync, and then grows by ~ 10 GiB/week.
This will fill a 1TB SSD in ~6 months, to the point where space usage should be brought down again with an offline prune.

Happily, [Geth 1.10.x](https://blog.ethereum.org/2021/03/03/geth-v1-10-0/) introduces "snapshot offline prune", which brings it back down to about its original size. It takes roughly 4 hours to prune the Geth database, and this has to be done while Geth is not running.

Caveat that while several folx have used offline pruning successfully, there is risk associated with it. The two failure modes
we have seen already are:
* There is 25 GiB or less of free disk space
* The pruning process is interrupted partway through

## Prerequisites

- [ ] The volume Geth stores its database on has 50 GiB of free space or more. We know 25 GiB is not enough.
- [ ] Geth 1.10.x installed
- [ ] Geth is fully synced
- [ ] Geth has finished creating a snapshot, and this snapshot is 128 blocks old or older, about 35 minutes. You can tell it is done creating the snapshot when it is no longer showing "generating snapshot" messages in logs. Geth generates a snapshot by default, right after it is done syncing.
- [ ] `tmux` or similar installed: `sudo apt install tmux`. This [intro](https://medium.com/hackernoon/a-gentle-introduction-to-tmux-8d784c404340) is useful for navigating tmux.
    
## What you expect to see

Geth will prune in 3 stages: "Iterating state snapshot", "Pruning state data", and "Compacting database". During the "Compacting database" stage, it may not output any log entries for an hour or so (mainstream SSD IOPS). Don't restart it when this happens, let it run!

If you see messages about "generating snapshot" and an ETA during the prune, you don't actually have a snapshot yet! Either the `--datadir` and/or USER aren't right, or Geth just didn't have enough time to complete the snapshot. In that case, do stop the process, run Geth normally again, and observe its logs until snapshot has completed and is 128 blocks old.

## Pruning if you are using systemd to run Geth

systemd will run something like a `geth` service, with a `User` specified in the `/etc/system/systemd/geth.service` file,
and an `ExecStart` in the same file that runs geth, which also specifies the `--datadir`.

Stop Geth: `sudo systemctl stop geth`

You now have two options, choose whichever is easiest for you.

### Systemd option A, use sudo

* First, start `tmux`.
* Then, with the USER and path to `--datadir` from the systemd service file, run `sudo -u USER geth --datadir /my/data/dir snapshot prune-state`.
* NB: CoinCashew's instructions run geth as the local user, in that case it'd just be `geth --datadir /my/data/dir snapshot prune-state`
 
Note that running as the user Geth usually runs as is critical for the Geth service to still have permissions to its own DB files, when
you start it up again.

Once pruning is complete, start Geth again: `sudo systemctl start geth`

If you don't want to run tmux, you could modify the Geth service instead.

### Systemd option B, modify the existing service

* Edit the existing file: `sudo nano /etc/systemd/system/geth.service` and add this to the very end of `ExecStart`: `snapshot prune-state`
> *Add* this to the existing arguments, do not replace the existing arguments. Geth still needs to know where its `--datadir` is at.
* Tell systemd you made changes: `sudo systemctl daemon-reload`
* Start the Geth service: `sudo systemctl start geth`
* You can observe prune progress with `journalctl -fu geth`
    
Once Geth has finished pruning, undo the changes you made:

* Edit the existing file: `sudo nano /etc/systemd/system/geth.service` and remove this from `ExecStart`: `snapshot prune-state`
* Tell systemd you made changes: `sudo systemctl daemon-reload`
* Start the Geth service: `sudo systemctl start geth`
* You can observe that Geth starts correctly with `journalctl -fu geth`

## Pruning if you are using docker-compose to run Geth

If you are using docker-compose, all you need to do is stop the Geth service, and start it again with pruning parameters.
This has been tested with [eth-docker](https://eth-docker.net/docs/Support/GethPrune). 

> Rocketpool has its own ideosyncracies when it comes to docker-compose, check their
> Discord for a script that does this for you, created by @Mentor.

* `docker-compose stop execution && docker-compose rm execution`
* `docker-compose run --rm --name geth_prune -d execution snapshot prune-state`
* Observe pruning progress with: `docker logs -f --tail 500 geth_prune`
* When pruning is done: `docker-compose up -d execution`
* And observe that Geth is running correctly: `docker-compose logs -f execution`
