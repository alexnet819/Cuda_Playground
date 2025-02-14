#include <curand.h>
#include <curand_kernel.h>
#include <stdio.h>
#include "Cuda_Random.cu"

int main() {
	using rand_type = int;
	thrust::host_vector<rand_type> host_vec(10, 0);
	thrust::device_vector<rand_type> device_vec(10, 0);
	CudaRandom<rand_type> cr;

	cr.GPURand(device_vec, 0, 100);

	for (int i = 0; i < device_vec.size(); i++){
		std::cout << device_vec[i] << std::endl;
		//printf("%d \n", static_cast<int>(device_vec[i]));
	}
    return 0;
}