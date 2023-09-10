#!/bin/bash

set -euo pipefail

export OPENSSL_ROOT_DIR=$PREFIX

if [[ "${target_platform}" == osx-* ]]; then
  # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

FEATURES=bigtable,iam,pubsub,storage,spanner
USE_INSTALLED_COMMON=OFF
if [[ "$PKG_NAME" == "google-cloud-cpp-full" ]]; then
  FEATURES=__ga_libraries__,-bigtable,-iam,-pubsub,-storage,-spanner
  USE_INSTALLED_COMMON=ON
fi

cmake ${CMAKE_ARGS} \
    -GNinja -S . -B build_cmake \
    -DGOOGLE_CLOUD_CPP_ENABLE=$FEATURES \
    -DGOOGLE_CLOUD_CPP_USE_INSTALLED_COMMON=$USE_INSTALLED_COMMON \
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

cmake --build build_cmake
