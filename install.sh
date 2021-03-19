#!/bin/bash

# run.sh

# -----------------------------------------
# System level stuff

# --
# Install anaconda
# 
# !! For some reason, pytorch=1.8 install fails w/ AWS Deep Learning image pre-installed anaconda
#    so we re-install it here, and move the old one. YMMV.

# # Move old conda
# mv /home/ubuntu/anaconda3 /home/ubuntu/anaconda3_orig

# # Install conda
# wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
# bash Anaconda3-2020.11-Linux-x86_64.sh -b -p /home/ubuntu/anaconda3
# rm Anaconda3-2020.11-Linux-x86_64.sh

# --
# Set CUDA version to 11.1
# !! 11.0 should work as well.
# - Matching `cudnn` version to pytorch may be important. cudnn=8.0.5 for pytorch=1.8.0 as of 3/19/21.

# sudo rm /usr/local/cuda
# sudo ln -s /usr/local/cuda-11.1/ /usr/local/cuda

# --
# Upgrade cmake

# wget https://github.com/Kitware/CMake/releases/download/v3.20.0-rc5/cmake-3.20.0-rc5-linux-x86_64.sh
# bash cmake-3.20.0-rc5-linux-x86_64.sh
# export PATH=$(pwd)/cmake-3.20.0-rc5-linux-x86_64/bin:$PATH
# rm cmake-3.20.0-rc5-linux-x86_64.sh

# -----------------------------------------
# python_essentials installation

# --
# Setup conda environment

conda create -y -n pyg_env python=3.7
conda activate pyg_env

conda install -y pytorch=1.8.0 cudatoolkit=11.1 \
    -c pytorch -c conda-forge

pip install scipy==1.6.1

# --
# pybind11

git clone https://github.com/pybind/pybind11

# --
# build

./build.sh # > build.log

# --
# test

python test.py

# Should print:
# tensor([0., 2., 2., 2., 2., 2., 1., 1., 2., 2., 1., 1., 1., 2., 2., 2., 2., 2.,
#         2., 2., 2., 1., 1., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 1., 1., 2.,
#         1., 2., 1.], device='cuda:0')
# tensor([2., 0., 2., 2., 2., 2., 1., 1., 1., 2., 1., 1., 1., 2., 2., 2., 2., 2.,
#         2., 2., 2., 1., 1., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 3., 1., 1.,
#         2., 2., 1.], device='cuda:0')
# tensor([2., 2., 0., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 1., 1., 1., 1., 1.,
#         2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 3., 2., 1.,
#         3., 3., 1.], device='cuda:0')