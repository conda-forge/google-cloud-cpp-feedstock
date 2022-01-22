#!/bin/bash

set -euo pipefail

if [[ "$PKG_NAME" == "libgoogle-cloud" ]]; then
  cmake --install build_cmake --component google_cloud_cpp_runtime
else
  cmake --install build_cmake --component google_cloud_cpp_development
fi
