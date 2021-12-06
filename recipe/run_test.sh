#!/bin/bash

# Stop on first error
set -euo pipefail

cmake -GNinja \
    -S google/cloud/storage/quickstart -B .build/quickstart \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_PREFIX_PATH="$PREFIX" \
    -DCMAKE_MODULE_PATH="$PREFIX/lib/cmake"
cmake --build .build/quickstart

test -f $PREFIX/lib/libgoogle_cloud_cpp_storage${SHLIB_EXT}
test -f $PREFIX/lib/pkgconfig/google_cloud_cpp_storage.pc
test -f $PREFIX/lib/cmake/google_cloud_cpp_storage/google_cloud_cpp_storage-config.cmake
test -f $PREFIX/include/google/cloud/storage/version.h
test -f $PREFIX/lib/libgoogle_cloud_cpp_bigtable${SHLIB_EXT}
test -f $PREFIX/lib/cmake/google_cloud_cpp_bigtable/google_cloud_cpp_bigtable-config.cmake
test -f $PREFIX/include/google/cloud/bigtable/version.h
