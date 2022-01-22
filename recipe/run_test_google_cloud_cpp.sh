#!/bin/bash

# Stop on first error
set -euo pipefail

cmake -GNinja \
    -S google/cloud/storage/quickstart -B .build/quickstart \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_PREFIX_PATH="$PREFIX" \
    -DCMAKE_MODULE_PATH="$PREFIX/lib/cmake"
cmake --build .build/quickstart
