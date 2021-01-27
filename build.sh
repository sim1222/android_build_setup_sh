#!/bin/sh
. build/envsetup.sh
lunch
make -j$(nproc) bacon