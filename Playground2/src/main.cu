#include<cuda.h>
#include<thrust/host_vector.h>
#include<thrust/device_vector.h>
#include<vector>
#include<iostream>

// __global__はGPUで実行される関数であることを示す
__global__ void vectorAdd(int *a, int *b, int n) {
	int thread = blockIdx.x * blockDim.x + threadIdx.x;
	for(int j = 0; j < n; j++)
		a[thread] = thread * b[j];
}

int main(int argc, char** argv) {

	// GPUにデータを渡すようにvectorを作成
	// NVIDIAがstd::vector相当のライブラリを用意してくれている
	thrust::host_vector<int> vec1(10);
	thrust::host_vector<int> vec2(20);
	
	// vectorに値を代入する
	for (int i = 0; i < 20; i++) {
		if(i < 10)
			vec1[i] = i;
		vec2[i] = i * 2;
	}

	// vec1の中身を表示
	std::cout << "Vector 1: ";
	for (int i = 0; i < 10; i++)
	{
		std::cout << vec1[i] << " ";
	}
	
	std::cout << std::endl;

	// GPUにvec1, vec2のデータを渡す
	int *gpu_vec1, *gpu_vec2;
	cudaMalloc((void**)&gpu_vec1, vec1.size() * sizeof(int));
	cudaMalloc((void**)&gpu_vec2, vec2.size() * sizeof(int));
	cudaMemcpy(gpu_vec1, vec1.data(), vec1.size() * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(gpu_vec2, vec2.data(), vec2.size() * sizeof(int), cudaMemcpyHostToDevice);

	// GPUで起動するthreadの数を決める
	dim3 block(vec1.size());
	dim3 grid(1);

	// GPUでvectorAdd関数を実行
	vectorAdd <<<grid, block>>>(gpu_vec1, gpu_vec2, vec2.size());

	// GPUで計算した結果をvec1にコピー
	cudaMemcpy(vec1.data(), gpu_vec1, vec1.size() * sizeof(int), cudaMemcpyDeviceToHost);
	std::cout << "Vector 1: ";
	for (int i = 0; i < vec1.size(); i++)
	{
		std::cout << vec1[i] << " ";
	}

	std::cout << std::endl;
	return 0;
}