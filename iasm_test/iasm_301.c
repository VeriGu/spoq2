#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_301(u64 in0)
{
    asm volatile("msr pmevtyper23_el0, %0":  : "r" (in0));
}
