#!/bin/bash
pkill dolphin-emu
PULSE_SERVER=host.docker.internal dolphin-emu -v OGL -e ~/archive/${GAME_FILE}
