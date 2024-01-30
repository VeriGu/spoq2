#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_184(void)
{
    asm volatile("dsb ish":  : );
}
