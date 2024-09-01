#include <curand.h>
#include <curand_kernel.h>
#include <stdio.h>

__global__ void init(unsigned int seed, curandState_t* states) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    curand_init(seed, idx, 0, &states[idx]);
}

__global__ void randoms(curandState_t* states, int* numbers) {
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    numbers[idx] = curand(&states[idx]) % 100;
}

int main() {
    int N = 100;
    curandState_t* states;
    int* numbers;
    cudaMalloc((void**)&states, N * sizeof(curandState_t));
    cudaMalloc((void**)&numbers, N * sizeof(int));

    init<<<N, 1>>>(time(0), states);
    randoms<<<N, 1>>>(states, numbers);


	cudaError_t err = cudaGetLastError();
	if (err != cudaSuccess) {
		printf("CUDA error: %s\n", cudaGetErrorString(err));
		return;
	}
	cudaDeviceSynchronize();
    int h_numbers[N];
    cudaMemcpy(h_numbers, numbers, N * sizeof(int), cudaMemcpyDeviceToHost);

    for(int i = 0; i < N; i++) {
        printf("%d ", h_numbers[i]);
    }

    cudaFree(states);
    cudaFree(numbers);

    return 0;
}