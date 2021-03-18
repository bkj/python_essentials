#!/usr/bin/env python

"""
  test.py
"""

import torch

import sys
sys.path.append('.')
import pygunrock as pyg

import numpy as np
from scipy.io import mmread

# --
# Load graph

csr = mmread('data/chesapeake.mtx').tocsr()

n_vertices = csr.shape[0]
n_edges    = csr.nnz

# --
# Convert data to torch + move to GPU

indptr   = torch.IntTensor(csr.indptr).cuda()
indices  = torch.IntTensor(csr.indices).cuda()
data     = torch.FloatTensor(csr.data).cuda()

# --
# Allocate memory for output

distances    = torch.zeros(csr.shape[0]).float().cuda()
predecessors = torch.zeros(csr.shape[0]).int().cuda()

# --
# Run

for single_source in [0, 1, 2]:
  _ = distances.zero_()
  _ = predecessors.zero_()
  
  G = pyg.from_csr(n_vertices, n_vertices, n_edges, indptr, indices, data)
  _ = pyg.sssp(G, single_source, distances, predecessors)
  print(distances)