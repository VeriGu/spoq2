#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_101(void)
{
    u64 out;
    asm volatile("mrs %0, pmevcntr15_el0": "=r" (out) : );
    return out;
}
