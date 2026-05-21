#!/usr/bin/env bash
set -e

cd /work

mkdir -p build
cd build

export CC=afl-clang-fast
export CXX=afl-clang-fast++

cmake /opt/clamav \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=RelWithDebInfo

ninja
