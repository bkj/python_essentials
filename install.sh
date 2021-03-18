#!/bin/bash

# run.sh

# --
# Install anaconda

# wget https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh
# bash Anaconda3-2020.11-Linux-x86_64.sh
# rm Anaconda3-2020.11-Linux-x86_64.sh

# --
# Setup environment

conda create -y -n pyg_env python=3.7
conda activate pyg_env

# dependencies
conda install -y -c pytorch -c conda-forge \
    pytorch=1.8.0 cudatoolkit=11.1 

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