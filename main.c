enum {
    /* UART Registers */
    UART_REG_TXFIFO = 0,
};

static volatile int *uart = (int *)(void *)0x10010000;

int putchar(int ch)
{
    while (uart[UART_REG_TXFIFO] < 0);
    return uart[UART_REG_TXFIFO] = ch & 0xff;
}

void main()
{
    const char *s = "Welcome to RVOS!\n";
    while (*s) putchar(*s++);
    while(1);
}
