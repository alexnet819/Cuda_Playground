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
	int *vec1[10], *vec2[20];
	//thrust::host_vector<int> vec1(10);
	//thrust::host_vector<int> vec2(20);
	
	// vectorに値を代入する
	for (int i = 0; i < 20; i++) {
		if(i < 10)
			vec1[i] = i;
		vec2[i] = i * 2;
	}

	// vec1の中身を表示
	std::cout << "Vector 1: ";
	for (int i = 0; i < vec1.size(); i++)
	{
		std::cout << vec1[i] << " ";
	}
	
	std::cout << std::endl;

	// GPUにvec1, vec2のデータを渡す
	int *gpu_vec1, *gpu_vec2;
	cudaMalloc((void**)&gpu_vec1, sizeof(vec1) * sizeof(int));
	cudaMalloc((void**)&gpu_vec2, sizeof(vec2) * sizeof(int));
	cudaMemcpy(gpu_vec1, vec1, sizeof(vec1) * sizeof(int), cudaMemcpyHostToDevice);
	cudaMemcpy(gpu_vec2, vec2, sizeof(vec2) * sizeof(int), cudaMemcpyHostToDevice);


	//thrust::device_vector<int> gpu_vec1 = vec1;
	//thrust::device_vector<int> gpu_vec2 = vec2;

	// GPUで起動するthreadの数を決める
	dim3 block(sizeof(vec1) / sizeof(int));
	dim3 grid(1);

	// GPUでvectorAdd関数を実行
	vectorAdd <<<grid, block>>>(gpu_vec1, gpu_vec2, sizeof(vec2) / sizeof(int);

	// GPUで計算した結果をvec1にコピー
	cudaMemcpy(vec1, gpu_vec1, sizeof(vec1) * sizeof(int), cudaMemcpyDeviceToHost);
	std::cout << "Vector 1: ";
	for (int i = 0; i < vec1.size(); i++)
	{
		std::cout << vec1[i] << " ";
	}

	std::cout << std::endl;
	return 0;
}