#!/bin/bash
pkill dolphin-emu
PULSE_SERVER=host.docker.internal QT_QPA_PLATFORM=xcb dolphin-emu -v OGL -e ~/archive/${GAME_FILE}
