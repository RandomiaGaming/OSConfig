#!/bin/bash
# Initializes and sets up a new debian install.
# Written by RandomiaGaming

# Before any installations make sure the local package cache is up to date.
apt update

# Install the best desktop environment
apt install kde-plasma-desktop
dpkg-reconfigure sddm
systemctl enable sddm
apt install sddm-theme-breeze
echo -e "[Theme]\nCurrent=breeze" > /etc/sddm.conf

# Install our favorite terminal emulator Alacritty
apt install alacritty

# Install our favorite code editor VSCode
apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
apt install apt-transport-https
apt update
apt install code

# Install language compilers and tools
apt install gcc
apt install g++
apt install nasm
apt install python3
apt install nodejs
apt install gdb
apt install git

# Install mono
apt install dirmngr gnupg apt-transport-https ca-certificates software-properties-common
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
apt-add-repository 'deb https://download.mono-project.com/repo/ubuntu stable-focal main'
apt update
apt install mono-complete

# Install our favorite hex editor Bless
apt install bless

# Install our favorite media player
apt install vlc

# Install the best free video editor
apt install kdenlive

# Install the best free audio editor
apt install audacity

# Install GParted
apt install gparted

# Install discord
echo Download ./discord.deb then press Ctrl+C
open "https://discord.com/api/download?platform=linux&format=deb"
apt install ./discord.deb
rm -f discord.deb

# Install steam
wget -O "/etc/apt/keyrings/steam.gpg" "https://repo.steampowered.com/steam/archive/stable/steam.gpg"
tee /etc/apt/sources.list.d/steam-stable.list <<'EOF'
deb [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ stable steam
deb-src [arch=amd64,i386 signed-by=/usr/share/keyrings/steam.gpg] https://repo.steampowered.com/steam/ stable steam
EOF
apt update
apt install steam-launcher

# Finally make sure everything is up to date and ready to go
apt update
apt upgrade
apt autoremove