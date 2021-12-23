#!/bin/sh
#

set -ue

VER1=""

for VER2 in 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15; do
    if [ -n "${VER1}" ]; then
        balena pull drewmoseley/docker-size-test:${VER1}
        balena pull drewmoseley/docker-size-test:${VER2}
        balena image delta drewmoseley/docker-size-test:${VER1} drewmoseley/docker-size-test:${VER2} 2>&1 | tee /tmp/delta-log.txt
        DELTA_ID=$(grep "Created delta:" /tmp/delta-log.txt | awk -F: '{print $NF}')
        balena tag ${DELTA_ID} drewmoseley/docker-size-test:delta-${VER1}-${VER2}
        balena push drewmoseley/docker-size-test:delta-${VER1}-${VER2}
    fi
    VER1=${VER2}
done
