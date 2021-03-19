#!/bin/bash

# run.sh

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
# Set CUDA version to 11.0

# sudo rm /usr/local/cuda
# sudo ln -s /usr/local/cuda-11.0/ /usr/local/cuda

# --
# Upgrade cmake

# wget https://github.com/Kitware/CMake/releases/download/v3.20.0-rc5/cmake-3.20.0-rc5-linux-x86_64.sh
# bash cmake-3.20.0-rc5-linux-x86_64.sh
# export PATH=$(pwd)/cmake-3.20.0-rc5-linux-x86_64/bin:$PATH
# rm cmake-3.20.0-rc5-linux-x86_64.sh

# --
# Setup environment

conda create -y -n pyg_env python=3.7
conda activate pyg_env

conda install -y pytorch=1.8.0 cudatoolkit=11.1 \
    -c pytorch -c conda-forge

pip install scipy==1.6

# --
# pybind11

git clone https://github.com/pybind/pybind11

# --
# build

./build.sh # > build.log

# --
# test

python test.py