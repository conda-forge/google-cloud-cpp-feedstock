#!/bin/bash

set -euo pipefail

export OPENSSL_ROOT_DIR=$PREFIX

if [[ "${target_platform}" == osx-* ]]; then
  # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

cmake ${CMAKE_ARGS} \
    -GNinja -S . -B build_cmake \
    -DGOOGLE_CLOUD_CPP_ENABLE=bigtable,iam,pubsub,storage,spanner \
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

#
# TODO: the rest of this file just shows how to build with the core components
#   pre-installed. We need to choose if we create a new package that hosts the
#   core components (e.g. google-cloud-cpp-core-feedstock) or a new package that
#   hosts the full build (e.g. google-cloud-cpp-full-feedstock)
#
cmake --install build_cmake --prefix stage

echo =======================================================================
echo CMAKE_ARGS=${CMAKE_ARGS}
echo =======================================================================
echo PWD="$(pwd)"
echo =======================================================================
echo =======================================================================

# TODO: replace =kms with =__ga_libraries__,-bigtable,-iam,-pubsub,-storage,-spanner 
cmake ${CMAKE_ARGS} \
    -GNinja -S . -B build_cmake_full \
    -DGOOGLE_CLOUD_CPP_ENABLE=kms \
    -DGOOGLE_CLOUD_CPP_USE_INSTALLED_COMMON=ON \
    -DCMAKE_PREFIX_PATH="${CMAKE_PREFIX_PATH};${PWD}/stage" \
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

cmake --build build_cmake_full
