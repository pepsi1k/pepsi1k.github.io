### Sending a notification message to Telegram using its HTTP API via cURL

1. [Create a bot](https://core.telegram.org/bots#6-botfather)
2. Get the bot's API token from [@BotFather](https://telegram.me/BotFather)
3. Add your bot to the chat you'll be sending messages to
3. Get the ID of the chat  
   a. Fetch bot updates and look for the chat id:  
      ```shell
      curl https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/getUpdates | jq -r '.result[].message.chat.id'
      ```
   b. OR, run [bot.rb](https://gist.github.com/dideler/85de4d64f66c1966788c1b2304b9caf1#file-bot-rb) and @-mention your bot in the chat. The chat id will appear in `bot.rb`'s output.  
     The bot may need temporary message access: `@BotFather Bot Settings Group Privacy > Turn off`
4. Send a message using the HTTP API: https://core.telegram.org/bots/api#sendmessage  
   ```shell
   curl -X POST \
        -H 'Content-Type: application/json' \
        -d '{"chat_id": "123456789", "text": "This is a test from curl", "disable_notification": true}' \
        https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
   ```


### script

```shell
CHAT_ID="<your_chat_id>"
MESSAGE="Your message here"
BOT_TOKEN="<your_bot_token>"

curl -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
     -H "Content-Type: application/json" \
     -d "{\"chat_id\": \"${CHAT_ID}\", \"text\": \"${MESSAGE}\"}"
```

Example, copy script to /usr/local/bin/notify-on-ssh-login.sh:

```shell
#!/bin/bash

TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
ID="xxxxxxxxxxxxxx"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

if [ "$PAM_TYPE" != "open_session" ]
then
	exit 0
else
	curl -s -X POST $URL -d chat_id=$ID -d text="$(echo -e "Host: `hostname`\nUser: $PAM_USER\nHost: $PAM_RHOST")" /dev/null 2>&1
	exit 0
fi
```

Add to end file /etc/pam.d/sshd

```shell
session    optional     pam_exec.so  /usr/local/bin/notify-on-ssh-login.sh
```
