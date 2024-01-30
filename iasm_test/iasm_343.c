#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_343(u64 in0)
{
    asm volatile("msr vtcr_el2, %0":  : "r" (in0));
}
