#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

u64 iasm_110(void)
{
    u64 out;
    asm volatile("mrs %0, pmevcntr23_el0": "=r" (out) : );
    return out;
}
