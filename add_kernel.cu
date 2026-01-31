#include <cuda_runtime.h>
#include <stdio.h>
#include <stdlib.h>

// CUDA kernel to perform addition operation
__global__ void add_kernel(int *result, int iterations) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    // Each thread performs additions based on its index
    if (idx < iterations) {
        int sum = 0;
        for (int i = 0; i < 1000000; i++) {  // 一百万次循环
            sum = 1 + 1;
        }
        result[idx] = sum;
    }
}

// Alternative kernel that computes 1+1 a million times and accumulates
__global__ void accumulate_add_kernel(int *result, int iterations) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (idx < iterations) {
        int sum = 0;
        for (int i = 0; i < 1000000; i++) {  // 一百万次1+1累加
            sum += 1 + 1;
        }
        result[idx] = sum;
    }
}

int main() {
    const int N = 1024;  // Number of threads
    const int size = N * sizeof(int);
    
    // Allocate memory on host
    int *h_result = (int*)malloc(size);
    
    // Allocate memory on device
    int *d_result;
    cudaMalloc((void**)&d_result, size);
    
    // Define grid and block dimensions
    dim3 blockSize(256);
    dim3 gridSize((N + blockSize.x - 1) / blockSize.x);
    
    printf("Launching kernel to compute 1+1 a million times per thread...\n");
    
    // Launch the kernel
    add_kernel<<<gridSize, blockSize>>>(d_result, N);
    
    // Copy result back to host
    cudaMemcpy(h_result, d_result, size, cudaMemcpyDeviceToHost);
    
    // Print some results
    printf("Results (first 10): ");
    for (int i = 0; i < 10 && i < N; i++) {
        printf("%d ", h_result[i]);
    }
    printf("\n");
    
    // Launch the accumulation kernel
    printf("Launching accumulation kernel (summing 1+1 a million times)...\n");
    accumulate_add_kernel<<<gridSize, blockSize>>>(d_result, N);
    
    // Copy result back to host
    cudaMemcpy(h_result, d_result, size, cudaMemcpyDeviceToHost);
    
    // Print some accumulated results
    printf("Accumulated Results (first 10): ");
    for (int i = 0; i < 10 && i < N; i++) {
        printf("%d ", h_result[i]);
    }
    printf("\n");
    
    // Free memory
    free(h_result);
    cudaFree(d_result);
    
    printf("Kernel execution completed.\n");
    
    return 0;
}