#!/bin/bash

# run.sh

# --
# Install anaconda
# !! For some reason, pytorch=1.8 install fails w/ AWS Deep Learning image pre-installed anaconda
#    so we re-install it here. YMMV.

# wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
# bash Anaconda3-2020.11-Linux-x86_64.sh -b -p /home/ubuntu/.anaconda
# rm Anaconda3-2020.11-Linux-x86_64.sh
# export PATH=/home/ubuntu/.anaconda/bin:$PATH

# --
# Set CUDA version to 11.0

# sudo rm /usr/local/cuda
# sudo ln -s /usr/local/cuda-11.0/ /usr/local/cuda

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