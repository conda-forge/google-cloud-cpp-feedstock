#!/bin/bash

set -euo pipefail

if [[ "$PKG_NAME" == "libgoogle-cloud" ]]; then
  cmake --install build_cmake --component google_cloud_cpp_runtime
elif [[ "$PKG_NAME" == "google-cloud-cpp" ]]; then
  cmake --install build_cmake --component google_cloud_cpp_development
elif [[ "$PKG_NAME" == "libgoogle-cloud-cpp-full" ]]; then
  cmake --install build_cmake_full --component google_cloud_cpp_runtime
elif [[ "$PKG_NAME" == "google-cloud-cpp-full" ]]; then
  cmake --install build_cmake_full --component google_cloud_cpp_development
fi
