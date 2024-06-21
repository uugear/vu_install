#!/bin/bash
#
# File: gqrx.sh
#
# This script installs Gqrx SDR (and GNU Radio Companion) into Vivid Unit.
# It runs volk_profile during the installation, which takes a few minutes.
# The first time to run Gqrx would take rather long to initiate everything.
#
# Version: 0.10
#

#===================
#=== preparation ===
#===================

set -e

# get network time and set to system
sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | sed -n 's/^ *Date: *//p')"


sudo apt update

sudo apt install -y gr-osmosdr gnuradio-dev libusb-1.0-0-dev git cmake debhelper


#===========================
#=== RTL-SDR Blog Driver ===
#===========================

echo 'Installing RTL-SDR Blog Driver...'

git clone https://github.com/rtlsdrblog/rtl-sdr-blog

cd rtl-sdr-blog

sudo dpkg-buildpackage -b --no-sign

cd ..

sudo dpkg -i librtlsdr0_*.deb
sudo dpkg -i librtlsdr-dev_*.deb
sudo dpkg -i rtl-sdr_*.deb

sudo rm -R *.deb *.buildinfo *.changes rtl-sdr-blog


#===================
#=== Gqrx binary ===
#===================

echo 'Download pre-built gqrx file...'

sudo curl -s https://www.vividunit.com/download/files/gqrx -o /usr/local/bin/gqrx

sudo chmod +x /usr/local/bin/gqrx


#====================
#=== volk_profile ===
#====================
echo 'Run volk_profile, this will take a while...'

volk_profile


#================
#=== Gqrx App ===
#================
echo 'Creating application icon on desktop...'

# variables
APP_NAME="Gqrx"
APP_ICON_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
APP_ICON="$APP_ICON_DIR/Gqrx.png"
DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/$APP_NAME.desktop"
DESKTOP_SHORTCUT_PATH="$HOME/Desktop/$APP_NAME.desktop"

# download the icon
mkdir -p $APP_ICON_DIR
curl -s 'https://www.vividunit.com/images/1/15/Gqrx.png' -o $APP_ICON

# create the desktop entry
echo "[Desktop Entry]
Name=$APP_NAME
Exec=/usr/local/bin/gqrx
Terminal=false
Type=Application
Icon=$APP_ICON
Categories=AudioVideo;Recorder;Player;Multimedia;
MimeType=application/x-gqrx;
Keywords=SDR;Radio;Receiver;" > $DESKTOP_ENTRY_PATH
chmod +x $DESKTOP_ENTRY_PATH

# create a shortcut on the desktop
cp $DESKTOP_ENTRY_PATH $DESKTOP_SHORTCUT_PATH
chmod +x $DESKTOP_SHORTCUT_PATH

echo 'The Gqrx application has been installed and placed on desktop.'

set +e