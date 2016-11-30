#pragma once
#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#pragma region Warp-wide methods
template<typename T>
__inline__ __device__ T WarpSum(T value)
{
	for (int i = warpSize / 2; i > 0; i /= 2)
	{
		value += __shfl_down(sum, i);
	}

	return value;
}

template<typename T>
__inline__ __device__ T WarpMin(T value)
{
	for (int i = warpSize / 2; i > 0; i /= 2)
	{
		value = min(value, __shfl_down(value, i));
	}

	return value;
}

template<typename T>
__inline__ __device__ T WarpMax(T value)
{
	for (int i = warpSize / 2; i > 0; i /= 2)
	{
		value = max(value, __shfl_down(value, i));
	}

	return value;
}

template<typename T>
__inline__ __device__ T WarpAvg(T value)
{
	value = WarpSum(value);

	return value / warpSize;
}
#pragma endregion

#pragma region Block-wide methods
template<typename T>
__inline__ __device__ T BlockSum(T value)
{


	return value;
}
#pragma endregion