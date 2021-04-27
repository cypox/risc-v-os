# risc-v-os [![Build Status](https://travis-ci.com/cypox/risc-v-os.svg?branch=master)](https://travis-ci.org/github/cypox/virtual-economy)

## Building
You need riscv cross compile toolchain. You can download it [here](https://github.com/riscv/riscv-gnu-toolchain/releases/).

To build you simply run:
```bash
make -j 4 RISCVPATH={PATH_TO_YOUR_RISCV_TOOLCHAIN_BIN_FOLDER}
```

To build an iso bootfile you run:
```bash
make -j 4 iso RISCVPATH={PATH_TO_YOUR_RISCV_TOOLCHAIN_BIN_FOLDER}
```

## Running on qemu
You need qemu with riscv support. You can compile it from [here](https://risc-v-getting-started-guide.readthedocs.io/en/latest/linux-qemu.html).

To run with OpenSBI simply run:
```bash
qemu-system-riscv64 -nographic -machine sifive_u -kernel main.elf
```

You can specify the bios with:
```bash
qemu-system-riscv64 -nographic -machine sifive_u -bios /usr/local/share/qemu/opensbi-riscv64-generic-fw_dynamic.bin -kernel main.elf
```

Or you can run the iso file:
```bash
qemu-system-riscv64 -nographic -machine sifive_u -bios none -boot d -m 128 -cdrom boot.iso
```

## Configuration
To get the device tree:
```bash
qemu-system-riscv64 -nographic -machine sifive_u -machine dumpdtb=riscv64-virt.dtb -m 128M -kernel main.elf
```

To decode it:
```bash
dtc -I dtb -O dts -o riscv64-virt.dts riscv64-virt.dtb
```

You can check the memory address (low, high), cpus, uart addresses (for prining), etc.

If you are getting overlapping errors in qemu (regions overlap), make sure that in your linker script (link.ld), the .text segment starts *after* the low memory address since the OpenSBI code is put at that location. In this example, I am using 0x80020000 since my OpenSBI is 108kb long (you can check this when you run the machine, it gives you the size of the OpenSBI).

## Verification
You can disassemble and check the addresses of the elf file:
```bash
riscv64-unknown-linux-gnu-objdump -d main.elf
```
or:
```bash
riscv64-unknown-linux-gnu-objdump -S main.elf
```
or:
```bash
riscv64-unknown-linux-gnu-objdump --syms main.elf
```
