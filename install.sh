#!/bin/sh

set -e

BEANSTALKD_VERSION="1.12"



# Install build dependencies

apk add --no-cache --virtual .build-deps gcc make musl-dev pkgconfig



# Download source

cd /tmp/

wget --quiet "https://github.com/beanstalkd/beanstalkd/archive/v${BEANSTALKD_VERSION}.tar.gz"

tar -xzf "v${BEANSTALKD_VERSION}.tar.gz"

cd "beanstalkd-${BEANSTALKD_VERSION}/"



# Build

make

make check -j1 VERBOSE=1

make PREFIX=/usr install

mkdir /var/lib/beanstalkd/



# Clean up

apk del .build-deps

rm -rf /tmp/*



# Check it runs

beanstalkd -v
