#!/bin/sh
#

set -ue

VER1=""

for VER2 in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15; do
    if [ -n "${VER1}" ]; then
        echo "======================================="
        echo "Comparing Versions: ${VER1} and ${VER2}"
        balena pull drewmoseley/docker-size-test:${VER1} > /dev/null 2>&1
        balena pull drewmoseley/docker-size-test:${VER2}
        balena rmi drewmoseley/docker-size-test:${VER2} > /dev/null 2>&1
        balena pull drewmoseley/docker-size-test:delta-${VER1}-${VER2}
        echo "======================================="
    fi
    VER1=${VER2}
done
