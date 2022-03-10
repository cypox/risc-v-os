RISCVPATH=../../../gnu-toolchain/riscv-gnu-toolchain/build/bin/
AS=$(RISCVPATH)riscv64-unknown-linux-gnu-as
LD=$(RISCVPATH)riscv64-unknown-linux-gnu-ld
CC=$(RISCVPATH)riscv64-unknown-linux-gnu-gcc
SZ=$(RISCVPATH)riscv64-unknown-linux-gnu-size
CFLAGS = -nostdlib -fno-builtin -mcmodel=medany -march=rv64id -mabi=lp64d

QEMU = qemu-system-riscv64
QFLAGS = -nographic -smp 4 -machine virt -bios none

OBJDUMP = riscv64-unknown-elf-objdump

all: os.elf

os.elf: os.s os.c
	$(CC) $(CFLAGS) -T os.ld -o os.elf $^

qemu: $(TARGET)
	@qemu-system-riscv64 -M ? | grep virt >/dev/null || exit
	@echo "Press Ctrl-A and then X to exit QEMU"
	$(QEMU) $(QFLAGS) -kernel os.elf

clean:
	rm -f *.elf