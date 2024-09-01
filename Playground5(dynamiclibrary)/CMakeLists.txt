cmake_minimum_required(VERSION 3.18)

# this has to be set before project()
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
  set(CMAKE_CUDA_ARCHITECTURES 86)
endif()

project(test LANGUAGES CXX CUDA)

add_library(cuda_comp SHARED kernel.h kernel.cu)

# this command would only set the minimum standard,
# i.e. CMake can still decide to use -std=c++17 instead
# if the given compilers support C++17
target_compile_features(cuda_comp PRIVATE cuda_std_14)

set_target_properties(cuda_comp
        PROPERTIES
                CUDA_RUNTIME_LIBRARY Shared
                # CUDA_STANDARD 14 # this one cannot be changed by CMake
                # CUDA_SEPARABLE_COMPILATION ON # not needed for this example
)

add_executable(main main.cpp)

target_compile_features(main PRIVATE cxx_std_17)
# set_target_properties(main CXX_STANDARD 17)

target_link_libraries(main cuda_comp)