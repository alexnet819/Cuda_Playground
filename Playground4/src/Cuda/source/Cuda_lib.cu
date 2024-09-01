#include "Cuda_lib.cuh"
//#include "../include/Cuda_lib.cuh"
#include <curand.h>
#include <curand_kernel.h>
#include<thrust/host_vector.h>
#include<thrust/device_vector.h>
#include <cuda.h>
#include <cstdio>

#define MAX 100


//__global__ void kernel_Random(unsigned int seed, int *result) {
__global__ void kernel_Random() {
	// curandState_t states;
    // int idx = threadIdx.x + blockIdx.x * blockDim.x;
    // curand_init(seed, 0, 0, &states);
    // *result = curand_normal(&states);
	//curandState_t state;

    //curand_init(seed, 0, 0, &state);
    //std::printf("\n%f", curand_normal(&state));

}

cuda_lib::cuda_lib() {
}

cuda_lib::~cuda_lib() {
}

void cuda_lib::random(unsigned int seed, int* result) {
	std::cout << "test" << std::endl;
	cudaError_t err = cudaGetLastError();
	if (err != cudaSuccess) {
		printf("CUDA error: %s\n", cudaGetErrorString(err));
		return;
	}
}

// void cuda_lib::random(unsigned int seed, int* result) {
// 	std::cout << "test" << std::endl;
// 	cudaError_t err = cudaGetLastError();
// 	if (err != cudaSuccess) {
// 		printf("CUDA error: %s\n", cudaGetErrorString(err));
// 		return;
// 	}
	
// 	int *gpu1 = 0;
// 	unsigned int gpu_seed = 0;
// 	cudaMalloc((void**)&gpu1, sizeof(int));
// 	err = cudaGetLastError();
// 	if (err != cudaSuccess) {
// 		printf("CUDA error: %s\n", cudaGetErrorString(err));
// 		return;
// 	}
// 	cudaMalloc((void**)&gpu_seed, sizeof(unsigned int));
// 	err = cudaGetLastError();
// 	if (err != cudaSuccess) {
// 		printf("CUDA error: %s\n", cudaGetErrorString(err));
// 		return;
// 	}
// 	std::cout << "test" << std::endl;
// 	cudaMemcpy(gpu1, result, sizeof(int), cudaMemcpyHostToDevice);
// 	err = cudaGetLastError();
// 	if (err != cudaSuccess) {
// 		printf("CUDA error: %s\n", cudaGetErrorString(err));
// 		return;
// 	}

// 	cudaMemcpy(&gpu_seed, &seed, sizeof(unsigned int), cudaMemcpyHostToDevice);
// 	err = cudaGetLastError();
// 	if (err != cudaSuccess) {
// 		printf("CUDA error: %s\n", cudaGetErrorString(err));
// 		return;
// 	}
// 	std::cout << "test" << std::endl;
// 	//kernel_Random<<<1,1>>>(gpu_seed, gpu1);
// 	dim3 blockSize(1);
// 	dim3 numBlocks(1);
// 	//kernel_Random<<<numBlocks, blockSize>>>();
// 	//cudaError_t err = cudaGetLastError();
// 	// curandStatus_t _t;
// 	// curandCreateGenerator(&_t, CURAND_RNG_PSEUDO_DEFAULT);
// 	curandGenerator_t gen;
// 	curandStatus_t status = curandCreateGenerator(&gen, CURAND_RNG_PSEUDO_DEFAULT);
// 	curandSetPseudoRandomGeneratorSeed(gen, 1234ULL);
// 	curandGenerateNormalDouble(gen, (double *)gpu1, 1, 100, 1.0);
// 	// err = cudaGetLastError();
// 	// if (err != cudaSuccess) {
// 	// 	printf("CUDA error: %s\n", cudaGetErrorString(err));
// 	// 	return;
// 	// }
// 	cudaDeviceSynchronize();
// 	std::cout << "test" << std::endl;
// 	cudaMemcpy(result, gpu1, sizeof(int), cudaMemcpyDeviceToHost);
// 	std::cout << result << std::endl;
// 	//cudaMemcpy(gpu1, result, sizeof(int), cudaMemcpyDeviceToHost);
// 	cudaFree(gpu1);
// 	cudaFree(&gpu_seed);
// 	cudaDeviceSynchronize();
// 	curandDestroyGenerator(gen);
// }

void cuda_lib::vectorAdd(int *a, int *b, int n) {
}