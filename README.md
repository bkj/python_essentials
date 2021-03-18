# python_essentials

Call `gunrock/essentials` from Python using `pybind11` and `pytorch`.

# Installation

See `./install.sh` for installation.

# Example

```
$ python test.py
tensor([0., 2., 2., 2., 2., 2., 1., 1., 2., 2., 1., 1., 1., 2., 2., 2., 2., 2.,
        2., 2., 2., 1., 1., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 1., 1., 2.,
        1., 2., 1.], device='cuda:0')
tensor([2., 0., 2., 2., 2., 2., 1., 1., 1., 2., 1., 1., 1., 2., 2., 2., 2., 2.,
        2., 2., 2., 1., 1., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 3., 1., 1.,
        2., 2., 1.], device='cuda:0')
tensor([2., 2., 0., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 1., 1., 1., 1., 1.,
        2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 2., 3., 2., 1.,
        3., 3., 1.], device='cuda:0')
```

# Version information

I had some hard-to-debug issues installing w/ different versions of `pytorch`, `cuda` and `cudnn` -- apparently the compatability between all these pieces is a bit finnicky.

Note the weirdness of `pytorch` and `cudatoolkit` referencing `cuda-11.1`, but we're actually using `cuda-11.0`.

Pull requests that get this working w/ `cuda-11.1` would be much appreciated!

```
$ ll -t /usr/local/cuda
lrwxrwxrwx 1 root root 21 Mar 18 18:19 /usr/local/cuda -> /usr/local/cuda-11.0/

$ nvcc -V
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2020 NVIDIA Corporation
Built on Wed_Jul_22_19:09:09_PDT_2020
Cuda compilation tools, release 11.0, V11.0.221
Build cuda_11.0_bu.TC445_37.28845127_0

$ conda list | fgrep pytorch
pytorch                   1.8.0           py3.7_cuda11.1_cudnn8.0.5_0    pytorch

$ conda list | fgrep cudatoolkit
cudatoolkit               11.1.1               h6406543_8    conda-forge

$ cat build.log | fgrep cudnn | head -n 2
-- Found CUDNN: /usr/local/cuda/lib64/libcudnn.so  
-- Found cuDNN: v8.0.5  (include: /usr/local/cuda/include, library: /usr/local/cuda/lib64/libcudnn.so)
```

See `build.log` for additional version information.