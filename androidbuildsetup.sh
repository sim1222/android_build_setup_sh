#!/bin/sh
echo "Android build setup sh for ubuntu 20.04"
echo -e "/n"
echo "Installing some packages...(and delete old jdk...)"
sudo apt-get update
sudo apt-get purge openjdk-* -y
sudo apt-get purge icedtea-* -y
sudo apt-get purge icedtea6-* -y
sudo apt-get install bison g++-multilib git gperf libxml2-utils make zlib1g-dev:i386 zip liblz4-tool libncurses5 libssl-dev bc flex openjdk-11-jdk python ccache -y
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev python
java -version

echo "Setting repo and ccache..."
mkdir ~/bin
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
{
echo "export PATH=~/bin:$PATH" 
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
souece ~/.bashrc

echo "done. Copy build.sh to android dir and run."
