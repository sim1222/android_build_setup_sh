#!/bin/sh
echo "Android build setup sh for ubuntu 20.04"
echo -e "/n"

echo "Installing some packages...(and delete old jdk...)"
sudo apt update
sudo apt install git
cd ~/
git clone https://github.com/akhilnarang/scripts
cd scripts
./setup/android_build_env.sh

cd ~/
git clone https://github.com/akhilnarang/scripts
cd scripts
./setup/android_build_env.sh

sudo apt install -y git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig
sudo apt install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-gtk3-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev 


echo "Setting ccache..."
{
echo "export USE_CCACHE=1"
echo "export CCACHE_COMPRESS=1"
} >> ~/.bashrc
ccache -M 50G

echo "Setting java heap size..."
ram=$(awk '{ printf "%.2f", $2/1024/1024 ; exit}' /proc/meminfo | awk '{printf("%dn",$1 - 1 + 0.5)}')
export _JAVA_OPTIONS=-Xmx$ramG

echo "Setting page file..."
swapoff /swap.img
rm /swap.img
fallocate -l 16G /swap.img
mkswap /swap.img
swapon /swap.img
source ~/.bashrc

echo "done. Copy build.sh to android dir and run."
