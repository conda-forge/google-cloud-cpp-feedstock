#!/bin/bash

set -euo pipefail

case "${PKG_NAME}" in
  libgoogle-cloud-all-devel)
    cmake --install build --component google_cloud_cpp_development
    ;;
  libgoogle-cloud-all)
    cmake --install build --component google_cloud_cpp_runtime
    ;;
esac
