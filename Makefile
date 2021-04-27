AS=riscv64-unknown-linux-gnu-as
LD=riscv64-unknown-linux-gnu-ld
CC=riscv64-unknown-linux-gnu-gcc

CFLAGS=-mcmodel=medany -static -std=gnu99 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns
LDFLAGS=

main.elf: boot.s link.ld main.c
	$(AS) -o boot.o boot.s
	$(CC) $(CFLAGS) -c main.c -o main.o
	$(LD) -T link.ld main.o boot.o -o main.elf $(LDFLAGS)
	rm boot.o main.o

clean:
	rm -f boot.o main.o main.elf boot.iso

iso: main.elf boot.bin
	dd if=/dev/zero of=boot.iso bs=512 count=2880
	dd if=boot.bin of=boot.iso conv=notrunc bs=512 seek=0 count=1
	dd if=main.elf of=boot.iso conv=notrunc bs=512 seek=1 count=2048
