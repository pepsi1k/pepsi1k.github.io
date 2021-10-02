#rTorrent

Установка:
```bash
sudo pacman -S rtorrent
```

Before running rTorrent, copy the example configuration file `/usr/share/doc/rtorrent/rtorrent.rc` to 
`~/.rtorrent.rc`.

> Vim may mistake the syntax of the config file, causing errors in the highlighting. 
To resolve this you can append a modeline `#vim: set syntax=conf:` to `~/.rtorrent.rc`, or install [rtorrnet-syntax-file](https://github.com/vim-scripts/rtorrent-syntax-file).
