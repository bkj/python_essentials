cmake_minimum_required(VERSION 3.19 FATAL_ERROR)
project(pygunrock LANGUAGES C CXX CUDA)
include(cmake/CPM.cmake)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# --
# User defined variables

set(ANACONDA_PATH       $ENV{PYG_ANACONDA_PATH})
set(CMAKE_PREFIX_PATH   $ENV{PYG_TORCH_DIR})

# --
# python + pytorch

set(PYTHON_INCLUDE_PATH ${ANACONDA_PATH}/include/python3.7m)
set(PYTHON_LIBRARIES    ${ANACONDA_PATH}/lib/libpython3.7m.so)

find_package(PythonInterp 3.7 REQUIRED)
find_package(PythonLibs 3.7 REQUIRED)

find_package(Torch REQUIRED)
find_library(TORCH_PYTHON_LIBRARY torch_python PATHS ${TORCH_INSTALL_PREFIX}/lib)

include_directories(
  ${PYTHON_INCLUDE_DIRS}
  ./pybind11/include
)

# --
# essentials

CPMAddPackage(
  NAME              Essentials
  GITHUB_REPOSITORY gunrock/essentials
  GIT_TAG           7f0966e0177531c3d76b5e5c7c0451484691d189
  SOURCE_DIR        ${CMAKE_SOURCE_DIR}/externals/essentials
)

set(ESSENTIALS_DIR ${CMAKE_SOURCE_DIR}/externals/essentials)

# --
# pygunrock

add_library(
  pygunrock 
  SHARED
  src/interface.cu 
  ${ESSENTIALS_DIR}/externals/mtx/mmio.cpp
)

target_include_directories(
  pygunrock
  PRIVATE
  ${TORCH_INCLUDE_DIRS}
)

target_link_libraries(
  pygunrock 
  essentials
  ${TORCH_LIBRARIES}
  ${TORCH_PYTHON_LIBRARY}
)

set_target_properties(pygunrock PROPERTIES PREFIX "")