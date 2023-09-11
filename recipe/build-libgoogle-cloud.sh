#!/bin/bash

set -euo pipefail

if [[ "$PKG_NAME" == "libgoogle-cloud" ]]; then
  cmake --install build_cmake --component google_cloud_cpp_runtime
else if [[ "$PKG_NAME" == "google-cloud-cpp" ]]; then
  cmake --install build_cmake --component google_cloud_cpp_development
else if [[ "$PKG_NAME" == "google-cloud-cpp-full" ]]; then
  # TODO: this won't be needed once the package is really split into
  #     separate feedstocks.
  cmake ${CMAKE_ARGS} \
      -GNinja -S . -B build_full \
      -DGOOGLE_CLOUD_CPP_ENABLE=kms \
      -DGOOGLE_CLOUD_CPP_USE_INSTALLED_COMMON=ON \
      -DBUILD_TESTING=OFF \
      -DBUILD_SHARED_LIBS=ON \
      -DOPENSSL_ROOT_DIR=$PREFIX \
      -DCMAKE_BUILD_TYPE=release \
      -DCMAKE_CXX_STANDARD=17 \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DProtobuf_PROTOC_EXECUTABLE=$BUILD_PREFIX/bin/protoc \
      -DGOOGLE_CLOUD_CPP_GRPC_PLUGIN_EXECUTABLE=$BUILD_PREFIX/bin/grpc_cpp_plugin \
      -DGOOGLE_CLOUD_CPP_ENABLE_WERROR=OFF
  cmake --build build_full
  cmake --install build_full
fi
