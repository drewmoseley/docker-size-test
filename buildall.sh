#!/bin/sh
#
# Build all docker images
#

VERSIONS=$(echo Dockerfile.* | awk -F. 'BEGIN{RS=" ";} {print $NF}' | sort --numeric)
for VERSION in ${VERSIONS}; do
    docker build . -f Dockerfile*.${VERSION} -t drewmoseley/docker-size-test:${VERSION}
    docker push drewmoseley/docker-size-test:${VERSION}
done
