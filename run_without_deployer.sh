#!/usr/bin/env bash

set -e

# Make sure we're doing stuff in test directory
BUILD_SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$BUILD_SCRIPT_DIR"

# Export my_lib recipe to cache
conan export my_lib

# Build my_app from cache
cd my_app
rm -rf build || true
conan install . -s:h build_type=Debug -s:b build_type=Debug --build="*"
cmake --preset conan-debug
cmake --build --preset conan-debug
