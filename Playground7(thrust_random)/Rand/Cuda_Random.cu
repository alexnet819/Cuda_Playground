#include <curand.h>
#include <curand_kernel.h>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/sort.h>
#include <thrust/copy.h>
#include <thrust/random.h>

#include <random>
#include <ctime>
#include <typeinfo>


template<typename U>
struct RandGen;
	// int型のための特殊化
template<>
struct RandGen<int>
{
	int _min, _max, _time;
	RandGen(int min, int max, std::uint_fast64_t time):_min(min), _max(max), _time(time) {}
	__host__ __device__
	int operator () (int idx) {
		thrust::default_random_engine randEng(_time);
		thrust::uniform_int_distribution<int> uniDist(_min, _max);
		randEng.discard(idx);
		return uniDist(randEng);
	}
};
// double型のための特殊化
template<>
struct RandGen<double>
{
	double _min, _max;
	int _time;
	RandGen(double min, double max, std::uint_fast64_t time):_min(min), _max(max), _time(time) {}
	__host__ __device__
	double operator () (int idx)
	{
		thrust::default_random_engine randEng(_time);
		thrust::uniform_real_distribution<double> uniDist(_min, _max);
		randEng.discard(idx);
		return uniDist(randEng);
	}
};

// float型のための特殊化
template<>
struct RandGen<float>
{
	float _min, _max;
	int _time;
	RandGen(float min, float max, int time):_min(min), _max(max), _time(time) {}
	__host__ __device__
	float operator () (int idx)
	{
		thrust::default_random_engine randEng(_time);
		thrust::uniform_real_distribution<float> uniDist(_min, _max);
		randEng.discard(idx);
		return uniDist(randEng);
	}
};

template<typename T>
class CudaRandom {
public:
	CudaRandom() {}
	~CudaRandom() {}

	void HostRand(thrust::host_vector<T>& host_vec, T min = 0, T max = 1) {
		std::random_device rd;
		_mt.seed(rd());
		thrust::transform(thrust::make_counting_iterator(0), thrust::make_counting_iterator((int)host_vec.size()), host_vec.begin(), RandGen<T>(min, max, _mt()));
		// thrust::default_random_engine rng(1337);
		// thrust::uniform_real_distribution<double> dist(min, max);
		// thrust::generate(host_vec.begin(), host_vec.end(), [&] { return dist(rng); });
		// return host_vec;
	}

	void GPURand(thrust::device_vector<T>& device_vec, T min = 0, T max = 1) {
		std::random_device rd;
		_mt.seed(rd());
		thrust::transform(thrust::make_counting_iterator(0), thrust::make_counting_iterator((int)device_vec.size()), device_vec.begin(), RandGen<T>(min, max, _mt()));
		//return device_vec;
	}
private:
	std::mt19937_64 _mt;
};

