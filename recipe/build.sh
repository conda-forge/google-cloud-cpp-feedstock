#!/bin/bash

set -euo pipefail

export OPENSSL_ROOT_DIR=$PREFIX

if [[ "${target_platform}" == osx-* ]]; then
  # See https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

# This list represents some of the larger features in `google-cloud-cpp`.
# Moving them to their own feedstock splits the build time across feedstocks.
# The features happen to be AI and ML related, which provides a good mnemonic
# for the feedstock.  They are not, however, all the AI based features in
# `google-cloud-cpp`.
feature_list=(
  # Provided by `google-cloud-cpp-core-feedstock`
  oauth2
  bigtable
  iam
  policytroubleshooter
  pubsub
  spanner
  storage
  # Provided by `google-cloud-cpp-bigquery-feedstock`.
  bigquery
  # Provided by `google-cloud-cpp-compute-feedstock`.
  compute
  # Provided by `google-cloud-cpp-compute-ai-feedstock`.
  aiplatform
  automl
  discoveryengine
  dialogflow_es
  dialogflow_cx
  dlp
  speech
)
disabled=$(printf ",-%s" "${feature_list[@]}")

echo "$(date -u '+%Y-%m-%dT%H:%M:%SZ'): Building all - (${feature_list[@]})"
cmake ${CMAKE_ARGS} \
      -GNinja -S . -B build \
      -DGOOGLE_CLOUD_CPP_ENABLE=__ga_libraries__${disabled} \
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
cmake --build build
echo "$(date -u '+%Y-%m-%dT%H:%M:%SZ'): DONE all - (${feature_list[@]})"
