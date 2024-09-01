# add_subdirectory(Cuda)

# 実行ファイルの生成
add_executable(Main main.cu)
target_link_libraries(Main PRIVATE cuda_lib ${CUDA_curand_LIBRARY})
target_compile_options(Main PRIVATE $<$<COMPILE_LANGUAGE:CUDA>:-extended-lambda>)