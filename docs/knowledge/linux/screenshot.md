## Screenshot on linux

Философия Linux: ***"Write programs that do one thing and do it well."***
Поэтому чтобы сделать screenshot, нужно сделать несколько операций, узнать координаты 
и передать их через pipeline другой программе которая сделать скриншот.

Для начало скачаем `xrectsel` c AUR, она как раз и берет координаты с экрана:
```console
git clone https://aur.archlinux.org/xrectsel.git 
cd xrectsel
makepkg -sri
```

Скачаем `maim` это приложение делает снимок, также нужно установить compositor for X11, я выбрал `picom`
```console
sudo pacman -S maim picom
```

Теперь можем создать снимок. Он сохранится в **clipboard**
```console
maim -g $(xrectsel) | xclip -selection clipboard -t image/jpeg
```

```bash
# take screanshot from current active window
"maim -s | xclip -selection clipboard -t image/jpeg"
	Print
# take screanshot from selected region
"maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/jpeg"
	Shift+Print
# take screanshot from full display
"maim | xclip -selection clipboard -t image/jpeg"
	Control+Print
```



