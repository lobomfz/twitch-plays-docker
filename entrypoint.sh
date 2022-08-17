#!/bin/fish
sed -i "s/REPLACE_ACCESS_TOKEN/$ACCESS_TOKEN/g" ~/twitch-plays/tokens.json
sed -i "s/REPLACE_REFRESH_TOKEN/$REFRESH_TOKEN/g" ~/twitch-plays/tokens.json
sed -i "s/TWITCH_APP_CLIENT_ID/$CLIENT_ID/g" ~/twitch-plays/settings.json
sed -i "s/TWITCH_APP_CLIENT_SECRET/$CLIENT_SECRET/g" ~/twitch-plays/settings.json
sed -i "s/TWITCH_CHAT_CHANNEL_NAME/$CHANNEL/g" ~/twitch-plays/settings.json
cd ~/twitch-plays
npm install
/home/user/archive/backuper.sh &

PULSE_SERVER=host.docker.internal DISPLAY=:0 dolphin-emu -v OGL -e ~/archive/${GAME_FILE}
DISPLAY=:0 /home/user/twitch-plays/runbot.sh