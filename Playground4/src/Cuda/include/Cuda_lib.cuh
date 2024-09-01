#pragma once
#include<cuda.h>

// extern __global__ void kernel_Random(unsigned int seed, int* result);

class cuda_lib {
public:
	cuda_lib();
	~cuda_lib();
	void random(unsigned int seed, int* result);
	void vectorAdd(int *a, int *b, int n);

};


