/* random2.cu */

#include <unistd.h>
#include <cstdio>
#include <typeinfo>

/* we need these includes for CUDA's random number stuff */
#include <curand.h>
#include <curand_kernel.h>
#include<thrust/host_vector.h>
#include<thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/copy.h>
#include <thrust/random.h>

// #include "Cuda/include/Cuda_lib.cuh"
#include "Cuda_lib.cuh"
// #include "include/Cuda_lib.cuh"


// /* this GPU kernel function calculates a random number and stores it in the parameter */
// __global__ void random(unsigned int seed, int* result) {
//     /* CUDA's random number library uses curandState_t to keep track of the seed value
//        we will store a random state for every thread  */
//     curandState_t state;

//     /* we have to initialize the state */
//     curand_init(seed, /* the seed controls the sequence of random values that are produced */
//             0, /* the sequence number is only important with multiple cores */
//             0, /* the offset is how much extra we advance in the sequence for each call, can be 0 */
//             &state);

//     /* curand works like rand - except that it takes a state as a parameter */
//     *result = curand(&state) % MAX;
// }

template<typename T>
struct RandGen
{
    RandGen(T min, T max):_min(min), _max(max) {}
	T _min;
	T _max;
    __device__
    double operator () (int idx)
    {
        thrust::default_random_engine randEng(1337);
        thrust::uniform_real_distribution<double> uniDist(_min, _max);
		randEng.discard(idx);
        return uniDist(randEng);
    }
};

int main() {

	// cuda_lib instance;
	// /* host copy of result */
	// thrust::host_vector<double> h_result(10 ,0);
	// thrust::device_vector<double> d_result(10, 0);
	// thrust::default_random_engine rng(1337);
	// thrust::uniform_real_distribution<double> dist(-50.0, 50.0);
	// thrust::generate(d_result.begin(), d_result.end(), [&] { return dist(rng); });

	// std::cout << "test" << std::endl;

	// //instance.random(0, d_result);

	// //d_result.copy(h_result.begin(), h_result.end());
	// /* print the result */
	// for(int i = 0;i<h_result.size();i++){
	// 	std::cout << "Random number: " << h_result[i] << std::endl;

	// }

	const int num = 1000;
	thrust::device_vector<double> rVec(num);
	std::cout << (int)rVec.size() << std::endl;
	std::cout << typeid(rVec.size()).name() << std::endl;
	thrust::transform(thrust::make_counting_iterator(0), thrust::make_counting_iterator((int)rVec.size()), rVec.begin(), RandGen<double>(0, 1));

	for(int i = 0;i<rVec.size();i++)
		std::cout << "Random number: " << rVec[i] << std::endl;
    return 0;
}
