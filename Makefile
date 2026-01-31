# Makefile for CUDA addition kernel
NVCC = nvcc
NVCC_FLAGS = -arch=sm_61  # Set architecture appropriate for your GPU (RTX 960 uses Pascal architecture)

# Target names
TARGET = add_kernel
SOURCE = add_kernel.cu

# Default target
all: $(TARGET) ptx

# Compile the executable
$(TARGET): $(SOURCE)
	$(NVCC) $(NVCC_FLAGS) -o $(TARGET) $(SOURCE)

# Generate PTX code
ptx: $(SOURCE)
	$(NVCC) -ptx $(NVCC_FLAGS) -o $(TARGET).ptx $(SOURCE)
	
# Clean build artifacts
clean:
	rm -f $(TARGET) $(TARGET).ptx

# Run the program (only if compiled successfully)
run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run ptx