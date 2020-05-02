#!/bin/sh

set -e

BEANSTALKD_VERSION="1.10"



# Install build dependencies

apk add --no-cache --virtual .build-deps gcc make musl-dev



# Download source

cd /tmp/

wget --quiet "https://github.com/beanstalkd/beanstalkd/archive/v${BEANSTALKD_VERSION}.tar.gz"

tar -xzf "v${BEANSTALKD_VERSION}.tar.gz"

cd "beanstalkd-${BEANSTALKD_VERSION}/"



# Fix file path reference

sed -i "s|#include <sys/fcntl.h>|#include <fcntl.h>|g" sd-daemon.c



# Build

make

make PREFIX=/usr install

mkdir /var/lib/beanstalkd/



# Clean up

apk del .build-deps

rm -rf /tmp/*



# Check it runs

beanstalkd -v
