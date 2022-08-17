FROM archlinux:latest
ARG COUNTRY_CODE

RUN pacman -Syu reflector --needed --noconfirm && \
    reflector -c us --sort score --save /etc/pacman.d/mirrorlist

RUN pacman -S dolphin-emu inetutils npm git xdotool pulseaudio fish libxtst\
    noto-fonts base base-devel tmux python-pip nano htop --noconfirm --needed && \
    useradd -m ubuntu

USER ubuntu
WORKDIR /home/ubuntu

COPY entrypoint.sh /home/ubuntu/entrypoint.sh

ENTRYPOINT /home/ubuntu/entrypoint.sh
