#include <curand.h>
#include <curand_kernel.h>
#include <stdio.h>
#include "Cuda_Random.cu"

// __global__ void init(unsigned int seed, curandState_t* states) {
//     int idx = threadIdx.x + blockIdx.x * blockDim.x;
//     curand_init(seed, idx, 0, &states[idx]);
// }

// __global__ void randoms(curandState_t* states, int* numbers) {
//     int idx = threadIdx.x + blockIdx.x * blockDim.x;
//     numbers[idx] = curand(&states[idx]) % 100;
// }

// int main() {
//     int N = 100;
//     curandState_t* states;
//     int* numbers;
//     cudaMalloc((void**)&states, N * sizeof(curandState_t));
//     cudaMalloc((void**)&numbers, N * sizeof(int));

//     init<<<N, 1>>>(time(0), states);
//     randoms<<<N, 1>>>(states, numbers);


// 	cudaError_t err = cudaGetLastError();
// 	if (err != cudaSuccess) {
// 		printf("CUDA error: %s\n", cudaGetErrorString(err));
// 		return;
// 	}
// 	cudaDeviceSynchronize();
//     int h_numbers[N];
//     cudaMemcpy(h_numbers, numbers, N * sizeof(int), cudaMemcpyDeviceToHost);

//     for(int i = 0; i < N; i++) {
//         printf("%d ", h_numbers[i]);
//     }

//     cudaFree(states);
//     cudaFree(numbers);

//     return 0;
// }

int main() {
	using rand_type = double;
	thrust::host_vector<rand_type> host_vec(10, 0);
	thrust::device_vector<rand_type> device_vec(10, 0);
	CudaRandom<rand_type> cr;

	// for (int i = 0; i < 10; i++){
	// 	printf("%f \n", static_cast<double>(device_vec[i]));
	// }
	//thrust::fill(device_vec.begin(), device_vec.end(), 0);
	// host_vec = cr.HostRand(host_vec, 0, 1);
	// device_vec = cr.GPURand(device_vec, 0, 1);
	//cr.HostRand(host_vec, 0, 10);
	cr.GPURand(device_vec, 0, 100);

	// for (int i = 0; i < 10; i++){
	// 	std::cout << host_vec[i] << std::endl;
	// 	//printf("%f ", static_cast<double>(host_vec[i]));
	// 	//printf("\n");
	// }
	for (int i = 0; i < device_vec.size(); i++){
		std::cout << device_vec[i] << std::endl;
		//printf("%d \n", static_cast<int>(device_vec[i]));
	}
    return 0;
}