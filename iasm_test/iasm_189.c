#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_189(void)
{
    asm volatile("dsb ish":  : );
}
