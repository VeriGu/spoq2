#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_135(void)
{
    u64 out;
    asm volatile("mrs %0, pmevtyper18_el0": "=r" (out) : );
    return out;
}
