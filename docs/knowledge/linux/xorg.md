# xorg

## Конфиг

Настройки для X Window System обчно описывают в ***~/.Xresources***, но его можно создать где угодно, 
я создам в ***~/.config/xterm/Xresources***.

Чтобы пречитать наш вайл ***~/.Xresources*** нужно запустить команду:
```bash
xrdb -merge ~/.Xresources
```
> Для того чтобы сохранить настройки для **xorg** навсегда, нужно добавить эту строку в **~/.xinitrc**.

## Настройка терминала st
**st** - simple terminal, легковесный терминал от [suckless](https://st.suckless.org/).
Философия suckless говорит "не используй то что не нужно", по этой причине его нужно сбилдить самому.

**Download:** [st 0.8.2 (2019-02-09)](https://dl.suckless.org/st/st-0.8.2.tar.gz)

Все кастомные настройки делаются в `config.def.h`.


## Настройка терминала urxvt
Статья: [rxvt-unicode](https://wiki.archlinux.org/index.php/Rxvt-unicode)

#### Установка:
```bash
sudo pacman -S rxvt-unicode
```

Устанавливаем шрифты с [GitHub](https://github.com/source-foundry/Hack) или скачиваем спомощью:
```bash
pacman -S ttf-hack
pacman -Syu qwesome-terminal-fonts
```

Config ***~/.Xresources***:
```bash
URxvt.scrollbar: false
URxvt.font: xft:Hack:size=9
URxvt.letterSpace: -1
```



#### Изменение размера шрифта 
1. Клонируем репозиторий [github](https://github.com/simmel/urxvt-resize-font):
```bash
git clone https://github.com/simmel/urxvt-resize-font
```
2. Теперь скопируем ***resize-font*** в ***~/.urxvt/ext/***.
3. Добавляем в ***~/.Xresources***:
```bash
urxvt.perl-ext-common: ...,resize-font,...
```

The default keybindings are
* `Ctrl++` (or `Ctrl+Shift+=`) to increase size
* `Ctrl+-` to decrease size
* `Ctrl+=` to reset size
* `Ctrl+?` to see current size

#### Копирование с терминаал
1. Клонируем репозоторий [github](https://github.com/muennich/urxvt-perls):
```bash
git clone https://github.com/muennich/urxvt-perls
```
2. Копируем ***urxvt-perls/keyboard-select*** в ***.urxvt/ext***.
3. Добавляем в конфиг ***.Xresources***:
```bash
URxvt.perl-ext-common: ...,keyboard-select
URxvt.keyboard-select.clipboard: true
URxvt.keysym.M-s: perl:keyboard-select:search
URxvt.keysym.M-p: perl:keyboard-select:activate
```

> **M** - Meta, по умолчанию это Alt.
* h/j/k/l:    Move cursor left/down/up/right (also with arrow keys)
* g/G/0/^/$/H/M/L/f/F/;/,/w/W/b/B/e/E: More vi-like cursor movement keys
* '/'/?:      Start forward/backward search
* n/N:        Repeat last search, N: in reverse direction
* Ctrl-f/b:   Scroll down/up one screen
* Ctrl-d/u:   Scroll down/up half a screen
* v/V/Ctrl-v: Toggle normal/linewise/blockwise selection
* y/Return:   Copy selection to primary buffer, Return: quit afterwards
* Y:          Copy selected lines to primary buffer or cursor line and quit
* q/Escape:   Quit keyboard selection mode


## Xorg/Kyeboard configuration
Оригинальная статья: [Xorg/Kyeboard configuration](https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration)


Чтобы посмотреть доступные разкладки:
```bash
localectl list-keymaps
```

### Using X configuration files
Here is an example ***/etc/X11/xorg.conf.d/00-keyboard.conf***:
```bash
Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us,ru"
        Option "XkbOptions" "grp:alt_shift_toggle"
EndSection
```

## Switch layout by command
You could use `xkb-switch` (`-n` switches to next layout):
```bash
xkb-switch -n
```

Or `xkblayout-state` (with `set +1` to wrap around, in your case):
```bash
xkblayout-state set +1
```

Or `xte` from xautomation to simulate **Ctr+Shift+L** key press/release:
```bash
te 'keydown Control_L' 'keydown Shift_L' 'keyup Shift_L' 'keyup Control_L'
r
```

## Enable tap to ckick in i3
Статья: [Enable tap to click in i3 WM](https://cravencode.com/post/essentials/enable-tap-to-click-in-i3wm/)

Нужно создать конфиг ***/etc/X11/xorg.conf.d/90-touchpad.conf***:
```console
sudo mkdir -p /etc/X11/xorg.conf.d
sudo touch /etc/X11/xorg.conf.d/90-touchpad.conf
```

Теперь открываем файл в редактере и вставляем следуйщее:
```bash
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
EndSection
```

### Дополнительные опции

Нажатие двумя пальцами вызывает *right-click*, а нажатие тремя пальцами *middle-click*:
```bash
Option "TappingButtonMap" "lrm"
```
Нажатие двумя пальцами вызывает *middle-click*, а нажатие тремя пальцами *right-click*:
```bash
Option "TappingButtonMap" "lmr"
```
Natural scrolling:
```bash
Option "NaturalScrolling" "on"
```
Scrolling двумя пальцами:
```bash
Option "ScrollMethod" "twofinger"
```
Скроллинг используя край тачпада:
```bash
Option "ScrollMethod" "edge"
```

## Disable bell

#### Xorg
```bash
xset -b
```
You can add this command to a astartup file such as `/etc/xprofile` to make it permanent.

