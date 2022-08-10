#!/bin/fish
pulseaudio &
set -Ux XDG_RUNTIME_DIR /tmp/user/(id -u)

sed -i "s/REPLACE_ACCESS_TOKEN/$ACCESS_TOKEN/g" ~/twitch-plays/tokens.json
sed -i "s/REPLACE_REFRESH_TOKEN/$REFRESH_TOKEN/g" ~/twitch-plays/tokens.json
sed -i "s/TWITCH_APP_CLIENT_ID/$CLIENT_ID/g" ~/twitch-plays/settings.json
sed -i "s/TWITCH_APP_CLIENT_SECRET/$CLIENT_SECRET/g" ~/twitch-plays/settings.json
sed -i "s/TWITCH_CHAT_CHANNEL_NAME/$CHANNEL/g" ~/twitch-plays/settings.json

websockify --web /home/user/noVNC 6080 localhost:5900 -D --heartbeat=30

cd ~/archive/rtsp/
./rtsp-simple-server &

cd ~/twitch-plays
npm install

/home/user/archive/backuper.sh &

WLR_BACKENDS=headless sway
