#!/bin/sh
echo "Setting ccache..."

export USE_CCACHE=1
export CCACHE_COMPRESS=1

ccache -M 50G

echo "Setting java heap size..."
ram=$(awk '{ printf "%.2f", $2/1024/1024 ; exit}' /proc/meminfo | awk '{printf("%dn",$1 - 1 + 0.5)}')
export _JAVA_OPTIONS=-Xmx$ramG

echo "done."