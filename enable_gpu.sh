#!/bin/bash
#
# File: enable_gpu.sh
#
# This script fully enable the GPU hardware acceleration on Vivid Unit.  
# 
# It upgrades Linux kernel to 5.15 for newer Panfrost driver.
# It installs newer Mesa driver 21.2.6.
#
# After upgrading, reboot the device and run "glxinfo -B" to check the
# result, you will see "Mali-T860 (Panfrost)" as OpenGL render string.
#
# Version: 1.00
#

#===================
#=== preparation ===
#===================
sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | sed -n 's/^ *Date: *//p')"

sudo apt update

sudo apt install -y aptitude

#======================
#=== upgrade kernel ===
#======================
echo "Upgrading Kernel 5.15..."
sudo apt install -y vu-kernel-5.15

#========================
#=== upgrade x-server ===
#========================
echo "Upgrading X-Server..."
sudo aptitude install -y xserver-xorg-core

#===========================
#=== install mesa 21.2.6 ===
#===========================
echo "Installing MESA 21.2.6..."
wget https://www.vividunit.com/download/files/mesa_21.2.6.zip
unzip mesa_21.2.6.zip
cd mesa_21.2.6
chmod +x ./install.sh
./install.sh
cd ..
sudo rm -R mesa_21.2.6
rm -f mesa_21.2.6.zip

#=============================
#=== rename mali directory ===
#=============================
cd ..
sudo mv /usr/lib/aarch64-linux-gnu/mali  /usr/lib/aarch64-linux-gnu/mali_DEL

echo "Upgrade is done, please reboot your device."
