FROM archlinux:latest
ARG CC

RUN pacman -Syu reflector --needed --noconfirm && \
    reflector -c ${CC} --sort score --save /etc/pacman.d/mirrorlist

RUN pacman -S dolphin-emu xdg-desktop-portal-wlr inetutils wayvnc xorg-xwayland sway xorg-xrandr xorg-server mesa-utils \
    npm git xdotool pulseaudio wf-recorder fish libxtst ffmpeg noto-fonts base base-devel tmux python-pip nano htop --noconfirm --needed && \
    useradd -m user && \
    echo "user ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    pip install websockify && \
    mkdir -p /var/run/dbus && \
    dbus-uuidgen > /var/lib/dbus/machine-id && \
    dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

USER user
WORKDIR /home/user

RUN git clone https://github.com/novnc/noVNC && \
    sed -i "/#top_bar {/a \            display: none;" ~/noVNC/vnc_lite.html && \
    mkdir -p /home/user/.local/share/dolphin-emu/StateSaves/

COPY entrypoint.sh /home/user/entrypoint.sh
COPY config /home/user/.config
COPY archive/share /home/user/.local/share

RUN printf "/bin/fish\n" | sudo chsh user && \
    export XDG_RUNTIME_DIR=/tmp/user/$(id -u) && \
    mkdir -p $XDG_RUNTIME_DIR && chmod 0700 $XDG_RUNTIME_DIR && \
    fish -c "set -Ux XDG_RUNTIME_DIR $XDG_RUNTIME_DIR" && \
    sudo chown -R user:user /home/user/

ENTRYPOINT /home/user/entrypoint.sh
