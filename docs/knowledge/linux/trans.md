# Translate Shell

**Translate Shell** - это переводчик командной строки, работающий на **Google Translate(by default)**,
а также **Bing Translator**, **Yandex.Translate**, **DeepL Translator**.


## Установка
```console
sudo pacman -S translate-shell
```


## User guid

Перевод слова:
```bash
trans dog
```
Перевод строки:
```bash
trans "to display help section"
```
Перево с русского на английский:
```bash
trans ru:en собака
```
Короткий вывод:
```bash
trans -b dog
```
Прослушать перевод и полный вывод:
```bash
trans -speak dog
```



## Настройка
Можно настоить конфиг так чтобы по умолчанию переводило с английского на русский.
Вставляем в файл ***~/.config/translate-shell/init.trans*** следуйщее:
```bash
{
 :hl              "en"
 :tl              "ru"
}
```

Создание **alias**, для этого добавим в файл ***~/.bashrc*** следующее:
```bash
alias t='trans -b'
alias ts='trans -speak'
```
