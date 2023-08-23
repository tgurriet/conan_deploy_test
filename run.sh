#!/usr/bin/env bash

set -e

# Make sure we're doing stuff in test directory
BUILD_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$BUILD_SCRIPT_DIR"

# Export my_lib recipe to cache
conan export my_lib

# Deploy my_lib
rm -rf deploy || true
mkdir deploy
cd deploy
conan install --requires="my_lib/1.0" --generator=CMakeDeps --generator=CMakeToolchain --deployer=full_deploy --build="*"

# Build my_app
source conanbuild.sh
cd ../my_app
rm -rf build || true
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../../deploy/conan_toolchain.cmake
cmake --build .
