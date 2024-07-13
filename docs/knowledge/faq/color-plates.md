# terminal color plates
soliris
```
['rgb(7,54,66)', 'rgb(220,50,47)', 'rgb(133,153,0)', 'rgb(181,137,0)', 'rgb(38,139,210)', 'rgb(211,54,130)', 'rgb(42,161,152)', 'rgb(238,232,213)', 'rgb(0,43,54)', 'rgb(203,75,22)', 'rgb(91,150,45)', 'rgb(101,123,131)', 'rgb(131,148,150)', 'rgb(108,113,196)', 'rgb(147,161,161)', 'rgb(253,246,227)']
```

kanagawa
```
['#16161D', '#C34043', '#76946A', '#C0A36E', '#7E9CD8', '#957FB8', '#6A9589', '#C8C093', '#727169', '#E82424', '#98BB6C', '#E6C384', '#7FB4CA', '#938AA9', '#7AA89F', '#DCD7BA']
```


export-gterminal-profile.sh
```bash
#!/bin/bash

outputFile=$1
if [ -z $outputFile ]; then
	echo "Usage: $0 file.dconf"
	exit 1
fi

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")
dconf dump /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ > $outputFile
```

import-gterminal-profile.sh
```bash
#!/bin/bash

inputFile=$1
if [ -z $inputFile ]; then
	echo "Usage: $0 file.dconf"
	exit 1
fi

PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

dconf load /org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/ < "$inputFile"
```

# vscode manually colorize a token

`Ctr+Shift+P` -> "Developer: Inspect Editor Tokens and Scopes" -> click on specific token in your code

```json
// settings.json
"editor.tokenColorCustomizations": {
  "[Kanagawa]": {
    "textMateRules": [
      {
        "scope": [
          "<token>",
        ],
        "settings": {
          "foreground": "#75a67e"
        }
      }
    ],
  }
},
```