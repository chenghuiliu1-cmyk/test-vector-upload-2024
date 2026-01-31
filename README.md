# CUDA PTX 1+1 运算示例

本项目演示如何使用CUDA PTX（Parallel Thread Execution）在Linux RTX 960环境下计算一百万次1+1运算。

## 文件说明

- `add_kernel.cu`: CUDA源代码，包含执行1+1运算的内核函数
- `Makefile`: 编译脚本，用于生成可执行文件和PTX代码
- `README.md`: 本说明文档

## 环境要求

- Linux操作系统
- NVIDIA RTX 960显卡（或兼容CUDA的GPU）
- CUDA Toolkit已安装
- GCC编译器

## 编译步骤

1. **生成PTX代码**：
   ```bash
   make ptx
   ```
   这将生成`add_kernel.ptx`文件，其中包含了汇编级的PTX指令。

2. **编译可执行文件**：
   ```bash
   make
   ```
   或者
   ```bash
   make all
   ```

3. **运行程序**：
   ```bash
   make run
   ```
   或者直接运行可执行文件：
   ```bash
   ./add_kernel
   ```

## 代码功能说明

本代码包含两个CUDA内核：

1. `add_kernel`: 每个线程执行一百万次1+1运算，每次都将结果存储到变量中（结果始终为2）
2. `accumulate_add_kernel`: 每个线程执行一百万次1+1运算并将结果累加（最终结果为2,000,000）

## PTX代码查看

编译后的PTX代码可以在`add_kernel.ptx`文件中查看，它展示了CUDA C代码被编译成的低级并行汇编语言。

## 注意事项

- RTX 960基于Pascal架构，可能需要调整Makefile中的架构标志（如改为`-arch=sm_61`）
- 如果遇到架构不支持的问题，请修改Makefile中的`NVCC_FLAGS`参数
- 代码中的循环次数可以通过修改`1000000`常量来调整

## 性能提示

由于执行的运算是固定的1+1，现代GPU可能会优化掉大部分重复计算。如果要进行实际性能测试，建议使用更复杂的计算模式。