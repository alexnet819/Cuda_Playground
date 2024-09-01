#include "kernel.h"

#include <cstdio>

void __global__ print()
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    std::printf("%d\n", idx);
}

void f()
{
    print<<<1, 10>>>();
    cudaDeviceSynchronize();
}