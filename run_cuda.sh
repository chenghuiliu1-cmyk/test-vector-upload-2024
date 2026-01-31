#!/bin/bash

echo "CUDA PTX 1+1 运算示例"
echo "======================"

# 检查CUDA是否可用
if ! command -v nvcc &> /dev/null; then
    echo "错误: 未找到nvcc (CUDA编译器)"
    echo "请确保已安装CUDA Toolkit并将其添加到PATH中"
    echo ""
    echo "安装CUDA Toolkit后，您可以："
    echo "1. 使用 'make ptx' 生成PTX代码"
    echo "2. 使用 'make' 编译可执行文件"
    echo "3. 使用 'make run' 运行程序"
    exit 1
fi

echo "检测到CUDA环境，开始编译..."

# 尝试编译
make clean
make all

if [ $? -eq 0 ]; then
    echo ""
    echo "编译成功！"
    echo "已生成:"
    echo "- add_kernel (可执行文件)"
    echo "- add_kernel.ptx (PTX汇编代码)"
    echo ""
    echo "运行程序以执行一百万次1+1运算..."
    make run
else
    echo "编译失败。请确保您的系统满足以下要求："
    echo "- 已安装CUDA Toolkit"
    echo "- 支持CUDA的GPU（如RTX 960）"
    echo "- 正确的GPU驱动程序"
fi