#!/bin/bash

# build.sh

# --
# Build

rm -rf build
rm -rf externals
rm -f pygunrock.so

mkdir build
cd build

export PYG_ANACONDA_PATH=$(dirname $(dirname $(which conda)))
export PYG_TORCH_DIR=$(python -c "import torch; import os; print(os.path.dirname(torch.__file__))")
cmake ..

make -j12 VERBOSE=1

cd ..

cp build/_deps/essentials-build/lib/pygunrock.so ./
# cp build/pygunrock.so ./