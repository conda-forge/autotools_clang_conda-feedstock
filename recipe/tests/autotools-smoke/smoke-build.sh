#!/bin/bash
set -euxo pipefail

autoreconf -vfi
./configure --prefix="${PREFIX}"
if [[ "${target_platform}" == "win-arm64" ]]; then
  grep -F "build='aarch64-w64-mingw32'" config.log
  grep -F "host='aarch64-w64-mingw32'" config.log
fi
patch_libtool
make -j"${CPU_COUNT:-2}"
make check
make install
