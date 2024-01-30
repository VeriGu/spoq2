#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_274(u64 in0)
{
    asm volatile("msr pmevcntr27_el0, %0":  : "r" (in0));
}
