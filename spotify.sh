#!/bin/bash
#
# File: spotify.sh
#
# This script installs Spotify (Web) App into Vivid Unit
#
# Version: 0.10
#

#===================
#=== preparation ===
#===================

set -e

# get network time and set to system
sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | sed -n 's/^ *Date: *//p')"

# install aptitude to solve package conflicts easily
sudo apt install -y aptitude


#============================================
#=== replace Chromium with RPi's Chromium ===
#============================================

echo "Replacing Chromium browser..."

# remove the default chromium browser
sudo apt remove -y --allow-change-held-packages chromium-x11-dbgsym chromium-x11

# add armhf architecture
sudo dpkg --add-architecture armhf

# add raspberry pi archive to source list
echo 'deb http://archive.raspberrypi.org/debian/ bullseye main' | sudo tee -a /etc/apt/sources.list.d/uugear.list

# add the key for raspberry pi archive
wget -qO - https://archive.raspberrypi.org/debian/raspberrypi.gpg.key | sudo apt-key add -

# update the source
sudo apt update

# install required dependency
sudo aptitude install -y libc6:armhf libnss3:armhf

# install the chromium browser from raspberry pi archive
sudo aptitude install -y chromium-browser:arm64

# install libwidevinecdm0 to support DRM playback
sudo aptitude install -y libwidevinecdm0:arm64

# link chromium-browser to chromium
sudo ln -s /usr/bin/chromium-browser /usr/bin/chromium

# use chromium-browser icon
sed -i 's/^Icon=chromium$/Icon=chromium-browser/' "$HOME/.config/xfce4/panel/launcher-7/16598787213.desktop"

# remove raspberry pi source from source list
sudo sed -i '/^deb http:\/\/archive\.raspberrypi\.org\/debian\/ bullseye main$/d' /etc/apt/sources.list.d/uugear.list

# remove the key for raspberry pi archive
sudo apt-key del 7FA3303E

echo "Chromium browser has been replaced."


#===================================
#=== create Spotify Chromium App ===
#===================================

echo "Creating Spotify app..."

# variables
APP_NAME="Spotify"
APP_URL="https://open.spotify.com"
APP_ICON="Spotify"
DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
DESKTOP_SHORTCUT_PATH="$HOME/Desktop/$APP_NAME.desktop"

# download the icon
mkdir -p "$HOME/.local/share/icons/hicolor/512x512/apps/"
curl -s 'https://www.vividunit.com/images/7/71/Spotify_512.png' -o "$HOME/.local/share/icons/hicolor/512x512/apps/Spotify.png"

# create the desktop entry
echo "[Desktop Entry]
Name=$APP_NAME
Exec=/usr/bin/chromium --app=$APP_URL --start-maximized
Terminal=false
Type=Application
Icon=$APP_ICON
Categories=Network;WebBrowser;" > $DESKTOP_ENTRY_PATH
chmod +x $DESKTOP_ENTRY_PATH

# create a shortcut on the desktop
cp $DESKTOP_ENTRY_PATH $DESKTOP_SHORTCUT_PATH
chmod +x $DESKTOP_SHORTCUT_PATH

echo 'The Spotify app has been installed and placed on desktop.'

set +e