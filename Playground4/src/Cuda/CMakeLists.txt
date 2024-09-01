# cmake_policy(SET CMP0076 NEW)


# set_target_properties(cuda_lib PROPERTIES CUDA_SEPARABLE_COMPILATION ON)

# static library
add_library(cuda_lib STATIC "")
target_sources(cuda_lib PRIVATE source/cuda_lib.cu include/cuda_lib.cuh)

# dynamic library
# add_library(cuda_lib SHARED "")
# target_sources(cuda_lib PRIVATE source/cuda_lib.cu include/cuda_lib.cuh)

# add_library(cuda_lib SHARED source/cuda_lib.cu include/cuda_lib.cuh)




# target_compile_features(cuda_lib PRIVATE cuda_std_14)
# set_target_properties(cuda_lib
#         PROPERTIES
#                 CUDA_RUNTIME_LIBRARY Shared
#                 # CUDA_STANDARD 14 # this one cannot be changed by CMake
#                 # CUDA_SEPARABLE_COMPILATION ON # not needed for this example
# )

target_include_directories(cuda_lib PUBLIC include)
