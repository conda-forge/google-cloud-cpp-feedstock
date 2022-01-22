#!/bin/bash

set -euo pipefail

pushd build_cmake

ninja install
if [[ "$PKG_NAME" == "libgoogle-cloud" ]]; then
  rm -r ${PREFIX}/lib/cmake/google_cloud_cpp*
  rm -r ${PREFIX}/include/google
fi

popd
