AS=/home/cypox/personal/risc-v-os/gnu-toolchain/riscv-gnu-toolchain/build/bin/riscv64-unknown-linux-gnu-as
LD=/home/cypox/personal/risc-v-os/gnu-toolchain/riscv-gnu-toolchain/build/bin/riscv64-unknown-linux-gnu-ld
CC=/home/cypox/personal/risc-v-os/gnu-toolchain/riscv-gnu-toolchain/build/bin/riscv64-unknown-linux-gnu-gcc

CFLAGS=-mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns
LDFLAGS=

main.elf: boot.s link.lds main.c
	$(AS) -o boot.o boot.s
	$(CC) $(CFLAGS) -c main.c -o main.o
	$(LD) -T link.lds main.o boot.o -o main.elf $(LDFLAGS)

clean:
	rm -f boot.o main.o main.elf boot.iso

iso: main.elf boot.bin
	dd if=/dev/zero of=boot.iso bs=512 count=2880
	dd if=boot.bin of=boot.iso conv=notrunc bs=512 seek=0 count=1
	dd if=main.elf of=boot.iso conv=notrunc bs=512 seek=1 count=2048

