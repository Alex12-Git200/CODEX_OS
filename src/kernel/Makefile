BUILD_DIR?=build/
ASM?=nasm
CC16?=/opt/watcom/binl64/wcc
LD16?=/opt/watcom/binl64/wlink

.PHONY: all kernel clean

all: kernel

kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin:
	$(ASM) main.asm -f bin -o $(BUILD_DIR)/kernel.bin

clean:
	rm -f $(BUILD_DIR)/kernel.bin