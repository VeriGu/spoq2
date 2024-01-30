#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_338(u64 in0)
{
    asm volatile("msr ttbr1_el2, %0":  : "r" (in0));
}
