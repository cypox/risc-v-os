RISCVPATH=
OPENSBI_BIN=/usr/local/share/qemu/opensbi-riscv64-generic-fw_dynamic.bin
AS=$(RISCVPATH)riscv64-unknown-linux-gnu-as
LD=$(RISCVPATH)riscv64-unknown-linux-gnu-ld
CC=$(RISCVPATH)riscv64-unknown-linux-gnu-gcc

CFLAGS=-mcmodel=medany -static -std=c17 -O2 -ffast-math -fno-common -fno-builtin-printf -fno-tree-loop-distribute-patterns
LDFLAGS=

main.elf: crt0.s link.ld main.c
	$(AS) -o crt0.o crt0.s
	$(CC) $(CFLAGS) -c main.c -o main.o
	$(LD) -T link.ld main.o crt0.o -o main.elf $(LDFLAGS)
	rm crt0.o main.o

clean:
	rm -f crt0.o main.o main.elf boot.iso

iso: main.elf
	dd if=/dev/zero of=boot.iso bs=512 count=2880
	dd if=$(OPENSBI_BIN) of=boot.iso conv=notrunc bs=512 seek=0
	dd if=main.elf of=boot.iso conv=notrunc bs=512 seek=256
