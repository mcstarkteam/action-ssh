#!/usr/bin/bash

echo $PWD

git config --global user.email "2987456283@qq.com"
git config --global user.name "neoterm-extra"

cd ~
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh

mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git # (or, using ssh, "git clone git@gitlab.com:OrangeFox/sync.git")
cd ~/OrangeFox_sync/sync/
yes | ./orangefox_sync.sh --branch 11.0 --path ~/fox_11.0

# These are example commands
cd ~/fox_11.0 # (or whichever directory hosts the synced manifest)
git clone https://github.com/neoterm-extra/orangefox_device_nx531j device/nubia/nx531j

cd ~/fox_11.0 # (or whichever directory has the synced manifest)
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export LC_ALL="C"

lunch twrp_nx531j-eng -j8
mka recoveryimage -j8
