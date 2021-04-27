OUTPUT_ARCH( "riscv" )

ENTRY( _start )

MEMORY
{
  ram   (wxa!ri) : ORIGIN = 0x80000000, LENGTH = 128M
}

SECTIONS
{
  . = 0x80020000;
  .text : {
    *(.text.init) *(.text .text.*)
  }

  .rodata : {
    *(.rodata .rodata.*)
  }

  .data : {
    . = ALIGN(4096);
    *(.sdata .sdata.*) *(.data .data.*)
  }

  .bss :{
    *(.sbss .sbss.*) *(.bss .bss.*)
  }

}
