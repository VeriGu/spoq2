#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_170(void)
{
    u64 out;
    asm volatile("mrs %0, spsr_el2": "=r" (out) : );
    return out;
}
